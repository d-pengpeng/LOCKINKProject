//
//  MHFourthRoleYYKZController.h
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleFourthYYKZBlockDJBlock)(int typeM);
@interface MHFourthRoleYYKZController : eBaseViewController

@property (nonatomic, copy) RoleFourthYYKZBlockDJBlock block_;
@property (nonatomic, copy) RoleFourthYYKZBlockDJBlock twoBBlock_;
@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyp;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, assign) BOOL isBMMM;
@property (nonatomic, assign) BOOL isConnDevic;
@property (nonatomic, assign) BOOL time_Boo2; //是否在本页面
@property (nonatomic, assign) BOOL time_Boo2_old;
@property (nonatomic, strong) UIViewController *selfUpVC;

@property (nonatomic, assign) int isChannelBoo;
@property (nonatomic, assign) int isChannelBoo_play;

- (void)uploadUIUIUI;
- (void)stopMethodUIUIUI;

- (void)channelBtnChooseMethodOne;
- (void)channelStartChooseMethodTwo;

@end

NS_ASSUME_NONNULL_END
