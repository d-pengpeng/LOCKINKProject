//
//  MHshowColoUITwoView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/6.
//

#import "MHshowColoUITwoView.h"

@implementation MHshowColoUITwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.pointMutAr = [NSMutableArray array];
        self.pointMutAr2 = [NSMutableArray array];
        
        self.pathMut = [NSMutableArray array];
        self.pathMut2 = [NSMutableArray array];
        self.row_int = 20;
        
    }
    return self;
}

- (void)addDataToArr:(NSArray *)arr
{
//    for (int i=0; i<self.pathMut.count; i++) {
//        UIBezierPath *path2 = self.pathMut[i];
//        [path2 removeAllPoints];
//
//        CAShapeLayer *shapeLayer = self.pathMut2[i];
//        [shapeLayer removeFromSuperlayer];
//        [self setNeedsDisplay];//重绘
//
//        [self.pathMut removeObjectAtIndex:i];
//        [self.pathMut2 removeObjectAtIndex:i];
//    }
    [self setNeedsDisplay];
    
    for (NSString *vsStr in arr) {
        [self.pointMutAr addObject:vsStr];
    }
    [self updateXianTiaoUITwo];
}



- (void)updateXianTiaoUITwo
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint p0 = CGPointMake(0.0, self.HH_H);
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i=0; i<self.pointMutAr.count; i++) {

        NSString *twoS = self.pointMutAr[i];
        float two_hh = self.HH_H*(1-([twoS floatValue]/100.f));
        
        NSString *MM = [NSString stringWithFormat:@"%.f", two_hh];
        [array2 addObject:MM];
    }
 
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<array2.count; i++) {
        int yy_wx = [array2[i] intValue];
        if(i==0) {
            
            p0 = CGPointMake(0.0+self.row_int*i, yy_wx);
            NSValue *v0 = [NSValue valueWithCGPoint:p0];
            [array addObject:v0];
            [array addObject:v0];
        }else {
            CGPoint p3 = CGPointMake(0.0+self.row_int*i, yy_wx);
            NSValue *v3 = [NSValue valueWithCGPoint:p3];
            [array addObject:v3];
        }
    }
    [path moveToPoint:p0];
    
    for (NSInteger i=0; i<array.count; i++) {
        CGPoint nowPoint = [array[i] CGPointValue];
        [path addLineToPoint:nowPoint];
    }

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width,  self.frame.size.height);
    shapeLayer.lineWidth = 1.0;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeColor = self.lineColor.CGColor;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd = 1.0;
    [self.layer addSublayer:shapeLayer];
    
    [self.pathMut addObject:path];
    [self.pathMut2 addObject:shapeLayer];
}

- (void)clearArrMethod
{
    for (int i=0; i<self.pathMut.count; i++) {
        UIBezierPath *path2 = self.pathMut[i];
        [path2 removeAllPoints];
        
        CAShapeLayer *shapeLayer = self.pathMut2[i];
        [shapeLayer removeFromSuperlayer];
        [self setNeedsDisplay];//重绘
        
        [self.pathMut removeObjectAtIndex:i];
        [self.pathMut2 removeObjectAtIndex:i];
    }
    
    [self setNeedsDisplay];
    [self.pointMutAr removeAllObjects];
    [self.pointMutAr2 removeAllObjects];
    
}

@end
