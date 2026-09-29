//
//  MHDeviceListMsgModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHDeviceListMsgModel : NSObject

@property (nonatomic, assign) int messageId;
@property (nonatomic, copy) NSString *fromProfile;
@property (nonatomic, copy) NSString *fromNickName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) int type;
@end

NS_ASSUME_NONNULL_END
