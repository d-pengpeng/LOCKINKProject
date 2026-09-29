//
//  MHRoleOneTwoController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^RoleTwoOneBlockDJBlock)(void);
@interface MHRoleOneTwoController : eBaseViewController

@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, copy) RoleTwoOneBlockDJBlock twoBBlock_;
@property (nonatomic, assign) BOOL isBMMM;
@property (nonatomic, assign) BOOL isConnDevic;

- (void)uploadUIUIUI;
@end

NS_ASSUME_NONNULL_END
