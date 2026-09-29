//
//  myIMSearchModel.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface myIMSearchModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *groupid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) int num;
@property (nonatomic, assign) double addtime;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) BOOL is_join;

@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) int attention;
@property (nonatomic, assign) BOOL is_live;
@property (nonatomic, assign) BOOL is_follow;
@end

NS_ASSUME_NONNULL_END
