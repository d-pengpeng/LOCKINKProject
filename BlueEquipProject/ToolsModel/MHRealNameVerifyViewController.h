//
//  MHRealNameVerifyViewController.h
//  BlueEquipProject
//
//  实名认证表单页，点击 IM 聊天页的"去认证"按钮 present/push 进来。
//  TUIBaseChatViewController 通过 NSClassFromString(@"MHRealNameVerifyViewController")
//  动态查找此类，因此类名不能改。
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHRealNameVerifyViewController : UIViewController

/// push 进入后，用户提交成功（status 变成 Approved）会回调。
/// 外部（如 TUIBaseChatVC）可以据此决定是否 dismiss 或刷新 UI。
@property (nonatomic, copy, nullable) void(^onVerifiedBlock)(void);

@end

NS_ASSUME_NONNULL_END
