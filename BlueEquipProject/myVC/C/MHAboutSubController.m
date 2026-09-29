//
//  MHAboutSubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/14.
//

#import "MHAboutSubController.h"
#import <WebKit/WebKit.h>

@interface MHAboutSubController ()

@property (nonatomic, strong) WKWebView *contLab;
@end

@implementation MHAboutSubController

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
    
    if(self.isBB) {
        self.titleName.text = self.tit_str;
    }else {
        NSArray *fouAr = @[@"my_about1", @"my_about2", @"my_about3"];
        self.titleName.text = eLocalizedString(fouAr[self.typeNN]);
    }
    
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.contLab = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    self.contLab.contentMode = UIViewContentModeScaleAspectFill;
    self.contLab.scrollView.bounces = NO;
    self.contLab.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.contLab];
    
    if(self.isBB) {
        [self guideMethodUI];
    }else {
        NSURL *url = [NSURL URLWithString:self.guide_id];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [self.contLab loadRequest:request];
    }
//https://admin.lockink.cn/Agreement.html?type=2&lang=zh
//https://admin.lockink.cn/Agreement.html?type=1&lang=zh
}

- (void)guideMethodUI
{
//    NSString *url_url = [NSString stringWithFormat:@"%@?id=%@", request_userGuide_getDetail, self.guide_id];
//    [requestToolClass getNetworkWithUrl:url_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        if([info isKindOfClass:[NSDictionary class]]) {
//            NSString *detailTextString = [NSString stringWithFormat:@"%@", info[@"content"]];
//            NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
//            NSString *adaptString = [NSString stringWithFormat:@"<head><style>img{max-width:100%% !important;height:auto !important}</style></head>%@", [NSString stringWithFormat:@"%@<br><br>", detailTextString]];
//            [self.contLab loadHTMLString:[headerString stringByAppendingString:adaptString] baseURL:nil];
//        }
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
}

- (void)adddMMethod
{
//    NSString *url_url = request_appUser_getPrivacyPolicy;
//    if(self.typeNN == 2) {
//        url_url = request_appUser_getTermsAndConditions;
//    }
//    if(self.typeNN == 3) {
//        url_url = request_appUser_getUserLicenseAgreement;
//    }
//    [requestToolClass getNetworkWithUrl:url_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//        
//        NSString *detailTextString = [NSString stringWithFormat:@"%@", info];
//        NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
//        NSString *adaptString = [NSString stringWithFormat:@"<head><style>img{max-width:100%% !important;height:auto !important}</style></head>%@", [NSString stringWithFormat:@"%@<br><br>", detailTextString]];
//        [self.contLab loadHTMLString:[headerString stringByAppendingString:adaptString] baseURL:nil];
//    } fail:^(NSString * _Nonnull msg) {
//        
//    }];
    
}

@end
