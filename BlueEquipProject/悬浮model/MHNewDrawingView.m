//
//  MHNewDrawingView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/13.
//

#import "MHNewDrawingView.h"
#import <QuartzCore/QuartzCore.h>
#include <sys/sysctl.h>

@interface MHNewDrawingView ()

@property (nonatomic, strong) UIImageView *poin_HandImgV;
@property (nonatomic, strong) UIImageView *poin_HandImgV2;
@property (nonatomic, assign) BOOL js_jsAll;
@property (nonatomic, assign) int js_jsNum;
@property (nonatomic, assign) int js_jsNum2;

@end

@implementation MHNewDrawingView

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
  
        CGFloat ww_hwwy = (self.width-84)/2;
        if (!self.poin_HandImgV) {
            self.poin_HandImgV = [HistoryRecordModel createImgImgView];
            self.poin_HandImgV.frame = CGRectMake(ww_hwwy/2-22, self.height-64, 44, 44);
            self.poin_HandImgV.image = [UIImage imageNamed:@"center_img18"];
            [self addSubview:self.poin_HandImgV];
        }
        
        if (!self.poin_HandImgV2) {
            self.poin_HandImgV2 = [HistoryRecordModel createImgImgView];
            self.poin_HandImgV2.frame = CGRectMake(ww_hwwy+ww_hwwy/2-22, self.height-64, 44, 44);
            self.poin_HandImgV2.image = [UIImage imageNamed:@"center_img17"];
            [self addSubview:self.poin_HandImgV2];
        }
    }
    return self;
}

//清除
- (void)clean {

    [self.pointMutY removeAllObjects];
    [self.pointMutYPath removeAllObjects];
    
    //重绘
    [self setNeedsDisplay];
    
//    self.poin_HandImgV.hidden = YES;
    self.point_YY = 0;
    self.point_YY2 = 0;
    self.point_YY3 = 0;
    
    self.point2_YY = 0;
    self.point2_YY2 = 0;
    self.point2_YY3 = 0;
    
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
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self];
        //当手指按下的时候就创建一条路径
        if (self.pointMutY.count <= 0) {
            
            if ((point.x>=self.poin_HandImgV.x)&&(point.x<=self.poin_HandImgV.x+self.poin_HandImgV.width)&&(point.y>=self.poin_HandImgV.y)&&(point.y<=self.poin_HandImgV.y+self.poin_HandImgV.height)) {
                self.js_jsNum = 0;
                
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path setLineWidth:_lineWidth];
                [_lineColor setStroke];
                [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                [path moveToPoint:point];
                [self.pointMutYPath addObject:path];
                
                [self.pointMutY addObject:touch];
                
                if (self.block_) {
                    self.block_();
                }
                
                self.js_jsAll = NO;
            }
            if (self.pointMutY.count<=0) {
                if ((point.x>=self.poin_HandImgV2.x)&&(point.x<=self.poin_HandImgV2.x+self.poin_HandImgV2.width)&&(point.y>=self.poin_HandImgV2.y)&&(point.y<=self.poin_HandImgV2.y+self.poin_HandImgV2.height)) {
                    self.js_jsNum2 = 0;
                    
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    [path setLineWidth:_lineWidth];
                    [_lineColor setStroke];
                    [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                    [path moveToPoint:point];
                    [self.pointMutYPath addObject:path];
                    
                    [self.pointMutY addObject:touch];
                    
                    if (self.block_) {
                        self.block_();
                    }
                    self.js_jsAll = YES;
                }
            }
            
        }
        if (self.pointMutY.count == 1) {
            
            if (self.js_jsAll) {
                if ((point.x>=self.poin_HandImgV.x)&&(point.x<=self.poin_HandImgV.x+self.poin_HandImgV.width)&&(point.y>=self.poin_HandImgV.y)&&(point.y<=self.poin_HandImgV.y+self.poin_HandImgV.height)) {
                    self.js_jsNum = 0;
                    
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    [path setLineWidth:_lineWidth];
                    [_lineColor setStroke];
                    [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                    [path moveToPoint:point];
                    [self.pointMutYPath addObject:path];
                    
                    [self.pointMutY addObject:touch];
                    
                    if (self.block_) {
                        self.block_();
                    }
                }
            }else {
                if ((point.x>=self.poin_HandImgV2.x)&&(point.x<=self.poin_HandImgV2.x+self.poin_HandImgV2.width)&&(point.y>=self.poin_HandImgV2.y)&&(point.y<=self.poin_HandImgV2.y+self.poin_HandImgV2.height)) {
                    self.js_jsNum2 = 0;
                    
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    [path setLineWidth:_lineWidth];
                    [_lineColor setStroke];
                    [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                    [path moveToPoint:point];
                    [self.pointMutYPath addObject:path];
                    
                    [self.pointMutY addObject:touch];
                    
                    if (self.block_) {
                        self.block_();
                    }
                }
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
                if ((point.x>=self.poin_HandImgV.x)&&(point.x<=self.poin_HandImgV.x+self.poin_HandImgV.width)&&(point.y>=self.poin_HandImgV.y)&&(point.y<=self.poin_HandImgV.y+self.poin_HandImgV.height)) {
                    self.js_jsNum = 0;
                    //当手指按下的时候就创建一条路径
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    [path setLineWidth:_lineWidth];
                    [_lineColor setStroke];
                    [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                    [path moveToPoint:point];
                    [self.pointMutYPath addObject:path];
                    [self.pointMutY addObject:touch];
                    
                    if (self.block_) {
                        self.block_();
                    }
                    self.js_jsAll = NO;
                }
                
                if (self.pointMutY.count<=0) {
                    if ((point.x>=self.poin_HandImgV2.x)&&(point.x<=self.poin_HandImgV2.x+self.poin_HandImgV2.width)&&(point.y>=self.poin_HandImgV2.y)&&(point.y<=self.poin_HandImgV2.y+self.poin_HandImgV2.height)) {
                        self.js_jsNum2 = 0;
                        //当手指按下的时候就创建一条路径
                        UIBezierPath *path = [UIBezierPath bezierPath];
                        [path setLineWidth:_lineWidth];
                        [_lineColor setStroke];
                        [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                        [path moveToPoint:point];
                        [self.pointMutYPath addObject:path];
                        [self.pointMutY addObject:touch];
                        
                        if (self.block_) {
                            self.block_();
                        }
                        
                        self.js_jsAll = YES;
                    }
                }
                
            }
            if (self.pointMutY.count == 1) {
                CGPoint point=[touch locationInView:self];
                
                if (self.js_jsAll) {
                    if ((point.x>=self.poin_HandImgV.x)&&(point.x<=self.poin_HandImgV.x+self.poin_HandImgV.width)&&(point.y>=self.poin_HandImgV.y)&&(point.y<=self.poin_HandImgV.y+self.poin_HandImgV.height)) {
                        self.js_jsNum = 0;
                        //当手指按下的时候就创建一条路径
                        UIBezierPath *path = [UIBezierPath bezierPath];
                        [path setLineWidth:_lineWidth];
                        [_lineColor setStroke];
                        [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                        [path moveToPoint:point];
                        [self.pointMutYPath addObject:path];
                        [self.pointMutY addObject:touch];
                        
                        if (self.block_) {
                            self.block_();
                        }
                    }
                }else {
                    if ((point.x>=self.poin_HandImgV2.x)&&(point.x<=self.poin_HandImgV2.x+self.poin_HandImgV2.width)&&(point.y>=self.poin_HandImgV2.y)&&(point.y<=self.poin_HandImgV2.y+self.poin_HandImgV2.height)) {
                        self.js_jsNum2 = 0;
                        //当手指按下的时候就创建一条路径
                        UIBezierPath *path = [UIBezierPath bezierPath];
                        [path setLineWidth:_lineWidth];
                        [_lineColor setStroke];
                        [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
                        [path moveToPoint:point];
                        [self.pointMutYPath addObject:path];
                        [self.pointMutY addObject:touch];
                        
                        if (self.block_) {
                            self.block_();
                        }
                    }
                }
            }
        }
    }
    
    for (UITouch *touch in event.allTouches) {
        
        CGPoint point = [touch locationInView:self];
        
        for (int i=0; i<self.pointMutY.count; i++) {
            
            UITouch *touchM = self.pointMutY[i];
            if (touchM == touch) {
                
                UIBezierPath *myPathM = self.pointMutYPath[i];
                
                [myPathM addLineToPoint:point];
                // 重绘
                [self setNeedsDisplay];
                
                
                if (self.js_jsAll) {
                    if (i==1) {
                        
                        //动画 延时消失
//                        UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-22, point.y-22, 44, 44)];
//                        dot.clipsToBounds = YES;
//                        dot.image = [UIImage imageNamed:@"center_img18"];
//                        [self addSubview:dot];
//                        [UIView animateWithDuration:0.3 animations:^{
//                            dot.alpha = 0;
//                        } completion:^(BOOL finished) {
//                            [dot removeFromSuperview];
//                        }];
                        
                        self.point_boo = YES;
                        if (!self.poin_HandImgV) {
                            self.poin_HandImgV = [HistoryRecordModel createImgImgView];
                            self.poin_HandImgV.image = [UIImage imageNamed:@"center_img18"];
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
                        
                    }else {
                        //动画 延时消失
//                        UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-22, point.y-22, 44, 44)];
//                        dot.clipsToBounds = YES;
//                        dot.image = [UIImage imageNamed:@"center_img17"];
//                        [self addSubview:dot];
//                        [UIView animateWithDuration:0.3 animations:^{
//                            dot.alpha = 0;
//                        } completion:^(BOOL finished) {
//                            [dot removeFromSuperview];
//                        }];
                        self.point_boo2 = YES;
                        if (!self.poin_HandImgV2) {
                            self.poin_HandImgV2 = [HistoryRecordModel createImgImgView];
                            self.poin_HandImgV2.image = [UIImage imageNamed:@"center_img17"];
                            [self addSubview:self.poin_HandImgV2];
                        }
                        self.poin_HandImgV2.hidden = NO;
                        self.poin_HandImgV2.frame = CGRectMake(point.x-22, point.y-22, 44, 44);
                        
                        float ww_yy = 100 - point.y*100/self.height;
                        
                        if (self.point2_YY3==0) {
                            self.point2_YY3 = ww_yy;
                        }
                        
                        if (ww_yy >= self.point2_YY) {
                            self.point2_YY = ww_yy;
                        }
                        if (ww_yy < self.point2_YY2) {
                            self.point2_YY2 = ww_yy;
                        }
                        self.point2_YY4 = ww_yy;
                    }
                }else {
                    if (i==0) {
                        
                        //动画 延时消失
//                        UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-22, point.y-22, 44, 44)];
//                        dot.clipsToBounds = YES;
//                        dot.image = [UIImage imageNamed:@"center_img18"];
//                        [self addSubview:dot];
//                        [UIView animateWithDuration:0.3 animations:^{
//                            dot.alpha = 0;
//                        } completion:^(BOOL finished) {
//                            [dot removeFromSuperview];
//                        }];
                        self.point_boo = YES;
                        if (!self.poin_HandImgV) {
                            self.poin_HandImgV = [HistoryRecordModel createImgImgView];
                            self.poin_HandImgV.image = [UIImage imageNamed:@"center_img18"];
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
                        
                    }else {
                        //动画 延时消失
//                        UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-22, point.y-22, 44, 44)];
//                        dot.clipsToBounds = YES;
//                        dot.image = [UIImage imageNamed:@"center_img17"];
//                        [self addSubview:dot];
//                        [UIView animateWithDuration:0.3 animations:^{
//                            dot.alpha = 0;
//                        } completion:^(BOOL finished) {
//                            [dot removeFromSuperview];
//                        }];
                        self.point_boo2 = YES;
                        if (!self.poin_HandImgV2) {
                            self.poin_HandImgV2 = [HistoryRecordModel createImgImgView];
                            self.poin_HandImgV2.image = [UIImage imageNamed:@"center_img17"];
                            [self addSubview:self.poin_HandImgV2];
                        }
                        self.poin_HandImgV2.hidden = NO;
                        self.poin_HandImgV2.frame = CGRectMake(point.x-22, point.y-22, 44, 44);
                        
                        float ww_yy = 100 - point.y*100/self.height;
                        
                        if (self.point2_YY3==0) {
                            self.point2_YY3 = ww_yy;
                        }
                        
                        if (ww_yy >= self.point2_YY) {
                            self.point2_YY = ww_yy;
                        }
                        if (ww_yy < self.point2_YY2) {
                            self.point2_YY2 = ww_yy;
                        }
                        self.point2_YY4 = ww_yy;
                    }
                }
            }
        }
    }
    
    if (!self.point_boo) {
        if (!self.isShowImg) {
            CGFloat ww_hwwy = (self.width-84)/2;
            [UIView animateWithDuration:0.3 animations:^{
                self.poin_HandImgV.y = self.height-64;
                self.poin_HandImgV.x = ww_hwwy/2-22;
            }];
        }
    }
    
    if (!self.point_boo2) {
        if (!self.isShowImg2) {
            CGFloat ww_hwwy = (self.width-84)/2;
            [UIView animateWithDuration:0.3 animations:^{
                self.poin_HandImgV2.y = self.height-64;
                self.poin_HandImgV2.x = ww_hwwy+ww_hwwy/2-22;
            }];
        }
    }
}
//电击
- (CGFloat)getPointYY
{
    float ww_yy = self.point2_YY;
    if (self.point2_YY == self.point2_YY3) {
        ww_yy = self.point2_YY2;
    }
    if (self.isShowImg2) {
        if (self.js_jsNum2==1) {
            ww_yy = self.point2_YY4;
        }else {
            self.point2_YY = 0;
            self.point2_YY2 = 0;
            self.point2_YY3 = 0;
        }
        
    }else {
        self.point2_YY = 0;
        self.point2_YY2 = 0;
        self.point2_YY3 = 0;
    }
    self.point_boo = NO;
    self.point_boo2 = NO;
    
    NSLog(@"--顺滑-- %.f", ww_yy);
    return ww_yy;
}
//旋转
- (CGFloat)getPointYYTwo
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
    
    for (UITouch *touch in event.allTouches) {
        
        if (self.pointMutY.count==1) {
            if ([self.pointMutY containsObject:touch]) {
                
                self.js_jsNum = 1;
                self.js_jsNum2 = 1;
            }
        }
        if (self.pointMutY.count==2) {
            for (int i=0; i<2; i++) {
                UITouch *touchPPP = self.pointMutY[i];
                if (touchPPP == touch) {
                    if (self.js_jsAll) {
                        if (i==0) {
                            self.js_jsNum2 = 1;
                        }else {
                            self.js_jsNum = 1;
                        }
                    }else {
                        if (i==0) {
                            self.js_jsNum = 1;
                        }else {
                            self.js_jsNum2 = 1;
                        }
                    }
                }
            }
        }
    }
    
    if ((self.js_jsNum==1)&&(self.js_jsNum2==1)) {
        [self.pointMutY removeAllObjects];
        [self.pointMutYPath removeAllObjects];
    }else {
        if ((self.js_jsNum==1)&&!self.point_boo2) {
            [self.pointMutY removeAllObjects];
            [self.pointMutYPath removeAllObjects];
        }
        if ((self.js_jsNum2==1)&&!self.point_boo) {
            [self.pointMutY removeAllObjects];
            [self.pointMutYPath removeAllObjects];
        }
        if (!self.point_boo&&!self.point_boo2) {
            [self.pointMutY removeAllObjects];
            [self.pointMutYPath removeAllObjects];
        }
    }
    
    if (self.js_jsNum==1) {
        if (self.isShowImg) {
            self.poin_HandImgV.hidden = NO;
        }else {
            
            CGFloat ww_hwwy = (self.width-84)/2;
            [UIView animateWithDuration:0.3 animations:^{
                self.poin_HandImgV.y = self.height-64;
                self.poin_HandImgV.x = ww_hwwy/2-22;
            }];
        }
    }
    
    if (self.js_jsNum2==1) {
        if (self.isShowImg2) {
            self.poin_HandImgV2.hidden = NO;
        }else {
            
            CGFloat ww_hwwy = (self.width-84)/2;
            [UIView animateWithDuration:0.3 animations:^{
                self.poin_HandImgV2.y = self.height-64;
                self.poin_HandImgV2.x = ww_hwwy+ww_hwwy/2-22;
            }];
        }
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
