//
//  myHomeSettingSubController.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/9/19.
//

#import "myHomeSettingSubController.h"

@interface myHomeSettingSubController ()
{
    NSTimer *messsageTimer;
    int messageIssssss;//短信倒计时  60s
}
@property (nonatomic, strong) UITextField *textFF;
@property (nonatomic, strong) UITextField *okTextFF;
@property (nonatomic, strong) UITextField *codeTextFF;
@property (nonatomic, strong) UIButton *yzmBtn;
@end

@implementation myHomeSettingSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = NO;
    if (self.typeN == aboutMineTypeN) {
        self.titleName.text = eLocalizedString(@"home_AboutUs");
        
        UIImageView *logoImgV = [HistoryRecordModel createImgImgView];
        logoImgV.image = [UIImage imageNamed:@"logo120"];
        [self.view addSubview:logoImgV];
        [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.navView.mas_bottom).offset(32);
            make.width.height.offset(68);
        }];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        // app版本

        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

        // app build版本

//        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        
        UILabel *logoNameLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        logoNameLab.text = [NSString stringWithFormat:@"%@V%@", app_Name, app_Version];
        [self.view addSubview:logoNameLab];
        [logoNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(logoImgV.mas_centerX);
            make.top.equalTo(logoImgV.mas_bottom).offset(6);
            make.height.offset(34);
        }];
        
        UIView *botnVV = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:botnVV];
        [botnVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(logoNameLab.mas_bottom).offset(38);
            make.height.offset(55);
        }];
        
        UILabel *onelLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        onelLab.text = eLocalizedString(@"home_set_VersionInformation");
        [botnVV addSubview:onelLab];
        [onelLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(botnVV.mas_centerY);
            make.left.equalTo(botnVV.mas_left).offset(12);
        }];
        UILabel *twolLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentRight];
        twolLab.text = app_Version;
        [botnVV addSubview:twolLab];
        [twolLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(botnVV.mas_centerY);
            make.right.equalTo(botnVV.mas_right).offset(-12);
        }];
        
        UILabel *httpsLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:12 textAlignment:NSTextAlignmentCenter];
        httpsLab.text = eLocalizedString(@"home_Copyright");
        httpsLab.numberOfLines = 0;
        [self.view addSubview:httpsLab];
        [httpsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-TARBARHEIGHT+27);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
//            make.centerX.equalTo(self.view.mas_centerX);
//            make.height.offset(32);
        }];
        
        UIView *pravyVV = [[UIView alloc] init];
        pravyVV.backgroundColor = RGB(75, 129, 247);
        [self.view addSubview:pravyVV];
        [pravyVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(httpsLab.mas_top).offset(-13);
            make.height.offset(13);
            make.width.offset(1);
        }];
        
        UIButton *agreementBtn = [HistoryRecordModel createImgBtn];
        [agreementBtn setTitle:eLocalizedString(@"home_set_UserAgreement") forState:UIControlStateNormal];
        [agreementBtn setTitleColor:RGB(75, 129, 247) forState:UIControlStateNormal];
        agreementBtn.titleLabel.font = SYS_Font(12);
        [agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:agreementBtn];
        [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pravyVV.mas_centerY);
            make.right.equalTo(pravyVV.mas_left).offset(-6);
            make.height.offset(40);
        }];
        
        UIButton *privacyBtn = [HistoryRecordModel createImgBtn];
        [privacyBtn setTitle:eLocalizedString(@"home_set_PrivacyPolicy") forState:UIControlStateNormal];
        [privacyBtn setTitleColor:RGB(75, 129, 247) forState:UIControlStateNormal];
        privacyBtn.titleLabel.font = SYS_Font(12);
        [privacyBtn addTarget:self action:@selector(privacyBtnnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:privacyBtn];
        [privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pravyVV.mas_centerY);
            make.left.equalTo(pravyVV.mas_right).offset(6);
            make.height.offset(40);
        }];
    }else if (self.typeN == payPasswordTypeN) {
        
        self.titleName.text = eLocalizedString(@"home_SetPaymentPassword");
        
        NSString *ppp = [NSString stringWithFormat:@"%@", eLocalizedString(@"Home_set_password2222")];
        messageIssssss = 60;
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:oneVV];
        [oneVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(self.navView.mas_bottom).offset(10);
            make.height.offset(54);
        }];
        
        self.textFF = [[UITextField alloc] init];
        self.textFF.textColor = GrayTextColor;
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:ppp attributes:
            @{NSForegroundColorAttributeName:GrayText,
                            NSFontAttributeName:self.textFF.font
            }];
        self.textFF.attributedPlaceholder = attrString;
        
        self.textFF.font = SYS_Font(15);
        self.textFF.keyboardType = UIKeyboardTypeNumberPad;
//        [self.textFF addTarget:self action:@selector(textFieldCChangeText:) forControlEvents:UIControlEventEditingChanged];
        [oneVV addSubview:self.textFF];
        [self.textFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneVV.mas_centerY);
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.right.equalTo(oneVV.mas_right).offset(-12);
            make.height.offset(50);
        }];
        
        UIView *oneVV2 = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:oneVV2];
        [oneVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(oneVV.mas_bottom).offset(10);
            make.height.offset(54);
        }];
        
        self.okTextFF = [[UITextField alloc] init];
        self.okTextFF.textColor = GrayTextColor;
        NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_Please3") attributes:
            @{NSForegroundColorAttributeName:GrayText,
                            NSFontAttributeName:self.okTextFF.font
            }];
        self.okTextFF.attributedPlaceholder = attrString2;
        self.okTextFF.font = SYS_Font(15);
        self.okTextFF.keyboardType = UIKeyboardTypeNumberPad;
//        [self.textFF addTarget:self action:@selector(textFieldCChangeText:) forControlEvents:UIControlEventEditingChanged];
        [oneVV2 addSubview:self.okTextFF];
        [self.okTextFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneVV2.mas_centerY);
            make.left.equalTo(oneVV2.mas_left).offset(12);
            make.right.equalTo(oneVV2.mas_right).offset(-12);
            make.height.offset(50);
        }];
        
        UIView *oneVV3 = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:oneVV3];
        [oneVV3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(oneVV2.mas_bottom).offset(10);
            make.height.offset(110);
        }];
        
        UIView *lineVV = [[UIView alloc] init];
        lineVV.backgroundColor = GroupBackColor;
        [oneVV3 addSubview:lineVV];
        [lineVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneVV3.mas_centerY);
            make.left.right.equalTo(oneVV3);
            make.height.offset(1);
        }];
        
        UILabel *codeLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//        codeLab.text = @"+86:  150****4304";
        NSString *phone_str = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobilePhone"];
        NSArray *phone_arr = [phone_str componentsSeparatedByString:@"-"];
        
        if (phone_arr.count == 2) {
            
            codeLab.text = [NSString stringWithFormat:@"+%@:  %@", phone_arr[0], phone_arr[1]];
        }else {
            codeLab.text = [NSString stringWithFormat:@"+86:  %@", phone_str];
        }
        
        [oneVV3 addSubview:codeLab];
        [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV3.mas_left).offset(12);
            make.top.equalTo(oneVV3.mas_top).offset(2);
            make.height.offset(50);
        }];
        
        self.yzmBtn = [[UIButton alloc] init];
        [self.yzmBtn setTitle:eLocalizedString(@"login_ObtainVerificationCode") forState:UIControlStateNormal];
        [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
        self.yzmBtn.titleLabel.font = SYS_Font(14);
        self.yzmBtn.titleLabel.numberOfLines = 0;
        self.yzmBtn.tag = 599;
        [self.yzmBtn addTarget:self action:@selector(loginRegistClick:) forControlEvents:UIControlEventTouchUpInside];
        [oneVV3 addSubview:self.yzmBtn];
        [self.yzmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineVV.mas_bottom).offset(13);
            make.right.equalTo(lineVV.mas_right).offset(-12);
            make.width.offset(80);
        }];
        
        self.codeTextFF = [[UITextField alloc] init];
        self.codeTextFF.textColor = GrayTextColor;
        NSAttributedString *attrString223 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"Login_PleaseEn2") attributes:
            @{NSForegroundColorAttributeName:GrayText,
                            NSFontAttributeName:self.codeTextFF.font
            }];
        self.codeTextFF.attributedPlaceholder = attrString223;
        self.codeTextFF.font = SYS_Font(15);
        self.codeTextFF.keyboardType = UIKeyboardTypeNumberPad;
//        [self.codeTextFF addTarget:self action:@selector(textFieldCChangeText:) forControlEvents:UIControlEventEditingChanged];
        [oneVV3 addSubview:self.codeTextFF];
        [self.codeTextFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.yzmBtn.mas_centerY);
            make.left.equalTo(oneVV3.mas_left).offset(12);
            make.right.equalTo(self.yzmBtn.mas_left).offset(-10);
            make.height.offset(50);
        }];
        
        UIButton *withdrawalBtn = [HistoryRecordModel createImgBtn];
        [withdrawalBtn setTitle:eLocalizedString(@"home_set_Commit") forState:UIControlStateNormal];
        [withdrawalBtn setTitleColor:RGB(135, 57, 14) forState:UIControlStateNormal];
        [withdrawalBtn.layer addSublayer:[HistoryRecordModel createColorFrame:CGRectMake(0, 0, 300, 46)]];
        withdrawalBtn.titleLabel.font = SYS_Font(17);
        [withdrawalBtn addTarget:self action:@selector(saveBBBMethod) forControlEvents:UIControlEventTouchUpInside];
        withdrawalBtn.layer.cornerRadius = 23;
        [self.view addSubview:withdrawalBtn];
        [withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneVV3.mas_bottom).offset(48);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.offset(300);
            make.height.offset(46);
        }];
    }else if (self.typeN == ModifyPasswordTypeN) {
        
        self.titleName.text = eLocalizedString(@"home_ChangePassword");
        messageIssssss = 60;
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:oneVV];
        [oneVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(self.navView.mas_bottom).offset(10);
            make.height.offset(170);
        }];
        
        UILabel *nameLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        nameLab.text = eLocalizedString(@"home_set_SMSVerification");
        [oneVV addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.top.equalTo(oneVV.mas_top).offset(15);
            make.height.offset(26);
        }];
        
        UILabel *codeLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentLeft];
        codeLab.text = [NSString stringWithFormat:@"%@%@%@", eLocalizedString(@"noData_msg5"), [LYUserDefault userDefault].mobile, eLocalizedString(@"noData_msg6")];
        [oneVV addSubview:codeLab];
        [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.top.equalTo(nameLab.mas_bottom).offset(5);
            make.height.offset(24);
        }];
        
        self.yzmBtn = [[UIButton alloc] init];
        [self.yzmBtn setTitle:eLocalizedString(@"login_ObtainVerificationCode") forState:UIControlStateNormal];
        [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
        self.yzmBtn.titleLabel.font = SYS_Font(14);
        self.yzmBtn.titleLabel.numberOfLines = 0;
        self.yzmBtn.tag = 599;
        [self.yzmBtn addTarget:self action:@selector(loginRegistClick:) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:self.yzmBtn];
        [self.yzmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(codeLab.mas_bottom).offset(10);
            make.right.equalTo(oneVV.mas_right).offset(-12);
            make.width.offset(80);
            make.height.offset(24);
        }];
        
        self.codeTextFF = [[UITextField alloc] init];
        self.codeTextFF.textColor = GrayTextColor;
        NSAttributedString *attrString223 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"Login_PleaseEn2") attributes:
            @{NSForegroundColorAttributeName:GrayText,
                            NSFontAttributeName:self.codeTextFF.font
            }];
        self.codeTextFF.attributedPlaceholder = attrString223;
        self.codeTextFF.font = SYS_Font(15);
//        [self.codeTextFF addTarget:self action:@selector(textFieldCChangeText:) forControlEvents:UIControlEventEditingChanged];
        [oneVV addSubview:self.codeTextFF];
        [self.codeTextFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.yzmBtn.mas_centerY);
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.right.equalTo(self.yzmBtn.mas_left).offset(-10);
            make.height.offset(50);
        }];
        
        UIView *lineVV = [[UIView alloc] init];
        lineVV.backgroundColor = GroupBackColor;
        [oneVV addSubview:lineVV];
        [lineVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yzmBtn.mas_bottom).offset(15);
            make.left.right.equalTo(oneVV);
            make.height.offset(1);
        }];
        
        self.textFF = [[UITextField alloc] init];
        self.textFF.textColor = GrayTextColor;
        NSString *ppp = [NSString stringWithFormat:@"%@", eLocalizedString(@"Home_set_password2222")];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:ppp attributes:
            @{NSForegroundColorAttributeName:GrayText,
                            NSFontAttributeName:self.textFF.font
            }];
        self.textFF.attributedPlaceholder = attrString;
        self.textFF.font = SYS_Font(15);
//        [self.textFF addTarget:self action:@selector(textFieldCChangeText:) forControlEvents:UIControlEventEditingChanged];
        [oneVV addSubview:self.textFF];
        [self.textFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineVV.mas_bottom).offset(2);
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.right.equalTo(oneVV.mas_right).offset(-12);
            make.height.offset(50);
        }];
        
        UIButton *withdrawalBtn = [HistoryRecordModel createImgBtn];
        [withdrawalBtn setTitle:eLocalizedString(@"home_ConfirmModification") forState:UIControlStateNormal];
        [withdrawalBtn setTitleColor:RGB(135, 57, 14) forState:UIControlStateNormal];
        [withdrawalBtn.layer addSublayer:[HistoryRecordModel createColorFrame:CGRectMake(0, 0, 300, 46)]];
        withdrawalBtn.titleLabel.font = SYS_Font(17);
        [withdrawalBtn addTarget:self action:@selector(saveBBBMethod) forControlEvents:UIControlEventTouchUpInside];
        withdrawalBtn.layer.cornerRadius = 23;
        [self.view addSubview:withdrawalBtn];
        [withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneVV.mas_bottom).offset(48);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.offset(300);
            make.height.offset(46);
        }];
    }else if (self.typeN == CancellationTypeN) {
        
        self.titleName.text = eLocalizedString(@"home_LogOut");
        messageIssssss = 60;
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:oneVV];
        [oneVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(self.navView.mas_bottom).offset(10);
            make.height.offset(115);
        }];
        
        UILabel *nameLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        nameLab.text = eLocalizedString(@"home_set_SMSVerification");
        [oneVV addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.top.equalTo(oneVV.mas_top).offset(15);
            make.height.offset(26);
        }];
        
        UILabel *codeLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentLeft];
        codeLab.text = [NSString stringWithFormat:@"%@%@%@", eLocalizedString(@"noData_msg5"), [LYUserDefault userDefault].mobile, eLocalizedString(@"noData_msg6")];
        
        [oneVV addSubview:codeLab];
        [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.top.equalTo(nameLab.mas_bottom).offset(5);
            make.height.offset(24);
        }];
        
        self.yzmBtn = [[UIButton alloc] init];
        [self.yzmBtn setTitle:eLocalizedString(@"login_ObtainVerificationCode") forState:UIControlStateNormal];
        [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
        self.yzmBtn.titleLabel.font = SYS_Font(14);
        self.yzmBtn.titleLabel.numberOfLines = 0;
        self.yzmBtn.tag = 599;
        [self.yzmBtn addTarget:self action:@selector(loginRegistClick:) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:self.yzmBtn];
        [self.yzmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(codeLab.mas_bottom).offset(10);
            make.right.equalTo(oneVV.mas_right).offset(-12);
            make.width.offset(80);
            make.height.offset(24);
        }];
        
        self.codeTextFF = [[UITextField alloc] init];
        self.codeTextFF.textColor = GrayTextColor;
        NSAttributedString *attrString223 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"Login_PleaseEn2") attributes:
            @{NSForegroundColorAttributeName:GrayText,
                            NSFontAttributeName:self.codeTextFF.font
            }];
        self.codeTextFF.attributedPlaceholder = attrString223;
        self.codeTextFF.font = SYS_Font(15);
        self.codeTextFF.keyboardType = UIKeyboardTypeNumberPad;
//        [self.codeTextFF addTarget:self action:@selector(textFieldCChangeText:) forControlEvents:UIControlEventEditingChanged];
        [oneVV addSubview:self.codeTextFF];
        [self.codeTextFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.yzmBtn.mas_centerY);
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.right.equalTo(self.yzmBtn.mas_left).offset(-10);
            make.height.offset(50);
        }];
        
        UIButton *withdrawalBtn = [HistoryRecordModel createImgBtn];
        [withdrawalBtn setTitle:eLocalizedString(@"home_ConfirmMLogout") forState:UIControlStateNormal];
        [withdrawalBtn setTitleColor:RGB(135, 57, 14) forState:UIControlStateNormal];
        [withdrawalBtn.layer addSublayer:[HistoryRecordModel createColorFrame:CGRectMake(0, 0, 300, 46)]];
        withdrawalBtn.titleLabel.font = SYS_Font(17);
        [withdrawalBtn addTarget:self action:@selector(saveBBBMethod) forControlEvents:UIControlEventTouchUpInside];
        withdrawalBtn.layer.cornerRadius = 23;
        [self.view addSubview:withdrawalBtn];
        [withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneVV.mas_bottom).offset(48);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.offset(300);
            make.height.offset(46);
        }];
        
        UILabel *msgDetailLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentLeft];
        msgDetailLab.text = eLocalizedString(@"noData_msg7");
        msgDetailLab.numberOfLines = 0;
        [self.view addSubview:msgDetailLab];
        [msgDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(withdrawalBtn.mas_bottom).offset(24);
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
        }];
    }
}

- (void)RequestUserData
{
    //获取个人信息
//    [requestToolClass getNetworkWithUrl:request_appUser_get andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        NSDictionary *dicAll = info;
//        [LYUserDefault saveUserDefault:dicAll];
//        [self.navigationController popViewControllerAnimated:YES];
//    } fail:^(NSString * _Nonnull msg) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}

- (void)saveBBBMethod
{
    [self.view endEditing:YES];
    
    if (self.typeN == payPasswordTypeN) {
        
        if ((self.textFF.text.length > 0)&&(self.okTextFF.text.length > 0)&&(self.codeTextFF.text.length > 0)) {
            
//            if ([self.textFF.text isEqualToString:self.okTextFF.text]) {
//                [SVProgressHUD showWithStatus:@""];
//
//                NSDictionary *dicdic = @{@"password":self.textFF.text, @"code":self.codeTextFF.text};
//                [requestToolClass postNetworkWithUrl:request_Member_paymentPassword andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                    [SVProgressHUD showSuccessWithStatus:@"设置成功"];
//                    [self RequestUserData];
//                } fail:^(NSString * _Nonnull msg) {
//
//                }];
//            }else {
//                [SVProgressHUD showErrorWithStatus:@"密码不一致"];
//            }
        }
    }else if (self.typeN == ModifyPasswordTypeN) {
        
//        if ((self.textFF.text.length > 0)&&(self.codeTextFF.text.length > 0)) {
//
//            [SVProgressHUD showWithStatus:@""];
//
//            NSDictionary *dicdic = @{@"mobile":[LYUserDefault userDefault].mobile, @"password":self.textFF.text, @"code":self.codeTextFF.text};
//            [requestToolClass postNetworkWithUrl:request_user_forgotPassword andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"user_eidter_success")];
//                [self.navigationController popViewControllerAnimated:YES];
//            } fail:^(NSString * _Nonnull msg) {
//
//            }];
//        }
    }else if (self.typeN == CancellationTypeN) {
        
        if ((self.codeTextFF.text.length > 0)) {
            
            NSString *msg_str = [NSString stringWithFormat:@"%@?", eLocalizedString(@"home_LogOut")];
            [SGActionView showAlertWithTitle:nil message:msg_str leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"event_Sure") selectedHandle:^(NSInteger index) {
                if (index == 1) {

                    [self outLoginMethod];
                }
            }];
        }
    }
}

- (void)outLoginMethod
{
//    [SVProgressHUD showWithStatus:@""];
//
//    NSString *get_url = [NSString stringWithFormat:@"%@?code=%@", request_member_logout, self.codeTextFF.text];
//    [requestToolClass getNetworkWithUrl:get_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"user_cancellation_success")];
//        [LYUserDefault clearLoginCache];
//
//        if (self.block_) {
//            self.block_();
//        }
//
//        [self.navigationController popViewControllerAnimated:YES];
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
}

//MARK: 用户协议
- (void)agreementBtnClick
{
//    if ([LYUserDefault userDefault].user_agreement.length > 0) {
//        YBWebViewController *vc = [[YBWebViewController alloc] init];
//        vc.urls = [LYUserDefault userDefault].user_agreement;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}
- (void)privacyBtnnClick
{
//    if ([LYUserDefault userDefault].privacy_policy.length > 0) {
//        YBWebViewController *vc = [[YBWebViewController alloc] init];
//        vc.urls = [LYUserDefault userDefault].privacy_policy;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)loginRegistClick:(UIButton *)btn
{
//    if (self.typeN == CancellationTypeN) {
//
//        if (self.codeTextFF.text.length > 0) {
//
//            if (messageIssssss > 58) {
//                [self requestYZMcode];
//            }
//
//            if (messsageTimer == nil) {
//                messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
//            }
//        }
//    }else {
            
        if (messageIssssss > 58) {
            [self requestYZMcode];
        }
        
        if (messsageTimer == nil) {
            messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
        }
//    }
}

//获取验证码倒计时
-(void)daojishi{
    [_yzmBtn setTitle:[NSString stringWithFormat:@"%@%ds",eLocalizedString(@"login_Countdown"),messageIssssss] forState:UIControlStateNormal];
    _yzmBtn.userInteractionEnabled = NO;
    [_yzmBtn setTitleColor:GrayText204 forState:0];

    if (messageIssssss<=0) {
        [_yzmBtn setTitleColor:normalColors forState:0];
        [_yzmBtn setTitle:eLocalizedString(@"login_Retrieve") forState:UIControlStateNormal];
        _yzmBtn.userInteractionEnabled = YES;
        [messsageTimer invalidate];
        messsageTimer = nil;
        messageIssssss = 60;
    }
    messageIssssss-=1;
}

//MARK: 获取验证码
- (void)requestYZMcode
{
//    if (self.typeN == CancellationTypeN) {
//        
//        [SVProgressHUD show];
//        NSDictionary *dicdic = @{@"email":[LYUserDefault userDefault].mobile, @"type":@"11"};
//        [requestToolClass postNetworkWithUrl:request_user_getCode andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//            [SVProgressHUD dismiss];
//        } fail:^(NSString * _Nonnull msg) {
//            [SVProgressHUD dismiss];
//        }];
//    }else if (self.typeN == payPasswordTypeN) {
//        
//        [SVProgressHUD show];
//        NSDictionary *dicdic = @{@"email":[LYUserDefault userDefault].mobile, @"type":@"5"};
//        [requestToolClass postNetworkWithUrl:request_user_getCode andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//            [SVProgressHUD dismiss];
//        } fail:^(NSString * _Nonnull msg) {
//            [SVProgressHUD dismiss];
//        }];
//    }else {
//        [SVProgressHUD show];
//        
//        NSDictionary *dicdic = @{@"email":[LYUserDefault userDefault].mobile, @"type":@"2"};
//        [requestToolClass postNetworkWithUrl:request_user_getCode andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//            [SVProgressHUD dismiss];
//        } fail:^(NSString * _Nonnull msg) {
//            [SVProgressHUD dismiss];
//        }];
//    }
    
}

@end
