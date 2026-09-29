//
//  MHRoleThrJDMSController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/11.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleThrJDMSBlockDJBlock)(int typeM);
@interface MHRoleThrJDMSController : eBaseViewController

@property (nonatomic, copy) RoleThrJDMSBlockDJBlock block_;
@property (nonatomic, copy) RoleThrJDMSBlockDJBlock twoBBlock_;
@property (nonatomic, copy) RoleThrJDMSBlockDJBlock device7Block_;
@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyp;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, assign) BOOL isBMMM; //没收权限
@property (nonatomic, assign) BOOL isConnDevic;
@property (nonatomic, assign) BOOL time_Boo2; //是否在本页面
@property (nonatomic, assign) BOOL time_Boo2_old;
@property (nonatomic, strong) UIViewController *selfUpVC;

- (void)uploadUIUIUI;
- (void)stopMethodUIUIUI;

- (BOOL)getBooMEthod;

- (void)recoveryControlMethodZL;

@end

NS_ASSUME_NONNULL_END
