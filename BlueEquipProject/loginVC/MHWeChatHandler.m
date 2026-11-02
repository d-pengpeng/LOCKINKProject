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
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"LOCKINK_LOGIN";
    [WXApi sendReq:req completion:^(BOOL success) {
        if (!success) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidFailNotification
                                                                object:nil
                                                              userInfo:@{@"error": @"调起微信失败"}];
        }
    }];
}

#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq *)req {
    // App → 微信 请求，不用处理
}

- (void)onResp:(BaseResp *)resp {
    if (![resp isKindOfClass:[SendAuthResp class]]) return;
    
    SendAuthResp *authResp = (SendAuthResp *)resp;
    switch (authResp.errCode) {
        case WXSuccess:
            if (authResp.code.length > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidReceiveCodeNotification
                                                                    object:nil
                                                                  userInfo:@{@"code": authResp.code}];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidFailNotification
                                                                    object:nil
                                                                  userInfo:@{@"error": @"微信授权失败"}];
            }
            break;
        case WXErrCodeUserCancel:
            [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidCancelNotification
                                                                object:nil
                                                              userInfo:nil];
            break;
        default: {
            NSString *errMsg = authResp.errStr ?: @"微信授权失败";
            [[NSNotificationCenter defaultCenter] postNotificationName:MHWeChatDidFailNotification
                                                                object:nil
                                                              userInfo:@{@"error": errMsg}];
            break;
        }
    }
}

@end
