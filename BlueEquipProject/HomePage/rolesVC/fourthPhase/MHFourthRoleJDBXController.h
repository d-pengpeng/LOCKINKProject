//
//  MHFourthRoleJDBXController.h
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleFourthJDMSBlockDJBlock)(int typeM);
@interface MHFourthRoleJDBXController : eBaseViewController

@property (nonatomic, copy) RoleFourthJDMSBlockDJBlock block_;
@property (nonatomic, copy) RoleFourthJDMSBlockDJBlock twoBBlock_;
@property (nonatomic, copy) RoleFourthJDMSBlockDJBlock stopWBlock_;
@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyp;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, assign) BOOL isBMMM;
@property (nonatomic, assign) BOOL isConnDevic;
@property (nonatomic, assign) BOOL time_Boo2; //是否在本页面 no是 yes否
@property (nonatomic, assign) BOOL time_Boo2_old; //yes刚离开 
@property (nonatomic, strong) UIViewController *selfUpVC;

@property (nonatomic, assign) int isChannelBoo;
@property (nonatomic, assign) int isChannelBoo_play;

- (void)uploadUIUIUI;

- (BOOL)getBooMEthod;

- (void)stopMethodUIUIUI;

- (void)channelBtnChooseMethodOne;
- (void)channelStartChooseMethodTwo;

@end

NS_ASSUME_NONNULL_END
