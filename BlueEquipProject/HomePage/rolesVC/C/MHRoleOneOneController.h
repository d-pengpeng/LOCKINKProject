//
//  MHRoleOneOneController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleOneOneBlockDJBlock)(void);
@interface MHRoleOneOneController : eBaseViewController

@property (nonatomic, copy) RoleOneOneBlockDJBlock block_;
@property (nonatomic, copy) RoleOneOneBlockDJBlock twoBBlock_;
@property (nonatomic, copy) RoleOneOneBlockDJBlock stopBBlock_;//开锁
@property (nonatomic, copy) RoleOneOneBlockDJBlock stopBXBBlock_; //停止03播放

@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *devicTyp;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, strong) MHRoleOneModel *roleOneModeltwo;
@property (nonatomic, assign) BOOL isBMMM; //是否被没收权限
@property (nonatomic, assign) BOOL isConnDevic;

@property (nonatomic, assign) BOOL isTwoBoo; //是否是二期 开发 手动电击
@property (nonatomic, strong) UIViewController *selfUpVC;

- (void)uploadUIUIUI;
@end

NS_ASSUME_NONNULL_END
