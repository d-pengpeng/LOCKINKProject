//
//  LBCompass.h
//  LPJCompassDemo
//
//  Created by fighting on 17/3/2.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBCompass : UIView
/**
 *  创建罗盘对象
 *
 *  @param frame   罗盘坐标大小
 *  @param radius 罗盘的半径
 *
 *  @return  罗盘对象
 */
+ (instancetype)sharedWithFrame:(CGRect)frame andRadius:(CGFloat)radius;
//标注刻度颜色
@property (nonatomic, strong) UIColor *textColor;
//刻度颜色
@property (nonatomic, strong) UIColor *scaleColor;

@end
