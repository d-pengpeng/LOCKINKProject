//
//  UIButton+MyBtn.h
//  椭圆
//
//  Created by Han on 2017/6/29.
//  Copyright © 2017年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UIButton (MyBtn)
@property (nonatomic, strong) NSNumber *btnAngle;
- (void)zp;
- (void)changeSize;
@end
