//
//  JZLYFactory.h
//  GatherJobs
//
//  Created by LYX on 15/6/27.
//  Copyright (c) 2015年 JuPin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JZLYFactory : NSObject
/**
 *   cal the text size
 *
 *   @param text      cal the text
 *   @param fontSize  text current size
 *   @param sizeWidth the text most length
 *
 *   @return the text all height
 *
 *   @since nil
 */
+(float)heightWithText:(NSString *)text font:(float)fontSize sizeWidth:(float)sizeWidth;

+(float)widthWithText:(NSString *)text font:(float)fontSize sizeWidth:(float)sizeWidth;

/**
 *  cal the size of input text
 */
+(CGRect)sizeWithText:(NSString *)text font:(float)fontSize;

+(CGRect)sizeWithText:(NSString *)text font:(float)fontSize tSize:(CGSize)tsize;

+(UILabel *)lable:(UILabel *)lab alignmentText:(NSString *)text allTextCount:(int)count_text font:(float)fontSize;

/**
 *  animation
 */
+(void)startTranslationAnimation:(UIViewController *)vc animationView:(UIViewController *)animationView;

+(void)endedTranslationAnimation:(UIViewController *)vc animationView:(UIViewController *)animationView;

/**
 *  image orientation
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

+(void)asycLoadIngTheImageFromNetWork:(NSString *)urlString button:(UIButton *)bnt;

@end
