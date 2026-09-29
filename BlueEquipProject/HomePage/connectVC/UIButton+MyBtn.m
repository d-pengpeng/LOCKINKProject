//
//  UIButton+MyBtn.m
//  椭圆
//
//  Created by Han on 2017/6/29.
//  Copyright © 2017年 Han. All rights reserved.
//

#import "UIButton+MyBtn.h"
#import "UIView+Frame.h"

@implementation UIButton (MyBtn)
- (void)setBtnAngle:(NSNumber *)btnAngle
{
    [self willChangeValueForKey:@"btnAngle"];
    objc_setAssociatedObject(self, "btnAngle",btnAngle, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"btnAngle"];
}
- (NSNumber *)btnAngle
{
    return objc_getAssociatedObject(self, "btnAngle");
}
- (void)zp
{
    if ([self.btnAngle floatValue] >= 1.5 * 36 &&  [self.btnAngle floatValue] <= 3.5 * 36)
    {
        self.layer.zPosition = 3;
    }
    else
    {
        self.layer.zPosition = 2;
    }
    if ([self.btnAngle floatValue] >= 360)
    {
        self.btnAngle = @(0);
    }
}
- (void)changeSize
{
//    if ([self.btnAngle floatValue] >= 1.5 * 36 &&  [self.btnAngle floatValue] <= 3.5 * 36)
//    {
//        self.transform = CGAffineTransformIdentity;
//        self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
//    }
//    else if ([self.btnAngle floatValue] >= 6.5 * 36 &&  [self.btnAngle floatValue] <= 8.5 * 36)
//    {
//        self.transform = CGAffineTransformIdentity;
//        self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
//    }
//    else
//    {
//        self.transform = CGAffineTransformIdentity;
//        self.transform = CGAffineTransformScale(self.transform, 1.0, 1.0);
//    }
    
    if ([self.btnAngle floatValue] >= 1.5 * 36 &&  [self.btnAngle floatValue] <= 2.0 * 36)
    {
        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 1.4, 1.4);
    }
    else if ([self.btnAngle floatValue] >= 2.0 * 36 &&  [self.btnAngle floatValue] <= 2.5 * 36)
    {

        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    }
    else if ([self.btnAngle floatValue] >= 2.5 * 36 &&  [self.btnAngle floatValue] <= 3.5 * 36)
    {

        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    }
    else if ([self.btnAngle floatValue] >= 6.5 * 36 &&  [self.btnAngle floatValue] <= 7.0 * 36)
    {

        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 0.6, 0.6);
    }
    else if ([self.btnAngle floatValue] >= 7.0 * 36 &&  [self.btnAngle floatValue] <= 8.0 * 36)
    {

        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 0.6, 0.6);
    }
    else if ([self.btnAngle floatValue] >= 8.0 * 36 &&  [self.btnAngle floatValue] <= 8.5 * 36)
    {

        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
    }
    else
    {
        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformScale(self.transform, 1.0, 1.0);
    }
}
@end
