//
//  MHRoleSettingController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleSetBlock)(BOOL isboo);
@interface MHRoleSettingController : eBaseViewController

@property (nonatomic, assign) int numTpy;
@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyp;
@property (nonatomic, copy) RoleSetBlock block_;
@property (nonatomic, strong) UIViewController *selfUpVC;
@end

NS_ASSUME_NONNULL_END
