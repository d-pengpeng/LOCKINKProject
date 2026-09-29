//
//  drawLVVVV.m
//  SYChartKit
//
//  Created by Edwin on 2024/3/30.
//

#import "drawLVVVV.h"
#import "SYChartTool.h"

@interface drawLVVVV ()
@property (nonatomic, strong) NSMutableArray *lisMArr;
@property (nonatomic, assign) CGFloat x_wFF;
@property (nonatomic, assign) CGPoint centerPP;
@end

@implementation drawLVVVV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.lisMArr = [NSMutableArray array];
        UIBezierPath *pointPath = [UIBezierPath bezierPath];
        [self.lisMArr addObject:pointPath];
        self.x_wFF = 0;
    }
    return self;
}

- (void)addDataToArr:(NSArray *)arlM
{
    UIBezierPath *pointPath = self.lisMArr[0];
//    UIBezierPath *pointPath = [UIBezierPath bezierPath];
//    [self.lisMArr addObject:pointPath];
    
    CGPoint startPathPoint = CGPointMake(self.x_wFF, self.height);
    if(self.x_wFF > 0) {
        startPathPoint = self.centerPP;
    }
    NSArray *arlM_two = @[];
    if(arlM.count > 1) {
        arlM_two = arlM;
    }else {
        arlM_two = @[arlM[0], arlM[0]];
    }
    for (int i=0; i<arlM_two.count; i++) {
        
        float xx_w = self.height*(1-([minStr(arlM_two[i]) floatValue]/100.f));
        
        CGPoint center = CGPointMake((i * 50  + self.x_wFF), xx_w);
        
        CGPoint point = CGPointMake(self.x_wFF, self.height);
        if(self.x_wFF > 0) {
            point = self.centerPP;
        }
        if(i==0) {
            [pointPath moveToPoint:point];
        }else {
            // 曲线
//            CGPoint midPoint = [SYChartTool midPointForPointsWithP1:startPathPoint p2:center];
//            [pointPath addQuadCurveToPoint:midPoint controlPoint:[SYChartTool controlPointForPointsWithP1:midPoint p2:startPathPoint]];
//            [pointPath addQuadCurveToPoint:center controlPoint:[SYChartTool controlPointForPointsWithP1:midPoint p2:center]];
            
            [pointPath addLineToPoint:center];
            
            UIView *witVV = [[UIView alloc] initWithFrame:CGRectMake(center.x-3, center.y-3, 6, 6)];
            witVV.clipsToBounds = YES;
            witVV.layer.cornerRadius = 3;
            witVV.layer.borderColor = self.lineColor.CGColor;
            witVV.layer.borderWidth = 1;
            [self addSubview:witVV];
        }
        startPathPoint = center;
        if(i==arlM_two.count-1) {
            self.centerPP = center;
        }
    }
    self.x_wFF = arlM_two.count*50-50 + self.x_wFF;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
//    if(self.lisMArr.count > 0) {
//        UIBezierPath *pointPath = self.lisMArr[i];
//       
//        CAShapeLayer *lineLayer = [CAShapeLayer layer];
//        [SYChartTool drawLineWithPath:pointPath lineColor:UIColor.blackColor lineLayer:lineLayer superLayer:self.layer];
//    }
    
    for (int i = 0; i < self.lisMArr.count; i++) {
        UIBezierPath *pointPath = self.lisMArr[i];
       
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        [SYChartTool drawLineWithPath:pointPath lineColor:self.lineColor lineLayer:lineLayer superLayer:self.layer];
    }
}

@end
