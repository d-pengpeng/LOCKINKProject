//
//  MHClip.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/10.
//

#import "UIImage+MHClip.h"

@implementation UIImage (MHClip)

+(instancetype)clipImgWithName:(UIImage *)name radius:(CGFloat)radiusL
{
    UIImage *img = name;
    UIGraphicsBeginImageContext(img.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, img.size.width*0.5*M_SQRT2, img.size.height*0.5*M_SQRT2) cornerRadius:radiusL];
    [path applyTransform:CGAffineTransformMakeRotation(M_PI_4)];
    [path applyTransform:CGAffineTransformMakeTranslation(img.size.width*0.5, 0)];
    
    [path addClip];
    
    [img drawAtPoint:CGPointZero];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

@end
