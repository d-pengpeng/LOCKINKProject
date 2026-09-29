//
//  MHRedoPasswordController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/19.
//

#import "MHRedoPasswordController.h"
#import "eSelectCountryCodeView.h"

@interface MHRedoPasswordController ()<UITextFieldDelegate>
{
    NSTimer *messsageTimer;
    int messageIssssss;//短信倒计时  60s
}
@property (nonatomic, strong) UITextField *textCodeFF;
@property (nonatomic, strong) UITextField *textPasswordFF;
@property (nonatomic, strong) UITextField *textPasswordFF2;
@property (nonatomic, strong) UIButton *yzmBtn;

@property (nonatomic, strong) UITextField *textFF;
@property (nonatomic, strong) UIImageView *accImgV;
@property (nonatomic, strong) UIImageView *passImgV;
@property (nonatomic, strong) UIButton *regionBtn;

@property (nonatomic, strong) UIButton *deleleMethBtn;
@property (nonatomic, strong) eSelectCountryCodeView *eSelectCountryCodeV;
@property (nonatomic, copy) NSString *regonStr;
@property (nonatomic, assign) BOOL isRRRR;
@end

@implementation MHRedoPasswordController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    //MARK: 判断是否是返回上一页
    NSArray *viewCtrolsArr = self.navigationController.viewControllers;
    if ([viewCtrolsArr indexOfObject:self] == NSNotFound) {
        [messsageTimer invalidate];
        messsageTimer = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.redNavView = NO;
    self.titleName.text = eLocalizedString(@"my_settings12");
    self.navView.backgroundColor = GroupBackColor;
    
    messageIssssss = 60;
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    if(self.isChageAccount == 1) {
        
        self.titleName.text = eLocalizedString(@"my_settings11");
        
        UILabel *titLLLL = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:18 textAlignment:NSTextAlignmentLeft];
        titLLLL.font = [UIFont systemFontOfSize:18 weight:1];
        titLLLL.frame = CGRectMake(26, NAVHEIGHT+30, _window_width-52, 38);
        [self.view addSubview:titLLLL];
        
        UILabel *accoutLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        accoutLLab.frame = CGRectMake(26, titLLLL.y+titLLLL.height, _window_width-52, 36);
        accoutLLab.text = [LYUserDefault userDefault].emailAuccount;
        [self.view addSubview:accoutLLab];
        
        UILabel *accoutLLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        accoutLLab2.frame = CGRectMake(26, accoutLLab.y+accoutLLab.height+20, _window_width-52, 36);
        accoutLLab2.text = eLocalizedString(@"my_about10");
        [self.view addSubview:accoutLLab2];
        
        UIView *linVV = [[UIView alloc] initWithFrame:CGRectMake(16, accoutLLab2.y+accoutLLab2.height+72, _window_width-32, 3)];
        linVV.backgroundColor = RGB(186, 80, 191);
        [self.view addSubview:linVV];
        
        UIView *linVV2 = [[UIView alloc] initWithFrame:CGRectMake(16, linVV.y+72, _window_width-32, 3)];
        linVV2.backgroundColor = RGB(186, 80, 191);
        [self.view addSubview:linVV2];
        
        if([[LYUserDefault userDefault].emailAuccount containsString:@"@"]) {
            
            titLLLL.text = eLocalizedString(@"my_about9");
            
            self.accImgV = [[UIImageView alloc] initWithFrame:CGRectMake(26, linVV.y-34, 26, 26)];
            self.accImgV.image = [UIImage imageNamed:@"login_allimg4"];
            [self.view addSubview:self.accImgV];
            
            self.textFF = [[UITextField alloc] initWithFrame:CGRectMake(self.accImgV.x+self.accImgV.width+4, self.accImgV.y-8, _window_width-(self.accImgV.x+self.accImgV.width+4+30), 42)];
            self.textFF.textColor = UIColor.blackColor;
            self.textFF.font = SYS_Font(14);
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all3_3") attributes:
                @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textFF.font}];
            self.textFF.attributedPlaceholder = attrString;
            self.textFF.returnKeyType = UIReturnKeyDone;
            [self.view addSubview:self.textFF];
            
        }else {
            titLLLL.text = eLocalizedString(@"my_about8");
            
            self.accImgV = [[UIImageView alloc] initWithFrame:CGRectMake(26, linVV.y-34, 26, 26)];
            self.accImgV.image = [UIImage imageNamed:@"login_allimg1"];
            [self.view addSubview:self.accImgV];
            
            self.regionBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.accImgV.x+self.accImgV.width, self.accImgV.y, 60, 26)];
            [self.regionBtn setTitle:@"+86" forState:UIControlStateNormal];
            [self.regionBtn setTitleColor:normalColors forState:UIControlStateNormal];
            self.regionBtn.titleLabel.font = SYS_Font(13);
            [self.regionBtn setImage:[UIImage imageNamed:@"dissm_nexImg_black"] forState:UIControlStateNormal];
            [self.regionBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:3];
            [self.regionBtn addTarget:self action:@selector(regionBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.regionBtn];
            self.regonStr = @"+86";
            
            self.textFF = [[UITextField alloc] initWithFrame:CGRectMake(self.regionBtn.x+self.regionBtn.width+4, self.accImgV.y-8, _window_width-(self.regionBtn.x+self.regionBtn.width+4+30), 42)];
            self.textFF.textColor = UIColor.blackColor;
            self.textFF.font = SYS_Font(14);
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all3") attributes:
                @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textFF.font}];
            self.textFF.attributedPlaceholder = attrString;
            self.textFF.returnKeyType = UIReturnKeyDone;
            [self.view addSubview:self.textFF];
        }
        
        UIImageView *lefImgV = [HistoryRecordModel createImgImgView];
        lefImgV.frame = CGRectMake(linVV2.x+10, linVV2.y-34, 26, 26);
        lefImgV.image = [UIImage imageNamed:@"login_allimg2"];
        [self.view addSubview:lefImgV];
        
        self.textCodeFF = [[UITextField alloc] initWithFrame:CGRectMake(lefImgV.x+lefImgV.width+6, lefImgV.y-8, _window_width-(lefImgV.x+lefImgV.width+90+40), 42)];
        self.textCodeFF.textColor = UIColor.blackColor;
        self.textCodeFF.font = SYS_Font(14);
        NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all4") attributes:
                                           @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textCodeFF.font}];
        self.textCodeFF.attributedPlaceholder = attrString3;
        self.textCodeFF.returnKeyType = UIReturnKeyDone;
        self.textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
        [self.view addSubview:self.textCodeFF];
        
        
        self.yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-120, self.textCodeFF.y, 90, 42)];
        [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
        [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
        self.yzmBtn.titleLabel.font = SYS_Font(14);
        self.yzmBtn.titleLabel.numberOfLines = 0;
        [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.yzmBtn];
        
    }else if(self.isChageAccount == 2) {
        
        self.titleName.text = eLocalizedString(@"my_settings10");
        
        UILabel *titLLLL = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:18 textAlignment:NSTextAlignmentLeft];
        titLLLL.font = [UIFont systemFontOfSize:18 weight:1];
        titLLLL.frame = CGRectMake(26, NAVHEIGHT+30, _window_width-52, 38);
        titLLLL.text = eLocalizedString(@"my_settings10");
        [self.view addSubview:titLLLL];
        
        NSArray *namAr = @[[LYUserDefault userDefault].mobile, eLocalizedString(@"login_all4")];
        
        for (int i=0; i<namAr.count; i++) {
            
            UIView *linVV = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titLLLL.frame)+24+74+73*i, _window_width-32, 3)];
            linVV.backgroundColor = RGB(186, 80, 191);
            [self.view addSubview:linVV];
            
            if(i==0) {
                
                UIImageView *lefImgV = [HistoryRecordModel createImgImgView];
                lefImgV.frame = CGRectMake(linVV.x+10, linVV.y-34, 26, 26);
                lefImgV.image = [UIImage imageNamed:@"passw_img1"];
                [self.view addSubview:lefImgV];
                
                UILabel *acouLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                acouLab.frame = CGRectMake(lefImgV.x+33, lefImgV.y, _window_width-100, 26);
                acouLab.text = [LYUserDefault userDefault].emailAuccount;
                [self.view addSubview:acouLab];
                
            }else if (i==1) {
                
                UIImageView *lefImgV = [HistoryRecordModel createImgImgView];
                lefImgV.frame = CGRectMake(linVV.x+10, linVV.y-34, 26, 26);
                lefImgV.image = [UIImage imageNamed:@"login_allimg2"];
                [self.view addSubview:lefImgV];
                
                self.textCodeFF = [[UITextField alloc] initWithFrame:CGRectMake(lefImgV.x+lefImgV.width+6, lefImgV.y-8, _window_width-(lefImgV.x+lefImgV.width+90+40), 42)];
                self.textCodeFF.textColor = UIColor.blackColor;
                self.textCodeFF.font = SYS_Font(14);
                NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all4") attributes:
                                                   @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textCodeFF.font}];
                self.textCodeFF.attributedPlaceholder = attrString3;
                self.textCodeFF.returnKeyType = UIReturnKeyDone;
                self.textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
                [self.view addSubview:self.textCodeFF];
                
                
                self.yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-120, self.textCodeFF.y, 90, 42)];
                [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
                [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
                self.yzmBtn.titleLabel.font = SYS_Font(14);
                self.yzmBtn.titleLabel.numberOfLines = 0;
                [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.yzmBtn];
            }
        }
        
        UILabel *zzz = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        zzz.frame = CGRectMake(16, CGRectGetMaxY(titLLLL.frame)+24+73*2+20, _window_width-32, 34);
        zzz.text = eLocalizedString(@"my_about12");
        [self.view addSubview:zzz];
        
        UILabel *zzz2 = [HistoryRecordModel createLabLabTextColor:RGB(94, 94, 94) fontFloat:14 textAlignment:NSTextAlignmentLeft];
        zzz2.numberOfLines = 0;
        zzz2.text = eLocalizedString(@"my_about13");
        [self.view addSubview:zzz2];
        [zzz2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(zzz);
            make.top.equalTo(zzz.mas_bottom).offset(3);
        }];
        
        UILabel *zzz3 = [HistoryRecordModel createLabLabTextColor:RGB(94, 94, 94) fontFloat:14 textAlignment:NSTextAlignmentLeft];
        zzz3.numberOfLines = 0;
        zzz3.text = eLocalizedString(@"my_about14");
        [self.view addSubview:zzz3];
        [zzz3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(zzz);
            make.top.equalTo(zzz2.mas_bottom).offset(3);
        }];
        
        UILabel *zzz4 = [HistoryRecordModel createLabLabTextColor:RGB(94, 94, 94) fontFloat:14 textAlignment:NSTextAlignmentLeft];
        zzz4.numberOfLines = 0;
        zzz4.text = eLocalizedString(@"my_about15");
        [self.view addSubview:zzz4];
        [zzz4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(zzz);
            make.top.equalTo(zzz3.mas_bottom).offset(3);
        }];
        
    }else {
        
        NSArray *namAr = @[[LYUserDefault userDefault].mobile, eLocalizedString(@"login_all4"), eLocalizedString(@"login_all16"), eLocalizedString(@"login_all17")];
        
        for (int i=0; i<namAr.count; i++) {
            
            UIView *linVV = [[UIView alloc] initWithFrame:CGRectMake(16, NAVHEIGHT+73+73*i, _window_width-32, 3)];
            linVV.backgroundColor = RGB(186, 80, 191);
            [self.view addSubview:linVV];
            
            if(i==0) {
                
                UIImageView *lefImgV = [HistoryRecordModel createImgImgView];
                lefImgV.frame = CGRectMake(linVV.x+10, linVV.y-34, 26, 26);
                lefImgV.image = [UIImage imageNamed:@"passw_img1"];
                [self.view addSubview:lefImgV];
                
                UILabel *acouLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                acouLab.frame = CGRectMake(lefImgV.x+33, lefImgV.y, _window_width-100, 26);
                acouLab.text = [LYUserDefault userDefault].emailAuccount;
                [self.view addSubview:acouLab];
                
            }else if (i==1) {
                
                UIImageView *lefImgV = [HistoryRecordModel createImgImgView];
                lefImgV.frame = CGRectMake(linVV.x+10, linVV.y-34, 26, 26);
                lefImgV.image = [UIImage imageNamed:@"login_allimg2"];
                [self.view addSubview:lefImgV];
                
                self.textCodeFF = [[UITextField alloc] initWithFrame:CGRectMake(lefImgV.x+lefImgV.width+6, lefImgV.y-8, _window_width-(lefImgV.x+lefImgV.width+90+40), 42)];
                self.textCodeFF.textColor = UIColor.blackColor;
                self.textCodeFF.font = SYS_Font(14);
                NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all4") attributes:
                                                   @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textCodeFF.font}];
                self.textCodeFF.attributedPlaceholder = attrString3;
                self.textCodeFF.returnKeyType = UIReturnKeyDone;
                self.textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
                [self.view addSubview:self.textCodeFF];
                
                
                self.yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-120, self.textCodeFF.y, 90, 42)];
                [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
                [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
                self.yzmBtn.titleLabel.font = SYS_Font(14);
                self.yzmBtn.titleLabel.numberOfLines = 0;
                [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.yzmBtn];
            }else if (i==2) {
                
                self.textPasswordFF = [[UITextField alloc] initWithFrame:CGRectMake(34, linVV.y-42, _window_width-80, 42)];
                self.textPasswordFF.textColor = UIColor.blackColor;
                self.textPasswordFF.font = SYS_Font(14);
                NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all16") attributes:
                                                   @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textPasswordFF.font}];
                self.textPasswordFF.attributedPlaceholder = attrString2;
                self.textPasswordFF.returnKeyType = UIReturnKeyDone;
                self.textPasswordFF.secureTextEntry = YES;
                self.textPasswordFF.delegate = self;
                [self.view addSubview:self.textPasswordFF];
                
                UIButton * lookPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-60, self.textPasswordFF.y+11, 20, 20)];
                [lookPwdBtn setImage:[UIImage imageNamed:@"login_password_select"] forState:UIControlStateNormal];
                [lookPwdBtn setImage:[UIImage imageNamed:@"login_password"] forState:UIControlStateSelected];
                [lookPwdBtn addTarget:self action:@selector(clickLookAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:lookPwdBtn];
            }else {
                self.textPasswordFF2 = [[UITextField alloc] initWithFrame:CGRectMake(34, linVV.y-42, _window_width-80, 42)];
                self.textPasswordFF2.textColor = UIColor.blackColor;
                self.textPasswordFF2.font = SYS_Font(14);
                NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all17") attributes:
                                                   @{NSForegroundColorAttributeName:RGB(170, 170, 170), NSFontAttributeName:self.textPasswordFF2.font}];
                self.textPasswordFF2.attributedPlaceholder = attrString4;
                self.textPasswordFF2.returnKeyType = UIReturnKeyDone;
                self.textPasswordFF2.secureTextEntry = YES;
                self.textPasswordFF2.delegate = self;
                [self.view addSubview:self.textPasswordFF2];
                
                UIButton * lookPwdBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-60, self.textPasswordFF2.y+11, 20, 20)];
                [lookPwdBtn2 setImage:[UIImage imageNamed:@"login_password_select"] forState:UIControlStateNormal];
                [lookPwdBtn2 setImage:[UIImage imageNamed:@"login_password"] forState:UIControlStateSelected];
                [lookPwdBtn2 addTarget:self action:@selector(clickLookActionTwo:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:lookPwdBtn2];
            }
        }
        
    }
        
    UIButton *loginBBtn = [HistoryRecordModel createImgBtn];
    [loginBBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [loginBBtn setTitle:eLocalizedString(@"home_ok") forState:UIControlStateNormal];
    [loginBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    loginBBtn.titleLabel.font = SYS_Font(16);
    [loginBBtn addTarget:self action:@selector(loginBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBBtn];
    [loginBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-130);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(46);
        make.width.offset(210);
    }];
    if(self.isChageAccount == 1) {
        [loginBBtn setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
    }else if (self.isChageAccount == 2) {
        [loginBBtn setTitle:eLocalizedString(@"my_about11") forState:UIControlStateNormal];
    }
    
}

- (void)loginBtnMethod
{
    if(self.isChageAccount == 1) {
        
        if((self.textCodeFF.text.length>0) && (self.textFF.text.length>0)) {
            
            if(self.isRRRR) {
                return;
            }
            
            self.isRRRR = YES;
            [SVProgressHUD show];
            
            NSDictionary *dicMM = @{@"contact":[NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text], @"code":minStr(self.textCodeFF.text)};
            if([[LYUserDefault userDefault].emailAuccount containsString:@"@"]) {
                dicMM = @{@"contact":minStr(self.textFF.text), @"code":minStr(self.textCodeFF.text)};
            }
            [requestToolClass postNetworkWithUrl:request_login_changeBinding andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                self.isRRRR = NO;
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRR = NO;
            }];
        }
    }else if (self.isChageAccount == 2) {
     
        if(self.textCodeFF.text.length>0) {
            
            if(self.isRRRR) {
                return;
            }
            
            self.isRRRR = YES;
            [SVProgressHUD show];
            
            NSString *smmmStr = [[LYUserDefault userDefault].emailAuccount stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSDictionary *dicMM = @{@"contact":smmmStr, @"code":minStr(self.textCodeFF.text)};
            [requestToolClass postNetworkWithUrl:request_login_logout andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                [LYUserDefault clearLoginCache];
                [LYUserDefault saveIsLoginBoo:NO];
                self.isRRRR = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRR = NO;
            }];
        }
        
    }else {
        
        if((self.textCodeFF.text.length>0) && (self.textPasswordFF.text.length>0) && (self.textPasswordFF2.text.length>0)) {
            
            if(self.isRRRR) {
                return;
            }
            
            if(![minStr(self.textPasswordFF.text) isEqualToString:minStr(self.textPasswordFF2.text)]) {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_all17")];
                return;
            }
            
            self.isRRRR = YES;
            [SVProgressHUD show];

            NSDictionary *dicMM = @{@"password":minStr(self.textPasswordFF.text), @"code":minStr(self.textCodeFF.text)};
            [requestToolClass postNetworkWithUrl:request_login_modifyPassword andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                self.isRRRR = NO;
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRR = NO;
            }];
        }
    }
}

- (void)codeRegistClick
{
    if (self.isChageAccount == 1) {
        if(self.textFF.text.length <= 0) {
            return;
        }
    }
    _yzmBtn.userInteractionEnabled = NO;
    if (messageIssssss > 58) {
        [self requestYZMcode];
    }
    if (messsageTimer == nil) {
        messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    }
}

//MARK: 获取验证码
- (void)requestYZMcode
{
    NSDictionary *dicdic = @{};
    if (self.isChageAccount == 1) {
        NSString *str_lll = @"";
        if([[LYUserDefault userDefault].emailAuccount containsString:@"@"]) {
            str_lll = minStr(self.textFF.text);
        }else {
            str_lll = [NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text];
        }
        dicdic = @{@"contact":str_lll, @"type":@"5"};
    }else if (self.isChageAccount == 2) {
        NSString *smmmStr = [[LYUserDefault userDefault].emailAuccount stringByReplacingOccurrencesOfString:@" " withString:@""];
        dicdic = @{@"contact":smmmStr, @"type":@"4"};
    }else {
        
        NSString *smmmStr = [[LYUserDefault userDefault].emailAuccount stringByReplacingOccurrencesOfString:@" " withString:@""];
        dicdic = @{@"contact":smmmStr, @"type":@"6"};
    }
    [requestToolClass postNetworkWithUrl:request_login_sendVerificationCode andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

//获取验证码倒计时
-(void)daojishi{
    [_yzmBtn setTitle:[NSString stringWithFormat:@"%ds",messageIssssss] forState:UIControlStateNormal];
    _yzmBtn.userInteractionEnabled = NO;
    [_yzmBtn setTitleColor:GrayText204 forState:0];

    if (messageIssssss<=0) {
        [_yzmBtn setTitleColor:normalColors forState:0];
        [_yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
        _yzmBtn.userInteractionEnabled = YES;
        [messsageTimer invalidate];
        messsageTimer = nil;
        messageIssssss = 60;
    }
    messageIssssss-=1;
}
- (void)clickLookAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    self.textPasswordFF.secureTextEntry = !btn.selected;
}

- (void)clickLookActionTwo:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    self.textPasswordFF2.secureTextEntry = !btn.selected;
}

- (void)regionBtnMethod
{
    [self.view endEditing:YES];
    
    self.deleleMethBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.deleleMethBtn addTarget:self action:@selector(removSelCountyV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleleMethBtn];

    
    [self.eSelectCountryCodeV removeFromSuperview];
    self.eSelectCountryCodeV = nil;
    self.eSelectCountryCodeV = [[eSelectCountryCodeView alloc] initWithFrame:CGRectMake(self.regionBtn.x-10, self.regionBtn.y+30, 188, 350)];
    self.eSelectCountryCodeV.backgroundColor = UIColor.whiteColor;
    self.eSelectCountryCodeV.layer.cornerRadius = 8;
    self.eSelectCountryCodeV.clipsToBounds = YES;
    [self.view addSubview:self.eSelectCountryCodeV];
    WEAKSELF
    self.eSelectCountryCodeV.eSelectBlock = ^(NSString * _Nonnull code) {
        
        [weakSelf.regionBtn setTitle:code forState:UIControlStateNormal];
        weakSelf.regonStr = code;
        [weakSelf removSelCountyV];
    };
}

- (void)removSelCountyV {
    self.eSelectCountryCodeV.hidden = YES;
    self.deleleMethBtn.hidden = YES;
    [self.deleleMethBtn removeFromSuperview];
}

@end
