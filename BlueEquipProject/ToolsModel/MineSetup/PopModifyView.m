//
//  PopModifyView.m
//  DongGuanHome
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import "PopModifyView.h"
#import "UIButton+Disable.h"
#import "UITextField+MacRange.h"
#import "JZLYFactory.h"

@implementation PopModifyView

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, _window_width-30*2, 170)];
        self.bgView.backgroundColor = normalColors;//[UIColor grayColor];
        self.bgView.layer.cornerRadius = 5;
        self.bgView.layer.masksToBounds = YES;
        self.bgView.alpha = 0;
        self.bgView.center = self.center;
        
        UIView *VV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, 170)];
        VV.backgroundColor = RGBA(235, 253, 255, 0.50);
        [self.bgView addSubview:VV];
        
//        closeBnt = [UIButton buttonWithType:UIButtonTypeSystem];
//        [closeBnt setBackgroundImage:[UIImage imageNamed:@"mine_info_close"] forState:0];
//        closeBnt.frame = CGRectMake(_window_width-30*2-22, 0, 22, 22);
//        [closeBnt addTarget:self action:@selector(closeBnt) forControlEvents:UIControlEventTouchUpInside];
//        [self.bgView addSubview:closeBnt];
        
        self.lab_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bgView.frame.size.width, 44)];
        self.lab_title.font = SYS_Font(14);
        self.lab_title.textColor = GrayText;
        self.lab_title.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:self.lab_title];
        
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.lab_title.frame)+5, self.bgView.width-40, 44)];
        self.textfield.placeholder = @"";
        self.textfield.layer.borderColor = RGB(250, 250, 250).CGColor;
        self.textfield.layer.borderWidth = 0.3;
        self.textfield.font = SYS_Font(14);
        self.textfield.textColor = GrayTextColor;
        self.textfield.layer.cornerRadius = 4;
        self.textfield.backgroundColor = UIColor.whiteColor;
        [self.bgView addSubview:self.textfield];
        
        self.textfield.leftViewMode = UITextFieldViewModeAlways;
        self.textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
        self.textfield.leftView = leftView;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChangeText:) name:UITextFieldTextDidChangeNotification object:self.textfield];
        
        
        self.textfield_phone = [[UITextField alloc]init];
        self.textfield_phone.placeholder = @"";
//        self.textfield_phone.borderStyle = UITextBorderStyleRoundedRect;
        self.textfield_phone.font = SYS_Font(15);
        self.textfield_phone.keyboardType = UIKeyboardTypeDecimalPad;
        [self.bgView addSubview:self.textfield_phone];
        self.textfield_phone.hidden = YES;
        self.textfield_phone.textColor = GrayTextColor;
        self.textfield_phone.leftViewMode = UITextFieldViewModeAlways;
        self.textfield_phone.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView *leView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
        self.textfield_phone.leftView = leView;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChangeTextPhone:) name:UITextFieldTextDidChangeNotification object:self.textfield_phone];
        
        self.lab_name = [[UILabel alloc]init];
        self.lab_name.font = SYS_Font(15);
        self.lab_name.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:self.lab_name];
        
        self.lab_phone = [[UILabel alloc]init];
        self.lab_phone.font = SYS_Font(15);
        self.lab_phone.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:self.lab_phone];
        
        self.switchView = [[UISwitch alloc]init];
        [self.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
        [self.bgView addSubview: self.switchView];
        
        self.lab_name.hidden = YES;
        self.lab_phone.hidden = YES;
        self.textfield.hidden = YES;
        self.textfield_phone.hidden = YES;
        self.switchView.hidden = YES;
        
        self.bnt_ok = [UIButton buttonWithType:UIButtonTypeSystem];
        self.bnt_ok.frame = CGRectMake(40, CGRectGetMaxY(self.textfield.frame)+20, _window_width-30*2-40*2, 33);
        self.bnt_ok.backgroundColor = normalColors;
        self.bnt_ok.layer.cornerRadius = 5;
        self.bnt_ok.layer.masksToBounds = YES;
        [self.bnt_ok setTitle:eLocalizedString(@"home_edit_save") forState:0];
        [self.bnt_ok setTintColor:[UIColor whiteColor]];
        [self.bnt_ok addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:self.bnt_ok];
        
        [self.bnt_ok disable];
        
        UITapGestureRecognizer *tapInputView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInputViewAction:)];
        tapInputView.numberOfTapsRequired = 1;
        [self.bgView addGestureRecognizer:tapInputView];
        
        // 监听键盘改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        // 监听文本框输入改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextFieldText) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextFieldText) name:UITextFieldTextDidBeginEditingNotification object:nil];
        
        _isAddFamily = NO;
        
    }
    return self;
}

-(void)setIsAddFamily:(BOOL)isAddFamily{
    if (isAddFamily) {
        
        _isAddFamily = isAddFamily;
        
        self.lab_name.hidden = NO;
        self.lab_phone.hidden = NO;
        self.textfield.hidden = NO;
        self.textfield_phone.hidden = NO;
        
        CGRect rect_bg = self.bgView.frame;
        rect_bg.size.height = 170+50;
        [self.bgView setFrame:rect_bg];
        
        CGFloat width_ = [JZLYFactory widthWithText:@"类目" font:15 sizeWidth:100];
        
        self.lab_name.frame = CGRectMake(20, self.lab_title.frame.origin.y+self.lab_title.frame.size.height+5, width_, 40);
        
        
        CGFloat widsta_ = self.lab_name.frame.origin.x+self.lab_name.frame.size.width+8;
        CGRect rect_name = self.textfield.frame;
        rect_name.origin.x = widsta_;
        rect_name.size.width = _window_width-30*2-widsta_-20;
        [self.textfield setFrame:rect_name];
        
        self.lab_phone.frame = CGRectMake(20, self.lab_name.frame.origin.y+self.lab_name.frame.size.height+10, width_, 40);
        
        self.textfield_phone.frame = CGRectMake(widsta_, self.lab_name.frame.origin.y+self.lab_name.frame.size.height+10, _window_width-30*2-widsta_-20, 40);
        
        self.lab_name.text = @"类目";
        self.lab_phone.text = @"金额";
        [self.bnt_ok setTitle:@"添加" forState:0];
        self.textfield.placeholder = @"请输入";
        self.textfield_phone.placeholder = @"请输入";
        
        CGRect rect_ok = self.bnt_ok.frame;
        rect_ok.origin.y = self.textfield_phone.frame.origin.y+self.textfield_phone.frame.size.height+20;
        [self.bnt_ok setFrame:rect_ok];
    }
}

-(void)setIsSingleCommit:(BOOL)isSingleCommit{
    
    _isSingleCommit = isSingleCommit;
    if (isSingleCommit) {
        
        self.textfield.hidden = NO;
    }else {
        self.lab_name.hidden = NO;
        self.lab_phone.hidden = NO;
        self.textfield.hidden = NO;
        self.textfield_phone.hidden = NO;
    }
}

- (void)setIsSecureTextF:(BOOL)isSecureTextF
{
    if (isSecureTextF) {
        self.textfield.secureTextEntry = YES;
    }
}

-(void)setIsShowPower:(BOOL)isShowPower{
    if (isShowPower) {
        
        //
        CGFloat width_ = [JZLYFactory widthWithText:@"房源被带看时是否需要确认：" font:15 sizeWidth:200];
        self.lab_name.hidden = NO;
        self.lab_name.frame = CGRectMake(20, self.lab_title.frame.origin.y+self.lab_title.frame.size.height+5, width_, 40);
        //
        self.lab_name.text = @"房源被带看时是否需要确认：";
        self.bnt_ok.hidden = YES;
        self.switchView.hidden = NO;
        
        
        self.switchView.frame = CGRectMake(self.lab_name.frame.origin.x+self.lab_name.frame.size.width, self.lab_title.frame.origin.y+self.lab_title.frame.size.height+10, 120.0f, 28.0f);
        
        
        CGRect rect_bg = self.bgView.frame;
        rect_bg.size.height = 170-50;
        [self.bgView setFrame:rect_bg];
        
    }
}

-(void)setValueWithPower:(BOOL) isOn{
    self.switchView.on = isOn;//设置初始为ON的一边
}


-(void)switchAction:(UISwitch *)sender{
    self.blockCallBackSwitch(sender);
}


-(void)setIs_sendValues:(NSDictionary *)is_sendValues{
    self.textfield.text = is_sendValues[@"name"];
    self.textfield_phone.text = is_sendValues[@"phone"];
    self.textfield.placeholder = @"您家人的姓名";
    self.textfield_phone.placeholder = @"您家人的手机号码";
    [self.bnt_ok setTitle:eLocalizedString(@"home_edit_save") forState:0];
}

-(void)setTitleString:(NSString *)titleString{
    self.lab_title.text = titleString;

    self.textfield.placeholder = eLocalizedString(@"postPlaza_placeText");
    
}

-(void)setTitleStringPlaceHoder:(NSString *)titleStringPlaceHoder{
    self.textfield.placeholder = titleStringPlaceHoder;
}

-(void)setTitleStringSureAction:(NSString *)titleStringSureAction{
    [self.bnt_ok setTitle:titleStringSureAction forState:0];
}

-(void)tapAction:(UITapGestureRecognizer *)tap{

    if (self.BlockCloseToMod) {
        self.BlockCloseToMod(@"");
    }
    [self removiewThealL];

}

-(void)closeBnt {
    if (self.BlockCloseToMod) {
        self.BlockCloseToMod(@"");
    }
    [self removiewThealL];
}

-(void)removiewThealL{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 1;
    }];
    
}

-(void)tapInputViewAction:(UITapGestureRecognizer *)tap{
    [self.textfield resignFirstResponder];
}


#pragma mark 通知方法

/** 键盘frame即将改变的通知 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 键盘下去了
        if (keyboardF.origin.y >= _window_height) {
            CGPoint center = self.center;
            center.y = _window_height / 2;
            self.bgView.center = center;
            // 键盘上来了
        } else {
            CGRect frame = self.bgView.frame;
            frame.origin.y = keyboardF.origin.y - frame.size.height - 2; // 2是输入框和键盘的间隙，自己调..
            self.bgView.frame = frame;
        }
    }];
}

/** 监听文本框输入改变/开始输入的通知 刷新确认按钮的enable状态 */
- (void)checkTextFieldText {
    if (_isAddFamily) {
        if (self.textfield.text.length > 0 && self.textfield_phone.text.length > 0) {
            [self.bnt_ok enable];
        }else{
            [self.bnt_ok disable];
        }
    }else{
        if (self.textfield.text.length > 0) {
            [self.bnt_ok enable];
        }else{
            [self.bnt_ok disable];
        }
    }
}

#pragma mark---传值----
-(void)sureAction:(UIButton *)sender{

    if (self.isSingleCommit) {
        
        if (self.textfield.text.length == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"不能为空"];
        }else{
            self.blockTextToModify(self.textfield.text,self.textfield_phone.text);
            [self.textfield_phone resignFirstResponder];
            [self.textfield resignFirstResponder];
            [self removiewThealL];
        }
        
    }else {
        
        if ((self.textfield.text.length == 0)||(self.textfield_phone.text.length == 0)) {

            [SVProgressHUD showErrorWithStatus:@"不能为空"];
        }else{
            self.blockTextToModify(self.textfield.text,self.textfield_phone.text);
            [self.textfield_phone resignFirstResponder];
            [self.textfield resignFirstResponder];
            [self removiewThealL];
        }
    }
}

-(void)textFieldDidChangeText:(NSNotification *)notify{
    //
    if([self.lab_title.text isEqualToString:@"修改昵称"]){
        
        UITextField *textfield = notify.object;
        [textfield textMaxRangeMax:20 showTip:NO];
    }

}



-(void)textFieldDidChangeTextPhone:(NSNotification *)notify{
    //MARK: 限制位数
    [self.textfield_phone textMaxRangeMax:11 showTip:NO];

}

@end
