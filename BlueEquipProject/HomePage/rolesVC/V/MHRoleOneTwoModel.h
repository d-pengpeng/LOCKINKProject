//
//  MHRoleOneTwoModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHRoleOneTwoModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int countdownSeconds;
@property (nonatomic, assign) int frequency;
@property (nonatomic, assign) int voltage;
@property (nonatomic, assign) int duration;
@property (nonatomic, assign) BOOL isDeleteBoo;
@end

NS_ASSUME_NONNULL_END
