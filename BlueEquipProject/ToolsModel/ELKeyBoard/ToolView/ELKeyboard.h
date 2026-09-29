//
//  ELKeyboard.h
//  ELKeyboard
//
//  Created by Parkin on 2017/6/29.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELTextView.h"
@protocol ELKeyboardDelegate <NSObject>

- (void)sendMessageText:(NSString *)message;
- (void)addImgELKeyboardDelegate;
@end

@class ELVoiceView, ELBrowView, ELMoreView, ELTVVoiceBtn;
//带有语音、表情、更多按钮 并带有输入框的view
@interface ELKeyboard : UIView

@property (nonatomic, strong) UIButton *voiceBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *moresubBtn;
@property (nonatomic, strong) UIButton *browBtn;
@property (nonatomic, strong) ELTVVoiceBtn *tvVoiceBtn;
@property (nonatomic, strong) ELTextView *textView;

@property (nonatomic, strong) ELBrowView *browView;
@property (nonatomic, strong) ELMoreView *moreView;

@property (nonatomic, weak) id<ELKeyboardDelegate>delegate;

@property (nonatomic, copy) void(^changeHeightBlock)(CGFloat height);

- (void)ClickeBrowVVOrTextVV:(BOOL)boo;

- (void)repleySubOrBrowVVOrTextVV:(BOOL)boo;

- (void)deleELKeyboardCenterMethod;

- (void)ELKeyboardAddImg:(UIImage *)img isShow:(BOOL)boo;

@end
