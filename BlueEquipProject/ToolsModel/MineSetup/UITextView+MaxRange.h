//
//  UITextView+MaxRange.h
//  DongGuanHome
//
//  Created by lyx on 2017/11/13.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (MaxRange)

-(void)textMaxRangeMax:(int)max showTip:(BOOL)showTip;

-(void)textMaxRangeMin:(int)min max:(int)max ext:(NSString *)text;

@end
