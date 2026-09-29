//
//  eDrawingView.m
//  beijing
//
//  Created by Edwin on 2020/10/8.
//  Copyright © 2020 zhou last. All rights reserved.
//

#import "eDrawingView.h"
#import <QuartzCore/QuartzCore.h>
#include <sys/sysctl.h>

@interface eDrawingView ()

@property (nonatomic, strong) UIImageView *poin_HandImgV;
@property (nonatomic, assign) int js_jsNum;
@end
@implementation eDrawingView

-(NSMutableArray *)pointMutY{
    if(!_pointMutY){
        _pointMutY=[NSMutableArray array];
    }
    return _pointMutY;
}
-(NSMutableArray *)pointMutYPath{
    if(!_pointMutYPath){
        _pointMutYPath=[NSMutableArray array];
    }
    return _pointMutYPath;
}

-(NSMutableArray *)pointMutAr{
    if(!_pointMutAr){
        _pointMutAr=[NSMutableArray array];
    }
    return _pointMutAr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
    
    }
    return self;
}

//清除
- (void)clean {

    [_pointMutY removeAllObjects];
    [self.pointMutYPath removeAllObjects];
    
    //重绘
    [self setNeedsDisplay];
    
    self.poin_HandImgV.hidden = YES;
    self.point_YY = 0;
    self.point_YY2 = 0;
    self.point_YY3 = 0;
    
}

//回退
- (void)undo{
    
    for (int i=0; i<self.pointMutYPath.count; i++) {
        if(i==0) {
            UIBezierPath *path = self.pointMutYPath[i];
            [path removeAllPoints];
            [self setNeedsDisplay];//重绘
            
            [self.pointMutYPath removeObjectAtIndex:0];
            [self.pointMutY removeObjectAtIndex:0];
        }
    }
}

//橡皮擦
- (void)eraser{
    _lineColor = self.backgroundColor;
}

//保存
- (void)save{
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //截屏
    [self.layer renderInContext:context];
    //获取图片
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

//保存图片的回调
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
    }else{
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitVV = [super hitTest:point withEvent:event];
    if (hitVV == self) {
        return hitVV;
    }
    return nil;
}

//MARK: 开始手绘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.js_jsNum = 0;
    
    for (UITouch *touch in touches) {
        
        CGPoint point=[touch locationInView:self];
        //当手指按下的时候就创建一条路径
        if (self.pointMutY.count <= 0) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path setLineWidth:_lineWidth];
            [_lineColor setStroke];
            [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
            [path moveToPoint:point];
            [self.pointMutYPath addObject:path];
            
            [self.pointMutY addObject:touch];
            
            if (self.block_) {
                self.block_(@[]);
            }
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in event.allTouches) {
        if ([self.pointMutY containsObject:touch]) {
            
        }else {
            if (self.pointMutY.count <= 0) {
                CGPoint point=[touch locationInView:self];
                //分
                //当手指按下的时候就创建一条路径
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path setLineWidth:_lineWidth];
                [_lineColor setStroke];
                [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                [path moveToPoint:point];
                [self.pointMutYPath addObject:path];
                [self.pointMutY addObject:touch];
                
                if (self.block_) {
                    self.block_(@[]);
                }
            }
        }
    }
    
    for (UITouch *touch in event.allTouches) {
        
        CGPoint point = [touch locationInView:self]; //touch.view
        
        for (int i=0; i<self.pointMutY.count; i++) {
            
            UITouch *touchM = self.pointMutY[i];
            if (touchM == touch) {
                
                UIBezierPath *myPathM = self.pointMutYPath[i];
                
                [myPathM addLineToPoint:point];
                // 重绘
                [self setNeedsDisplay];
            }
        }
        
        //动画 延时消失
        UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-22, point.y-22, 44, 44)];
        dot.clipsToBounds = YES;
        dot.image = [UIImage imageNamed:@"center_img17"];
        [self addSubview:dot];
        [UIView animateWithDuration:0.3 animations:^{
            dot.alpha = 0;
        } completion:^(BOOL finished) {
            [dot removeFromSuperview];
        }];
        
        if (!self.poin_HandImgV) {
            self.poin_HandImgV = [HistoryRecordModel createImgImgView];
            self.poin_HandImgV.image = [UIImage imageNamed:@"center_img17"];
            [self addSubview:self.poin_HandImgV];
        }
        self.poin_HandImgV.hidden = NO;
        self.poin_HandImgV.frame = CGRectMake(point.x-22, point.y-22, 44, 44);
        
        float ww_yy = 100 - point.y*100/self.height;
        
        if (self.point_YY3==0) {
            self.point_YY3 = ww_yy;
        }
        
        if (ww_yy >= self.point_YY) {
            self.point_YY = ww_yy;
        }
        if (ww_yy < self.point_YY2) {
            self.point_YY2 = ww_yy;
        }
        
        self.point_YY4 = ww_yy;
        
//        [self.pointMutAr addObject:[NSString stringWithFormat:@"%.0f,%.0f", point.x*100/self.width, point.y*100/self.height]];
//        if(self.pointMutAr.count > 3) {
//            if(self.pointMutAr.count%4==0) {
//                if(self.block_) {
//                    self.block_(self.pointMutAr);
//                }
//            }
//        }
    }
}

- (CGFloat)getPointYY
{
    float ww_yy = self.point_YY;
    if (self.point_YY == self.point_YY3) {
        ww_yy = self.point_YY2;
    }
    
    if (self.isShowImg) {
        if (self.js_jsNum==1) {
            ww_yy = self.point_YY4;
        }else {
            self.point_YY = 0;
            self.point_YY2 = 0;
            self.point_YY3 = 0;
        }
        
    }else {
        self.point_YY = 0;
        self.point_YY2 = 0;
        self.point_YY3 = 0;
    }
    NSLog(@"--顺滑-- %.f", ww_yy);
    return ww_yy;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.pointMutAr removeAllObjects];
    self.js_jsNum = 1;
    if (self.isShowImg) {
        self.poin_HandImgV.hidden = NO;
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.poin_HandImgV.y = self.height;
            self.poin_HandImgV.hidden = YES;
        }];
//        self.point_YY = 0;
    }
}

- (void)drawRect:(CGRect)rect {
    
    for (UIBezierPath *path in self.pointMutYPath) {
        //设置颜色
        [_lineColor setStroke];
        // 设置连接处的样式
        [path setLineJoinStyle:kCGLineJoinRound];
        // 设置头尾的样式
        [path setLineCapStyle:kCGLineCapRound];
        //渲染
        [path stroke];
    }
}

@end
