//
//  MHwelcomLoginController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "MHwelcomLoginController.h"
#import "MHloginController.h"
#import "MHRegisterLController.h"
#import "MHPrivacyProtectionVView.h"
#import "MHAboutSubController.h"
#import "eSelectCountryCodeView.h"

@interface MHwelcomLoginController ()<UITextViewDelegate>
{
    NSTimer *messsageTimer;
    int messageIssssss;//短信倒计时  60s
}
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *oneLab2;
@property (nonatomic, strong) UIImageView *linImgV;
@property (nonatomic, strong) UIImageView *accImgV;
@property (nonatomic, strong) UIImageView *passImgV;
@property (nonatomic, strong) UIButton *regionBtn;
@property (nonatomic, strong) UIButton *yzmBtn;
@property (nonatomic, strong) UIButton *qhBtn;
@property (nonatomic, strong) UIButton * lookPwdBtn;

@property (nonatomic, strong) UITextField *textFF;
@property (nonatomic, strong) UITextField *textCodeFF;
@property (nonatomic, assign) BOOL isRequBoo;

@property (nonatomic, assign) BOOL isTYBoo;
@property (nonatomic, strong) UIImageView *selImgV;
@property (nonatomic, strong) MHPrivacyProtectionVView *privacyProtectionVV;
@property (nonatomic, copy) NSString *regonStr;
@property (nonatomic, copy) NSString *pasYZStr;
@property (nonatomic, assign) BOOL isEmilBoo;
@property (nonatomic, strong) UIButton *deleleMethBtn;
@property (nonatomic, strong) eSelectCountryCodeView *eSelectCountryCodeV;
@end

@implementation MHwelcomLoginController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
//    if([LYUserDefault userDefault].emailAuccount.length>0) {
//        self.textFF.text = [LYUserDefault userDefault].emailAuccount;
//    }
    if(self.privacyProtectionVV) {
        self.privacyProtectionVV.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.hideNavView = YES;
    
    UIImageView *backIMgV = [HistoryRecordModel createImgImgView];
    backIMgV.image = [UIImage imageNamed:@"backNormalImg"];
    [self.view addSubview:backIMgV];
    [backIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    messageIssssss = 60;
    
    UIImageView *logoImgV = [HistoryRecordModel createImgImgView];
    logoImgV.frame = CGRectMake(_window_width/2-62, NAVHEIGHT+12, 124, 110);
    logoImgV.image = [UIImage imageNamed:@"logoImg"];
    [self.view addSubview:logoImgV];

    
    self.oneLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:16 textAlignment:NSTextAlignmentCenter];
    self.oneLab.frame = CGRectMake(10, logoImgV.y+110+22, 104, 36);
    self.oneLab.text = eLocalizedString(@"login_all1");
    self.oneLab.numberOfLines = 0;
    [self.view addSubview:self.oneLab];
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_top).offset(logoImgV.y+110+22+30);
        make.width.offset(104);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.oneLab2 = [HistoryRecordModel createLabLabTextColor:RGB(90, 90, 90) fontFloat:16 textAlignment:NSTextAlignmentCenter];
    self.oneLab2.frame = CGRectMake(10+104, self.oneLab.y, 104, 36);
    self.oneLab2.text = eLocalizedString(@"login_all2");
    self.oneLab2.numberOfLines = 0;
    [self.view addSubview:self.oneLab2];
    [self.oneLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneLab.mas_right).offset(8);
        make.bottom.equalTo(self.view.mas_top).offset(logoImgV.y+110+22+30);
        make.width.offset(104);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.linImgV = [[UIImageView alloc] initWithFrame:CGRectMake(37, logoImgV.y+110+22+30, 50, 3)];
    self.linImgV.clipsToBounds = YES;
    self.linImgV.image = [UIImage imageNamed:@"login_allimg5"];
    [self.view addSubview:self.linImgV];
    
    UIButton *oneBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, self.oneLab.y, 104, 36)];
    [oneBtn1 addTarget:self action:@selector(onebtnMethodOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneBtn1];
    
    UIButton *oneBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(114, self.oneLab.y, 104, 36)];
    [oneBtn2 addTarget:self action:@selector(onebtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneBtn2];
    
    
    self.accImgV = [[UIImageView alloc] initWithFrame:CGRectMake(34, CGRectGetMaxY(self.oneLab.frame)+34, 26, 26)];
    self.accImgV.image = [UIImage imageNamed:@"login_allimg1"];
    [self.view addSubview:self.accImgV];
    
    self.regionBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, self.accImgV.y, 60, 26)];
    [self.regionBtn setTitle:@"+86" forState:UIControlStateNormal];
    [self.regionBtn setTitleColor:normalColors forState:UIControlStateNormal];
    self.regionBtn.titleLabel.font = SYS_Font(13);
    [self.regionBtn setImage:[UIImage imageNamed:@"dissm_nexImg_black"] forState:UIControlStateNormal];
    [self.regionBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:3];
    [self.regionBtn addTarget:self action:@selector(regionBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.regionBtn];
    self.regonStr = @"+86";
    
    self.textFF = [[UITextField alloc] initWithFrame:CGRectMake(self.regionBtn.x+self.regionBtn.width+4, self.accImgV.y-8, _window_width-(self.regionBtn.x+self.regionBtn.width+4+30), 42)];
    self.textFF.textColor = UIColor.whiteColor;
    self.textFF.font = SYS_Font(14);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all3") attributes:
        @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textFF.font}];
    self.textFF.attributedPlaceholder = attrString;
    self.textFF.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textFF];
    
    UIImageView *linVV = [HistoryRecordModel createImgImgView];
    linVV.frame = CGRectMake(30, self.textFF.y+42, _window_width-60, 3);
    linVV.backgroundColor = RGB(186, 80, 191);
    [self.view addSubview:linVV];
    
    
    self.passImgV = [[UIImageView alloc] initWithFrame:CGRectMake(34, CGRectGetMaxY(self.accImgV.frame)+50, 26, 26)];
    self.passImgV.image = [UIImage imageNamed:@"login_allimg2"];
    [self.view addSubview:self.passImgV];
    
    self.textCodeFF = [[UITextField alloc] initWithFrame:CGRectMake(self.passImgV.x+self.passImgV.width+6, self.passImgV.y-8, _window_width-(self.regionBtn.x+self.passImgV.width+90+30), 42)];
    self.textCodeFF.textColor = UIColor.whiteColor;
    self.textCodeFF.font = SYS_Font(14);
    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all4") attributes:
        @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textCodeFF.font}];
    self.textCodeFF.attributedPlaceholder = attrString3;
    self.textCodeFF.returnKeyType = UIReturnKeyDone;
//    self.textCodeFF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textCodeFF];
    
    
    _lookPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-60, self.textCodeFF.y+11, 20, 20)];
    [_lookPwdBtn setImage:[UIImage imageNamed:@"login_password_select"] forState:UIControlStateNormal];
    [_lookPwdBtn setImage:[UIImage imageNamed:@"login_password"] forState:UIControlStateSelected];
    [_lookPwdBtn addTarget:self action:@selector(clickLookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lookPwdBtn];
    _lookPwdBtn.hidden = YES;
    
    self.yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-120, self.textCodeFF.y, 90, 42)];
    [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
    [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
    self.yzmBtn.titleLabel.font = SYS_Font(14);
    self.yzmBtn.titleLabel.numberOfLines = 0;
    [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.yzmBtn];
    
    UIImageView *linVV2 = [HistoryRecordModel createImgImgView];
    linVV2.frame = CGRectMake(30, self.textCodeFF.y+42, _window_width-60, 3);
    linVV2.backgroundColor = RGB(186, 80, 191);
    [self.view addSubview:linVV2];
    
    self.pasYZStr = @"2";
    
    self.qhBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, linVV2.y+9, 96, 34)];
    [self.qhBtn setTitle:eLocalizedString(@"login_all6") forState:UIControlStateNormal];
    [self.qhBtn setTitle:eLocalizedString(@"login_all7") forState:UIControlStateSelected];
    [self.qhBtn setTitleColor:RGB(90, 90, 90) forState:UIControlStateNormal];
    self.qhBtn.titleLabel.font = SYS_Font(14);
    [self.qhBtn addTarget:self action:@selector(qhBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qhBtn];
    [self.qhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(linVV2.y+9);
        make.height.offset(34);
        make.width.mas_greaterThanOrEqualTo(96);
    }];
    
    UIButton *loginBBtn = [HistoryRecordModel createImgBtn];
    [loginBBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [loginBBtn setTitle:eLocalizedString(@"login_all8") forState:UIControlStateNormal];
    [loginBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    loginBBtn.titleLabel.font = SYS_Font(18);
    [loginBBtn addTarget:self action:@selector(loginBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBBtn];
    [loginBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qhBtn.mas_bottom).offset(54);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(48);
        make.width.offset(140);
    }];
    
    [self qhBtnMethod];//MARK: 改为默认密码登录
    
    UIView *botmVV = [HistoryRecordModel createViewUIUI];
    botmVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:botmVV];
    [botmVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBBtn.mas_bottom).offset(6);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(36);
    }];
    
    UILabel *namLab3 = [HistoryRecordModel createLabLabTextColor:RGB(90, 90, 90) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    namLab3.text = eLocalizedString(@"login_all9");
    [botmVV addSubview:namLab3];
    [namLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(botmVV);
        make.left.equalTo(botmVV.mas_left);
    }];
    
    UIButton *sigUpBtn = [HistoryRecordModel createImgBtn];
    [sigUpBtn setTitle:eLocalizedString(@"login_all10") forState:UIControlStateNormal];
    [sigUpBtn setTitleColor:normalColors forState:UIControlStateNormal];
    sigUpBtn.titleLabel.font = SYS_Font(16);
    [sigUpBtn addTarget:self action:@selector(sigUpBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [botmVV addSubview:sigUpBtn];
    [sigUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(botmVV);
        make.left.equalTo(namLab3.mas_right);
        make.right.equalTo(botmVV.mas_right).offset(-1);
    }];
    
    UIView *btVV = [HistoryRecordModel createViewUIUI];
    btVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:btVV];
    [btVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TARBARHEIGHT+30);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.selImgV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 16, 16)];
    self.selImgV.image = [UIImage imageNamed:@"selNor_img"];
    [btVV addSubview:self.selImgV];
    [self.selImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btVV.mas_left).offset(10);
        make.top.equalTo(btVV.mas_top).offset(10);
        make.width.height.offset(16);
    }];
    
    UIButton *ddddeB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 30)];
    [ddddeB addTarget:self action:@selector(seleImbBBMethod) forControlEvents:UIControlEventTouchUpInside];
    [btVV addSubview:ddddeB];
    [ddddeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btVV.mas_left).offset(0);
        make.top.equalTo(btVV.mas_top).offset(0);
        make.width.height.offset(36);
    }];
    
    NSString *urlsTTTT = eLocalizedString(@"login_all11_11");
    NSInteger one_num = eLocalizedString(@"login_all11_11").length;
    NSInteger one_num2 = eLocalizedString(@"login_all11").length;
    NSInteger one_num3 = eLocalizedString(@"login_all12").length;
    NSInteger one_num33 = eLocalizedString(@"login_all13").length;
    NSInteger one_num4 = eLocalizedString(@"login_all14").length;
    
    NSInteger two_nu = one_num - one_num2;
    UITextView *textV = [[UITextView alloc] init];
    textV.editable = false;
    textV.scrollEnabled = false;
    textV.backgroundColor = UIColor.clearColor;
    textV.delegate = self;
    [btVV addSubview:textV];
    [textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btVV.mas_left).offset(36);
        make.right.equalTo(btVV.mas_right).offset(-2);
        make.top.bottom.equalTo(btVV);
    }];
    
    //设置段落样式
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 4.0;//段内行间距
    paragraphStyle.paragraphSpacing = 8.0;//段落间距
    paragraphStyle.firstLineHeadIndent = 0.0;//段首行缩进
    textV.linkTextAttributes = @{NSForegroundColorAttributeName:normalColors};
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] initWithString:urlsTTTT];
    [mutAttString addAttributes:@{
        NSForegroundColorAttributeName:UIColor.whiteColor,
        NSParagraphStyleAttributeName:paragraphStyle,
        NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, mutAttString.length)];
    [mutAttString addAttributes:@{
        NSLinkAttributeName:eLocalizedString(@"login_all12")} range:NSMakeRange(urlsTTTT.length-two_nu, one_num3)];

    [mutAttString addAttributes:@{NSLinkAttributeName:eLocalizedString(@"login_all14")} range:NSMakeRange(one_num2+one_num3+one_num33, one_num4)];
    textV.attributedText = mutAttString;
    
    
    if(![LYUserDefault userDefault].isFirstStart) {
        
        self.privacyProtectionVV = [[MHPrivacyProtectionVView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.view addSubview:self.privacyProtectionVV];
        WEAKSELF
        self.privacyProtectionVV.block_ = ^(NSInteger typ) {
            if(typ == 1) {
                weakSelf.privacyProtectionVV.hidden = YES;
                [weakSelf.privacyProtectionVV removeFromSuperview];
                [LYUserDefault saveIsFirstStart:YES];
                weakSelf.isTYBoo = YES;
                if(weakSelf.isTYBoo) {
                    weakSelf.selImgV.image = [UIImage imageNamed:@"selSelect_img"];
                }else {
                    weakSelf.selImgV.image = [UIImage imageNamed:@"selNor_img"];
                }
            }else {
                weakSelf.privacyProtectionVV.hidden = YES;
            }
        };
    }
    
    if([LYUserDefault userDefault].isPEmail == 2) {
        [self onebtnMethodTwo];
    }
    
    [requestToolClass getNetworkWithUrl:request_config_get andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            //inDomestic 是否是国内
            
            if([info[@"areaCodeList"] isKindOfClass:[NSArray class]]) {
                [LYUserDefault saveCountryCodeArr:info[@"areaCodeList"]];
            }
            if([info[@"adList"] isKindOfClass:[NSArray class]]) {
                [LYUserDefault saveAdListArr:info[@"adList"]];
            }
            [LYUserDefault savePrivacyOrUserDic:info];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    NSString *lang_st = [[SwichLanguage shareInstance] userLanguage];

    if ([lang_st hasPrefix:@"zh"]) {
        
    }else {
        [self onebtnMethodTwo];
    }
    
}

- (void)handleTapUIMethod:(UITapGestureRecognizer *)tagMM
{
    
}

- (void)qhBtnMethod
{
    self.qhBtn.selected = !self.qhBtn.selected;
    if(self.qhBtn.selected == YES) {
        
        NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all4_4") attributes:
            @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textCodeFF.font}];
        self.textCodeFF.attributedPlaceholder = attrString3;
        self.yzmBtn.hidden = YES;
        self.lookPwdBtn.hidden = NO;
        self.textCodeFF.secureTextEntry = YES;
        
        self.pasYZStr = @"1";
    }else {
        NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all4") attributes:
            @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textCodeFF.font}];
        self.textCodeFF.attributedPlaceholder = attrString3;
        self.yzmBtn.hidden = NO;
        self.lookPwdBtn.hidden = YES;
        self.lookPwdBtn.selected = NO;
        self.textCodeFF.secureTextEntry = NO;
        self.pasYZStr = @"2";
    }
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

- (void)onebtnMethodOne
{
    self.oneLab.textColor = normalColors;
    self.oneLab2.textColor = RGB(90, 90, 90);
    [UIView animateWithDuration:0.3 animations:^{
        self.linImgV.x = 37;
    }];
    
    self.accImgV.image = [UIImage imageNamed:@"login_allimg1"];
    self.regionBtn.hidden = NO;
    self.textFF.frame = CGRectMake(self.regionBtn.x+self.regionBtn.width+4, self.accImgV.y-8, _window_width-(self.regionBtn.x+self.regionBtn.width+4+30), 42);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all3") attributes:
        @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textFF.font}];
    self.textFF.attributedPlaceholder = attrString;
    
    self.isEmilBoo = NO;
}

- (void)onebtnMethodTwo
{
    self.oneLab2.textColor = normalColors;
    self.oneLab.textColor = RGB(90, 90, 90);
    [UIView animateWithDuration:0.3 animations:^{
        self.linImgV.x = 141;
    }];
    
    self.accImgV.image = [UIImage imageNamed:@"login_allimg4"];
    self.regionBtn.hidden = YES;
    self.textFF.frame = CGRectMake(self.accImgV.x+self.accImgV.width+8, self.accImgV.y-8, _window_width-(self.accImgV.x+self.accImgV.width+8+30), 42);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all3_3") attributes:
        @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textFF.font}];
    self.textFF.attributedPlaceholder = attrString;
    
    self.isEmilBoo = YES;
}


- (void)loginBtnMethod
{
    [self.view endEditing:YES];
    if((self.textFF.text.length>0)&&(self.textCodeFF.text.length>0)) {
        if(!self.isTYBoo) {
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_all15")];
            return;
        }
        if(self.isRequBoo) {
            return;
        }
        self.isRequBoo = YES;
        [SVProgressHUD show];
        NSString *phoneStr = [NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text];
        if(self.isEmilBoo) {
            phoneStr = minStr(self.textFF.text);
        }
        NSDictionary *dicMM = @{@"contact":phoneStr, @"verificationMethod":self.pasYZStr, @"password":minStr(self.textCodeFF.text), @"code":minStr(self.textCodeFF.text)};
        [requestToolClass postNetworkWithUrl:request_login_login andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            if([info isKindOfClass:[NSDictionary class]]) {
                [LYUserDefault saveEmailAuccount:phoneStr];
                
                [LYUserDefault saveUserLoginDefault:info];
          
                if(self.isEmilBoo) {
                    [LYUserDefault saveIsEmailBoo:2];
                }else {
                    [LYUserDefault saveIsEmailBoo:1];
                }
                
                [LYUserDefault saveIsLoginBoo:YES];
                
                if([LYUserDefault userDefault].sealing) {
                    
                    [LYUserDefault saveIsSealing:NO];
                    
                    NSArray *ar_list = [HistoryRecordModel requestAccountAllDataPlist];
                    NSString *main_id = @"";
                    BOOL isMMainBoo = NO;
                    for (NSDictionary *dicSub in ar_list) {
                        if([minStr(dicSub[@"uid"]) isEqualToString:minStr(info[@"userId"])]) {

                            isMMainBoo = YES;
                        }
                        if([minStr(dicSub[@"recordId"]) intValue] == 0) {
                            main_id = minStr(dicSub[@"uid"]);
                        }
                    }
                    if(isMMainBoo) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                        });
                    }else {
                        [requestToolClass postNetworkWithUrl:request_config_establishLink andParameter:@{@"mainId":main_id, @"subId":minStr(info[@"userId"]), @"subToken":minStr(info[@"token"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                        } fail:^(NSString * _Nonnull msg) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                        }];
                    }
                    
                }else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                    });
                }
            }
            
        } fail:^(NSString * _Nonnull msg) {
            self.isRequBoo = NO;
            if([msg isEqualToString:@"50008"]) {
                
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"login_err1") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"login_err2") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        [self sigUpBtnMethod];
                    }
                }];
            }
        }];
    }
}

- (void)sigUpBtnMethod
{
    MHRegisterLController *vc = [[MHRegisterLController alloc] init];
    vc.isTYBoo = self.isTYBoo;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^(BOOL isboo) {
      
        self.isTYBoo = isboo;
        if(self.isTYBoo) {
            self.selImgV.image = [UIImage imageNamed:@"selSelect_img"];
        }else {
            self.selImgV.image = [UIImage imageNamed:@"selNor_img"];
        }
    };
}

- (void)codeRegistClick
{
    if (self.textFF.text.length > 0) {
        _yzmBtn.userInteractionEnabled = NO;
        if (messageIssssss > 58) {
            [self requestYZMcode];
        }
        if (messsageTimer == nil) {
            messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
        }
    }
}

//MARK: 获取验证码
- (void)requestYZMcode
{
    NSString *phoneStr = [NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text];
    if(self.isEmilBoo) {
        phoneStr = minStr(self.textFF.text);
    }
    NSDictionary *dicdic = @{@"contact":phoneStr, @"type":@"2"};
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

- (void)seleImbBBMethod
{
    self.isTYBoo = !self.isTYBoo;
    if(self.isTYBoo) {
        self.selImgV.image = [UIImage imageNamed:@"selSelect_img"];
    }else {
        self.selImgV.image = [UIImage imageNamed:@"selNor_img"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSInteger one_num2 = eLocalizedString(@"login_all11").length;
    if(characterRange.location == one_num2) {
        MHAboutSubController *vc = [[MHAboutSubController alloc] init];
        vc.typeNN = 1;
        vc.guide_id = [LYUserDefault userDefault].privacyPolicyUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        MHAboutSubController *vc = [[MHAboutSubController alloc] init];
        vc.typeNN = 0;
        vc.guide_id = [LYUserDefault userDefault].userAgreementUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
    return NO;
}

- (void)xieyiBtnMethod
{
    MHAboutSubController *vc = [[MHAboutSubController alloc] init];
    vc.typeNN = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)xieyiBtnMethodTwo
{
    MHAboutSubController *vc = [[MHAboutSubController alloc] init];
    vc.typeNN = 3;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickLookAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.textCodeFF.secureTextEntry = !btn.selected;
}

@end
