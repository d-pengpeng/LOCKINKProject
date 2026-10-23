//
//  MHAgeAssurance.h
//  BlueEquipProject
//
//  Apple Declared Age Range（Age Assurance）Swift 桥接类的 Objective-C 声明
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHAgeAssurance : NSObject

/// 是否已确认成年（由最近一次共享结果写入，默认 NO）
@property (class, nonatomic, readonly) BOOL isAdultConfirmed;

/// 最近一次状态：none/unavailable/sharing/declined/error
@property (class, nonatomic, readonly, copy) NSString *assuranceStatus;

/// 已明确共享年龄但未满 18 岁（其余状态不拦截）
@property (class, nonatomic, readonly) BOOL isAgeRestricted;

+ (instancetype)shared;

/// 请求年龄区间，completion 在主线程回调
/// result 字段：status / lowerBound / upperBound / declaration / parentalControls / error
- (void)requestAgeRangeFrom:(UIViewController *)viewController
                 completion:(nullable void (^)(NSDictionary *result))completion;

@end

NS_ASSUME_NONNULL_END
