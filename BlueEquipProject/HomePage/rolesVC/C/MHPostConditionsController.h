//
//  MHPostConditionsController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PostConditionsBLock)(NSArray *arr);
@interface MHPostConditionsController : eBaseViewController

@property (nonatomic, copy) PostConditionsBLock block_;
@property (nonatomic, strong) NSArray *arrFind;
@end

NS_ASSUME_NONNULL_END
