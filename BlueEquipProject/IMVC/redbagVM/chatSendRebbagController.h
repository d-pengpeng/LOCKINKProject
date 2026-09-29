//
//  chatSendRebbagController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/23.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^chatSendRebbagCBlock)(NSArray *arr);
@interface chatSendRebbagController : eBaseViewController

@property (nonatomic, assign) BOOL isC2CBoo;
@property (nonatomic, copy) NSString *chatId;
@property (nonatomic, copy) chatSendRebbagCBlock block_;
@end

NS_ASSUME_NONNULL_END
