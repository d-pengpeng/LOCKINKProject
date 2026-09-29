//
//  ELKeyboard.m
//  ELKeyboard
//
//  Created by Parkin on 2017/6/29.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELKeyboard.h"
#import "ELKeyboardCenter.h"
#import "ELTVVoiceBtn.h"

#import "ELTextView.h"
#import "ELBrowView.h"
#import "ELMoreView.h"
#import "ELTVVoiceBtn.h"
#import "UIView+Frame.h"

//按钮的宽度
static CGFloat KeyBoardBtnWidth = 34;
static CGFloat KeyboardHeight = 200;

//按钮与边框之间的间距
static CGFloat interval = 5;
//textview与其它按钮的间距
static CGFloat textVItl = 5;
//输入框的高度
static CGFloat textVHight = 34;


#define ELScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ELScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface ELKeyboard ()<ELTextViewDelegate>
//ELKeyboardCenterDelegate
@property (nonatomic, assign) CGFloat initHeight; //初始化 ELKeyboard 的高度

@property (nonatomic, assign) CGFloat oneselfHeight;  //键盘落下和抬起的高度
@property (nonatomic, assign) CGFloat textViewHeight; //textview的高度

@property (nonatomic, assign) BOOL isBecomeFirstResponder;

@property (nonatomic, assign) BOOL isImgSub;

@end

@implementation ELKeyboard

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"isbecome  %d", self.isBecomeFirstResponder);
        _initHeight = frame.size.height;
        self.backgroundColor = RGB(241, 241, 248);
        [self initializa];
    }
    
    return self;
}

- (void)deleELKeyboardCenterMethod
{
//    [[ELKeyboardCenter defaultCenter] deleNotifitMethod];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)repleySubOrBrowVVOrTextVV:(BOOL)boo
{
    self.isImgSub = boo;
    if (boo) {
        _voiceBtn.frame = CGRectMake(interval, (self.height-KeyBoardBtnWidth)/2, 0, KeyBoardBtnWidth);
        _textView.frame = CGRectMake(self->_voiceBtn.right+interval, (self.height-textVHight)/2, self.width-interval-textVItl-KeyBoardBtnWidth-interval, textVHight);
        
    }else {
        _voiceBtn.frame = CGRectMake(interval, (self.height-KeyBoardBtnWidth)/2, KeyBoardBtnWidth, KeyBoardBtnWidth);
        _textView.frame = CGRectMake(self->_voiceBtn.right+interval, (self.height-textVHight)/2, self.width-interval-2*textVItl-2*KeyBoardBtnWidth-interval, textVHight);
    }
}

- (void)initializa
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //更多
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-KeyBoardBtnWidth*2-interval, _voiceBtn.top, KeyBoardBtnWidth*2, KeyBoardBtnWidth)];
//    _moreBtn.backgroundColor = normalBlueColors;
//    _moreBtn.layer.cornerRadius = 17;
    [_moreBtn setTitle:eLocalizedString(@"keyboard_send") forState:UIControlStateNormal];
    [_moreBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = SYS_Font(16);
    _moreBtn.clipsToBounds = YES;
    [_moreBtn addTarget:self action:@selector(sendStartMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_moreBtn];
    
    //表情
    _browView = [[ELBrowView alloc] initWithFrame:CGRectMake(0, 0, self.width, KeyboardHeight)];
    //更多
    _moreView = [[ELMoreView alloc] initWithFrame:CGRectMake(0, 0, self.width, KeyboardHeight)];

    
    _textView = [[ELTextView alloc] initWithFrame:CGRectMake(self->_voiceBtn.right+interval, (self.height-textVHight)/2, self.width-interval-2*textVItl-2*KeyBoardBtnWidth-interval, textVHight)];
    _textView.textDelegate = self;
    _textView.returnKeyType = UIReturnKeySend;
    [self addSubview:_textView];
    
    __weak __typeof(self)weakself = self;
    
    _textView.changeHeightBlock = ^(CGFloat height) {
    
        weakself.frame = CGRectMake(0, ELScreenHeight-(height+(weakself.initHeight-textVHight))-weakself.oneselfHeight, weakself.width, height+(weakself.initHeight-textVHight));
        if (weakself.isImgSub) {
            
            weakself.textView.frame = CGRectMake(textVItl, (weakself.height-height)/2, weakself.width-interval-textVItl-KeyBoardBtnWidth-interval, height);
        }else {
            weakself.textView.frame = CGRectMake(self->_voiceBtn.right+textVItl, (weakself.height-height)/2, weakself.width-interval-2*textVItl-2*KeyBoardBtnWidth-interval, height);
        }
        weakself.textViewHeight = height;
        
        height = (height == textVHight) ? 0 : height-textVHight;
        weakself.voiceBtn.top = weakself.browBtn.top = weakself.moreBtn.top = (weakself.initHeight-KeyBoardBtnWidth)/2+height;
        
    };
    
    _tvVoiceBtn = [[ELTVVoiceBtn alloc] initWithFrame:_textView.bounds];
    [_textView addSubview:_tvVoiceBtn];
    
//    UIView *spaceVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 1)];
//    spaceVV.backgroundColor = GroupBackColor;
//    [self addSubview:spaceVV];
}

//MARK:选择键盘还是表情
- (void)ClickeBrowVVOrTextVV:(BOOL)boo
{
    if (boo) {
        _browBtn.selected = NO;
        [self selectBrowSceneAct];
    }
}

- (void)selectBrowSceneAct
{
     //设置frame
    [self resetFrame];
    
    _tvVoiceBtn.hidden = YES;
    _voiceBtn.selected = NO;
    _moreBtn.selected = NO;
    
    [_textView resignFirstResponder];
    [_textView canCancelContentTouches];
    
    if (!_browBtn.selected) {
        self.isBecomeFirstResponder = NO;
        _textView.inputView = _browView;
    }
    else {
        self.isBecomeFirstResponder = YES;
        _textView.inputView = nil;
    }
    
    [_textView becomeFirstResponder];
    _browBtn.selected = !_browBtn.selected;
}

/*
 resignFirstResponder  让键盘下落
 resignFirstResponder  让键盘抬起
 */


//点击语音按钮
- (void)voiceSceneAction:(UIButton *)button
{
    _browBtn.selected = NO;
    _moreBtn.selected = NO;
    
    if (button.selected) {
        
        //设置frame
        self.textViewHeight = (self.textViewHeight == 0) ? textVHight : self.textViewHeight;
        self.frame = CGRectMake(0, ELScreenHeight-(self.textViewHeight+14)-self.oneselfHeight, self.width, self.textViewHeight+14);
        
        self.textView.frame = CGRectMake(self->_voiceBtn.right+textVItl, (self.height-self.textViewHeight)/2, self.width-interval-2*textVItl-2*KeyBoardBtnWidth-interval, self.textViewHeight);
        
        [self resetBtnFrame];
        
        
        _textView.inputView = nil;
        _tvVoiceBtn.hidden = YES;
        
        self.isBecomeFirstResponder = YES;
        [_textView becomeFirstResponder];
    
    }
    else {
        
        //设置frame 最开始的frame
        self.frame = CGRectMake(0, ELScreenHeight-_initHeight-self.oneselfHeight, self.width, _initHeight);
        self.textView.frame = CGRectMake(self->_voiceBtn.right+textVItl, (self.height-self.textViewHeight)/2, self.width-interval-2*textVItl-2*KeyBoardBtnWidth-interval, self.textViewHeight);
        
        _tvVoiceBtn.height = _textView.height;
        self.voiceBtn.top = self.browBtn.top = self.moreBtn.top = (self.initHeight-KeyBoardBtnWidth)/2;
        
        
        self.isBecomeFirstResponder = NO;
        [_textView resignFirstResponder];
        _tvVoiceBtn.hidden = NO;
        
    }
    
    
    button.selected = !button.selected;
}

//点击表情按钮
- (void)browSceneAction:(UIButton *)button
{
     //设置frame
    [self resetFrame];
    
    _tvVoiceBtn.hidden = YES;
    _voiceBtn.selected = NO;
    _moreBtn.selected = NO;
    
    [_textView resignFirstResponder];
    [_textView canCancelContentTouches];
    
    if (!button.selected) {
        self.isBecomeFirstResponder = NO;
        _textView.inputView = _browView;
        
    }
    else {
        self.isBecomeFirstResponder = YES;
        _textView.inputView = nil;
    }
    
    
    [_textView becomeFirstResponder];
    
    
    button.selected = !button.selected;
    
}

//点击更多按钮
- (void)moreSceneAction:(UIButton *)button
{
     //设置frame
//    [self resetFrame];
//
//    _tvVoiceBtn.hidden = YES;
//    _voiceBtn.selected = NO;
//    _browBtn.selected = NO;
    [_textView resignFirstResponder];
//
//    if (!button.selected) {
//        self.isBecomeFirstResponder = NO;
//        _textView.inputView = _moreView;
//    }
//    else {
//        self.isBecomeFirstResponder = YES;
//        _textView.inputView = nil;
//    }
//
//    [_textView becomeFirstResponder];
//    button.selected = !button.selected;
    
    
    if ([self.delegate respondsToSelector:@selector(addImgELKeyboardDelegate)]) {
        [self.delegate addImgELKeyboardDelegate];
    }
}


//设置frame
- (void)resetFrame
{
    if (_voiceBtn.selected) {
        
        self.textViewHeight = (self.textViewHeight == 0) ? textVHight : self.textViewHeight;
        
        self.frame = CGRectMake(0, ELScreenHeight-(self.textViewHeight+14)-self.oneselfHeight, self.width, self.textViewHeight+14);
//        self.textView.frame = CGRectMake(_voiceBtn.right+textVItl, (self.height-self.textViewHeight)/2, self.width-interval-2*textVItl-3*KeyBoardBtnWidth-interval, self.textViewHeight);
        if (self.isImgSub) {
            self.textView.frame = CGRectMake(textVItl, (self.height-self.textViewHeight)/2, self.width-interval-textVItl-KeyBoardBtnWidth-interval, self.textViewHeight);
        }else {
            self.textView.frame = CGRectMake(self->_voiceBtn.right+textVItl, (self.height-self.textViewHeight)/2, self.width-interval-2*textVItl-2*KeyBoardBtnWidth-interval, self.textViewHeight);
        }
        
        CGFloat height = (self.textViewHeight == textVHight) ? 0 : self.textViewHeight-textVHight;
        self.voiceBtn.top = self.browBtn.top = self.moreBtn.top = (self.initHeight-KeyBoardBtnWidth)/2 + height;
        
        [self resetBtnFrame];
    }
}

- (void)resetBtnFrame
{
    CGFloat height = (self.textViewHeight == textVHight) ? 0 : self.textViewHeight-textVHight;
    self.voiceBtn.top = self.browBtn.top = self.moreBtn.top = (self.initHeight-KeyBoardBtnWidth)/2 + height;

}

#pragma mark - ELKeyboardCenterDelegate

- (void)keyboardWillShow:(NSNotification *)notification {
    
    // 获取通知的信息字典
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:7];
    
    self.top = ELScreenHeight - keyboardRect.size.height - self.height;
    _oneselfHeight = keyboardRect.size.height;
//    [UIView commitAnimations];
    
    // 调用代理
//    if ([self.delegate respondsToSelector:@selector(showOrHiddenKeyboardWithHeight:withDuration:isShow:)]) {
//        [self.delegate showOrHiddenKeyboardWithHeight:keyboardRect.size.height withDuration:animationDuration isShow:YES];
//    }
    
    
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    // 获取通知信息字典
    NSDictionary* userInfo = [notification userInfo];
    
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:7];
    
//    if (TARBARHEIGHT > 50) {
        self.top = ELScreenHeight - TARBARHEIGHT;
//    }else {
//        self.top = ELScreenHeight - self.height;
//    }
    _oneselfHeight = 0.0;
//    [UIView commitAnimations];
    
    // 调用代理
//    if ([self.delegate respondsToSelector:@selector(showOrHiddenKeyboardWithHeight:withDuration:isShow:)]) {
//        [self.delegate showOrHiddenKeyboardWithHeight:0.0 withDuration:animationDuration isShow:NO];
//    }
    
}

- (void)showOrHiddenKeyboardWithHeight:(CGFloat)height withDuration:(CGFloat)animationDuration isShow:(BOOL)isShow{
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:7];
    if (isShow) {
        self.top = ELScreenHeight - height - self.height;
    }else {
        if (TARBARHEIGHT > 50) {
            self.top = ELScreenHeight - height - TARBARHEIGHT;
        }else {
            self.top = ELScreenHeight - height - self.height;
        }
    }
    _oneselfHeight = height;
//    [UIView commitAnimations];
    
}

#pragma mark - ELTextViewDelegate
- (void)sendMessageText:(NSString *)message
{
    if ([self.delegate respondsToSelector:@selector(sendMessageText:)]) {
        [self.delegate sendMessageText:message];
    }
    
    
//    _tvVoiceBtn.hidden = YES;
//    _voiceBtn.selected = NO;
//    [self resetFrame];
//    _browBtn.selected = NO;
    [_textView resignFirstResponder];
//
//    if (!_voiceBtn.selected) {
//        self.isBecomeFirstResponder = NO;
//        _textView.inputView = _moreView;
//    }
//    else {
//        self.isBecomeFirstResponder = YES;
//        _textView.inputView = nil;
//        _voiceBtn.selected = !_voiceBtn.selected;
//    }
//
//    [_textView becomeFirstResponder];
    _textView.text = @"";
}

- (void)sendStartMethod
{
    NSString *stst = _textView.text;

    if ([self.delegate respondsToSelector:@selector(sendMessageText:)]) {
        [self.delegate sendMessageText:stst];
    }
    
//    _tvVoiceBtn.hidden = YES;
//    _voiceBtn.selected = NO;
//    [self resetFrame];
//    _browBtn.selected = NO;
    [_textView resignFirstResponder];
    
//    self.isBecomeFirstResponder = YES;
//    _textView.inputView = nil;
//    _voiceBtn.selected = NO;
    _textView.text = @"";
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (self.isBecomeFirstResponder == NO)
    {
        UITouch *touch = [touches anyObject];
        
        if ([touch.view isKindOfClass:NSClassFromString(@"UITextView")])
        {
            self.voiceBtn.selected = NO;
            self.browBtn.selected = NO;
            self.moreBtn.selected = NO;
            
            [self.textView resignFirstResponder];
            self.textView.inputView = nil;
            [self.textView becomeFirstResponder];
            
            self.isBecomeFirstResponder = YES;
        }
    }
}

- (void)ELKeyboardAddImg:(UIImage *)img isShow:(BOOL)boo
{
    if (boo) {
        _voiceBtn.selected = NO;
        [self resetFrame];
        
        _tvVoiceBtn.hidden = YES;
        
        _browBtn.selected = NO;
        [_textView resignFirstResponder];
        
        self.isBecomeFirstResponder = NO;
        _textView.inputView = _moreView;
        [_textView becomeFirstResponder];
        
        _voiceBtn.selected = YES;
        
        self.moreView.img_vv.image = img;
        
    }else {
        self.moreView.img_vv.image = nil;
        self.textView.text = @"";
        
        _tvVoiceBtn.hidden = YES;
        _voiceBtn.selected = NO;
        [self resetFrame];
        _browBtn.selected = NO;
        [_textView resignFirstResponder];
        
        self.isBecomeFirstResponder = YES;
        _textView.inputView = nil;
        _voiceBtn.selected = NO;
    }
}



@end
