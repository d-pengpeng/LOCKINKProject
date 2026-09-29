//
//  keyInputTextField.m
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/2/1.
//  Copyright © 2021 time. All rights reserved.
//

#import "keyInputTextField.h"

@implementation keyInputTextField

- (void)deleteBackward
{
    [super deleteBackward];
    if (self.keyinputDelegate && [self.keyinputDelegate respondsToSelector:@selector(deleteBackwardMkeytextfield:)]) {
        [self.keyinputDelegate deleteBackwardMkeytextfield:self];
    }
}

//- (BOOL)shouldChangeTextInRange:(UITextRange *)range replacementText:(NSString *)text
//{
//    [super shouldChangeTextInRange:range replacementText:text];
//    if (self.keyinputDelegate && [self.keyinputDelegate respondsToSelector:@selector(keytextfield:shouldMMMMChangeTextInRange:replacementText:)]) {
//        [self.keyinputDelegate keytextfield:self shouldMMMMChangeTextInRange:range replacementText:text];
//    }
//    return YES;
//}

@end
