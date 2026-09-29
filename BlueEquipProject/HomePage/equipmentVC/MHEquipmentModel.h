//
//  MHEquipmentModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHEquipmentModel : NSObject

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *deviceStatus;
@property (nonatomic, copy) NSString *lastConnectionTime;
@property (nonatomic, copy) NSString *remainingCharge;
@property (nonatomic, assign) BOOL isShowDelete;
@property (nonatomic, assign) BOOL isShowLinks;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, assign) BOOL roleSelection;
@property (nonatomic, assign) BOOL bothConnected;
@end


@interface MHEquipmentModel_linkUrl : NSObject

@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) NSString *url;

@end


NS_ASSUME_NONNULL_END
