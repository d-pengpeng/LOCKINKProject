//
//  myJoinGroupController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/10.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^myJoinGroupCBlock)(void);
@interface myJoinGroupController : eBaseViewController

@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) myJoinGroupCBlock block_;
@end

NS_ASSUME_NONNULL_END
