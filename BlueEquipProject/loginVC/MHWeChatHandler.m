//
//  MHWeChatHandler.m
//  BlueEquipProject
//

#import "MHWeChatHandler.h"

NSString * const MHWeChatDidReceiveCodeNotification = @"MHWeChatDidReceiveCodeNotification";
NSString * const MHWeChatDidFailNotification = @"MHWeChatDidFailNotification";
NSString * const MHWeChatDidCancelNotification = @"MHWeChatDidCancelNotification";

@implementation MHWeChatHandler

+ (instancetype)shared {
    static MHWeChatHandler *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MHWeChatHandler alloc] init];
    });
    return instance;
}

- (void)sendAuthReq {
    BOOL installed = [WXApi isWXAppInstalled];
    NSLog(@"[WeChat] sendAuthReq — isWXAppInstalled=%d", installed);
    if (!installed) {
        NSLog(@"[WeChat] sendAuthReq 拦截：微信未安装");
        return;
    }
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"LOCKINK_LOGIN";
    NSLog(@"[WeChat] sendAuthReq — scope=%@, state=%@", req.scope, req.state);
    [WXApi sendReq:req completion:^(BOOL success) {
        NSLog(@"[WeChat] sendReq completion — success=%d", success);
        if (!success) {
            NSLog(@"[WeChat] sendReq 失败，发 MHWeChatDidFailNotification");
            [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidFailNotification
                                                                object:nil
                                                              userInfo:@{@"error": @"调起微信失败"}];
        }
    }];
}

#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq *)req {
    NSLog(@"[WeChat] onReq — %@", NSStringFromClass([req class]));
}

- (void)onResp:(BaseResp *)resp {
    NSLog(@"[WeChat] onResp — class=%@, errCode=%d, errStr=%@",
          NSStringFromClass([resp class]), resp.errCode, resp.errStr ?: @"(null)");
    if (![resp isKindOfClass:[SendAuthResp class]]) {
        NSLog(@"[WeChat] onResp 忽略：不是 SendAuthResp");
        return;
    }
    
    SendAuthResp *authResp = (SendAuthResp *)resp;
    switch (authResp.errCode) {
        case WXSuccess:
            NSLog(@"[WeChat] 授权成功，code 长度=%lu", (unsigned long)authResp.code.length);
            if (authResp.code.length > 0) {
                NSLog(@"[WeChat] code=%@", authResp.code);
                [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidReceiveCodeNotification
                                                                    object:nil
                                                                  userInfo:@{@"code": authResp.code}];
            } else {
                NSLog(@"[WeChat] 授权成功但 code 为空");
                [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidFailNotification
                                                                    object:nil
                                                                  userInfo:@{@"error": @"微信授权失败"}];
            }
            break;
        case WXErrCodeUserCancel:
            NSLog(@"[WeChat] 用户取消授权 (errCode=%d)", authResp.errCode);
            [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidCancelNotification
                                                                object:nil
                                                              userInfo:nil];
            break;
        default: {
            NSString *errMsg = authResp.errStr ?: @"微信授权失败";
            NSLog(@"[WeChat] 授权失败 (errCode=%d) — %@", authResp.errCode, errMsg);
            [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidFailNotification
                                                                object:nil
                                                              userInfo:@{@"error": errMsg}];
            break;
        }
    }
}

@end
