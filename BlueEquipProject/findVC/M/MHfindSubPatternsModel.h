//
//  MHfindSubPatternsModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHfindSubPatternsModel : NSObject

@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *postTime;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *mediaType;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) int viewCount;
@property (nonatomic, assign) int commentCount;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, strong) NSArray *mediaUrlList;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) int participantCount;
@property (nonatomic, strong) NSArray *participantProfileList;
@property (nonatomic, copy) NSString *deviceModel;
@property (nonatomic, copy) NSString *auditStatus;
@property (nonatomic, copy) NSString *videoCover;
@property (nonatomic, assign) int audioDuration;
@property (nonatomic, assign) BOOL isLikes;
@property (nonatomic, assign) BOOL isPending;
@end

NS_ASSUME_NONNULL_END
