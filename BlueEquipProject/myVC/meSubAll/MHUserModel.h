//
//  MHUserModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHUserModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *placeOfOrigin;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *bg;
@property (nonatomic, copy) NSString *quote;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int weight;
@property (nonatomic, assign) int height;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *genderPreference;
@property (nonatomic, copy) NSString *rolePreference;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *followersCountConverted;
@property (nonatomic, copy) NSString *followingCountConverted;
@property (nonatomic, copy) NSString *likesCountConverted;
@property (nonatomic, assign) BOOL agePrivate;
@property (nonatomic, assign) BOOL weightPrivate;
@property (nonatomic, assign) BOOL heightPrivate;
@property (nonatomic, assign) BOOL genderPrivate;
@property (nonatomic, assign) BOOL genderPreferencePrivate;
@property (nonatomic, assign) BOOL rolePreferencePrivate;
@property (nonatomic, assign) BOOL locationPrivate;
@property (nonatomic, assign) int guestCount;
@property (nonatomic, copy) NSString *guestGrowthCountConverted;

@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) BOOL isBlocked;
@end

NS_ASSUME_NONNULL_END
