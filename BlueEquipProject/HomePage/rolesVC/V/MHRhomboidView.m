//
//  MHRhomboidView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/4/13.
//

#import "MHRhomboidView.h"

@implementation MHRhomboidView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置为菱形的layer
        self.layer.mask = [self diamondMaskLayer];
    }
    return self;
}

// 创建菱形的mask layer
- (CAShapeLayer *)diamondMaskLayer {
    CGRect bounds = self.bounds;
    CGFloat width = MIN(bounds.size.width, bounds.size.height);
    CGFloat height = width;
    
    // 创建菱形的路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(bounds.origin.x + width / 2.0, bounds.origin.y)];
    [path addLineToPoint:CGPointMake(bounds.origin.x, bounds.origin.y + height / 2.0)];
    [path addLineToPoint:CGPointMake(bounds.origin.x + width / 2.0, bounds.origin.y + height)];
    [path addLineToPoint:CGPointMake(bounds.origin.x + width, bounds.origin.y + height / 2.0)];
    [path closePath];
    
    // 创建CAShapeLayer并设置路径
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}

@end
