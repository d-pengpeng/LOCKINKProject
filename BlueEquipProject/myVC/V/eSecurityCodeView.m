//
//  eSecurityCodeView.m
//  MachineGlory
//
//  Created by Edwin on 2021/2/4.
//  Copyright © 2021 time. All rights reserved.
//

#import "eSecurityCodeView.h"
#import "UIView+Frame.h"
#import "keyInputTextField.h"

@interface eSecurityCodeView ()<keyInputTextFieldDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *messagelab;
@property (nonatomic, copy) NSString *codeSt;
@property (nonatomic, assign) NSInteger isNum;
@end

@implementation eSecurityCodeView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isSetting) {
        
        self.redNavView = YES;
        self.showImgVV = YES;
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        linVV.frame = CGRectMake(0, NAVHEIGHT-1, _window_width, 1);
        linVV.backgroundColor = RGB(121, 121, 121);
        [self.navView addSubview:linVV];
        self.titleName.text = eLocalizedString(@"my_settings24");
        
        UIImageView *imgV = [HistoryRecordModel createImgImgView];
        imgV.image = [UIImage imageNamed:@"lock_img"];
        [self.view addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navView.mas_bottom).offset(40);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.offset(74);
            make.height.offset(86);
        }];
        
        UILabel *oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        oneLab.text = eLocalizedString(@"my_settings28");
        oneLab.numberOfLines = 0;
        [self.view addSubview:oneLab];
        [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(imgV.mas_bottom).offset(30);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        [self acceptUIUIUI];
        self.codeSt = @"";
        
    }else {
        
        self.redNavView = YES;
        self.showImgVV = YES;
        self.hideBackBnt = YES;
        self.navView.frame = CGRectMake(0, 0, _window_width, TIMESTATUSHEIGHT+44);
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        linVV.frame = CGRectMake(0, TIMESTATUSHEIGHT+44-1, _window_width, 1);
        linVV.backgroundColor = RGB(121, 121, 121);
        [self.navView addSubview:linVV];
        self.titleName.text = eLocalizedString(@"my_settings24");
        
        UIImageView *imgV = [HistoryRecordModel createImgImgView];
        imgV.image = [UIImage imageNamed:@"lock_img"];
        [self.view addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navView.mas_bottom).offset(40);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.offset(74);
            make.height.offset(86);
        }];
        
        UILabel *oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        oneLab.text = eLocalizedString(@"my_settings28");
        oneLab.numberOfLines = 0;
        [self.view addSubview:oneLab];
        [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(imgV.mas_bottom).offset(30);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        [self acceptUIUIUITwo];
        self.codeSt = [LYUserDefault userDefault].eSecurityCode;

    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
}

- (void)acceptUIUIUITwo
{
    CGFloat w_texfied = (_window_width -200-60)/2.0;
    
    CGFloat text_yy = TIMESTATUSHEIGHT+44+200;
    
    for (int i=0; i<4; i++) {
        
        keyInputTextField *oneText = [[keyInputTextField alloc] initWithFrame:CGRectMake(w_texfied + 70*i, text_yy, 50, 50)];
        oneText.textColor = UIColor.blackColor;
        oneText.font = CGFontU_Growth(18);
        oneText.textAlignment = NSTextAlignmentCenter;
        oneText.layer.cornerRadius = 5;
        oneText.clipsToBounds = YES;
        oneText.keyboardType = UIKeyboardTypeNumberPad;
        oneText.keyinputDelegate = self;
        oneText.backgroundColor = UIColor.whiteColor;
        oneText.secureTextEntry = YES;
        oneText.tag = 30000+i;
        oneText.delegate = self;
        [self.view addSubview:oneText];
        if (i == 0) {
            [oneText becomeFirstResponder];
        }
    }
    
    UIButton *forgotBtn = [HistoryRecordModel createImgBtn];
    [forgotBtn setTitle:eLocalizedString(@"my_settings31") forState:UIControlStateNormal];
    [forgotBtn setTitleColor:RGB(13, 223, 255) forState:UIControlStateNormal];
    forgotBtn.titleLabel.font = SYS_Font(14);
    [forgotBtn addTarget:self action:@selector(forgotBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotBtn];
    [forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(text_yy+60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(48);
        make.width.offset(100);
    }];
    
//    self.messagelab = [[UILabel alloc] init];
//    self.messagelab.text = eLocalizedString(@"code_password2");
//    self.messagelab.textColor = GrayTextColor;
//    self.messagelab.textAlignment = NSTextAlignmentCenter;
//    self.messagelab.font = SYS_Font(15);
//    [self.view addSubview:self.messagelab];
//    [self.messagelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(text_yy-60);
//        make.height.offset(30);
//    }];
//
//    UILabel *titLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
//    titLLLab.text = eLocalizedString(@"code_password3");
//    [self.view addSubview:titLLLab];
//    [titLLLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(44);
//        make.height.offset(44);
//    }];
    
//    UIView *spacTextV = [[UIView alloc] initWithFrame:CGRectMake(0, text_yy, _window_width, 30)];
//    spacTextV.backgroundColor = UIColor.clearColor;
//    [self.view addSubview:spacTextV];
    
}

- (void)forgotBtnMehtod
{
    [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"my_settings32") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
        if (index == 1) {
            
            [LYUserDefault saveSetLockDisable:NO];
            [LYUserDefault saveSetLock:NO];
            [self dismissViewControllerAnimated:NO completion:^{
                if (self.eSecurityCodBlock) {
                    self.eSecurityCodBlock(2);
                }
            }];
        }
    }];
}

- (void)acceptUIUIUI
{
    CGFloat w_texfied = (_window_width -200-60)/2.0;
    
    CGFloat text_yy = NAVHEIGHT+200;
    
    for (int i=0; i<4; i++) {
        
        keyInputTextField *oneText = [[keyInputTextField alloc] initWithFrame:CGRectMake(w_texfied + 70*i, text_yy, 50, 50)];
        oneText.textColor = UIColor.blackColor;
        oneText.font = CGFontU_Growth(18);
        oneText.textAlignment = NSTextAlignmentCenter;
        oneText.layer.cornerRadius = 5;
        oneText.clipsToBounds = YES;
        oneText.keyboardType = UIKeyboardTypeNumberPad;
        oneText.keyinputDelegate = self;
        oneText.backgroundColor = UIColor.whiteColor;
        oneText.secureTextEntry = YES;
        oneText.tag = 30000+i;
        oneText.delegate = self;
        [self.view addSubview:oneText];
        if (i == 0) {
            [oneText becomeFirstResponder];
        }
    }
    
//    self.messagelab = [[UILabel alloc] init];
//    self.messagelab.text = eLocalizedString(@"my_settings29");
//    self.messagelab.textColor = UIColor.whiteColor;
//    self.messagelab.textAlignment = NSTextAlignmentCenter;
//    self.messagelab.font = SYS_Font(15);
//    [self.view addSubview:self.messagelab];
//    [self.messagelab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(text_yy+80);
//        make.height.offset(30);
//    }];
//    self.messagelab.text = @"";
    
}

- (void)okokBtnClick
{
    [self.view endEditing:YES];
    
    UITextField *oenTextf = [self.view viewWithTag:30000];
    UITextField *twoTextf = [self.view viewWithTag:30001];
    UITextField *thrTextf = [self.view viewWithTag:30002];
    UITextField *fouTextf = [self.view viewWithTag:30003];
    
    if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
        
        NSString *contSS = [NSString stringWithFormat:@"%@%@%@%@", oenTextf.text, twoTextf.text, thrTextf.text, fouTextf.text];
        if (self.isSetting) {
            
            if (self.codeSt.length > 0) {
                
                if ([contSS isEqualToString:self.codeSt]) {
                    
                    [LYUserDefault saveeSecurityCode:self.codeSt];
                    [LYUserDefault saveSetLock:YES];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    if (self.eSecurityCodBlock) {
                        self.eSecurityCodBlock(1);
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"my_settings30")];
//                    self.messagelab.text = eLocalizedString(@"my_settings29");
                    oenTextf.text = @"";
                    twoTextf.text = @"";
                    thrTextf.text = @"";
                    fouTextf.text = @"";
                    
                    [oenTextf becomeFirstResponder];
                }
            }else {
                self.codeSt = contSS;
                
//                self.messagelab.text = eLocalizedString(@"my_settings29");
                oenTextf.text = @"";
                twoTextf.text = @"";
                thrTextf.text = @"";
                fouTextf.text = @"";
                
                [oenTextf becomeFirstResponder];
            }
        }else {
            
            if ([contSS isEqualToString:self.codeSt]) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }else {
//                self.messagelab.text = eLocalizedString(@"安全码错误请重新输入");
                oenTextf.text = @"";
                twoTextf.text = @"";
                thrTextf.text = @"";
                fouTextf.text = @"";
                
                [oenTextf becomeFirstResponder];
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    keyInputTextField *oenTextf = [self.view viewWithTag:30000];
    keyInputTextField *twoTextf = [self.view viewWithTag:30001];
    keyInputTextField *thrTextf = [self.view viewWithTag:30002];
    keyInputTextField *fouTextf = [self.view viewWithTag:30003];

    if (textField == oenTextf) {

        if (string.length > 0) {
            textField.text = string;
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }else {
                
                [twoTextf becomeFirstResponder];
            }
        }else {
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }
        }
    }
    if (textField == twoTextf) {

        if (string.length > 0) {
            textField.text = string;
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }else {
                
                [thrTextf becomeFirstResponder];
            }
        }else {
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }
        }
    }
    if (textField == thrTextf) {

        if (string.length > 0) {
            textField.text = string;
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }else {
                
                [fouTextf becomeFirstResponder];
            }
        }else {
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }
        }
    }
    if (textField == fouTextf) {

        if (fouTextf.text.length > 0) {
            
            if ([string isEqualToString:@""]) {
                return YES;
            }else {
                
                return NO;
            }
        }else {
            fouTextf.text = string;
            if ((oenTextf.text.length > 0)&&(twoTextf.text.length > 0)&&(thrTextf.text.length > 0)&&(fouTextf.text.length > 0)) {
                [self okokBtnClick];
            }
        }
    }
    
    return YES;
}

- (void)deleteBackwardMkeytextfield:(keyInputTextField *)textF
{
    keyInputTextField *oenTextf = [self.view viewWithTag:30000];
    keyInputTextField *twoTextf = [self.view viewWithTag:30001];
    keyInputTextField *thrTextf = [self.view viewWithTag:30002];
    keyInputTextField *fouTextf = [self.view viewWithTag:30003];
    
    if (textF == fouTextf) {
        
        if (textF.text.length == 0) {
            
            self.isNum = self.isNum + 1;
            if (self.isNum == 2) {
                self.isNum = 0;
                [thrTextf becomeFirstResponder];
            }
        }
    }
    if (textF == thrTextf) {
        
        if (textF.text.length == 0) {
            
            self.isNum = self.isNum + 1;
            if (self.isNum == 2) {
                self.isNum = 0;
                [twoTextf becomeFirstResponder];
            }
        }
    }
    if (textF == twoTextf) {
        
        if (textF.text.length == 0) {
            self.isNum = self.isNum + 1;
            if (self.isNum == 2) {
                self.isNum = 0;
                [oenTextf becomeFirstResponder];
            }
        }
    }
    if (textF == oenTextf) {
        
        
    }
}

@end
