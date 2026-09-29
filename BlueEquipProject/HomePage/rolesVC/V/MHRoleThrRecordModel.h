//
//  MHRoleThrRecordModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHRoleThrRecordModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *operatorId;
@property (nonatomic, copy) NSString *operatorNickName;
@property (nonatomic, copy) NSString *operatorProfile;
@property (nonatomic, assign) int unlockRangeInKm;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *operationTime;
@property (nonatomic, assign) int status;
@end

NS_ASSUME_NONNULL_END
