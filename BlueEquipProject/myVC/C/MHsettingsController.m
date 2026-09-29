//
//  MHsettingsController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/31.
//

#import "MHsettingsController.h"
#import "MHsettingsSubController.h"

#import "MHUserGuideController.h"
#import "MHHelpController.h"
#import "MHAboutController.h"
#import "MHAboutSubController.h"
#import "MHRankingPlaceView.h"
#import "mandatoryUpdateView.h"
#import "MHLanguageController.h"
#import "MHRedoPasswordController.h"
#import "MHToggleAccountController.h"
#import "MHBlacklistController.h"

@interface MHsettingsController ()

@property (nonatomic, strong) UILabel *caheLab;
@property (nonatomic, copy) NSString *vairStr;
@property (nonatomic, assign) BOOL isRRRR;
@end

@implementation MHsettingsController

- (void)viewWillAppear:(BOOL)animated {
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
    
    self.titleName.text = eLocalizedString(@"my_settings");
    self.navView.backgroundColor = RGB(247, 247, 247);
    

    UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    scrolVV.showsVerticalScrollIndicator = NO;
    scrolVV.showsHorizontalScrollIndicator = NO;
    scrolVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:scrolVV];
    
    scrolVV.contentSize = CGSizeMake(_window_width, 54*13+120);
    
//    NSArray *imgsAr = @[@"setting_imgs1", @"setting_imgs2", @"setting_imgs3", @"setting_imgs4", @"setting_imgs5", @"setting_imgs6", @"setting_imgs7", @"setting_imgs9", @"setting_imgs10", @"setting_imgs11"];
//    NSArray *namsAr = @[@"my_settings1", @"my_settings2", @"my_settings3", @"my_settings4", @"my_settings5", @"my_settings6", @"my_settings7", @"my_settings8", @"my_settings9", @"my_settings10"];
//    NSArray *spacsAr = @[@"0", @"12", @"12", @"24", @"24", @"24", @"36", @"48", @"60", @"60"];
    
    
    NSArray *imgsAr = @[@"setting_imgs1", @"setting_imgs1_2", @"setting_imgs2", @"setting_imgs3", @"setting_imgs4", @"setting_imgs5", @"setting_imgs6", @"setting_imgs7", @"setting_imgs9", @"setting_imgs10", @"setting_imgs11"];
    NSArray *namsAr = @[@"my_settings1", @"message_tile5", @"my_settings2", @"my_settings3", @"my_settings4", @"my_settings5", @"my_settings6", @"my_settings7", @"my_settings8", @"my_settings9", @"my_settings10"];
    NSArray *spacsAr = @[@"0", @"12", @"24", @"24", @"36", @"36", @"36", @"48", @"60", @"72", @"72"];
    NSArray *tagsAr = @[@"500", @"510", @"501", @"502", @"503", @"504", @"505", @"506", @"507", @"508", @"509"];
    
//    NSArray *imgsAr = @[@"setting_imgs1", @"setting_imgs2", @"setting_imgs3", @"setting_imgs4", @"setting_imgs5", @"setting_imgs6", @"setting_imgs7", @"setting_imgs9", @"setting_imgs10", @"setting_imgs11"];
//    NSArray *namsAr = @[@"my_settings1", @"my_settings2", @"my_settings3", @"my_settings4", @"my_settings5", @"my_settings6", @"my_settings7", @"my_settings8", @"my_settings9", @"my_settings10"];
//    NSArray *spacsAr = @[@"0", @"12", @"12", @"24", @"24", @"24", @"36", @"48", @"60", @"72", @"72"];
//    NSArray *tagsAr = @[@"500", @"501", @"502", @"503", @"504", @"505", @"506", @"507", @"508", @"509"];
    
    for (int i=0; i<imgsAr.count; i++) {
        NSString *ssH = spacsAr[i];
        UIView *subVVV = [[UIView alloc] initWithFrame:CGRectMake(0, i*54+[ssH intValue], _window_width, 54)];
        subVVV.backgroundColor = UIColor.whiteColor;
        [scrolVV addSubview:subVVV];
        
        UIImageView *imgIV = [HistoryRecordModel createImgImgView];
        imgIV.frame = CGRectMake(12, 15, 24, 24);
        imgIV.image = [UIImage imageNamed:imgsAr[i]];
        [subVVV addSubview:imgIV];
        
        UILabel *labLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        labLab.frame = CGRectMake(50, 0, subVVV.width-100, subVVV.height);
        labLab.text = eLocalizedString(namsAr[i]);
        [subVVV addSubview:labLab];
        
        UIImageView *nexIV = [HistoryRecordModel createImgImgView];
        nexIV.image = [UIImage imageNamed:@"next_Img2"];
        [subVVV addSubview:nexIV];
        [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(subVVV.mas_right).offset(-12);
            make.centerY.equalTo(subVVV.mas_centerY);
            make.width.height.offset(16);
        }];
        
        UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, subVVV.width, subVVV.height-10)];
        cliBBtn.tag = [tagsAr[i] integerValue];
        [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
        [subVVV addSubview:cliBBtn];
        
        if((i == 2) || (i == 4) || (i == 5) || (i == 9)) {

            UIView *linV = [HistoryRecordModel createLineViewUIUI];
            linV.frame = CGRectMake(0, 53, _window_width, 1);
            [subVVV addSubview:linV];
        }
    }
    
    UIButton *logoutBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 54*12+30, _window_width, 54)];
    [logoutBBtn setTitle:eLocalizedString(@"home_LogOutLogOut") forState:UIControlStateNormal];
    logoutBBtn.backgroundColor = UIColor.whiteColor;
    [logoutBBtn setTitleColor:RGB(244, 90, 90) forState:UIControlStateNormal];
    logoutBBtn.titleLabel.font = SYS_Font(16);
    [logoutBBtn addTarget:self action:@selector(logoutMethod) forControlEvents:UIControlEventTouchUpInside];
    [scrolVV addSubview:logoutBBtn];
}

- (void)logoutMethod
{
    [SGActionView showAlertWithTitle:eLocalizedString(@"home_LogOutLogOut") message:eLocalizedString(@"home_set_SureLogOut") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
        if (index == 1) {
            [LYUserDefault clearLoginCache];
            [LYUserDefault saveIsLoginBoo:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
        }
    }];
}

- (void)KeepAwakeMethod:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(btn.selected == YES) {
        [LYUserDefault saveScreenAwake:YES];
        //设置常亮不锁屏
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }else {
        [LYUserDefault saveScreenAwake:NO];
        //设置常亮不锁屏
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    }
}

- (void)clicListTagsMethod:(UIButton *)btn
{
    switch (btn.tag) {
        case 500:
        {
            //账户与安全
            MHsettingsSubController *vc = [[MHsettingsSubController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 501:
        {
            //常见问题
            MHUserGuideController *vc = [[MHUserGuideController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 502:
        {
            //问题反馈
            MHHelpController *vc = [[MHHelpController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 503:
        {
            //检查更新
            
            [AppVersionManager checkAppStoreVersionWithAppId:@"6615071633"];
            
            
//            if(self.isRRRR) {
//                return;
//            }
//            [SVProgressHUD show];
//            self.isRRRR = YES;
//
//            [requestToolClass getNetworkWithUrl:request_other_checkUpdate andParameter:@{@"type":@"2"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                
//                if([info isKindOfClass:[NSDictionary class]]) {
//                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//                    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//
//                    NSString *ios_Verstr = [NSString stringWithFormat:@"%@", info[@"code"]];
//                    if([ios_Verstr containsString:@"."]) {
//                        if (![ios_Verstr isEqualToString:app_Version]) {
//                            mandatoryUpdateView *vc = [[mandatoryUpdateView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//                            [self.view addSubview:vc];
//                            [vc addUIUIUIUI:info];
//                        }else {
//                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
//                        }
//                    }else {
//                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
//                    }
//                }else {
//                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
//                }
//                self.isRRRR = NO;
//            } fail:^(NSString * _Nonnull msg) {
//                self.isRRRR = NO;
//                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
//            }];
            
        }
            break;
        case 504:
        {
            //关于我们
            MHAboutController *vc = [[MHAboutController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 505:
        {
            
            MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.view addSubview:vc];
            [vc addDataToDic:3];
            vc.block_ = ^(BOOL isBBB) {
                if(isBBB) {
                    [HistoryRecordModel cleanCache:^{
                        CGFloat size_all = [HistoryRecordModel folderSizeAtPath];
                        self.caheLab.text = [NSString stringWithFormat:@"%.1fM", size_all];
                    }];
                }
            };
            
//            CGFloat siz_str = [HistoryRecordModel folderSizeAtPath];
//            NSString *msg_str = [NSString stringWithFormat:@"%@%.1fM", eLocalizedString(@"home_set_CurrentCacheUsag"), siz_str];
//            [SGActionView showAlertWithTitle:nil message:msg_str leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
//                if (index == 1) {
//
//                    [HistoryRecordModel cleanCache:^{
//                        CGFloat size_all = [HistoryRecordModel folderSizeAtPath];
//                        self.caheLab.text = [NSString stringWithFormat:@"%.1fM", size_all];
//                    }];
//                }
//            }];
        }
            break;
        case 506:
        {
            //语言更换
            MHLanguageController *vc = [[MHLanguageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 507:
        {
            //在线客服
//            MHAboutSubController *vc = [[MHAboutSubController alloc] init];
//            vc.isBB = YES;
//            vc.tit_str = eLocalizedString(@"my_settings8");
//            [self.navigationController pushViewController:vc animated:YES];
            if([[LYUserDefault userDefault].kefuId intValue] > 0) {
                
                [[V2TIMManager sharedInstance] getConversation:[NSString stringWithFormat:@"c2c_%@", [LYUserDefault userDefault].kefuId] succ:^(V2TIMConversation *conv) {
                    [[FloatingWindowModel shareInstance] switchChatDetailControlNick:conv.showName hostId:[LYUserDefault userDefault].kefuId];
                } fail:^(int code, NSString *desc) {
                    
                }];
            }
            
        }
            break;
        case 508:
        {
            //切换账户
            MHToggleAccountController *vc = [[MHToggleAccountController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 509:
        {
            //注销账号
            MHRedoPasswordController *vc = [[MHRedoPasswordController alloc] init];
            vc.isChageAccount = 2;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 510:
        {
            //黑名单
            MHBlacklistController *vc = [[MHBlacklistController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
