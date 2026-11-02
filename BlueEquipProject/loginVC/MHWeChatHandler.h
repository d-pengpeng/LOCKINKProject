//
//  MHWeChatHandler.h
//  BlueEquipProject
//
//  微信开放平台回调处理器（WXApiDelegate）
//

#import <Foundation/Foundation.h>
#import <WechatOpenSDK/WXApi.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MHWeChatDidReceiveCodeNotification; // userInfo: @{@"code": ...}
extern NSString * const MHWeChatDidFailNotification;           // userInfo: @{@"error": ...}
extern NSString * const MHWeChatDidCancelNotification;

@interface MHWeChatHandler : NSObject <WXApiDelegate>

+ (instancetype)shared;

/// 发送微信授权请求（scope = snsapi_userinfo）
- (void)sendAuthReq;

@end

NS_ASSUME_NONNULL_END
