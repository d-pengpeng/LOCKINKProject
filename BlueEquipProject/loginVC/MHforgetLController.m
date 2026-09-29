//
//  MHforgetLController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "MHforgetLController.h"

@interface MHforgetLController ()<UITextFieldDelegate>
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
@end

@implementation MHforgetLController

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
    UIImageView *logoImgV = [HistoryRecordModel createImgImgView];
    logoImgV.image = [UIImage imageNamed:@"logoImg"];
    [self.view addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVHEIGHT+12);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.offset(116);
        make.height.offset(100);
    }];
    
    UILabel *namLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:26 textAlignment:NSTextAlignmentLeft];
    namLab.text = eLocalizedString(@"login_all10");
    namLab.font = CGFontU_Growth(26);
    [self.view addSubview:namLab];
    [namLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImgV.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(12);
        make.height.offset(47);
    }];
    
    UILabel *namLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    namLab2.text = eLocalizedString(@"login_all20");
    namLab2.numberOfLines = 0;
    [self.view addSubview:namLab2];
    [namLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(namLab.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.mas_greaterThanOrEqualTo(47);
    }];
    
    self.textFF = [[UITextField alloc] init];
    self.textFF.textColor = UIColor.whiteColor;
    self.textFF.font = SYS_Font(14);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all8") attributes:
        @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:self.textFF.font}];
    self.textFF.attributedPlaceholder = attrString;
    self.textFF.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textFF];
    [self.textFF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(namLab2.mas_bottom).offset(30);
        make.height.offset(40);
    }];
    
    UIView *linVV = [HistoryRecordModel createViewUIUI];
    [self.view addSubview:linVV];
    [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.textFF.mas_bottom);
        make.height.offset(1);
    }];
    
    self.textCodeFF = [[UITextField alloc] init];
    self.textCodeFF.textColor = UIColor.whiteColor;
    self.textCodeFF.font = SYS_Font(14);
    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all12") attributes:
        @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:self.textCodeFF.font}];
    self.textCodeFF.attributedPlaceholder = attrString3;
    self.textCodeFF.returnKeyType = UIReturnKeyDone;
    self.textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textCodeFF];
    [self.textCodeFF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.top.equalTo(self.textFF.mas_bottom).offset(15);
        make.height.offset(40);
    }];
    
    self.yzmBtn = [[UIButton alloc] init];
    [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
    [self.yzmBtn setTitleColor:normalColors forState:UIControlStateNormal];
    self.yzmBtn.titleLabel.font = SYS_Font(14);
    self.yzmBtn.titleLabel.numberOfLines = 0;
    [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.yzmBtn];
    [self.yzmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textCodeFF.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.width.offset(100);
    }];
    
    UIView *linVV22 = [HistoryRecordModel createViewUIUI];
    [self.view addSubview:linVV22];
    [linVV22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.yzmBtn.mas_left);
        make.top.bottom.equalTo(self.textCodeFF);
        make.width.offset(1);
    }];
    
    UIView *linVV2 = [HistoryRecordModel createViewUIUI];
    [self.view addSubview:linVV2];
    [linVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.textCodeFF.mas_bottom).offset(1);
        make.height.offset(1);
    }];
    
    self.textPasswordFF = [[UITextField alloc] init];
    self.textPasswordFF.textColor = UIColor.whiteColor;
    self.textPasswordFF.font = SYS_Font(14);
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all9") attributes:
        @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:self.textPasswordFF.font}];
    self.textPasswordFF.attributedPlaceholder = attrString2;
    self.textPasswordFF.returnKeyType = UIReturnKeyDone;
    self.textPasswordFF.secureTextEntry = YES;
    self.textPasswordFF.delegate = self;
    [self.view addSubview:self.textPasswordFF];
    [self.textPasswordFF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.textCodeFF.mas_bottom).offset(15);
        make.height.offset(40);
    }];
    
    UIView *linVV3 = [HistoryRecordModel createViewUIUI];
    [self.view addSubview:linVV3];
    [linVV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.textPasswordFF.mas_bottom).offset(1);
        make.height.offset(1);
    }];
    
    self.textPasswordFF2 = [[UITextField alloc] init];
    self.textPasswordFF2.textColor = UIColor.whiteColor;
    self.textPasswordFF2.font = SYS_Font(14);
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"login_all14") attributes:
        @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:self.textPasswordFF2.font}];
    self.textPasswordFF2.attributedPlaceholder = attrString4;
    self.textPasswordFF2.returnKeyType = UIReturnKeyDone;
    self.textPasswordFF2.secureTextEntry = YES;
    self.textPasswordFF2.delegate = self;
    [self.view addSubview:self.textPasswordFF2];
    [self.textPasswordFF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.textPasswordFF.mas_bottom).offset(15);
        make.height.offset(40);
    }];
    
    UIView *linVV4 = [HistoryRecordModel createViewUIUI];
    [self.view addSubview:linVV4];
    [linVV4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.textPasswordFF2.mas_bottom).offset(1);
        make.height.offset(1);
    }];
    
    UIButton *loginBBtn = [HistoryRecordModel createImgBtn];
    [loginBBtn setBackgroundImage:[UIImage imageNamed:@"loginImgs1"] forState:UIControlStateNormal];
    [loginBBtn setTitle:eLocalizedString(@"login_all3") forState:UIControlStateNormal];
    [loginBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    loginBBtn.titleLabel.font = SYS_Font(22);
    [loginBBtn addTarget:self action:@selector(loginBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBBtn];
    [loginBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-TARBARHEIGHT-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(50);
        make.width.offset(230);
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.textPasswordFF) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -80;
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.y = -200;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = 0;
    }];
}

- (void)loginBtnMethod
{
//    if((self.textFF.text.length>0)&&(self.textCodeFF.text.length>0)&&(self.textPasswordFF.text.length>0)&&(self.textPasswordFF2.text.length>0)) {
//        if(self.isRequBoo) {
//            return;
//        }
//        self.isRequBoo = YES;
//        [SVProgressHUD show];
//        NSDictionary *dicMM = @{@"email":self.textFF.text, @"code":self.textCodeFF.text, @"password":minStr(self.textPasswordFF.text), @"confirmPassword":minStr(self.textPasswordFF2.text)};
//        [requestToolClass postNetworkWithUrl:request_user_retrievePasswordByEmail andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//            self.isRequBoo = NO;
//            [LYUserDefault saveEmailAuccount:self.textFF.text];
//            [self.navigationController popViewControllerAnimated:YES];
//        } fail:^(NSString * _Nonnull msg) {
//            self.isRequBoo = NO;
//        }];
//    }
}

- (void)codeRegistClick
{
    if (self.textFF.text.length > 0) {
        
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
//    NSString *phoneStr = minStr(self.textFF.text);
//
//    NSDictionary *dicdic = @{@"email":phoneStr, @"type":@"2"};
//    [requestToolClass getNetworkWithUrl:request_user_getCode andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//        
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
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

@end
