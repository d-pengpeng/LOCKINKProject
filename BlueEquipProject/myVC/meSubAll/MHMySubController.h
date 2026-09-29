//
//  MHMySubController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/9.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMySubController : eBaseViewController

@property (nonatomic, assign) int cageId;
@property (nonatomic, copy) NSString *othrerId;
@property (nonatomic, strong) UIViewController *selfVVVV;
- (void)booToBoo:(BOOL)booM arrMut:(nonnull NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
