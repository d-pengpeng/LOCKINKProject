//
//  MHSystemMessageController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/18.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SystemMessageBlock)(int numLL);
@interface MHSystemMessageController : eBaseViewController

@property (nonatomic, copy) SystemMessageBlock block_;
@end

NS_ASSUME_NONNULL_END
