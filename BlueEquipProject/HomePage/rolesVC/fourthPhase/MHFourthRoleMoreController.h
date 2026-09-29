//
//  MHFourthRoleMoreController.h
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^roloeFourthMoreBLock)(void);

@interface MHFourthRoleMoreController : eBaseViewController
@property (nonatomic, copy) roloeFourthMoreBLock block_;
@property (nonatomic, assign) BOOL isBooMM;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, copy) NSString *macStrL;
@end

NS_ASSUME_NONNULL_END
