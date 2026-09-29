//
//  MHRoleMoreListController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHRoleMoreListController : eBaseViewController

@property (nonatomic, assign) NSInteger typeNN;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@end

NS_ASSUME_NONNULL_END
