//
//  MHRoleMoreController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^roloeMoreBLock)(void);
@interface MHRoleMoreController : eBaseViewController

@property (nonatomic, copy) roloeMoreBLock block_;
@property (nonatomic, assign) BOOL isBooMM; //是否是 佩戴者
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, copy) NSString *macStrL;
@end

NS_ASSUME_NONNULL_END
