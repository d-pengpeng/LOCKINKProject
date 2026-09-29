//
//  receiveRedbagModel.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface receiveRedbagModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) int red_id;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) BOOL isCrown;
@end

NS_ASSUME_NONNULL_END
