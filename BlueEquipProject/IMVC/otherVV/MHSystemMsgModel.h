//
//  MHSystemMsgModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHSystemMsgModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray *msgList;

@property (nonatomic, assign) int messageId;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *fromId;
@property (nonatomic, copy) NSString *fromProfile;
@property (nonatomic, copy) NSString *fromNickName;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *activityMediaType;
@property (nonatomic, copy) NSString *activityContent;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *videoCover;
@end

NS_ASSUME_NONNULL_END
