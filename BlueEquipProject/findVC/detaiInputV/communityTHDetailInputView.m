//
//  communityTHDetailInputView.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/18.
//

#import "communityTHDetailInputView.h"
#import "ELBrowView.h"
#import "LFResultVideo.h"

@interface communityTHDetailInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *allVV;
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) UIView *twoVV;
@property (nonatomic, strong) UIView *thrdV;
@property (nonatomic, strong) NSMutableArray *photoMut;
@property (nonatomic, strong) UIButton *input_sendBtn;
@property (nonatomic, assign) BOOL isFaceT;
@property (nonatomic, assign) BOOL isShowKeyb;
@property (nonatomic, assign) BOOL isImg;
@property (nonatomic) ELBrowView *browFaceView;

@end
@implementation communityTHDetailInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 80)];
        self.oneVV.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.oneVV];
        
        self.twoVV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 50)];
        self.twoVV.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.twoVV];
        
        self.thrdV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 50)];
        self.thrdV.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.thrdV];
        
        UIView *pVV = [[UIView alloc] init];
        pVV.backgroundColor = UIColor.whiteColor;
        [self addSubview:pVV];
        [pVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.thrdV.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.face_Btn = [HistoryRecordModel createImgBtn];
        [self.face_Btn setBackgroundImage:[UIImage imageNamed:@"topic_postTopic_faceImg"] forState:UIControlStateNormal];
        [self.face_Btn addTarget:self action:@selector(allBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.thrdV addSubview:self.face_Btn];
        [self.face_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thrdV.mas_top).offset(13);
            make.left.equalTo(self.thrdV.mas_left).offset(16);
            make.width.height.offset(24);
        }];
        
        self.photo_Btn = [HistoryRecordModel createImgBtn];
        [self.photo_Btn setBackgroundImage:[UIImage imageNamed:@"topic_postTopic_photo"] forState:UIControlStateNormal];
        [self.photo_Btn addTarget:self action:@selector(allBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.thrdV addSubview:self.photo_Btn];
        [self.photo_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.thrdV.mas_centerY);
            make.left.equalTo(self.face_Btn.mas_right).offset(32);
            make.width.height.offset(24);
        }];
        
        self.video_Btn = [HistoryRecordModel createImgBtn];
        [self.video_Btn setBackgroundImage:[UIImage imageNamed:@"topic_postTopic_video"] forState:UIControlStateNormal];
        [self.video_Btn addTarget:self action:@selector(allBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.thrdV addSubview:self.video_Btn];
        [self.video_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.thrdV.mas_centerY);
            make.left.equalTo(self.photo_Btn.mas_right).offset(32);
            make.width.height.offset(24);
        }];
        
        self.input_sendBtn = [HistoryRecordModel createImgBtn];
        [self.input_sendBtn setTitle:eLocalizedString(@"home_send") forState:UIControlStateNormal];
        [self.input_sendBtn setTitleColor:normalPurpleColors forState:UIControlStateNormal];
        self.input_sendBtn.titleLabel.font = SYS_Font(16);
        self.input_sendBtn.backgroundColor = UIColor.clearColor;
        [self.input_sendBtn addTarget:self action:@selector(sendMsgBarrageBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.twoVV addSubview:self.input_sendBtn];
        [self.input_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.twoVV.mas_centerY);
            make.right.equalTo(self.twoVV.mas_right).offset(-16);
            make.width.offset(60);
        }];
        
        self.input_textF = [[UITextField alloc] initWithFrame:CGRectMake(16, 10, self.twoVV.width-90-16, 30)];
        self.input_textF.backgroundColor = RGB(245, 245, 245);
        self.input_textF.layer.cornerRadius = 4;
        self.input_textF.placeholder = eLocalizedString(@"fieldText_place");
        self.input_textF.font = SYS_Font(12);
        self.input_textF.delegate = self;
        self.input_textF.textColor = GrayTextColor;
        self.input_textF.returnKeyType = UIReturnKeySend;
        [self.twoVV addSubview:self.input_textF];
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        leftV.backgroundColor = UIColor.clearColor;
        self.input_textF.leftView = leftV;
        self.input_textF.leftViewMode = UITextFieldViewModeAlways;
        
        self.oneVV.hidden = YES;
        self.thrdV.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionNotification:) name:@"EmotionNotification" object:nil];
    }
    return self;
}

- (void)addImgsArr:(NSArray *)arrImgs video:(NSArray *)arrVideo
{
    [self.oneVV removeAllSubviews];
    [self.photoMut removeAllObjects];
    if (arrImgs.count > 0) {
        
        self.isImg = YES;
        for (UIImage *img in arrImgs) {
            [self.photoMut addObject:img];
        }
        
        self.oneVV.hidden = NO;
        CGFloat ww_wX = self.oneVV.height+20;
        for (int i=0; i<arrImgs.count; i++) {
            LFResultVideo *resultVideo = arrImgs[i];
            
            NSInteger num = i%3;
            UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num, 10, ww_wX, self.oneVV.height-20)];
            [self.oneVV addSubview:cont_VV];
            [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
        }
    }else if (arrVideo.count > 0) {
        self.isImg = NO;
        self.oneVV.hidden = NO;
        
        for (UIImage *img in arrVideo) {
            [self.photoMut addObject:img];
        }
        
        CGFloat ww_wX = self.oneVV.height+20;
        for (int i=0; i<arrVideo.count; i++) {
            LFResultVideo *resultVideo = arrVideo[i];
            
            NSInteger num = i%3;
            UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num, 10, ww_wX, self.oneVV.height-20)];
            [self.oneVV addSubview:cont_VV];
            [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:YES];
        }
        
    }else {
        self.oneVV.hidden = YES;
        if (self.isTwoMsg) {
            self.photo_Btn.hidden = YES;
            self.video_Btn.hidden = YES;
        }
    }
}

- (void)createUIUI:(UIView *)botVV tag:(NSInteger)tagN model:(LFResultVideo *)model isVideo:(BOOL)isVideo
{
    
    UIImageView *bigImgV = [HistoryRecordModel createImgImgView];
    bigImgV.frame = CGRectMake(10, 0, botVV.width-20, botVV.height);
    bigImgV.contentMode = UIViewContentModeScaleAspectFill;
    bigImgV.tag = tagN+200;
    bigImgV.image = model.smallImage;
    [botVV addSubview:bigImgV];
    
//    UIButton *imgBtn = [HistoryRecordModel createImgBtn];
//    imgBtn.frame = CGRectMake(0, 0, botVV.width-10, botVV.height);
//    imgBtn.tag = tagN;
//    [botVV addSubview:imgBtn];
    
    UIButton *deleteBtn = [HistoryRecordModel createImgBtn];
    deleteBtn.frame = CGRectMake(botVV.width-20, 0, 20, 20);
    deleteBtn.tag = tagN+100;
    [deleteBtn setImage:[UIImage imageNamed:@"topic_postTopic_deleImg"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnsMethod:) forControlEvents:UIControlEventTouchUpInside];
    [botVV addSubview:deleteBtn];
    
    if (isVideo) {
        UIImageView *vide_img = [HistoryRecordModel createImgImgView];
        vide_img.image = [UIImage imageNamed:@"topic_postTopic_video"];
        [bigImgV addSubview:vide_img];
        [vide_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bigImgV);
            make.width.height.offset(30);
        }];
    }else {
//        [imgBtn addTarget:self action:@selector(showImgSBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)deleteBtnsMethod:(UIButton *)btn
{
    [self.photoMut removeObjectAtIndex:btn.tag-2200];
    
    if (self.isImg) {
        [self.oneVV removeAllSubviews];
        
        CGFloat ww_wX = self.oneVV.height+20;
        for (int i=0; i<self.photoMut.count; i++) {
            LFResultVideo *resultVideo = self.photoMut[i];

            NSInteger num = i%3;
            UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num, 10, ww_wX, self.oneVV.height-20)];
            [self.oneVV addSubview:cont_VV];
            [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
        }
    }else {
        [self.oneVV removeAllSubviews];
    }
    
    if (self.block_) {
        self.block_(5, [NSString stringWithFormat:@"%ld", btn.tag-2200]);
    }
}

//MARK: 发消息
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    [self.browFaceView removeFromSuperview];
    if (textField.text.length > 0) {
        
        if (self.block_) {
            self.block_(2, self.input_textF.text);
        }
    }
    return YES;
}

- (void)sendMsgBarrageBtn
{
    [self endEditing:YES];
    [self.browFaceView removeFromSuperview];
    if (self.input_textF.text.length > 0) {
        if (self.block_) {
            self.block_(2, self.input_textF.text);
        }
    }
}

- (void)allBtnsClick:(UIButton *)btn
{
    if (btn == self.face_Btn) {
        [self faceBtnMethod];
    }else if (btn == self.photo_Btn) {
        
        if (self.block_) {
            self.block_(3, self.input_textF.text);
        }
    }else if (btn == self.video_Btn) {
        
        if (self.block_) {
            self.block_(4, self.input_textF.text);
        }
    }
}

//MARK: 点击弹幕表情
- (void)faceBtnMethod
{
    [_input_textF resignFirstResponder];
    
    self.thrdV.frame = CGRectMake(0, self.height-180-50, self.width, 50);
    
    self.twoVV.frame = CGRectMake(0, self.thrdV.y-50, self.width, 50);
    
    self.oneVV.frame = CGRectMake(0, self.twoVV.y-80, self.width, 80);

    [self showFaceAnimation];
    _isFaceT = YES;
    self.isShowKeyb = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.oneVV.frame = CGRectMake(0, self.height, self.width, 80);
    self.twoVV.frame = CGRectMake(0, self.height, self.width, 50);
    self.thrdV.frame = CGRectMake(0, self.height, self.width, 50);
    
    self.isShowKeyb = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if(_isFaceT){
        [self hideFaceAnimation];
    }
    _isFaceT = NO;
    
    self.isShowKeyb = YES;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    CGFloat hh_y = keyboardFrame.size.height + self.thrdV.height;
//    self.thrdV.frame = CGRectMake(0, self.height-hh_y, self.width, 50);
//
//    self.twoVV.frame = CGRectMake(0, self.thrdV.y-50, self.width, 50);
//
//    self.oneVV.frame = CGRectMake(0, self.twoVV.y-80, self.width, 80);
    CGFloat hh_y = keyboardFrame.size.height + self.twoVV.height;
    self.twoVV.frame = CGRectMake(0, self.height-hh_y, self.width, 50);
    
    self.oneVV.frame = CGRectMake(0, self.twoVV.y-80, self.width, 80);
}

- (void)hideFaceAnimation
{
    self.browFaceView.hidden = NO;
    self.browFaceView.alpha = 1.0;
    
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        ws.browFaceView.alpha = 0.0;
    } completion:^(BOOL finished) {
        ws.browFaceView.hidden = YES;
        ws.browFaceView.alpha = 1.0;
        [ws.browFaceView removeFromSuperview];
    }];
}

- (void)showFaceAnimation
{
    self.browFaceView = [[ELBrowView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.thrdV.frame), self.width, 180)];
    [self addSubview:self.browFaceView];

    self.browFaceView.hidden = NO;
    CGRect frame = self.browFaceView.frame;
    frame.origin.y = self.height;
    self.browFaceView.frame = frame;

    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect newFrame = ws.browFaceView.frame;
        newFrame.origin.y = ws.thrdV.frame.origin.y + ws.thrdV.frame.size.height;
        ws.browFaceView.frame = newFrame;
    } completion:nil];
}

//MARK:  表情选择
- (void)emotionNotification:(NSNotification *)notification
{
    NSString *text = [notification object];
    
    //删除
    if ([text isEqual:@"Delete_ios7"])
    {
//        [self deleteBackward];
        
    }
    else
    {
        [self.input_textF insertText:(NSString *)text];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.browFaceView.frame = CGRectMake(0, _window_height, _window_width, 200);
        self.thrdV.frame =CGRectMake(0, _window_height, _window_width, 50);
        self.twoVV.frame =CGRectMake(0, _window_height, _window_width, 50);
        self.oneVV.frame =CGRectMake(0, _window_height, _window_width, 80);
        
        if (self.block_) {
            self.block_(1, @"");
        }
    }];
}

- (NSMutableArray *)photoMut
{
    if (!_photoMut) {
        _photoMut = [NSMutableArray array];
    }
    return _photoMut;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EmotionNotification" object:nil];
}

@end
