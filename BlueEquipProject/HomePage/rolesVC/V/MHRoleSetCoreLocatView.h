//
//  MHRoleSetCoreLocatView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/19.
//

#import <UIKit/UIKit.h>
#import "MHRoleOneModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^RoleSetCoreLocatBlock)(NSArray *arrList);
@interface MHRoleSetCoreLocatView : UIView

@property (nonatomic, copy) RoleSetCoreLocatBlock block_;
@property (nonatomic, copy) RoleSetCoreLocatBlock twoBlock_;
@property (nonatomic, strong) NSArray *arrFind;
@property (nonatomic, strong) UIButton *customLab;
@property (nonatomic, strong) UIButton *avatorBtn;
@property (nonatomic, copy) NSString *readName;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, copy) NSString *bx_sstr;

- (void)addUIUIU;
- (void)addUIUIUTwo;
- (void)addUnlockingMethod:(BOOL)boo;
- (void)addUIUIUIUMethodType:(NSInteger)typeMM;

- (void)customeUIUIUIU:(NSString *)strM;


- (void)addTwoNewTextfUIUIMethod:(int)typeML; //记录感受命名
@end

NS_ASSUME_NONNULL_END
