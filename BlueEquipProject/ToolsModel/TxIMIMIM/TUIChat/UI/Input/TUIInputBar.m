//
//  TUIInputBar.m
//  UIKit
//
//  Created by kennethmiao on 2018/9/18.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "TUIInputBar.h"
#import "TUIRecordView.h"
#import "TUIDefine.h"
#import "TUITool.h"
#import "TUIDefine.h"
#import <AVFoundation/AVFoundation.h>
#import "ReactiveObjC.h"
#import "UIView+TUILayout.h"
#import "TUIDarkModel.h"
#import "TUIGlobalization.h"

@interface TUIInputBar() <UITextViewDelegate, AVAudioRecorderDelegate>
@property (nonatomic, strong) TUIRecordView *record;
@property (nonatomic, strong) NSDate *recordStartTime;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *recordTimer;
@property (nonatomic, assign) BOOL isLiving;
@end

@implementation TUIInputBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
//        [self setupViews];
//        [self defaultLayout];
    }
    return self;
}

- (void)livingChatGIftAllUIIsShow:(NSInteger)isLiving
{
    self.isLiving = isLiving;
    
    if (isLiving == 1) {
        
        [self setupViewsLiving];//隐藏红包按钮
        [self defaultLayoutLiving];
    }else if (isLiving == 2) {
        
        [self setupViewsLivingBarrage];
        [self defaultLayoutLivingBarrage];
    }else if (isLiving == 4) {
        
        [self setupViewsC2C];
        [self defaultLayoutC2C];
    }else {
        [self setupViews];
        [self defaultLayout];
    }
}

//MARK: 弹幕布局
- (void)setupViewsLivingBarrage
{
    self.backgroundColor = UIColor.clearColor;
    
    self.placeAlph_VV = [[UIView alloc] init];
    self.placeAlph_VV.backgroundColor = UIColor.clearColor;
    [self addSubview:self.placeAlph_VV];
    
    _place_VV = [[UIView alloc] init];
    _place_VV.backgroundColor = UIColor.whiteColor;
    [_place_VV.layer setMasksToBounds:YES];
    [_place_VV.layer setCornerRadius:14.0f];
    [self addSubview:_place_VV];

    _faceButton = [[UIButton alloc] init];
    [_faceButton addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotion" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotionHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [self addSubview:_faceButton];

    _inputTextView = [[TUIResponderTextView alloc] init];
    _inputTextView.delegate = self;
    [_inputTextView setFont:[UIFont systemFontOfSize:16]];
    [_inputTextView.layer setMasksToBounds:YES];
    _inputTextView.textColor = GrayTextColor;
    _inputTextView.backgroundColor = UIColor.clearColor;
    [_inputTextView setReturnKeyType:UIReturnKeySend];
    [self addSubview:_inputTextView];
    
}

- (void)defaultLayoutLivingBarrage
{
    CGFloat l_Margin = 20;
    CGSize buttonSize = TTextView_Button_Size;
    CGFloat buttonOriginY = (TTextView_Height - buttonSize.height) * 0.5;
    
    self.placeAlph_VV.frame = self.bounds;
//    self.placeAlph_VV.backgroundColor = RGBA(0, 0, 0, 0.4);
    self.placeAlph_VV.backgroundColor = UIColor.clearColor;
    
    _faceButton.frame = CGRectMake(self.width - buttonSize.width - l_Margin, buttonOriginY, buttonSize.width, buttonSize.height);

    CGFloat beginX = l_Margin+10;
    CGFloat endX = _faceButton.frame.origin.x - l_Margin-10;
    
    _inputTextView.frame = CGRectMake(beginX, (TTextView_Height - TTextView_TextView_Height_Min) * 0.5, endX - beginX, TTextView_TextView_Height_Min);
    
    CGFloat beginX_two = l_Margin;
    CGFloat endX_two = _faceButton.frame.origin.x+_faceButton.frame.size.width+10;
    _place_VV.frame = CGRectMake(beginX_two, (TTextView_Height - TTextView_TextView_Height_Min) * 0.5, endX_two - beginX_two, TTextView_TextView_Height_Min);
}

//MARK: 直播间布局
- (void)setupViewsLiving
{
    self.backgroundColor = UIColor.whiteColor;

    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color];//[UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color_Dark];
    [self addSubview:_lineView];

    _crownButton = [[UIButton alloc] init];
    [_crownButton addTarget:self action:@selector(clickCrownBtn) forControlEvents:UIControlEventTouchUpInside];
    [_crownButton setImage:[UIImage imageNamed:@"living_input_crown"] forState:UIControlStateNormal];
    [self addSubview:_crownButton];
    
    _place_VV = [[UIView alloc] init];
    _place_VV.backgroundColor = [UIColor d_colorWithColorLight:TInput_Background_Color dark:TInput_Background_Color];//[UIColor d_colorWithColorLight:TInput_Background_Color dark:TInput_Background_Color_Dark];
    [_place_VV.layer setMasksToBounds:YES];
    [_place_VV.layer setCornerRadius:4.0f];
    [self addSubview:_place_VV];
    
    _lookButton = [[UIButton alloc] init];
    [_lookButton addTarget:self action:@selector(clickLookBtn) forControlEvents:UIControlEventTouchUpInside];
    [_lookButton setImage:[UIImage imageNamed:@"living_input_look"] forState:UIControlStateNormal];
    [_lookButton setImage:[UIImage imageNamed:@"living_input_noLook"] forState:UIControlStateSelected];
    [self addSubview:_lookButton];

    _faceButton = [[UIButton alloc] init];
    [_faceButton addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotion" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotionHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [self addSubview:_faceButton];

    _keyboardButton = [[UIButton alloc] init];
    [_keyboardButton addTarget:self action:@selector(clickKeyboardBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_keyboardButton setImage:[UIImage d_imageNamed:@"ToolViewKeyboard" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_keyboardButton setImage:[UIImage d_imageNamed:@"ToolViewKeyboardHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    _keyboardButton.hidden = YES;
    [self addSubview:_keyboardButton];

    _redbagButton = [[UIButton alloc] init];
    [_redbagButton addTarget:self action:@selector(clickRedbagBtn) forControlEvents:UIControlEventTouchUpInside];
    [_redbagButton setImage:[UIImage imageNamed:@"living_input_redbag"] forState:UIControlStateNormal];
    [self addSubview:_redbagButton];
    
    _giftButton = [[UIButton alloc] init];
    [_giftButton addTarget:self action:@selector(clickGiftBtn) forControlEvents:UIControlEventTouchUpInside];
    [_giftButton setImage:[UIImage imageNamed:@"living_input_gift"] forState:UIControlStateNormal];
    [self addSubview:_giftButton];

    _inputTextView = [[TUIResponderTextView alloc] init];
    _inputTextView.delegate = self;
    [_inputTextView setFont:[UIFont systemFontOfSize:16]];
    [_inputTextView.layer setMasksToBounds:YES];
    _inputTextView.backgroundColor = UIColor.clearColor;
    _inputTextView.textColor = GrayTextColor;
    [_inputTextView setReturnKeyType:UIReturnKeySend];
    [self addSubview:_inputTextView];
    
   
}

- (void)defaultLayoutLiving
{
    CGFloat l_Margin = 10;
    _lineView.frame = CGRectMake(0, 0, Screen_Width, TLine_Heigh);
    CGSize buttonSize = TTextView_Button_Size;
    CGFloat buttonOriginY = (TTextView_Height - buttonSize.height) * 0.5;
    _crownButton.frame = CGRectMake(l_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _lookButton.frame = CGRectMake(l_Margin*2+buttonSize.width, buttonOriginY, buttonSize.width, buttonSize.height);
    
    _giftButton.frame = CGRectMake(Screen_Width - buttonSize.width - l_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _redbagButton.frame = CGRectMake(Screen_Width - buttonSize.width*2 - l_Margin*2, buttonOriginY, buttonSize.width, buttonSize.height);
    _faceButton.frame = CGRectMake(Screen_Width - buttonSize.width*3 - l_Margin*3, buttonOriginY, buttonSize.width, buttonSize.height);
//    _faceButton.frame = CGRectMake(Screen_Width - buttonSize.width*2 - l_Margin*2, buttonOriginY, buttonSize.width, buttonSize.height);
    
    _keyboardButton.frame = _faceButton.frame;

    CGFloat beginX = _lookButton.frame.origin.x + _lookButton.frame.size.width + l_Margin;
    CGFloat endX = _faceButton.frame.origin.x - l_Margin;
    
    _inputTextView.frame = CGRectMake(beginX, (TTextView_Height - TTextView_TextView_Height_Min) * 0.5, endX - beginX, TTextView_TextView_Height_Min);
    
    CGFloat beginX_two = _crownButton.frame.origin.x + _crownButton.frame.size.width;
    CGFloat endX_two = _redbagButton.frame.origin.x;
//    CGFloat endX_two = _giftButton.frame.origin.x;
    _place_VV.frame = CGRectMake(beginX_two, (TTextView_Height - TTextView_TextView_Height_Min) * 0.5, endX_two - beginX_two, TTextView_TextView_Height_Min);
}

//MARK: 简单布局
- (void)setupViews
{
    self.backgroundColor = TInput_Background_Color;//[UIColor d_colorWithColorLight:TInput_Background_Color dark:TInput_Background_Color_Dark];

    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = TLine_Color;//[UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color_Dark];
    [self addSubview:_lineView];

    _micButton = [[UIButton alloc] init];
    [_micButton addTarget:self action:@selector(clickVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_micButton setImage:[UIImage d_imageNamed:@"ToolViewInputVoice" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_micButton setImage:[UIImage d_imageNamed:@"ToolViewInputVoiceHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [self addSubview:_micButton];

    _faceButton = [[UIButton alloc] init];
    [_faceButton addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotion" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotionHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [self addSubview:_faceButton];

    _keyboardButton = [[UIButton alloc] init];
    [_keyboardButton addTarget:self action:@selector(clickKeyboardBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_keyboardButton setImage:[UIImage d_imageNamed:@"ToolViewKeyboard" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_keyboardButton setImage:[UIImage d_imageNamed:@"ToolViewKeyboardHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    _keyboardButton.hidden = YES;
    [self addSubview:_keyboardButton];

//    _moreButton = [[UIButton alloc] init];
//    [_moreButton addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_moreButton setImage:[UIImage d_imageNamed:@"TypeSelectorBtn_Black" bundle:TUIChatBundle] forState:UIControlStateNormal];
//    [_moreButton setImage:[UIImage d_imageNamed:@"TypeSelectorBtnHL_Black" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
//    [self addSubview:_moreButton];

    _recordButton = [[UIButton alloc] init];
    [_recordButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_recordButton.layer setMasksToBounds:YES];
    [_recordButton.layer setCornerRadius:4.0f];
    [_recordButton.layer setBorderWidth:0.5f];
//    [_recordButton.layer setBorderColor:[UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color_Dark].CGColor];
    [_recordButton.layer setBorderColor:TLine_Color.CGColor];
    [_recordButton addTarget:self action:@selector(recordBtnDown:) forControlEvents:UIControlEventTouchDown];
    [_recordButton addTarget:self action:@selector(recordBtnUp:) forControlEvents:UIControlEventTouchUpInside];
    [_recordButton addTarget:self action:@selector(recordBtnCancel:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [_recordButton addTarget:self action:@selector(recordBtnExit:) forControlEvents:UIControlEventTouchDragExit];
    [_recordButton addTarget:self action:@selector(recordBtnEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal];
//    [_recordButton setTitle:eLocalizedString(@"im_callSound1") forState:UIControlStateNormal];
//    [_recordButton setTitleColor:[UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark] forState:UIControlStateNormal];
    [_recordButton setTitleColor:TText_Color forState:UIControlStateNormal];
    _recordButton.hidden = YES;
    [self addSubview:_recordButton];

    _inputTextView = [[TUIResponderTextView alloc] init];
    _inputTextView.delegate = self;
    [_inputTextView setFont:[UIFont systemFontOfSize:16]];
    [_inputTextView.layer setMasksToBounds:YES];
    [_inputTextView.layer setCornerRadius:4.0f];
    [_inputTextView.layer setBorderWidth:0.5f];
//    [_inputTextView.layer setBorderColor:[UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color_Dark].CGColor];
    [_inputTextView.layer setBorderColor:TLine_Color.CGColor];
    [_inputTextView setReturnKeyType:UIReturnKeySend];
    [self addSubview:_inputTextView];
}

- (void)defaultLayout
{
    _lineView.frame = CGRectMake(0, 0, Screen_Width, TLine_Heigh);
    CGSize buttonSize = TTextView_Button_Size;
    CGFloat buttonOriginY = (TTextView_Height - buttonSize.height) * 0.5;
    _micButton.frame = CGRectMake(TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _keyboardButton.frame = _micButton.frame;
//    _moreButton.frame = CGRectMake(Screen_Width - buttonSize.width - TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
//    _faceButton.frame = CGRectMake(_moreButton.frame.origin.x - buttonSize.width - TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _faceButton.frame = CGRectMake(Screen_Width - buttonSize.width - TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);

    CGFloat beginX = _micButton.frame.origin.x + _micButton.frame.size.width + TTextView_Margin;
    CGFloat endX = _faceButton.frame.origin.x - TTextView_Margin;
    _recordButton.frame = CGRectMake(beginX, (TTextView_Height - TTextView_TextView_Height_Min) * 0.5, endX - beginX, TTextView_TextView_Height_Min);
    _inputTextView.frame = _recordButton.frame;
}

//MARK: C2C样式
- (void)setupViewsC2C
{
    self.backgroundColor = RGB(247, 247, 247);//[UIColor d_colorWithColorLight:TInput_Background_Color dark:TInput_Background_Color_Dark];

    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = RGB(180, 166, 188);//TLine_Color;
    [self addSubview:_lineView];

    _micButton = [[UIButton alloc] init];
    [_micButton addTarget:self action:@selector(clickVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_micButton setImage:[UIImage d_imageNamed:@"ToolViewInputVoice" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_micButton setImage:[UIImage imageNamed:@"message_allImg8"] forState:UIControlStateNormal];
//    [_micButton setImage:[UIImage d_imageNamed:@"ToolViewInputVoiceHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [_micButton setImage:[UIImage imageNamed:@"message_allImg8"] forState:UIControlStateHighlighted];
    [self addSubview:_micButton];
    
    _faceButton = [[UIButton alloc] init];
    [_faceButton addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotion" bundle:TUIChatBundle] forState:UIControlStateNormal];
//    [_faceButton setImage:[UIImage d_imageNamed:@"ToolViewEmotionHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [_faceButton setImage:[UIImage imageNamed:@"message_allImg9"] forState:UIControlStateNormal];
    [_faceButton setImage:[UIImage imageNamed:@"message_allImg9"] forState:UIControlStateHighlighted];
    [self addSubview:_faceButton];

    _keyboardButton = [[UIButton alloc] init];
    [_keyboardButton addTarget:self action:@selector(clickKeyboardBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_keyboardButton setImage:[UIImage d_imageNamed:@"ToolViewKeyboard" bundle:TUIChatBundle] forState:UIControlStateNormal];
    [_keyboardButton setImage:[UIImage d_imageNamed:@"ToolViewKeyboardHL" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    _keyboardButton.hidden = YES;
    [self addSubview:_keyboardButton];

    _moreButton = [[UIButton alloc] init];
    [_moreButton addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    //[_moreButton setImage:[UIImage d_imageNamed:@"TypeSelectorBtn_Black" bundle:TUIChatBundle] forState:UIControlStateNormal];
    //[_moreButton setImage:[UIImage d_imageNamed:@"TypeSelectorBtnHL_Black" bundle:TUIChatBundle] forState:UIControlStateHighlighted];
    [_moreButton setImage:[UIImage imageNamed:@"message_allImg10"] forState:UIControlStateNormal];
    [_moreButton setImage:[UIImage imageNamed:@"message_allImg10"] forState:UIControlStateHighlighted];
    [self addSubview:_moreButton];

    _recordButton = [[UIButton alloc] init];
    [_recordButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_recordButton.layer setMasksToBounds:YES];
    [_recordButton.layer setCornerRadius:4.0f];
    [_recordButton.layer setBorderWidth:0.5f];
//    [_recordButton.layer setBorderColor:[UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color_Dark].CGColor];
    [_recordButton.layer setBorderColor:TLine_Color.CGColor];
    [_recordButton addTarget:self action:@selector(recordBtnDown:) forControlEvents:UIControlEventTouchDown];
    [_recordButton addTarget:self action:@selector(recordBtnUp:) forControlEvents:UIControlEventTouchUpInside];
    [_recordButton addTarget:self action:@selector(recordBtnCancel:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [_recordButton addTarget:self action:@selector(recordBtnExit:) forControlEvents:UIControlEventTouchDragExit];
    [_recordButton addTarget:self action:@selector(recordBtnEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal];
//    [_recordButton setTitle:eLocalizedString(@"im_callSound1") forState:UIControlStateNormal];
//    [_recordButton setTitleColor:[UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark] forState:UIControlStateNormal];
    [_recordButton setTitleColor:TText_Color forState:UIControlStateNormal];
    _recordButton.hidden = YES;
    [self addSubview:_recordButton];

    _inputTextView = [[TUIResponderTextView alloc] init];
    _inputTextView.delegate = self;
    [_inputTextView setFont:[UIFont systemFontOfSize:16]];
    [_inputTextView.layer setMasksToBounds:YES];
    [_inputTextView.layer setCornerRadius:4.0f];
    [_inputTextView.layer setBorderWidth:0.5f];
//    [_inputTextView.layer setBorderColor:[UIColor d_colorWithColorLight:TLine_Color dark:TLine_Color_Dark].CGColor];
    [_inputTextView.layer setBorderColor:TLine_Color.CGColor];
    [_inputTextView setReturnKeyType:UIReturnKeySend];
    _inputTextView.backgroundColor = UIColor.whiteColor;//TInput_Background_Color;
    _inputTextView.textColor = GrayTextColor;
    [self addSubview:_inputTextView];
}

- (void)defaultLayoutC2C
{
    _lineView.frame = CGRectMake(0, 0, Screen_Width, TLine_Heigh);
    CGSize buttonSize = TTextView_Button_Size;
    CGFloat buttonOriginY = (TTextView_Height - buttonSize.height) * 0.5;
    _faceButton.frame = CGRectMake(TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _micButton.frame = CGRectMake(TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _keyboardButton.frame = _micButton.frame;
    _moreButton.frame = CGRectMake(Screen_Width - buttonSize.width - TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);
    _faceButton.frame = CGRectMake(_moreButton.frame.origin.x - buttonSize.width - TTextView_Margin, buttonOriginY, buttonSize.width, buttonSize.height);

    CGFloat beginX = _micButton.frame.origin.x + _micButton.frame.size.width + TTextView_Margin;
//    CGFloat beginX = TTextView_Margin;
    CGFloat endX = _faceButton.frame.origin.x - TTextView_Margin;
    _recordButton.frame = CGRectMake(beginX, (TTextView_Height - TTextView_TextView_Height_Min) * 0.5, endX - beginX, TTextView_TextView_Height_Min);
    _inputTextView.frame = _recordButton.frame;
}

- (void)layoutButton:(CGFloat)height
{
    CGRect frame = self.frame;
    CGFloat offset = height - frame.size.height;
    frame.size.height = height;
    self.frame = frame;

    CGSize buttonSize = TTextView_Button_Size;
    CGFloat bottomMargin = (TTextView_Height - buttonSize.height) * 0.5;
    CGFloat originY = frame.size.height - buttonSize.height - bottomMargin;

    CGRect faceFrame = _faceButton.frame;
    faceFrame.origin.y = originY;
    _faceButton.frame = faceFrame;

    CGRect moreFrame = _moreButton.frame;
    moreFrame.origin.y = originY;
    _moreButton.frame = moreFrame;

    CGRect voiceFrame = _micButton.frame;
    voiceFrame.origin.y = originY;
    _micButton.frame = voiceFrame;
    
    CGRect crownFrame = _crownButton.frame;
    crownFrame.origin.y = originY;
    _crownButton.frame = crownFrame;
    
    CGRect lookFrame = _lookButton.frame;
    lookFrame.origin.y = originY;
    _lookButton.frame = lookFrame;
    
    CGRect redbagFrame = _redbagButton.frame;
    redbagFrame.origin.y = originY;
    _redbagButton.frame = redbagFrame;
    
    CGRect giftFrame = _giftButton.frame;
    giftFrame.origin.y = originY;
    _giftButton.frame = giftFrame;


    if(_delegate && [_delegate respondsToSelector:@selector(inputBar:didChangeInputHeight:)]){
        [_delegate inputBar:self didChangeInputHeight:offset];
    }
}

- (void)clickVoiceBtn:(UIButton *)sender
{
    _recordButton.hidden = NO;
    _inputTextView.hidden = YES;
    _micButton.hidden = YES;
    _keyboardButton.hidden = NO;
    _faceButton.hidden = NO;
    [_inputTextView resignFirstResponder];
    [self layoutButton:TTextView_Height];
    if(_delegate && [_delegate respondsToSelector:@selector(inputBarDidTouchMore:)]){
        [_delegate inputBarDidTouchVoice:self];
    }
    _keyboardButton.frame = _micButton.frame;
}

- (void)clickKeyboardBtn:(UIButton *)sender
{
    _micButton.hidden = NO;
    _keyboardButton.hidden = YES;
    _recordButton.hidden = YES;
    _inputTextView.hidden = NO;
    _faceButton.hidden = NO;
    [self layoutButton:_inputTextView.frame.size.height + 2 * TTextView_Margin];
    if(_delegate && [_delegate respondsToSelector:@selector(inputBarDidTouchKeyboard:)]){
        [_delegate inputBarDidTouchKeyboard:self];
    }
}

- (void)clickFaceBtn:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputClearNote object:nil];
    _micButton.hidden = NO;
    _faceButton.hidden = NO;
//    _keyboardButton.hidden = NO;
    _recordButton.hidden = YES;
    _inputTextView.hidden = NO;
    if(_delegate && [_delegate respondsToSelector:@selector(inputBarDidTouchFace:)]){
        [_delegate inputBarDidTouchFace:self];
    }
//    _keyboardButton.frame = _faceButton.frame;
    
}

- (void)clickMoreBtn:(UIButton *)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(inputBarDidTouchMore:)]){
        [_delegate inputBarDidTouchMore:self];
    }
}

//MARK: 皇冠
- (void)clickCrownBtn
{
    if(_delegate && [_delegate respondsToSelector:@selector(hideFaceVVVVV)]){
        [_delegate hideFaceVVVVV];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputCrownNote object:nil];
}

- (void)clickLookBtn
{
    if(_delegate && [_delegate respondsToSelector:@selector(hideFaceVVVVV)]){
        [_delegate hideFaceVVVVV];
    }
    
    NSDictionary *dic = @{@"type":@""};
    if (_lookButton.selected == YES) {
        dic = @{@"type":@"1"};
    }else {
        dic = @{@"type":@"0"};
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputLookNote object:dic];
}

- (void)clickRedbagBtn
{
    if(_delegate && [_delegate respondsToSelector:@selector(hideFaceVVVVV)]){
        [_delegate hideFaceVVVVV];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputRedbagNote object:nil];
}

- (void)clickGiftBtn
{
    if(_delegate && [_delegate respondsToSelector:@selector(hideFaceVVVVV)]){
        [_delegate hideFaceVVVVV];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputGiftNote object:nil];
}

- (void)recordBtnDown:(UIButton *)sender
{
    AVAudioSessionRecordPermission permission = AVAudioSession.sharedInstance.recordPermission;
    //在此添加新的判定 undetermined，否则新安装后的第一次询问会出错。新安装后的第一次询问为 undetermined，而非 denied。
    if (permission == AVAudioSessionRecordPermissionDenied || permission == AVAudioSessionRecordPermissionUndetermined) {
        [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
            if (!granted) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:TUIKitLocalizableString(TUIKitInputNoMicTitle) message:TUIKitLocalizableString(TUIKitInputNoMicTips) preferredStyle:UIAlertControllerStyleAlert];
                [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitInputNoMicOperateLater) style:UIAlertActionStyleCancel handler:nil]];
                [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitInputNoMicOperateEnable) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIApplication *app = [UIApplication sharedApplication];
                    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([app canOpenURL:settingsURL]) {
                        [app openURL:settingsURL];
                    }
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mm_viewController presentViewController:ac animated:YES completion:nil];
                });
            }
        }];
        return;
    }
    //在此包一层判断，添加一层保护措施。
    if(permission == AVAudioSessionRecordPermissionGranted){
        if(!_record){
            _record = [[TUIRecordView alloc] init];
            _record.frame = [UIScreen mainScreen].bounds;
        }
        [self.window addSubview:_record];
        _recordStartTime = [NSDate date];
        [_record setStatus:Record_Status_Recording];
        _recordButton.backgroundColor = [UIColor lightGrayColor];
        [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputReleaseToSend) forState:UIControlStateNormal];  // @"松开 结束"
//        [_recordButton setTitle:eLocalizedString(@"im_callSound2") forState:UIControlStateNormal];
        [self startRecord];
    }
}

- (void)recordBtnUp:(UIButton *)sender
{
    if (AVAudioSession.sharedInstance.recordPermission == AVAudioSessionRecordPermissionDenied) {
        return;
    }
    _recordButton.backgroundColor = [UIColor clearColor];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal]; // @"按住 说话"
//    [_recordButton setTitle:eLocalizedString(@"im_callSound1") forState:UIControlStateNormal];
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_recordStartTime];
    if(interval < 1){
        [_record setStatus:Record_Status_TooShort];
        [self cancelRecord];
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.record removeFromSuperview];
        });
    } else if(interval > 60) {
        [_record setStatus:Record_Status_TooLong];
        if (self.recordTimer == nil) {
            // 此时超时回调已经在处理了，忽略
            return;
        }
        [self cancelRecord];
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.record removeFromSuperview];
        });
    } else{
        [_record removeFromSuperview];
        NSString *path = [self stopRecord];
        _record = nil;
        if (path) {
            if(_delegate && [_delegate respondsToSelector:@selector(inputBar:didSendVoice:)]){
                [_delegate inputBar:self didSendVoice:path];
            }
        }
    }
}

- (void)recordBtnCancel:(UIButton *)sender
{
    [_record removeFromSuperview];
    _recordButton.backgroundColor = [UIColor clearColor];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal]; // @"按住 说话"
//    [_recordButton setTitle:eLocalizedString(@"im_callSound1") forState:UIControlStateNormal];
    [self cancelRecord];
}

- (void)recordBtnExit:(UIButton *)sender
{
    [_record setStatus:Record_Status_Cancel];
//    [_recordButton setTitle:eLocalizedString(@"im_callSound2") forState:UIControlStateNormal];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputReleaseToCancel) forState:UIControlStateNormal]; //  @"松开 取消"
}

- (void)recordBtnEnter:(UIButton *)sender
{
    [_record setStatus:Record_Status_Recording];
//    [_recordButton setTitle:eLocalizedString(@"im_callSound2") forState:UIControlStateNormal];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputReleaseToSend) forState:UIControlStateNormal]; //  @"松开 结束"
}

#pragma mark - talk

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.keyboardButton.hidden = YES;
    self.micButton.hidden = NO;
    self.faceButton.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputClearNote object:nil];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [_inputTextView sizeThatFits:CGSizeMake(_inputTextView.frame.size.width, TTextView_TextView_Height_Max)];
    CGFloat oldHeight = _inputTextView.frame.size.height;
    CGFloat newHeight = size.height;

    if(newHeight > TTextView_TextView_Height_Max){
        newHeight = TTextView_TextView_Height_Max;
    }
    if(newHeight < TTextView_TextView_Height_Min){
        newHeight = TTextView_TextView_Height_Min;
    }
    if(oldHeight == newHeight){
        return;
    }

    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect textFrame = ws.inputTextView.frame;
        textFrame.size.height += newHeight - oldHeight;
        ws.inputTextView.frame = textFrame;
        
        CGRect textFrame_place = ws.place_VV.frame;
        textFrame_place.size.height += newHeight - oldHeight;
        ws.place_VV.frame = textFrame_place;
        
        [ws layoutButton:newHeight + 2 * TTextView_Margin];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        if(_delegate && [_delegate respondsToSelector:@selector(inputBar:didSendText:)]) {
            NSString *sp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (sp.length == 0) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:TUIKitLocalizableString(TUIKitInputBlankMessageTitle) message:nil preferredStyle:UIAlertControllerStyleAlert];
                [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(Confirm) style:UIAlertActionStyleDefault handler:nil]];
                [self.mm_viewController presentViewController:ac animated:YES completion:nil];
            } else {
                [_delegate inputBar:self didSendText:textView.text];
                [self clearInput];
            }
        }
        return NO;
    }
    else if ([text isEqualToString:@""]) {
        if (textView.text.length > range.location) {
            // 一次性删除 [微笑] 这种表情消息
            if ([textView.text characterAtIndex:range.location] == ']') {
                NSUInteger location = range.location;
                NSUInteger length = range.length;
                int left = 91;     // '[' 对应的ascii码
                int right = 93;    // ']' 对应的ascii码
                while (location != 0) {
                    location --;
                    length ++ ;
                    int c = (int)[textView.text characterAtIndex:location];     // 将字符转换成ascii码，复制给int  避免越界
                    if (c == left) {
                        textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                        return NO;
                    }
                    else if (c == right) {
                        return YES;
                    }
                }
            }
            // 一次性删除 @xxx 这种 @ 消息
            else if ([textView.text characterAtIndex:range.location] == ' ') {
                NSUInteger location = range.location;
                NSUInteger length = range.length;
                int at = 64;    // '@' 对应的ascii码
                while (location != 0) {
                    location --;
                    length ++ ;
                    int c = (int)[textView.text characterAtIndex:location]; // 将字符转成ascii码，复制给int,避免越界
                    if (c == at) {
                        NSString *atText = [textView.text substringWithRange:NSMakeRange(location, length)];
                        textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(inputBar:didDeleteAt:)]) {
                            [self.delegate inputBar:self didDeleteAt:atText];
                        }
                        return NO;
                    }
                }
            }
        }
    }
    // 监听 @ 字符的输入，包含全角/半角
    else if ([text isEqualToString:@"@"] || [text isEqualToString:@"＠"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(inputBarDidInputAt:)]) {
            [self.delegate inputBarDidInputAt:self];
        }
    }
    return YES;
}

- (void)clearInput
{
    _inputTextView.text = @"";
    [self textViewDidChange:_inputTextView];
}

- (NSString *)getInput
{
    return _inputTextView.text;
}

- (void)addEmoji:(NSString *)emoji
{
    [_inputTextView setText:[_inputTextView.text stringByAppendingString:emoji]];
    if(_inputTextView.contentSize.height > TTextView_TextView_Height_Max){
        float offset = _inputTextView.contentSize.height - _inputTextView.frame.size.height;
        [_inputTextView scrollRectToVisible:CGRectMake(0, offset, _inputTextView.frame.size.width, _inputTextView.frame.size.height) animated:YES];
    }
    [self textViewDidChange:_inputTextView];
}

- (void)backDelete
{
    [self textView:_inputTextView shouldChangeTextInRange:NSMakeRange(_inputTextView.text.length - 1, 1) replacementText:@""];
    [self textViewDidChange:_inputTextView];
}

- (void)updateTextViewFrame
{
    [self textViewDidChange:[UITextView new]];
}

- (void)startRecord
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [session setActive:YES error:&error];

    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatMPEG4AAC],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];

    NSString *path = [TUIKit_Voice_Path stringByAppendingString:[TUITool genVoiceName:nil withExtension:@"m4a"]];
    NSURL *url = [NSURL fileURLWithPath:path];
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    [_recorder record];
    [_recorder updateMeters];

    _recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(recordTick:) userInfo:nil repeats:YES];
}

- (void)recordTick:(NSTimer *)timer{
    [_recorder updateMeters];
    float power = [_recorder averagePowerForChannel:0];
    [_record setPower:power];
    
    //在此处添加一个时长判定，如果时长超过60s，则取消录制，提示时间过长,同时不再显示 recordView。
    //此处使用 recorder 的属性，使得录音结果尽量精准。注意：由于语音的时长为整形，所以 60.X 秒的情况会被向下取整。但因为 ticker 0.5秒执行一次，所以因该都会在超时时显示为60s
    NSTimeInterval interval = _recorder.currentTime;
    if(interval >= 55 && interval < 60){
        NSInteger seconds = 60 - interval;
        NSString *secondsString = [NSString stringWithFormat:TUIKitLocalizableString(TUIKitInputWillFinishRecordInSeconds),(long)seconds + 1];//此处加long，是为了消除编译器警告。此处 +1 是为了向上取整，优化时间逻辑。
        _record.title.text = secondsString;
    }
    if(interval >= 60){
        NSString *path = [self stopRecord];
        [_record setStatus:Record_Status_TooLong];
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.record removeFromSuperview];
        });
        if (path) {
            if(_delegate && [_delegate respondsToSelector:@selector(inputBar:didSendVoice:)]){
                [_delegate inputBar:self didSendVoice:path];
            }
        }
    }
    
}


- (NSString *)stopRecord
{
    if(_recordTimer){
        [_recordTimer invalidate];
        _recordTimer = nil;
    }
    if([_recorder isRecording]){
        [_recorder stop];
    }
    return _recorder.url.path;
}

- (void)cancelRecord
{
    if(_recordTimer){
        [_recordTimer invalidate];
        _recordTimer = nil;
    }
    if([_recorder isRecording]){
        [_recorder stop];
    }
    NSString *path = _recorder.url.path;
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

@end
