//
//  LPJDialView.h
//  LPJCompassDemo
//
//  Created by fighting on 17/3/3.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPJDialView : UIView
+ (instancetype)sharedWithFrame:(CGRect)frame andRadius:(CGFloat)radius andScale:(CGFloat)scale;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGPoint point;
@end
