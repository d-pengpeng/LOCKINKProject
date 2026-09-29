//
//  JZLYFactory.m
//  GatherJobs
//
//  Created by LYX on 15/6/27.
//  Copyright (c) 2015年 JuPin. All rights reserved.
//

#import "JZLYFactory.h"

@implementation JZLYFactory

+(float)heightWithText:(NSString *)text font:(float)fontSize sizeWidth:(float)sizeWidth {
    float height = 0.0;
    NSDictionary *attribute = @{NSFontAttributeName: SYS_Font(fontSize)};
    CGRect rect_ = [text boundingRectWithSize:CGSizeMake(sizeWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil];
    height = rect_.size.height;
    return height;
}

+(float)widthWithText:(NSString *)text font:(float)fontSize sizeWidth:(float)sizeWidth{
    NSDictionary *attribute = @{NSFontAttributeName: SYS_Font(fontSize)};
    CGRect rect_ = [text boundingRectWithSize:CGSizeMake(sizeWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil];
    return rect_.size.width + 0.5;
}

+(CGRect)sizeWithText:(NSString *)text font:(float)fontSize{
    NSDictionary *attribute = @{NSFontAttributeName: SYS_Font(fontSize)};
    CGRect rect_ = [text boundingRectWithSize:CGSizeMake(_window_width-30, 2000) options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil];
    return rect_;
    
}

+(CGRect)sizeWithText:(NSString *)text font:(float)fontSize tSize:(CGSize)tsize{
    NSDictionary *attribute = @{NSFontAttributeName: SYS_Font(fontSize)};
    CGRect rect_ = [text boundingRectWithSize:tsize options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil];
    return rect_;
    
}

+(UILabel *)lable:(UILabel *)lab alignmentText:(NSString *)targetText allTextCount:(int)count_text font:(float)fontSize{
    UILabel *lable = [[UILabel alloc]initWithFrame:lab.frame];
//    float width_one = [JZLYFactory widthWithText:@"你" font:fontSize sizeWidth:1000];
    float count_target = targetText.length;
//    float targetWidth = lab.frame.size.width;
    for (NSInteger index = 0; index < count_target; ) {
    }
    return lable;
}

+(void)startTranslationAnimation:(UIViewController *)vc animationView:(UIViewController *)animationView{
    [UIView transitionWithView:vc.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [vc.navigationController pushViewController:animationView animated:NO];
    } completion:^(BOOL finished) {
    }];
}

+(void)endedTranslationAnimation:(UIViewController *)vc animationView:(UIViewController *)animationView{
    [UIView transitionWithView:vc.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [vc.navigationController popViewControllerAnimated:NO];
    } completion:^(BOOL finished) {
    }];
}


+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

+(void)asycLoadIngTheImageFromNetWork:(NSString *)urlString button:(UIButton *)bnt {
    //开启一个多线程GCD
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);//创建一个队列
    //开启一个线程
    dispatch_async(queue1, ^{
        NSURL *url = [NSURL URLWithString:urlString];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [bnt setBackgroundImage:image forState:UIControlStateNormal];
        });
    });
}

@end
