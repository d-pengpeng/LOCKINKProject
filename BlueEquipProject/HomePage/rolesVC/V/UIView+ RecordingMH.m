//
//  UIView+RecordingMH.m
//


#import "UIView+RecordingMH.h"

@implementation UIView (RecordingMH)

-(void)showDrawBoardViewwid:(CGFloat)wid leng:(CGFloat)leng space:(CGFloat)space cornerRadius:(CGFloat)cornRadius color:(UIColor *)colorw
{
    self.layer.cornerRadius = cornRadius;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    shapeLayer.lineWidth = wid;
    
    shapeLayer.lineDashPattern = @[@(leng), @(space)];
    shapeLayer.lineDashPhase = 0.1;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}

-(void)showLine
{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds= CGRectMake(0,0, self.width, self.height);
    borderLayer.position= CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    borderLayer.path= [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
//    borderLayer.path= [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    borderLayer.lineWidth=1./ [[UIScreen mainScreen] scale];//虚线边框
    borderLayer.lineDashPattern= @[@8,@8];//实线边框//
//    borderLayer.lineDashPattern= nil;
    borderLayer.fillColor= [UIColor clearColor].CGColor;
    borderLayer.strokeColor= RGB(202, 76, 255).CGColor;
    [self.layer addSublayer:borderLayer];
    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:self.bounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
//    //设置虚线颜色
//    [shapeLayer setStrokeColor:RGB(202, 76, 255).CGColor];
//    shapeLayer.lineWidth = 0.5;
//    //设置虚线的线宽及间距
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:2], nil]];
//    //创建虚线绘制路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    //设置虚线绘制路径起点
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    //设置虚线绘制路径终点
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
//    //设置虚线绘制路径
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    //添加虚线
//    [self.layer addSublayer:shapeLayer];
}

@end
