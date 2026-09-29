//
//  MHMeEquipmentModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHMeEquipmentModel : NSObject

@property (nonatomic, assign) int deviceId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, assign) BOOL hasServant;
@property (nonatomic, copy) NSString *servantProfile;
@property (nonatomic, assign) int servantAge;
@property (nonatomic, copy) NSString *servantGender;
@property (nonatomic, copy) NSString *servantGenderPreference;
@property (nonatomic, copy) NSString *servantRolePreference;
@property (nonatomic, assign) BOOL hasMaster;
@property (nonatomic, assign) int masterAge;
@property (nonatomic, copy) NSString *masterGender;
@property (nonatomic, copy) NSString *masterGenderPreference;
@property (nonatomic, copy) NSString *masterRolePreference;
@property (nonatomic, copy) NSString *masterProfile;

@end

NS_ASSUME_NONNULL_END
