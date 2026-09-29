//
//  UIView+Frame.h
//  GY_Teacher
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat yz_centerX;
@property (nonatomic, assign) CGFloat yz_centerY;

@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;

- (void)removeAllSubviews;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (UIViewController *)viewController;

@end
