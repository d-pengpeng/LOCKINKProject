//
//  keyInputTextField.h
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/2/1.
//  Copyright © 2021 time. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol keyInputTextFieldDelegate;

@interface keyInputTextField : UITextField

@property (nonatomic, assign) id<keyInputTextFieldDelegate> keyinputDelegate;
@end

@protocol keyInputTextFieldDelegate <NSObject>

@optional
- (void)deleteBackwardMkeytextfield:(keyInputTextField *)textF;

//- (BOOL)keytextfield:(keyInputTextField *)textF shouldMMMMChangeTextInRange:(UITextRange *)range replacementText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
