//
//  myContactSelectController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/12.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^myContactSelectCblock)(NSString *nickNN, NSString *grouId);
typedef void(^myContactSelectCbTwolock)(NSArray *arrM);
@interface myContactSelectController : eBaseViewController

@property (nonatomic, copy) myContactSelectCblock block_;
@property (nonatomic, copy) myContactSelectCbTwolock twoblock_;
@property (nonatomic, assign) BOOL isGroupBoo;
@property (nonatomic, assign) NSInteger typeGroup;
@property (nonatomic, strong) NSArray *groupArr;
@property (nonatomic, copy) NSString *groupId;
@end

NS_ASSUME_NONNULL_END
