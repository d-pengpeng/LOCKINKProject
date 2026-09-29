//
//  MHRegisterLController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "MHRegisterLController.h"
#import "MHAboutSubController.h"
#import "MHloginController.h"
#import "eSelectCountryCodeView.h"

@interface MHRegisterLController ()<UITextFieldDelegate, UITextViewDelegate>
{
    NSTimer *messsageTimer;
    int messageIssssss;//短信倒计时  60s
}
@property (nonatomic, strong) UITextField *textFF;
@property (nonatomic, strong) UITextField *textCodeFF;
@property (nonatomic, strong) UITextField *textPasswordFF;
@property (nonatomic, strong) UITextField *textPasswordFF2;
@property (nonatomic, strong) UIButton *yzmBtn;
@property (nonatomic, assign) BOOL isRequBoo;

@property (nonatomic, strong) UIImageView *selImgV;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *oneLab2;
@property (nonatomic, strong) UIImageView *linImgV;

@property (nonatomic, strong) UIImageView *accImgV;
@property (nonatomic, strong) UIImageView *passImgV;
@property (nonatomic, strong) UIButton *regionBtn;

@property (nonatomic, strong) UIButton *deleleMethBtn;
@property (nonatomic, strong) eSelectCountryCodeView *eSelectCountryCodeV;
@property (nonatomic, copy) NSString *regonStr;
@property (nonatomic, assign) BOOL isEmilBoo;
@end

@implementation MHRegisterLController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //MARK: 判断是否是返回上一页
    NSArray *viewCtrolsArr = self.navigationController.viewControllers;
    if ([viewCtrolsArr indexOfObject:self] == NSNotFound) {
        [messsageTimer invalidate];
        messsageTimer = nil;
        
        if(self.block_) {
            self.block_(self.isTYBoo);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backIMgV = [HistoryRecordModel createImgImgView];
    backIMgV.image = [UIImage imageNamed:@"backNormalImg"];
    [self.view addSubview:backIMgV];
    [backIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    self.redNavView = YES;
    [self.view addSubview:self.navView];
    
    messageIssssss = 60;
    
    self.oneLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:16 textAlignment:NSTextAlignmentCenter];
    self.oneLab.frame = CGRectMake(10, NAVHEIGHT+25, 104, 36);
    self.oneLab.text = eLocalizedString(@"login_all1_1");
    self.oneLab.numberOfLines = 0;
    [self.view addSubview:self.oneLab];
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_top).offset(NAVHEIGHT+25+36);
        make.width.offset(104);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.oneLab2 = [HistoryRecordModel createLabLabTextColor:RGB(90, 90, 90) fontFloat:16 textAlignment:NSTextAlignmentCenter];
    self.oneLab2.frame = CGRectMake(10+104, self.oneLab.y, 104, 36);
    self.oneLab2.text = eLocalizedString(@"login_all2_2");
    self.oneLab2.numberOfLines = 0;
    [self.view addSubview:self.oneLab2];
    [self.oneLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneLab.mas_right).offset(8);
        make.bottom.equalTo(self.view.mas_top).offset(NAVHEIGHT+25+36);
        make.width.offset(104);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.linImgV = [[UIImageView alloc] initWithFrame:CGRectMake(37, NAVHEIGHT+25+36, 50, 3)];
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
    self.textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textCodeFF];
    
    
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
    
    
    self.textPasswordFF = [[UITextField alloc] initWithFrame:CGRectMake(34, CGRectGetMaxY(self.passImgV.frame)+42, _window_width-80, 42)];
    self.textPasswordFF.textColor = UIColor.whiteColor;
    self.textPasswordFF.font = SYS_Font(14);
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all16") attributes:
        @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textPasswordFF.font}];
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
    
    
    UIImageView *linVV3 = [HistoryRecordModel createImgImgView];
    linVV3.frame = CGRectMake(30, self.textPasswordFF.y+42, _window_width-60, 3);
    linVV3.backgroundColor = RGB(186, 80, 191);
    [self.view addSubview:linVV3];
    
    
    self.textPasswordFF2 = [[UITextField alloc] initWithFrame:CGRectMake(34, CGRectGetMaxY(linVV3.frame)+29, _window_width-80, 42)];
    self.textPasswordFF2.textColor = UIColor.whiteColor;
    self.textPasswordFF2.font = SYS_Font(14);
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all17") attributes:
        @{NSForegroundColorAttributeName:RGB(90, 90, 90), NSFontAttributeName:self.textPasswordFF2.font}];
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
    
    
    UIImageView *linVV4 = [HistoryRecordModel createImgImgView];
    linVV4.frame = CGRectMake(30, self.textPasswordFF2.y+42, _window_width-60, 3);
    linVV4.backgroundColor = RGB(186, 80, 191);
    [self.view addSubview:linVV4];
    
    
    UIButton *loginBBtn = [HistoryRecordModel createImgBtn];
    [loginBBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [loginBBtn setTitle:eLocalizedString(@"login_all18") forState:UIControlStateNormal];
    [loginBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    loginBBtn.titleLabel.font = SYS_Font(18);
    [loginBBtn addTarget:self action:@selector(loginBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBBtn];
    [loginBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linVV4.mas_bottom).offset(52);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(48);
        make.width.offset(140);
    }];
 
    
    UIView *btVV = [HistoryRecordModel createViewUIUI];
    btVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:btVV];
    [btVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_bottom).offset(-TARBARHEIGHT-60);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.selImgV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 16, 16)];
    self.selImgV.image = [UIImage imageNamed:@"selNor_img"];
    [btVV addSubview:self.selImgV];
    if(self.isTYBoo) {
        self.selImgV.image = [UIImage imageNamed:@"selSelect_img"];
    }else {
        self.selImgV.image = [UIImage imageNamed:@"selNor_img"];
    }
    
    UIButton *ddddeB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 30)];
    [ddddeB addTarget:self action:@selector(seleImbBBMethod) forControlEvents:UIControlEventTouchUpInside];
    [btVV addSubview:ddddeB];
    
    
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
    
//    UILabel *msgLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    msgLL.text = eLocalizedString(@"login_all11");
//    [btVV addSubview:msgLL];
//    [msgLL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(btVV.mas_left).offset(36);
//        make.top.bottom.equalTo(btVV);
//    }];
//    
//    UIButton *xieyiBtn = [HistoryRecordModel createImgBtn];
//    [xieyiBtn setTitle:eLocalizedString(@"login_all12") forState:UIControlStateNormal];
//    [xieyiBtn setTitleColor:normalColors forState:UIControlStateNormal];
//    xieyiBtn.titleLabel.font = SYS_Font(14);
//    [xieyiBtn addTarget:self action:@selector(xieyiBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//    [btVV addSubview:xieyiBtn];
//    [xieyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(msgLL.mas_right).offset(2);
//        make.top.bottom.equalTo(btVV);
//    }];
//    
//    UILabel *msgLL2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    msgLL2.text = eLocalizedString(@"login_all13");
//    [btVV addSubview:msgLL2];
//    [msgLL2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(xieyiBtn.mas_right).offset(2);
//        make.top.bottom.equalTo(btVV);
//    }];
//    
//    UIButton *xieyiBtn2 = [HistoryRecordModel createImgBtn];
//    [xieyiBtn2 setTitle:eLocalizedString(@"login_all14") forState:UIControlStateNormal];
//    [xieyiBtn2 setTitleColor:normalColors forState:UIControlStateNormal];
//    xieyiBtn2.titleLabel.font = SYS_Font(14);
//    [xieyiBtn2 addTarget:self action:@selector(xieyiBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
//    [btVV addSubview:xieyiBtn2];
//    [xieyiBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(msgLL2.mas_right).offset(2);
//        make.top.bottom.equalTo(btVV);
//    }];
    
    NSString *lang_st = [[SwichLanguage shareInstance] userLanguage];

    if ([lang_st hasPrefix:@"zh"]) {
        
    }else {
        [self onebtnMethodTwo];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.textPasswordFF) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -80;
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -80;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = 0;
    }];
}

- (void)msgBtnMethodTypeTwo
{
    MHAboutSubController *vc = [[MHAboutSubController alloc] init];
    vc.typeNN = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)msgBtnMethodType
{
    MHAboutSubController *vc = [[MHAboutSubController alloc] init];
    vc.typeNN = 3;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginBtnMethod
{
    if((self.textFF.text.length>0)&&(self.textCodeFF.text.length>0)&&(self.textPasswordFF.text.length>0)&&(self.textPasswordFF2.text.length>0)) {
        
        if(!self.isTYBoo) {
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_all15")];
            return;
        }
        if([minStr(self.textPasswordFF.text) isEqualToString:minStr(self.textPasswordFF2.text)]) {
            
            if(self.isRequBoo) {
                return;
            }
            self.isRequBoo = YES;
            
            if(self.isEmilBoo) {

                [requestToolClass postNetworkWithUrl:request_oauth_checkVerificationCode andParameter:@{@"contact":minStr(self.textFF.text), @"code":minStr(self.textCodeFF.text)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    self.isRequBoo = NO;
                    MHloginController *vc = [[MHloginController alloc] init];
                    if(self.isEmilBoo) {
                        vc.phoneStr = minStr(self.textFF.text);
                    }else {
                        vc.phoneStr = [NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text];
                    }
                    vc.passworStr = minStr(self.textPasswordFF.text);
                    vc.codeStr = minStr(self.textCodeFF.text);
                    vc.isEmilBoo = self.isEmilBoo;
                    [self.navigationController pushViewController:vc animated:YES];
                } fail:^(NSString * _Nonnull msg) {
                    self.isRequBoo = NO;
                }];
            }else {
                NSString *ssmmm = [NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text];
                [requestToolClass postNetworkWithUrl:request_oauth_checkVerificationCode andParameter:@{@"contact":ssmmm, @"code":minStr(self.textCodeFF.text)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    self.isRequBoo = NO;
                    MHloginController *vc = [[MHloginController alloc] init];
                    if(self.isEmilBoo) {
                        vc.phoneStr = minStr(self.textFF.text);
                    }else {
                        vc.phoneStr = [NSString stringWithFormat:@"%@%@", self.regonStr, self.textFF.text];
                    }
                    vc.passworStr = minStr(self.textPasswordFF.text);
                    vc.codeStr = minStr(self.textCodeFF.text);
                    vc.isEmilBoo = self.isEmilBoo;
                    [self.navigationController pushViewController:vc animated:YES];
                } fail:^(NSString * _Nonnull msg) {
                    self.isRequBoo = NO;
                }];
            }
        }else {
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_all17")];
        }
    }
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
    NSDictionary *dicdic = @{@"contact":phoneStr, @"type":@"1"};
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

@end
