//
//  MHConnectLinkController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/20.
//

#import "MHConnectLinkController.h"
#import "StarrySkyAnimate.h"
#import "MHConnectLinkOneView.h"
#import "MHConnectLinkTwoView.h"
#import "MHOthrMyController.h"

@interface MHConnectLinkController ()<StarrySkyAnimateDelegate>
{
    NSTimer *timeLL;
}
@property (nonatomic, strong) StarrySkyAnimate *StarrySkyA;
@property (nonatomic, strong) MHConnectLinkOneView *ConnectLinkOneV;
@property (nonatomic, strong) UILabel *peopleLab;
@property (nonatomic, strong) UIButton *timeMBtn;
@property (nonatomic, assign) int num_pp;
@property (nonatomic, assign) int num_pp2;
@property (nonatomic, assign) BOOL isSSYes;
@property (nonatomic, strong) NSArray *listsAr;
@property (nonatomic, copy) NSString *sear_str1;
@property (nonatomic, copy) NSString *sear_str2;
@property (nonatomic, copy) NSString *sear_str3;
@property (nonatomic, copy) NSString *sear_str4;
@property (nonatomic, strong) UIImageView *gifImgV;
@property (nonatomic, assign) int num_pp8;
@end

@implementation MHConnectLinkController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"2"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi2 object:@"3"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navView.backgroundColor = UIColor.clearColor;
    
    self.view.backgroundColor = RGB(1, 0, 2);
    
    self.sear_str1 = @"";
    self.sear_str2 = @"";
    self.sear_str3 = @"";
    self.sear_str4 = @"";
  
    //1
    UIButton *lllefBtn = [HistoryRecordModel createImgBtn];
    lllefBtn.frame = CGRectMake(12, NAVHEIGHT-38, 70, 32);
    [lllefBtn setBackgroundImage:[UIImage imageNamed:@"center_img2"] forState:UIControlStateNormal];
    [lllefBtn addTarget:self action:@selector(uploadAllMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:lllefBtn];
    [lllefBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navView.mas_left).offset(12);
        make.bottom.equalTo(self.navView.mas_bottom).offset(-6);
        make.height.offset(32);
        make.width.mas_greaterThanOrEqualTo(70);
    }];
    
    UIImageView *llefImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 16, 16)];
    llefImg.image = [UIImage imageNamed:@"center_img1"];
    [lllefBtn addSubview:llefImg];

    UILabel *llefLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    llefLlab.frame = CGRectMake(26, 0, 42, 32);
    llefLlab.text = eLocalizedString(@"center_all1");
    [lllefBtn addSubview:llefLlab];
    [llefLlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lllefBtn.mas_left).offset(30);
        make.top.bottom.equalTo(lllefBtn);
        make.right.equalTo(lllefBtn.mas_right).offset(-6);
    }];
    
    //2
    UIButton *lllefBtn2 = [HistoryRecordModel createImgBtn];
    lllefBtn2.frame = CGRectMake(_window_width-82, NAVHEIGHT-38, 70, 32);
    [lllefBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img2"] forState:UIControlStateNormal];
    [lllefBtn2 addTarget:self action:@selector(uploadAllMethodTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:lllefBtn2];
    [lllefBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navView.mas_right).offset(-12);
        make.bottom.equalTo(self.navView.mas_bottom).offset(-6);
        make.height.offset(32);
        make.width.mas_greaterThanOrEqualTo(70);
    }];
    
    UIImageView *llefImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 16, 16)];
    llefImg2.image = [UIImage imageNamed:@"center_img3"];
    [lllefBtn2 addSubview:llefImg2];

    UILabel *llefLlab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    llefLlab2.frame = CGRectMake(26, 0, 42, 32);
    llefLlab2.text = eLocalizedString(@"center_all2");
    [lllefBtn2 addSubview:llefLlab2];
    [llefLlab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lllefBtn2.mas_left).offset(30);
        make.top.bottom.equalTo(lllefBtn2);
        make.right.equalTo(lllefBtn2.mas_right).offset(-6);
    }];
    
    UIImageView *centeImgV2 = [HistoryRecordModel createImgImgView];
    centeImgV2.frame = CGRectMake((_window_width-341)/2, NAVHEIGHT+27, 341, 328);
    centeImgV2.image = [UIImage imageNamed:@"center_img10"];
    [self.view addSubview:centeImgV2];
  
    self.gifImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+80, _window_width, 220)];
    [self.view addSubview:self.gifImgV];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"discoverImgsGif.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    self.gifImgV.image = [UIImage sd_imageWithGIFData:data];
    
    self.StarrySkyA = [[StarrySkyAnimate alloc] init];
    self.StarrySkyA.frame = CGRectMake(0, NAVHEIGHT+80, _window_width, 290);
    self.StarrySkyA.delegate = self;
//    self.StarrySkyA.transform = CGAffineTransformRotate (self.StarrySkyA.transform, M_PI-M_PI_2/6);
    [self.view addSubview:self.StarrySkyA];
    
    
    self.ConnectLinkOneV = [[MHConnectLinkOneView alloc] initWithFrame:CGRectMake(0, _window_height-38-TARBARHEIGHT-196, _window_width, 190)];
    [self.view addSubview:self.ConnectLinkOneV];
    WEAKSELF
    self.ConnectLinkOneV.block_ = ^(NSInteger num) {
      
        [weakSelf publishAllMethodTwo:num];
    };
    
    NSString *msgLLstr = [NSString stringWithFormat:@"%@%@%@", eLocalizedString(@"center_all3"), @"10", eLocalizedString(@"center_all3_3")];
    self.peopleLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    self.peopleLab.frame = CGRectMake(0, _window_height-38-TARBARHEIGHT-196-36, _window_width, 20);
    self.peopleLab.text = msgLLstr;
    [self.view addSubview:self.peopleLab];
    
    self.peopleLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:@"10" All:msgLLstr nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    
    [self.view addSubview:self.navView];
    
    self.timeMBtn = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-210)/2, _window_height-38-TARBARHEIGHT-76, 210, 46)];
    [self.timeMBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [self.timeMBtn setTitle:[NSString stringWithFormat:@"00%@", eLocalizedString(@"center_all11")] forState:UIControlStateNormal];
    [self.timeMBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.timeMBtn.titleLabel.font = SYS_Font(14);
    [self.view addSubview:self.timeMBtn];
    self.timeMBtn.hidden = YES;
    
    self.num_pp8 = 1;
    [self UIUIURRRRRR];
    [self.view addSubview:self.navView];
    timeLL = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethodUI) userInfo:nil repeats:YES];
}

- (void)UIUIURRRRRR
{
    self.num_pp8 = 1;
    [requestToolClass getNetworkWithUrl:request_other_getSignalBasicInfo andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *dciM = info;
        self.num_pp2 = [minStr(dciM[@"totalInterval"]) intValue];
        
        self.num_pp = [minStr(dciM[@"sendingInterval"]) intValue];
        
        self.listsAr = dciM[@"userList"];
        
        NSString *msgLLstr2 = [NSString stringWithFormat:@"%@%@%@", eLocalizedString(@"center_all3"), dciM[@"totalAttendance"], eLocalizedString(@"center_all3_3")];
        self.peopleLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:minStr(dciM[@"totalAttendance"]) All:msgLLstr2 nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
        
        [self.StarrySkyA setCelestialName:self.listsAr];
        
        if(self.num_pp > 0) {
            self.isSSYes = YES;
            self.timeMBtn.hidden = NO;
            self.peopleLab.frame = CGRectMake(0, _window_height-38-TARBARHEIGHT-76-36, _window_width, 20);
            self.ConnectLinkOneV.hidden = YES;
        }
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)timeMethodUI
{
    if(self.isSSYes) {
        if(self.num_pp<=1) {
            self.num_pp = 0;
            
            self.isSSYes = NO;
            self.timeMBtn.hidden = YES;
            self.peopleLab.frame = CGRectMake(0, _window_height-38-TARBARHEIGHT-196-36, _window_width, 20);
            self.ConnectLinkOneV.hidden = NO;
        }else {
            self.num_pp --;
        }
        [self.timeMBtn setTitle:[NSString stringWithFormat:@"%@ %@", [HistoryRecordModel secondToHourMinutesSecond:self.num_pp], eLocalizedString(@"center_all11")] forState:UIControlStateNormal];
    }
}

- (void)uploadAllMethod
{
//    [requestToolClass postNetworkWithUrl:request_other_filterSignal andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        self.listsAr = info;
//        [self.StarrySkyA setCelestialName:self.listsAr];
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
    
    [self requestUrlMethodOne];
}

- (void)requestUrlMethodOne
{
    self.num_pp8 = 2;
    NSDictionary *dicdic = @{@"requireGender":self.sear_str2, @"requireGenderPreference":self.sear_str3, @"requireRolePreference":self.sear_str4};
    if(self.sear_str1.length > 0) {
        if([self.sear_str1 isEqualToString:@"1"]) {
            dicdic = @{@"hasToys":@"true", @"requireGender":self.sear_str2, @"requireGenderPreference":self.sear_str3, @"requireRolePreference":self.sear_str4};
        }else {
            dicdic = @{@"hasToys":@"false", @"requireGender":self.sear_str2, @"requireGenderPreference":self.sear_str3, @"requireRolePreference":self.sear_str4};
        }
    }
    [requestToolClass postNetworkWithUrl:request_other_filterSignal andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.listsAr = info;
        [self.StarrySkyA setCelestialName:self.listsAr];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)uploadAllMethodTwo
{
    MHConnectLinkTwoView *vc = [[MHConnectLinkTwoView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    vc.has_str1 = self.sear_str1;
    vc.has_str2 = self.sear_str2;
    vc.has_str3 = self.sear_str3;
    vc.has_str4 = self.sear_str4;
    [self.tabBarController.view addSubview:vc];
    [vc addConnectMethodUIUI:1];
    vc.block_ = ^(NSString * _Nonnull hasToys, NSString * _Nonnull requireGender, NSString * _Nonnull requireGenderPreference, NSString * _Nonnull requireRolePreference) {
        
        self.sear_str1 = hasToys;
        self.sear_str2 = requireGender;
        self.sear_str3 = requireGenderPreference;
        self.sear_str4 = requireRolePreference;
        [self requestUrlMethodOne];
    };
}

- (void)publishAllMethodTwo:(NSInteger)numTTTT
{
    MHConnectLinkTwoView *vc = [[MHConnectLinkTwoView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.tabBarController.view addSubview:vc];
    [vc addConnectMethodUIUI:2];
    vc.block_ = ^(NSString * _Nonnull hasToys, NSString * _Nonnull requireGender, NSString * _Nonnull requireGenderPreference, NSString * _Nonnull requireRolePreference) {
        
        NSString *topicM = @"";
        switch (numTTTT) {
            case 0:
                topicM = @"5";
                break;
            case 1:
                topicM = @"6";
                break;
            case 2:
                topicM = @"2";
                break;
            case 3:
                topicM = @"4";
                break;
            case 4:
                topicM = @"1";
                break;
            case 5:
                topicM = @"3";
                break;
                
            default:
                break;
        }
        
        NSDictionary *dicW = @{@"topic":topicM, @"hasToys":hasToys, @"requireGender":requireGender, @"requireGenderPreference":requireGenderPreference, @"requireRolePreference":requireRolePreference};
        [self uiuiui:dicW];
    };
}

- (void)uiuiui:(NSDictionary *)dicM
{
    [SVProgressHUD show];
    [requestToolClass postNetworkWithUrl:request_other_publishSignal andParameter:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.isSSYes = YES;
        self.num_pp = self.num_pp2;
        self.timeMBtn.hidden = NO;
        self.peopleLab.frame = CGRectMake(0, _window_height-38-TARBARHEIGHT-76-36, _window_width, 20);
        self.ConnectLinkOneV.hidden = YES;
        
        if(self.num_pp8 == 1) {
            [self UIUIURRRRRR];
        }else {
            [self requestUrlMethodOne];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)clickButtonAction:(NSInteger)index
{
    if(self.listsAr.count > index) {
        NSDictionary *dMM = self.listsAr[index];
        MHOthrMyController *vc = [[MHOthrMyController alloc] init];
        vc.otherId = minStr(dMM[@"uid"]);
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
