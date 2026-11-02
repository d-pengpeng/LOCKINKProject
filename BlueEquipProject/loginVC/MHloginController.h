//
//  MHloginController.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface MHloginController : eBaseViewController

@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, copy) NSString *passworStr;
@property (nonatomic, copy) NSString *codeStr;
@property (nonatomic, assign) BOOL isEmilBoo;
@property (nonatomic, copy, nullable) NSString *wechatTicket;
@end

NS_ASSUME_NONNULL_END
