//
//  myContactListController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/23.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^contactListNumBlock)(NSInteger redNum);
@interface myContactListController : eBaseViewController

@property (nonatomic, copy) contactListNumBlock block_;
@end

NS_ASSUME_NONNULL_END
