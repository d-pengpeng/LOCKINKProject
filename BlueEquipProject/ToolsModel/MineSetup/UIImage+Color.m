//
//  UIImage+Color.m
//  GatherJobs
//
//  Created by YangLin on 15/7/13.
//  Copyright (c) 2015年 JuPin. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+(instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *originalImage = [UIImage imageNamed:imageName];
    UIImage *backImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return backImage;
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
