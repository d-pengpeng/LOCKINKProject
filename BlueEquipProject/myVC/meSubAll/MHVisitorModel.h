//
//  MHVisitorModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHVisitorModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *genderPreference;
@property (nonatomic, copy) NSString *rolePreference;
@property (nonatomic, copy) NSString *accessTime;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int accessCount;
@property (nonatomic, assign) BOOL isFollowed;
@end

NS_ASSUME_NONNULL_END
