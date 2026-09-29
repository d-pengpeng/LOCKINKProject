//
//  LBSenderManager.m
//  LPJCompassDemo
//
//  Created by fighting on 17/3/2.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import "LBSenderManager.h"
#import <UIKit/UIKit.h>
@interface LBSenderManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation LBSenderManager
+ (instancetype)shared
{
    return [[self alloc]init];
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)startSensor
{
    _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        // 申请前后台权限
        [_manager requestAlwaysAuthorization];
        // 前权限
        [_manager requestWhenInUseAuthorization];
    }
    
    // 每隔多少米定位一次
    //_manager.distanceFilter = 10;
    // 定位精确度
    // 精确度越高，定位越慢，耗电量越多
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
    if ([CLLocationManager headingAvailable]) {
        _manager.headingFilter = 5;
        [_manager startUpdatingHeading];
    }
}

- (void)startGyroscope
{
    _motionManager = [[CMMotionManager alloc]init];
    
    if (_motionManager.deviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = 0.01f;
        __weak typeof(self)mySelf = self;
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMDeviceMotion *data, NSError *error) {
                                                
                                                if (mySelf.updateDeviceMotionBlock) {
                                                    mySelf.updateDeviceMotionBlock(data);
                                                }
                                                
                                            }];
        
    }
}

- (void)stopSensor
{
    [_manager stopUpdatingHeading];
    _manager = nil;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    if (_didUpdateHeadingBlock) {
        _didUpdateHeadingBlock(theHeading);
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * loc = [locations lastObject];
    // 经纬度
    CLLocationCoordinate2D coor = loc.coordinate;
    if (self.updateCoordinateBlock) {
        self.updateCoordinateBlock(coor);
    }
}
@end
