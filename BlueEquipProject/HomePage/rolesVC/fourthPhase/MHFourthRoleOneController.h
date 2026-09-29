//
//  MHFourthRoleOneController.h
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "eBaseViewController.h"
#import "MHEquipmentModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^MHFourthRoleOneCoBLock)(NSInteger typMM);
@interface MHFourthRoleOneController : eBaseViewController

@property (nonatomic, strong) MHEquipmentModel *modelM;
@property (nonatomic, copy) MHFourthRoleOneCoBLock block_;
@property (nonatomic, strong) NSArray *arrList;
@property (nonatomic, strong) NSArray *macsList;
@property (nonatomic, strong) NSArray *ListAAA;
@end

NS_ASSUME_NONNULL_END
