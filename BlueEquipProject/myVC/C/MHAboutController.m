//
//  MHAboutController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/1.
//

#import "MHAboutController.h"
#import "MHAboutSubController.h"

@interface MHAboutController ()

@property (nonatomic, copy) NSString *privacyPolicyUrl;
@property (nonatomic, copy) NSString *userAgreementUrl;
@property (nonatomic, copy) NSString *endUserLicenseAgreement;
@end

@implementation MHAboutController

-(void)viewWillAppear:(BOOL)animated {
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
    self.titleName.text = eLocalizedString(@"my_settings5");
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
     
    
    UIImageView *logoImgv = [HistoryRecordModel createImgImgView];
    logoImgv.image = [UIImage imageNamed:@"logoImg"];
    logoImgv.layer.cornerRadius = 6;
    [self.view addSubview:logoImgv];
    [logoImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(32);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.offset(76);
    }];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    UILabel *namL = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
    namL.text = app_Name;
    [self.view addSubview:namL];
    [namL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImgv.mas_bottom).offset(8);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(20);
    }];
    
    UILabel *namL2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    namL2.text = [NSString stringWithFormat:@"V%@", app_Version];
    [self.view addSubview:namL2];
    [namL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(namL.mas_bottom).offset(6);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(20);
    }];
    
    
    UIView *twoVV = [HistoryRecordModel createViewUIUI];
    twoVV.frame = CGRectMake(12, NAVHEIGHT+196, _window_width-24, 220);
    twoVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:twoVV];
    
    NSArray *fouAr = @[@"my_about1", @"my_about2", @"my_about3"];
    for (int i=0; i<fouAr.count; i++) {
        UIView *subVV = [HistoryRecordModel createViewUIUI];
        subVV.frame = CGRectMake(12, i*55, twoVV.width-24, 54);
        subVV.backgroundColor = UIColor.clearColor;
        [twoVV addSubview:subVV];
        
        UILabel *subLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        subLLab.frame = CGRectMake(0, 0, subVV.width-60, 54);
        subLLab.text = eLocalizedString(fouAr[i]);
        [subVV addSubview:subLLab];
        
        UIImageView *nexIV = [HistoryRecordModel createImgImgView];
        nexIV.image = [UIImage imageNamed:@"next_Img2"];
        [subVV addSubview:nexIV];
        [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(subVV.mas_right);
            make.centerY.equalTo(subVV.mas_centerY);
            make.width.height.offset(18);
        }];
        
//        if(i>0) {
//            UIView *linv = [HistoryRecordModel createLineViewUIUI];
//            linv.frame = CGRectMake(0, 0, subVV.width, 1);
//            [subVV addSubview:linv];
//        }
        
        UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, subVV.width, subVV.height-10)];
        cliBBtn.tag = 500+i;
        [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
        [subVV addSubview:cliBBtn];
    }
    
    self.privacyPolicyUrl = @"";
    self.userAgreementUrl = @"";
    self.endUserLicenseAgreement = @"";
    
    [requestToolClass getNetworkWithUrl:request_other_getAboutUs andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
        NSString *lang_new = @"en";
        if ([langStr hasPrefix:@"zh"]) {
        
            lang_new = @"zh";
        }else {
            lang_new = @"en";
        }
        
        self.privacyPolicyUrl = [NSString stringWithFormat:@"%@&lang=%@", minStr(info[@"privacyPolicyUrl"]), lang_new];
        self.userAgreementUrl = [NSString stringWithFormat:@"%@&lang=%@", minStr(info[@"userAgreementUrl"]), lang_new];
        self.endUserLicenseAgreement = [NSString stringWithFormat:@"%@&lang=%@", minStr(info[@"endUserLicenseAgreement"]), lang_new];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)clicListTagsMethod:(UIButton *)btn
{
    switch (btn.tag) {
        case 500:
        {
            MHAboutSubController *vc = [[MHAboutSubController alloc] init];
            vc.typeNN = 0;
            vc.guide_id = self.privacyPolicyUrl;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 501:
        {
            MHAboutSubController *vc = [[MHAboutSubController alloc] init];
            vc.typeNN = 1;
            vc.guide_id = self.userAgreementUrl;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 502:
        {
            MHAboutSubController *vc = [[MHAboutSubController alloc] init];
            vc.typeNN = 2;
            vc.guide_id = self.endUserLicenseAgreement;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 503:
        {
            /*
             NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
             NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
             if ([LYUserDefault userDefault].iosVersionNumber.length > 0) {

                 if ([[LYUserDefault userDefault].iosVersionNumber isEqualToString:app_Version]) {
                     [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
                 }else {

                     NSString *version_name = [NSString stringWithFormat:@"%@ %@", eLocalizedString(@"version_newUrl"), [LYUserDefault userDefault].iosVersionNumber];
                     [SGActionView showAlertWithTitle:eLocalizedString(@"home_CheckUpdates") message:version_name leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"event_Sure") selectedHandle:^(NSInteger index) {
                         if (index == 1) {

                             NSString *safari_url = [LYUserDefault userDefault].iosDownloadUrl;
                             if (safari_url.length > 0) {
                                 if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:safari_url]]) {
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:safari_url] options:@{} completionHandler:^(BOOL success) {
                                         
                                     }];
                                 }
                             }
                         }
                     }];
                 }
             }else {
                 [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
             }
             */
        }
            break;
            
        default:
            break;
    }
}

@end
