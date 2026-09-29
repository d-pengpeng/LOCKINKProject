//
//  MHRoleTwoSDDJController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^RoleTwoSDDJBlockDJBlock)(void);
@interface MHRoleTwoSDDJController : eBaseViewController

@property (nonatomic, copy) RoleTwoSDDJBlockDJBlock block_;
@property (nonatomic, copy) RoleTwoSDDJBlockDJBlock twoBBlock_;
@property (nonatomic, copy) RoleTwoSDDJBlockDJBlock thrBBlock_;
@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyp;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, assign) BOOL isBMMM;
@property (nonatomic, assign) BOOL isConnDevic;
@property (nonatomic, assign) BOOL time_Boo2; //是否在本页面
@property (nonatomic, strong) UIViewController *selfUpVC;

- (void)uploadUIUIUI;
- (void)uploadUIUIUIPlay:(BOOL)booo;
- (void)stopMethodUIUIUI;
@end

NS_ASSUME_NONNULL_END
