//
//  UIImage+Color.h
//  GatherJobs
//
//  Created by YangLin on 15/7/13.
//  Copyright (c) 2015年 JuPin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)


/**
 keep the original picture

 @param imageName picture name
 @return UIImage
 */
+(instancetype)imageWithOriginalName:(NSString *)imageName;


+ (UIImage*) createImageWithColor: (UIColor*) color;


@end
