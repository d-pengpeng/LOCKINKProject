//
//  searchFriendAddModel.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface searchFriendAddModel : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *faceURL;
@property (nonatomic, assign) BOOL isFriend;
@end

NS_ASSUME_NONNULL_END
