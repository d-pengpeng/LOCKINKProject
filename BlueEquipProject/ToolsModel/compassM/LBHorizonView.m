//
//  LBHorizonView.m
//  LPJCompassDemo
//
//  Created by fighting on 17/3/3.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import "LBHorizonView.h"



@implementation LBHorizonView

+ (instancetype)sharedWithFrame:(CGRect)frame andRadius:(CGFloat)radius
{
    return [[self alloc]initWithFrame:frame andRadius:radius];
}

- (instancetype)initWithFrame:(CGRect)frame andRadius:(CGFloat)radius
{
    if (self = [super initWithFrame:frame]) {
        _point = CGPointMake(frame.size.width/2, frame.size.width/2);
        _radius = radius;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat lineLength = _radius * 0.3;
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context,1.0);
    
    //画圆
    CGContextSetRGBFillColor(context, 31/255.0, 31/255.0, 31/255.0, 1.0);
    CGContextAddArc(context, _point.x, _point.y, _radius, 0, M_PI * 2, YES);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);
    //开始绘制水平线
    CGContextBeginPath(context);
    //画笔的起点
    CGContextMoveToPoint(context, _point.x - lineLength, _point.y);
    //画笔终点
    CGContextAddLineToPoint(context, _point.x + lineLength, _point.y);
    //绘制完成
    CGContextStrokePath(context);
    
    //开始绘制竖直线
    CGContextBeginPath(context);
    //画笔起点
    CGContextMoveToPoint(context, _point.x, _point.y - lineLength);
    //画笔终点
    CGContextAddLineToPoint(context, _point.x, _point.y + lineLength);
    //绘制完成
    CGContextStrokePath(context);
}
@end
