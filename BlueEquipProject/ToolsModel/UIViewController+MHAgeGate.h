//
//  UIViewController+MHAgeGate.h
//  BlueEquipProject
//
//  成人功能拦截提示
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MHAgeGate)

/// 未满 18 岁时弹出提示并返回 NO，调用方需终止后续跳转
- (BOOL)mh_requireAdult;

@end

NS_ASSUME_NONNULL_END
