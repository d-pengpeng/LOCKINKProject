//
//  UITextField+MacRange.m
//  DongGuanHome
//
//  Created by lyx on 2017/11/13.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import "UITextField+MacRange.h"

@implementation UITextField (MacRange)

-(void)textMaxRangeMax:(int)max showTip:(BOOL)showTip{
    if (self.text.length > max) {
        
        if (showTip) {
            [SVProgressHUD showErrorWithStatus:@"字数超出限制！"];
        }
        
        UITextRange *markedRange = [self markedTextRange];
        if (markedRange) {
            return;
        }
        //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
        //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:max];
        self.text = [self.text substringToIndex:range.location];
    }
}


-(void)textMaxRangeMin:(int)min max:(int)max ext:(NSString *)text{
    
    if (self.text.length < min || self.text.length > max) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@长度为%d~%d位！",text,min,max]];
        return;
    }
}


@end
