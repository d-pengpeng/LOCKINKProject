//
//  myFriendProfileController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/23.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface myFriendProfileController : eBaseViewController

@property (nonatomic, copy) NSString *f_UserId;
@property (nonatomic, copy) NSString *f_Nickname;
@property (nonatomic, copy) NSString *f_faceUrl;
@property (nonatomic, strong) NSURL *avator_Url;
@property (nonatomic, assign) BOOL isChatBoo;

@end

NS_ASSUME_NONNULL_END
