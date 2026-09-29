//
//  MHfindDetailModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHfindDetailModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) int likesCount;
@property (nonatomic, assign) int repliesCount;
@property (nonatomic, copy) NSString *commentTime;
@property (nonatomic, assign) BOOL allowDeleted;
@property (nonatomic, assign) BOOL isLikes;
@property (nonatomic, assign) BOOL isPrimary;
@property (nonatomic, strong) NSMutableArray *subArr;
@property (nonatomic, assign) BOOL isShowM;
@property (nonatomic, copy) NSString *toUserNickName;
@end

NS_ASSUME_NONNULL_END
