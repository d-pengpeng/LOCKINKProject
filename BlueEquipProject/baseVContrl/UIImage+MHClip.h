//
//  MHClip.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MHClip)

+(instancetype)clipImgWithName:(UIImage *)name radius:(CGFloat)radiusL;
@end

NS_ASSUME_NONNULL_END
