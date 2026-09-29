//
//  myGroupInfoController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/20.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^myGroupInfoBlock)(void);
@interface myGroupInfoController : eBaseViewController

@property (nonatomic, copy) myGroupInfoBlock block_;
@property (nonatomic, copy) NSString *chatId;
@end

NS_ASSUME_NONNULL_END
