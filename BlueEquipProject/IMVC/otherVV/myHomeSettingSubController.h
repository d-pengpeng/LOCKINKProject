//
//  myHomeSettingSubController.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/9/19.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    payPasswordTypeN,
    aboutMineTypeN,
    ModifyPasswordTypeN,
    CancellationTypeN,
} allSettingTypeN;

typedef void(^cancellationBlock)(void);
@interface myHomeSettingSubController : eBaseViewController

@property (nonatomic, copy) cancellationBlock block_;
@property (nonatomic, assign) allSettingTypeN typeN;
@end

NS_ASSUME_NONNULL_END
