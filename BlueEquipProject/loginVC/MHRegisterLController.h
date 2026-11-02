//
//  MHRegisterLController.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^registerLLLBlock)(BOOL isboo);
@interface MHRegisterLController : eBaseViewController

@property (nonatomic, assign) BOOL isTYBoo;
@property (nonatomic, copy, nullable) NSString *wechatTicket;
@property (nonatomic, copy, nullable) NSString *prefillName;
@property (nonatomic, copy) registerLLLBlock block_;
@end

NS_ASSUME_NONNULL_END
