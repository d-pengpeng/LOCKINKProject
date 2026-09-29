//
//  UIColor+Transform.h
//  Unity-iPhone
//
//  Created by HZ.CHEN on 16/4/29.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Transform)
+ (id)getColor:(NSString *) hexColor;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;
@end
