//
//  LBHorizonView.h
//  LPJCompassDemo
//
//  Created by fighting on 17/3/3.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBHorizonView : UIView

+ (instancetype)sharedWithFrame:(CGRect)frame andRadius:(CGFloat)radius;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint point;

@end
