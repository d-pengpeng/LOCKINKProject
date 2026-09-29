//
//  showColoUIUIUIView.m
//  testPayProject
//
//  Created by Edwin on 2023/8/24.
//

#import "showColoUIUIUIView.h"

@implementation showColoUIUIUIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.yellowColor;
        
        self.pointMutAr = [NSMutableArray array];
        self.pointMutAr2 = [NSMutableArray array];
        
        self.pathMut = [NSMutableArray array];
        self.pathMut2 = [NSMutableArray array];
        self.pathMut_2 = [NSMutableArray array];
        self.pathMut2_2 = [NSMutableArray array];
        self.numPag = 8;
        self.row_int = 20;
        
        self.poVVVV = [[UIView alloc] initWithFrame:CGRectMake(-18, 10, 12, 12)];
        self.poVVVV.backgroundColor = UIColor.redColor;
        self.poVVVV.layer.cornerRadius = 6;
        self.poVVVV.clipsToBounds = YES;
        [self addSubview:self.poVVVV];
        self.poVVVV.hidden = YES;
        
        self.wid_num = self.frame.size.width / self.row_int;
        
    }
    return self;
}

- (void)addDataPlaceToArr:(NSArray *)arr
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
    
    if(self.pointMutAr.count > self.wid_num) {
        int w_all = (int)(self.pointMutAr.count - self.wid_num);
//        for (int i=0; i<w_all; i++) {
//            [self.pointMutAr removeObjectAtIndex:0];
//        }
        
    }
    
    [self updateXianTiaoUITwo];
}

- (void)addDataToArr:(NSArray *)arr
{
    if(self.isShowCirc) {
        self.poVVVV.backgroundColor = UIColor.clearColor;
    }else {
        self.poVVVV.backgroundColor = self.lineColor;
    }
    for (int i=0; i<self.pathMut_2.count; i++) {
        UIBezierPath *path2 = self.pathMut_2[i];
        [path2 removeAllPoints];
        
        CAShapeLayer *shapeLayer = self.pathMut2_2[i];
        [shapeLayer removeFromSuperlayer];
        [self setNeedsDisplay];//重绘
        
        [self.pathMut_2 removeObjectAtIndex:i];
        [self.pathMut2_2 removeObjectAtIndex:i];
    }
    
    [self setNeedsDisplay];
    
    for (NSString *vsStr in arr) {
        [self.pointMutAr2 addObject:vsStr];
    }
    if(self.pointMutAr2.count > self.wid_num) {
        int w_all = (int)(self.pointMutAr2.count - self.wid_num);
        for (int i=0; i<w_all; i++) {
            [self.pointMutAr2 removeObjectAtIndex:0];
        }
    }
    
    [self updateXianTiaoUI];
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
    for (int i=0; i<self.pathMut_2.count; i++) {
        UIBezierPath *path2 = self.pathMut_2[i];
        [path2 removeAllPoints];
        
        CAShapeLayer *shapeLayer = self.pathMut2_2[i];
        [shapeLayer removeFromSuperlayer];
        [self setNeedsDisplay];//重绘
        
        [self.pathMut_2 removeObjectAtIndex:i];
        [self.pathMut2_2 removeObjectAtIndex:i];
    }
    
    [self setNeedsDisplay];
    [self.pointMutAr removeAllObjects];
    [self.pointMutAr2 removeAllObjects];
    self.poVVVV.hidden = YES;
    
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
    shapeLayer.lineWidth = 2.0;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeColor = self.placeColor.CGColor;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd = 1.0;
    [self.layer addSublayer:shapeLayer];
    
    [self.pathMut addObject:path];
    [self.pathMut2 addObject:shapeLayer];
}

- (void)updateXianTiaoUI
{
    CGPoint p0 = CGPointMake(0.0, self.HH_H);
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i=0; i<self.pointMutAr2.count; i++) {
         
        NSString *twoS = self.pointMutAr2[i];
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
    self.poVVVV.hidden = NO;
    if(array.count>self.numPag) {

        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:p0];
        
        for (NSInteger i=0; i<array.count; i++) {
            CGPoint nowPoint = [array[i] CGPointValue];
            if(self.isfinallyB) {
                if(i < array.count) {
                    [path addLineToPoint:nowPoint];
                    if(i == (array.count-1)) {
                        self.poVVVV.center = nowPoint;
                    }
                }
            }else {
                if(i+self.numPag < array.count) {
                    [path addLineToPoint:nowPoint];
                    if(i == (array.count-self.numPag-1)) {
                        self.poVVVV.center = nowPoint;
                    }
                }
            }
        }
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width,  self.frame.size.height);
        shapeLayer.lineWidth = 2.0;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.strokeColor = [self.lineColor CGColor];
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeStart = 0.0;
        shapeLayer.strokeEnd = 1.0;
        [self.layer addSublayer:shapeLayer];
        
        [self.pathMut_2 addObject:path];
        [self.pathMut2_2 addObject:shapeLayer];
        
        [self addSubview:self.poVVVV];
    }
}


@end
