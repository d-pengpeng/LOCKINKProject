//
//  MHNexLoginController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/5.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHNexLoginController : eBaseViewController

@property (nonatomic, copy) NSString *ymdStr;
@property (nonatomic, copy) NSString *ymdStr2;
@property (nonatomic, copy) NSString *ymdStr3;
@property (nonatomic, copy) NSString *ymdStr4;

@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, copy) NSString *passworStr;
@property (nonatomic, copy) NSString *codeStr;
@property (nonatomic, assign) BOOL isEmilBoo;
@end

NS_ASSUME_NONNULL_END
