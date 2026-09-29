//
//  MHRoleSetSubController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleSetSubBlock)(BOOL isboo);
@interface MHRoleSetSubController : eBaseViewController

@property (nonatomic, assign) int typN;
@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyy;
@property (nonatomic, copy) RoleSetSubBlock block_;
@property (nonatomic, strong) UIViewController *selfUpVC;
@end

NS_ASSUME_NONNULL_END
