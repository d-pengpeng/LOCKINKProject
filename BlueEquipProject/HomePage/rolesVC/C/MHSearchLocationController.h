//
//  MHSearchLocationController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/4/3.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^MHSearchLocationContBlock)(NSString *strLLL);
@interface MHSearchLocationController : eBaseViewController

@property (nonatomic, copy) MHSearchLocationContBlock block_;
@end

NS_ASSUME_NONNULL_END
