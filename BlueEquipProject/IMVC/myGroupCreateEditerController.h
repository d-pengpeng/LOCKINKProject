//
//  myGroupCreateEditerController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/18.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^myGroupCreateEditerCBlock)(NSString *nameStr, NSString *faceUrl);
@interface myGroupCreateEditerController : eBaseViewController

@property (nonatomic, copy) myGroupCreateEditerCBlock block_;
@end

NS_ASSUME_NONNULL_END
