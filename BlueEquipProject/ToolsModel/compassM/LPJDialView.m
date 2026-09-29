//
//  LPJDialView.m
//  LPJCompassDemo
//
//  Created by fighting on 17/3/3.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import "LPJDialView.h"

@implementation LPJDialView

+ (instancetype)sharedWithFrame:(CGRect)frame andRadius:(CGFloat)radius andScale:(CGFloat)scale
{
    return [[self alloc]initWithFrame:frame andRadius:radius andScale:scale];
}

- (instancetype)initWithFrame:(CGRect)frame andRadius:(CGFloat)radius andScale:(CGFloat)scale
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _point = CGPointMake(frame.size.width/2, frame.size.width/2);
        _radius = radius;
        _scale = scale;
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    CGFloat lineLength = _radius * 0.4;
    CGFloat heardLength = 2;
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context,1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context,0.4, 0.4, 0.4, 1.0);
    
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
    
    for (int i = 0; i < 4; i++) {
        //开始绘制小指针
        CGContextBeginPath(context);
        if (i == 0) {
            //画笔起点
            CGContextMoveToPoint(context, _point.x - heardLength, _point.y - lineLength + heardLength);
            //画笔转点
            CGContextAddLineToPoint(context, _point.x, _point.y - lineLength);
            //画笔终点
            CGContextAddLineToPoint(context, _point.x + heardLength, _point.y - lineLength + heardLength);
        }else if (i == 1){
            //画笔的起点
            CGContextMoveToPoint(context, _point.x - lineLength + heardLength, _point.y - heardLength);
            //画笔转点
            CGContextAddLineToPoint(context, _point.x - lineLength, _point.y);
            //画笔终点
            CGContextAddLineToPoint(context, _point.x - lineLength + heardLength, _point.y + heardLength);
        }else if (i == 2){
            //画笔起点
            CGContextMoveToPoint(context, _point.x - heardLength, _point.y + lineLength - heardLength);
            //画笔转点
            CGContextAddLineToPoint(context, _point.x, _point.y + lineLength);
            //画笔终点
            CGContextAddLineToPoint(context, _point.x + heardLength, _point.y + lineLength - heardLength);
        }else{
            //画笔的起点
            CGContextMoveToPoint(context, _point.x + lineLength - heardLength, _point.y - heardLength);
            //画笔转点
            CGContextAddLineToPoint(context, _point.x + lineLength, _point.y);
            //画笔终点
            CGContextAddLineToPoint(context, _point.x + lineLength - heardLength, _point.y + heardLength);
        }
        
        //绘制完成
        CGContextStrokePath(context);
    }
    
    
    //    //画矩形
    //    CGContextAddRect(context, CGRectMake(self.center.x - _scale, self.center.y - _radius * 1.15, 2 * _scale, 30 * _scale));
    //    [[UIColor whiteColor] set];
    //    CGContextFillPath(context);
    
    //    //画的小三角
    //    CGContextBeginPath(context);
    //    CGContextMoveToPoint(context, self.center.x, self.center.y - _radius-5); // 第一个点
    //    CGContextAddLineToPoint(context, self.center.x - 5, self.center.y - _radius + 4); // 第二个点
    //    CGContextAddLineToPoint(context, self.center.x + 5, self.center.y - _radius + 4); // 第三个点
    //    [[UIColor redColor] set];
    //    CGContextClosePath(context);
    //    CGContextFillPath(context);
    
}
@end
