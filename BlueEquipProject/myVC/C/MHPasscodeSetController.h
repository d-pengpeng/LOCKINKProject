//
//  MHPasscodeSetController.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/1.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^passcodeSetBlock)(void);
@interface MHPasscodeSetController : eBaseViewController

@property (nonatomic, copy) passcodeSetBlock block_;
@end

NS_ASSUME_NONNULL_END
