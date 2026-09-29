//
//  MHRoleOneController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "eBaseViewController.h"
#import "MHEquipmentModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHRoleOneCoBLock)(NSInteger typMM);
@interface MHRoleOneController : eBaseViewController

@property (nonatomic, strong) MHEquipmentModel *modelM;
@property (nonatomic, copy) MHRoleOneCoBLock block_;
@property (nonatomic, strong) NSArray *arrList;
@property (nonatomic, strong) NSArray *macsList;
@property (nonatomic, strong) NSArray *ListAAA;

@end

NS_ASSUME_NONNULL_END
