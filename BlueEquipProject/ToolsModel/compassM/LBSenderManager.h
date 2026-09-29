//
//  LBSenderManager.h
//  LPJCompassDemo
//
//  Created by fighting on 17/3/2.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLHeading.h>
#import <CoreMotion/CoreMotion.h>

@interface LBSenderManager : NSObject
+ (instancetype)shared;
- (void)startSensor;
- (void)startGyroscope;
- (void)stopSensor;

@property (nonatomic, copy) void (^didUpdateHeadingBlock)(CLLocationDirection theHeading);
@property (nonatomic, copy) void (^updateCoordinateBlock)(CLLocationCoordinate2D coor);
@property (nonatomic, copy) void (^updateDeviceMotionBlock)(CMDeviceMotion *data);
@end
