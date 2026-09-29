//
//  MHRoleTwoTimingClickController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/19.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleTwoTimingClickCBlock)(void);
@interface MHRoleTwoTimingClickController : eBaseViewController

@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) RoleTwoTimingClickCBlock block_;
@end

NS_ASSUME_NONNULL_END
