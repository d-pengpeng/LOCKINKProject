//
//  receiveRedbagController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface receiveRedbagController : eBaseViewController
@property (nonatomic, copy) NSString *redId;
@property (nonatomic, assign) NSInteger typeLL;
@property (nonatomic, copy) NSString *remarkMsg;
@property (nonatomic, copy) NSString *moneyStr;
@property (nonatomic, strong) NSDictionary *allDD;
@property (nonatomic, assign) BOOL isRequesBoo;
@end

NS_ASSUME_NONNULL_END
