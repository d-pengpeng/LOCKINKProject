//
//  MHRoleOneThrCopyController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/13.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleOneThrCBlock)(void);
typedef void(^RoleOneThrTwoCBlock)(NSString *latnd, NSString *longS);
@interface MHRoleOneThrCopyController : eBaseViewController

@property (nonatomic, copy) NSString *devicId;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, strong) UIViewController *selfVVC;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, copy) RoleOneThrCBlock block_;
@property (nonatomic, copy) RoleOneThrTwoCBlock twoBlock_;
@property (nonatomic, assign) BOOL isBMMM;

- (void)uploadUIUIUI;
- (void)uploadUIUIUITwo;
- (void)uploadUIUILatitude:(NSString *)latitude longitude:(NSString *)longitude;
@end

NS_ASSUME_NONNULL_END
