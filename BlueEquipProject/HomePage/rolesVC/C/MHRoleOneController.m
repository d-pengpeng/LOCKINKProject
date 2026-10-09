//
//  MHRoleOneController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "MHRoleOneController.h"
#import "MHRankingPlaceView.h"
#import "foundInformationView.h"
#import "FSPageContentView.h"
#import "MHRoleOneOneController.h"
#import "MHRoleOneTwoController.h"
#import "MHRoleOneThrCopyController.h"

#import "PopBottomView.h"
#import "MHRoleFriendSelectController.h"
#import "MHPostRoleController.h"
#import "MHRoleOneModel.h"
#import "MHRoleSetCoreLocatView.h"
#import <CoreLocation/CoreLocation.h>
#import "MHRankingPlaceView.h"
#import "MHRoleMoreController.h"
#import "MHOthrMyController.h"
#import "MHRoleConnectView.h"
#import "MHLimitsAuthorityView.h"
#import "MHAddTOYSController.h"

#import "MHRoleTwoSDDJController.h"
#import "MHRoleTwoYSBXController.h"

#import "MHRoleThrJDMSController.h"
#import "MHRoleThrYYYController.h"
#import "MHRoleThrYYKZController.h"
#import "MHRoleThrSDMSController.h"
#import "MHRoleThrBXGLController.h"


@interface MHRoleOneController ()<FSPageContentViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;
@property (nonatomic, strong) foundInformationView *foundInformationV;
@property (nonatomic, strong) UIView *placeOneVV;
@property (nonatomic, strong) UIView *placeTwoVV;
@property (nonatomic, strong) UIButton *headBtn1;
@property (nonatomic, strong) UIButton *headBtn2;
@property (nonatomic, strong) UIButton *lockBtn;
@property (nonatomic, strong) UIButton *lockBtn2;
@property (nonatomic, strong) UIButton *rigBtn;
@property (nonatomic, strong) UIButton *lampBtn;
@property (nonatomic, strong) UIButton *lampBtn57;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, copy) NSString *addresStr;
@property (nonatomic, assign) BOOL isRevokePermission;

@property (nonatomic, strong) MHRoleOneOneController *roleOneOneCVC;
@property (nonatomic, strong) MHRoleOneTwoController *roleOneTwoCVC;
@property (nonatomic, strong) MHRoleOneThrCopyController *MHRoleOneThrCopyC;

@property (nonatomic, strong) MHRoleTwoSDDJController *roleTwoSDDJCVC;
@property (nonatomic, strong) MHRoleTwoYSBXController *roleTwoYSBXCVC;//二期 预设波形

//三期
@property (nonatomic, strong) MHRoleThrJDMSController *roleThrJDMSCVC;
@property (nonatomic, strong) MHRoleThrYYYController *roleThrYYYCVC;
@property (nonatomic, strong) MHRoleThrYYKZController *roleThrYYKZCVC;
@property (nonatomic, strong) MHRoleThrSDMSController *roleThrSDMSCVC;
@property (nonatomic, strong) MHRoleThrBXGLController *roleThrBXGLCVC;



@property (nonatomic, strong) MHRoleConnectView *roleConnetV;

@property (nonatomic, strong) UIImageView *roleImgV11;
@property (nonatomic, strong) UIImageView *roleImgV22;
@property (nonatomic, strong) UILabel *statLLLab;

@property (nonatomic, assign) BOOL isRoleBBB;
@property (nonatomic, assign) BOOL isRoleBBBTwo;
@property (nonatomic, assign) BOOL isRquuu;
@property (nonatomic, assign) BOOL isRRRRR;
@property (nonatomic, assign) BOOL isConnDevic;
@property (nonatomic, assign) BOOL isConnDevic22;
@property (nonatomic, strong) UILabel *placLab;
@property (nonatomic, strong) UIView *placVVV;
@property (nonatomic, assign) BOOL isMasryBoo;
@property (nonatomic, assign) CGFloat wwhh_w;
@property (nonatomic, assign) CGFloat wwhh_w2;
@property (nonatomic, assign) CGFloat wwhh_w3;
@property (nonatomic, strong) UIView *placVVV_vv;

@property (nonatomic, assign) BOOL isLimitsAutBoo;
@end

@implementation MHRoleOneController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
    self.isRoleBBB = YES;
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        if(self.isRoleBBBTwo) {
            if(self.block_) {
                self.block_(2);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if (self.isLimitsAutBoo) {
        self.isLimitsAutBoo = NO;
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSArray *viewCtrolsArr = self.navigationController.viewControllers;
    if ([viewCtrolsArr indexOfObject:self] == NSNotFound) {
        
        [requestToolClass getNOMsgNetworkWithUrl:request_device_connectOrDisconnect andParameter:@{@"deviceId":minIntStr(self.modelM.id), @"type":@"2"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
        } fail:^(NSString * _Nonnull msg) {
            
        }];
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
            
            [self.roleTwoSDDJCVC stopMethodUIUIUI];
            [self.roleTwoYSBXCVC stopMethodUIUIUI];
            
            BOOL isEEEqq = [minStr(self.modelM.mac) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if (isEEEqq) {
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"2", @"strong2":@"1", @"strong3":@"0", @"strong4":@"0"}];
            }
        }
        
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName] || [kCharactName12 isEqualToString:self.modelM.realName] || [kCharactName15 isEqualToString:self.modelM.realName]) {
            
            [self.roleThrYYYCVC stopMethodUIUIUI];
            [self.roleThrYYKZCVC stopMethodUIUIUI];
            [self.roleThrSDMSCVC stopMethodUIUIUI];
            [self.roleThrBXGLCVC stopMethodUIUIUI];
            
            
            BOOL isEEEqq = [minStr(self.modelM.mac) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if (isEEEqq) {
                
                if ([kCharactName7 isEqualToString:self.modelM.realName]) {
                    [FloatingWindowModel shareInstance].choose_numW = self.pageContentV.contentViewCurrentIndex;
                }else {
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":@"0", @"spinIntensity":@"0", @"spinDirection":@"0", @"inElectricMode":@"0", @"voltage":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0"}];
                }
            }
        }
        if ([kCharactName5 isEqualToString:self.modelM.realName]) {
            
            [self.roleThrYYYCVC stopMethodUIUIUI];
            [self.roleThrYYKZCVC stopMethodUIUIUI];
            [self.roleThrSDMSCVC stopMethodUIUIUI];
            [self.roleThrBXGLCVC stopMethodUIUIUI];
            
            BOOL isEEEqq = [minStr(self.modelM.mac) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if (isEEEqq) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":@"0", @"spinIntensity":@"0", @"spinDirection":@"0", @"inElectricMode":@"0", @"voltage":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0"}];
            }

        }
    }
    self.isRoleBBB = NO;
}

-(CLGeocoder *)geocoder {
    if (_geocoder==nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDelegate:self];
    return _locationManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"2"}];
    
    self.redNavView = YES;
    self.addresStr = @"";
    self.isMasryBoo = NO;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    UIImageView *oneImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    oneImgV.image = [UIImage imageNamed:@"role_imgs3"];
    [self.view addSubview:oneImgV];
    
    UIImageView *oneImgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 280)];
    oneImgV2.image = [UIImage imageNamed:@"role_imgs1"];
    [self.view addSubview:oneImgV2];
    
    self.placeOneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 280)];
    self.placeOneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.placeOneVV];
    [self.view addSubview:self.navView];
    
    self.rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rigBtn.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    self.rigBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rigBtn setImage:[UIImage imageNamed:@"role_imgs12"] forState:UIControlStateNormal];
//    self.rigBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.rigBtn addTarget:self action:@selector(rightImageUIUIUI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rigBtn];
    self.rigBtn.hidden = YES;
    
    CGFloat w_xx = (_window_width-217)/2;
    self.headBtn1 = [HistoryRecordModel createImgBtn];
    self.headBtn1.frame = CGRectMake(w_xx+95, 280-205, 122, 122);
    [self.headBtn1 setBackgroundImage:[UIImage imageNamed:@"role_imgs2"] forState:UIControlStateNormal];
    [self.placeOneVV addSubview:self.headBtn1];
    
    _roleImgV11 = [HistoryRecordModel createImgImgView];
    _roleImgV11.frame = CGRectMake(10, 0, 102, 102);
    _roleImgV11.image = [UIImage imageNamed:@"role_imgs9"];
    [self.headBtn1 addSubview:_roleImgV11];

    self.headBtn2 = [HistoryRecordModel createImgBtn];
    self.headBtn2.frame = CGRectMake(w_xx, 280-218, 166, 166);
    [self.headBtn2 setBackgroundImage:[UIImage imageNamed:@"role_imgs2"] forState:UIControlStateNormal];
    [self.placeOneVV addSubview:self.headBtn2];
    
    _roleImgV22 = [HistoryRecordModel createImgImgView];
    _roleImgV22.frame = CGRectMake(13, 13, 140, 140);
    _roleImgV22.image = [UIImage imageNamed:@"role_imgs8"];
    [self.headBtn2 addSubview:_roleImgV22];
    
    self.wwhh_w = 30;
    self.wwhh_w2 = 20;
    self.wwhh_w3 = 10;
    
    //MARK: 开锁 按钮
    CGFloat lock_xx = (_window_width-96-self.wwhh_w*2)/2;
    self.lockBtn = [HistoryRecordModel createImgBtn];
    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 43+self.wwhh_w, 23+self.wwhh_w2);
    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
    [self.lockBtn addTarget:self action:@selector(lockBtnmethod) forControlEvents:UIControlEventTouchUpInside];
    [self.placeOneVV addSubview:self.lockBtn];
    
    self.lockBtn2 = [HistoryRecordModel createImgBtn];
    self.lockBtn2.frame = CGRectMake(lock_xx+self.lockBtn.width+10, self.placeOneVV.height-58-self.wwhh_w3, 43+self.wwhh_w, 23+self.wwhh_w2);
    [self.lockBtn2 setBackgroundImage:[UIImage imageNamed:@"role_lockImg2"] forState:UIControlStateNormal];
    [self.lockBtn2 setBackgroundImage:[UIImage imageNamed:@"role_lockImg2_sel"] forState:UIControlStateSelected];
    [self.lockBtn2 addTarget:self action:@selector(lockBtnmethodTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.placeOneVV addSubview:self.lockBtn2];
    
    self.statLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    self.statLLLab.frame = CGRectMake(50, self.placeOneVV.height-58-40, self.placeOneVV.width-100, 30);
    self.statLLLab.text = eLocalizedString(@"home_nam1");
    [self.placeOneVV addSubview:self.statLLLab];
    
    BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        self.statLLLab.text = eLocalizedString(@"home_nam3");
    }
    
    self.lockBtn.hidden = YES;
    self.lockBtn2.hidden = YES;
    
    //七彩灯
    
    self.lampBtn = [HistoryRecordModel createImgBtn];
    self.lampBtn.frame = CGRectMake((_window_width-60)/2, self.placeOneVV.height-58-self.wwhh_w3, 60, 30);
    [self.lampBtn setBackgroundImage:[UIImage imageNamed:@"lamp_imgNor"] forState:UIControlStateNormal];
    [self.lampBtn setBackgroundImage:[UIImage imageNamed:@"lamp_imgSel"] forState:UIControlStateSelected];
    [self.lampBtn addTarget:self action:@selector(lampBtnmethodMethodclick) forControlEvents:UIControlEventTouchUpInside];
    [self.placeOneVV addSubview:self.lampBtn];
    self.lampBtn.selected = YES;
    self.lampBtn.hidden = YES;
    
    self.lampBtn57 = [HistoryRecordModel createImgBtn];
    self.lampBtn57.frame = CGRectMake((_window_width-60)/2, self.placeOneVV.height-58-self.wwhh_w3, 60, 30);
    [self.lampBtn57 setBackgroundImage:[UIImage imageNamed:@"lamp_imgNor"] forState:UIControlStateNormal];
    [self.lampBtn57 setBackgroundImage:[UIImage imageNamed:@"lamp_imgSel"] forState:UIControlStateSelected];
    [self.lampBtn57 addTarget:self action:@selector(lamp57BtnmethodMethodclick) forControlEvents:UIControlEventTouchUpInside];
    [self.placeOneVV addSubview:self.lampBtn57];
    self.lampBtn57.hidden = YES;
    
    self.placeTwoVV = [[UIView alloc] initWithFrame:CGRectMake(0, oneImgV2.height+30, _window_width, 268)];
    self.placeTwoVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.placeTwoVV];
    
    UIButton *oneBBBB = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-220)/2, 0, 220, 124)];
    [oneBBBB setBackgroundImage:[UIImage imageNamed:@"role_imgs4"] forState:UIControlStateNormal];
    [oneBBBB addTarget:self action:@selector(oneBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.placeTwoVV addSubview:oneBBBB];
    
    UILabel *oneLab1 = [HistoryRecordModel createLabLabTextColor:RGBA(255, 255, 255, 0.18) fontFloat:28 textAlignment:NSTextAlignmentCenter];
    oneLab1.frame = CGRectMake(0, 22, 220, 102);
    oneLab1.text = eLocalizedString(@"role_name1");
    [oneBBBB addSubview:oneLab1];
    
    UIImageView *oneImgV1 = [HistoryRecordModel createImgImgView];
    oneImgV1.frame = CGRectMake(98, 30, 25, 68);
    oneImgV1.image = [UIImage imageNamed:@"role_imgs5"];
    [oneBBBB addSubview:oneImgV1];
    
    UIButton *oneBBBB2 = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-220)/2, 144, 220, 124)];
    [oneBBBB2 setBackgroundImage:[UIImage imageNamed:@"role_imgs6"] forState:UIControlStateNormal];
    [oneBBBB2 addTarget:self action:@selector(twoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.placeTwoVV addSubview:oneBBBB2];
    
    UILabel *oneLab2 = [HistoryRecordModel createLabLabTextColor:RGBA(255, 255, 255, 0.18) fontFloat:28 textAlignment:NSTextAlignmentCenter];
    oneLab2.frame = CGRectMake(0, 0, 220, 102);
    oneLab2.text = eLocalizedString(@"role_name2");
    [oneBBBB2 addSubview:oneLab2];
    
    UIImageView *oneImgV22 = [HistoryRecordModel createImgImgView];
    oneImgV22.frame = CGRectMake(84, 20, 53, 50);
    oneImgV22.image = [UIImage imageNamed:@"role_imgs7"];
    [oneBBBB2 addSubview:oneImgV22];
    
    if(self.modelM.roleSelection) {
        
        self.placVVV_vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        self.placVVV_vv.backgroundColor = GrayText204;
        [self.view addSubview:self.placVVV_vv];
        
        UIImageView *oneImgVppp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        oneImgVppp.image = [UIImage imageNamed:@"role_imgs3"];
        [self.placVVV_vv addSubview:oneImgVppp];
        
        UIImageView *oneImgV2ppp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 280)];
        oneImgV2ppp.image = [UIImage imageNamed:@"role_imgs1"];
        [self.placVVV_vv addSubview:oneImgV2ppp];
        
        
        UIButton *backBntTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        backBntTwo.frame = CGRectMake(10, TIMESTATUSHEIGHT+2, 40, 40);
        backBntTwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [backBntTwo setImage:[UIImage imageNamed:@"EventLiving_back"] forState:UIControlStateNormal];
//        backBntTwo.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [backBntTwo addTarget:self action:@selector(backActionTwoMMM) forControlEvents:UIControlEventTouchUpInside];
        [self.placVVV_vv addSubview:backBntTwo];
        
        
        [self requestDeviceDetailMethodJoinMethod];
    }else {
        
        //MARK: 判断是否可以选色角色
        self.statLLLab.hidden = YES;
        [requestToolClass getNetworkWithUrl:request_device_getRemainingRoles andParameter:@{@"deviceId":minIntStr(self.modelM.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            if([info isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dcMMM = info;
                if(dcMMM.allKeys.count == 2) {
                    
                    if(![dcMMM[@"masterOptional"] boolValue]) {
                        [oneBBBB setBackgroundImage:[UIImage imageNamed:@"role_imgs4_4"] forState:UIControlStateNormal];
                        oneLab1.textColor = RGBA(255, 255, 255, 0.18);
                        oneBBBB.userInteractionEnabled = NO;
                        oneImgV1.image = [UIImage imageNamed:@"role_imgs5_5"];
                    }
                    
                    if(![dcMMM[@"servantOptional"] boolValue]) {
                        [oneBBBB2 setBackgroundImage:[UIImage imageNamed:@"role_imgs6_6"] forState:UIControlStateNormal];
                        oneLab2.textColor = RGBA(255, 255, 255, 0.18);
                        oneBBBB2.userInteractionEnabled = NO;
                        oneImgV22.image = [UIImage imageNamed:@"role_imgs7_7"];
                    }
                }
            }
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    }
    //MARK: 终止远程操作
    self.roleConnetV = [[MHRoleConnectView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:self.roleConnetV];
    [self.roleConnetV addUIUIUIUIType:1];
    WEAKSELF
    self.roleConnetV.block_ = ^(BOOL isBBB) {
      
        if(isBBB) {
            
//            [requestToolClass getNetworkWithUrl:request_device_terminateRemoteConnect andParameter:@{@"deviceId":minIntStr(weakSelf.modelM.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                
//            } fail:^(NSString * _Nonnull msg) {
//                
//            }];
//            weakSelf.roleConnetV.hidden = YES;
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else {
//            weakSelf.roleConnetV.hidden = YES;
        }
    };
    self.roleConnetV.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kNeedChangeGoodsNNN:) name:kNeedChangeGoodsNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kNeedChangeGoodsUploginNoteMEthod) name:kNeedChangeGoodsUploginNote object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluuConnectedNotifMethod:) name:@"bluuConnectedNotif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadRoleTimelockMethod:) name:@"uploadRoleTimelock" object:nil];
    
    if ([[eSocketRocketUtility sharedInstance] getSocketCloseBoo]) {
        [self kNeedChangeGoodsUploginNoteMEthod];
    }
    
}

- (void)backActionTwoMMM
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)uploadRoleTimelockMethod:(NSNotification *)notiF
{
    if([minStr(notiF.object) isEqualToString:@"0"]) {
        [self requestDeviceDetailMethodTwo:3];
    }
}

//MARK: 更新 是否是连接状态
- (void)bluuConnectedNotifMethod:(NSNotification *)notiffB
{
    NSDictionary *MMM = notiffB.object;
    BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        if([minStr(MMM[@"status"]) intValue] == 1) {
            self.statLLLab.text = eLocalizedString(@"home_nam3");
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"1"}];
        }else {
            self.statLLLab.text = eLocalizedString(@"home_nam1");
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"2"}];
        }
    }else {
        if([[minStr(MMM[@"mac"]) uppercaseString] isEqualToString:self.modelM.mac]) {
            if([minStr(MMM[@"status"]) intValue] == 1) {
                self.statLLLab.text = eLocalizedString(@"home_nam3");
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"1"}];
            }else {
                self.statLLLab.text = eLocalizedString(@"home_nam1");
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"2"}];
            }
        }else {
            self.statLLLab.text = eLocalizedString(@"home_nam1");
        }
    }
}

//MARK: 开启tcp
- (void)kNeedChangeGoodsUploginNoteMEthod {
    
    if(self.isRquuu) {
        return;
    }
    self.isRquuu = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //MARK: 开启tcp
        NSURL *urlSS = [NSURL URLWithString:socketWSUrl];
        NSString *scheme = urlSS.scheme.lowercaseString;
        if([scheme isEqualToString:@"ws"] || [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"wss"] || [scheme isEqualToString:@"https"]) {
            [[eSocketRocketUtility sharedInstance] SRWebSocketOpenWithURLString:socketWSUrl];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isRquuu = NO;
        });
    });
}

//MARK:  接收 socket
- (void)kNeedChangeGoodsNNN:(NSNotification *)usfo {
    
    NSString * strD  = [NSString stringWithFormat:@"%@", usfo.object];
    NSData *jsonData = [strD dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (dic) {
        BOOL isEEEqqww = [self.modelM.mac compare:minStr(dic[@"mac"]) options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if([dic.allKeys containsObject:@"mac"]) {
            if(!isEEEqqww) {
                return;
            }
        }
       
        BOOL isEEEqq = [minStr(dic[@"mac"]) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
//        NSLog(@"--接收socket--%@", dic);
        NSString *type = [NSString stringWithFormat:@"%@", dic[@"type"]];
        
        if([type isEqualToString:@"LOCK-ENABLED"]) { //即时锁开启 {"type": "LOCK-ENABLED", "deviceId": 1, "mac": "xxx"}
            
            if([self.modelM.realName isEqualToString:kCharactName2]) {
                self.isMasryBoo = NO;
            }else {
                if(isEEEqq) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"1", @"strong":@"0", @"strong2":@"0"}];
                }
            }
                
            self.roleOneModel.lockEnabled = YES;
            self.lockBtn.selected = YES;
            if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }
                else if ([kCharactName15 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = NO;
                    self.lockBtn2.hidden = YES;
                    
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                }
                else {
                    self.lockBtn.hidden = NO;
                    //硬核模式 隐藏 lockBtn2 按钮
                    if (self.roleOneModel.hardcoreModeEnabled) {
                        self.lockBtn2.hidden = YES;
                        
                        CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                        self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                    }else {
                        //没收权限、恢复权限
                        self.lockBtn2.hidden = NO;
                        CGFloat lock_xx = (_window_width-96-self.wwhh_w*2)/2;
                        self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 43+self.wwhh_w, 23+self.wwhh_w2);
                    }
                }
                
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
                
                self.lockBtn2.selected = self.roleOneModel.revokePermission;
                self.isRevokePermission = NO;
            }else {
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else {
                    self.lockBtn.hidden = NO;
                    self.lockBtn2.hidden = YES;
                    
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                }
                
                
                if(self.roleOneModel.revokePermission) {
                    self.isRevokePermission = YES;
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateNormal];
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateSelected];
                }else {
                    self.isRevokePermission = NO;
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
                }
            }
        }else if([type isEqualToString:@"LOCK-RELEASE"]) { //即时锁关闭 {"type": "LOCK-RELEASE", "deviceId": 1, "mac": "xxx"}
                
            if(isEEEqq) {
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"1", @"strong":@"1", @"strong2":@"0"}];
            }
            if([self.modelM.realName isEqualToString:kCharactName2]) {
                self.isMasryBoo = YES;
            }
            self.roleOneModel.lockEnabled = NO;
            self.lockBtn.selected = NO;
            if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }
                else if ([kCharactName15 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = NO;
                    self.lockBtn2.hidden = YES;
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                }
                else {
                    self.lockBtn.hidden = NO;
                    
                    if (self.roleOneModel.hardcoreModeEnabled) {
                        self.lockBtn2.hidden = YES;
                        CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                        self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                    }else {
                        self.lockBtn2.hidden = NO;
                        CGFloat lock_xx = (_window_width-96-self.wwhh_w*2)/2;
                        self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 43+self.wwhh_w, 23+self.wwhh_w2);
                    }
                    
                }
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
                
                self.lockBtn2.selected = self.roleOneModel.revokePermission;
                self.isRevokePermission = NO;
            }else {
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else {
                    self.lockBtn.hidden = NO;
                    self.lockBtn2.hidden = YES;
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                }
                
                
                if(self.roleOneModel.revokePermission) {
                    self.isRevokePermission = YES;
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateNormal];
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateSelected];
                }else {
                    self.isRevokePermission = NO;
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                        [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
                }
            }

        }else if([type isEqualToString:@"TIME-LOCK-DURATION-CHANGE"]) { //定时锁时间变化  {"type": "TIME-LOCK-DURATION-CHANGE", "totalSeconds": 10000, "deviceId": 1, "mac": "xxx"}
            
            if(!([self.modelM.realName isEqualToString:kCharactName2])) {

                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    
                    int num_l = [minStr(dic[@"timeLockReleaseSeconds"]) intValue]%60;
                    int num_l2 = [minStr(dic[@"timeLockReleaseSeconds"]) intValue];
                    
                    
                    if (num_l == 0) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"4", @"strong":minIntStr(num_l2/60), @"strong2":minStr(dic[@"frequency"]), @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"]), @"strong5":minStr(dic[@"shockMinute"])}];
                    }else {
                        if(num_l>24) {
                            if (num_l2 > 60) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"4", @"strong":minIntStr(num_l2/60+1), @"strong2":minStr(dic[@"frequency"]), @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"]), @"strong5":minStr(dic[@"shockMinute"])}];
                            }
                        }else {
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"4", @"strong":minIntStr(num_l2/60), @"strong2":minStr(dic[@"frequency"]), @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"]), @"strong5":minStr(dic[@"shockMinute"])}];
                        }
                    }
                    
                }else {
                    int num_l = [minStr(dic[@"timeLockReleaseSeconds"]) intValue]%60;
                    int num_l2 = [minStr(dic[@"timeLockReleaseSeconds"]) intValue];
                    
                    
                    if (num_l == 0) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(num_l2/60), @"strong2":@"1", @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"])}];
                    }else {
                        if(num_l>24) {
                            if (num_l2 > 60) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(num_l2/60+1), @"strong2":@"1", @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"])}];
                            }
                        }else {
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(num_l2/60), @"strong2":@"1", @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"])}];
                        }
                    }
                }
            }
            
        }else if([type isEqualToString:@"TIME-LOCK-ENABLED"]) { //定时锁启用  {"type": "TIME-LOCK-ENABLED", "deviceId": 1, "mac": "xxx", "timeLockReleaseSeconds": "3600"}  电击频率和 电击时间
            
            if(isEEEqq) {
                if(![self.modelM.realName isEqualToString:kCharactName2]) {  //钥匙盒 无内部定时程序 无需发送定时指令
                    
                    if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                        
                        int num_l = ([minStr(dic[@"timeLockReleaseSeconds"]) intValue]+2)%60;
                        int num_l2 = [minStr(dic[@"timeLockReleaseSeconds"]) intValue]+2;
                        
                        if (num_l == 0) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"4", @"strong":minIntStr(num_l2/60), @"strong2":minStr(dic[@"frequency"]), @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"]), @"strong5":minStr(dic[@"shockMinute"])}]; //strong2 类型、 strong3 是否长电击 、 strong4 电击强度 、 strong5 电击时长
                        }else {
                            if(num_l>24) {
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"4", @"strong":minIntStr(num_l2/60+1), @"strong2":minStr(dic[@"frequency"]), @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"]), @"strong5":minStr(dic[@"shockMinute"])}];
                            }else {
                                
                                //                        if([minStr(dic[@"unlockReminderEnabled"]) isEqualToString:@"true"]) {
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"4", @"strong":minIntStr(num_l2/60), @"strong2":minStr(dic[@"frequency"]), @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"]), @"strong5":minStr(dic[@"shockMinute"])}];
                            }
                        }
                        
                    }else {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"1", @"strong":@"0", @"strong2":@"0"}];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            int num_l = ([minStr(dic[@"timeLockReleaseSeconds"]) intValue]+2)%60;
                            int num_l2 = [minStr(dic[@"timeLockReleaseSeconds"]) intValue]+2;
                            
                            if (num_l == 0) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(num_l2/60), @"strong2":@"1", @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"])}]; //strong2 类型、 strong3 是否长电击 、 strong4 电击强度
                            }else {
                                if(num_l>24) {
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(num_l2/60+1), @"strong2":@"1", @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"])}];
                                }else {
                                    
                                    //                        if([minStr(dic[@"unlockReminderEnabled"]) isEqualToString:@"true"]) {
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(num_l2/60), @"strong2":@"1", @"strong3":@"2", @"strong4":minStr(dic[@"unlockVoltage"])}];
                                }
                            }
                        });
                    }
                }
            }
            [self requestDeviceDetailMethodTwo:1];
            self.lockBtn.selected = YES;
        }else if([type isEqualToString:@"TIME-LOCK-RELEASE"]) { //定时锁关闭  {"type": "TIME-LOCK-RELEASE", "deviceId": 1, "mac": "xxx", "unlockReminderEnabled": true, "unlockVoltage": 10}
            
//            if(isEEEqq) {
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"1", @"strong":@"1", @"strong2":minStr(dic[@"unlockVoltage"])}];
//                
//                if([minStr(dic[@"unlockReminderEnabled"]) isEqualToString:@"1"]) {
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"0", @"strong2":@"1", @"strong3":minStr(dic[@"unlockVoltage"]), @"strong4":@"1"}];
//                    });
//                }
//            }
            [self requestDeviceDetailMethodTwo:2];
            self.lockBtn.selected = NO;
        }else if([type isEqualToString:@"LOCATION-LOCK-ENABLED"]) { //定位锁启动  {"type" : "LOCATION-LOCK-ENABLED","locationLockUnlockLatitude": "36.40", "locationLockUnlockLongitude": "117.27","locationLockUnlockRangeInKm": 10, "deviceId": 1, "mac": "xxx", "recordId": 1}
            
            self.roleOneModel.locationLockEnabled = YES;
//            self.roleOneModel.locationSERVANTLongitude = minStr(dic[@"locationLockUnlockLongitude"]);
//            self.roleOneModel.locationSERVANTLatitude = minStr(dic[@"locationLockUnlockLatitude"]);
            self.roleOneOneCVC.roleOneModel = self.roleOneModel;
            self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
            self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
            [self.MHRoleOneThrCopyC uploadUIUIUI];
            
            [self requestDeviceDetailMethodThr];
        }else if([type isEqualToString:@"LOCATION-LOCK-RADIUS-CHANGE"]) { //定位锁解锁范围改变  {"type": "LOCATION-LOCK-RADIUS-CHANGE", "locationLockUnlockRangeInKm": 20, "deviceId": 1, "mac": "xxx"}
            
            NSLog(@"定位锁改变");
            self.roleOneModel.locationLockUnlockRangeInKm = [minStr(dic[@"locationLockUnlockRangeInKm"]) intValue];
            self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
            self.roleOneOneCVC.roleOneModel = self.roleOneModel;
            self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
            [self.MHRoleOneThrCopyC uploadUIUIUI];
            
            [self requestDeviceDetailMethodThr];
            
        }else if([type isEqualToString:@"LOCATION-LOCK-RELEASE"]) { //定位锁关闭  {"type": "LOCATION-LOCK-RELEASE","unlockReminderEnabled": true, "unlockVoltage": 10, "deviceId": 1, "mac":"xxx", "recordId": 1}
            
            self.roleOneModel.locationLockEnabled = NO;
            self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
            self.roleOneOneCVC.roleOneModel = self.roleOneModel;
            self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
            [self.MHRoleOneThrCopyC uploadUIUIUI];
            
            [self requestDeviceDetailMethodThr];
            
        }else if([type isEqualToString:@"ELECTRIC-SHOCK"]) { //电击  {"deviceId": 1,"type": "ELECTRIC-SHOCK","countdownSeconds": 180,"frequency": 2,"voltage": 10,"duration": 12, "mac": "xxx", "openLongShock": true}
            
            //MARK: socket  电击
 
            if(isEEEqq) {
                
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    
                    NSLog(@"--电击123----%@", dic);
                    
                    if([minStr(dic[@"openLongShock"]) isEqualToString:@"1"]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"1", @"strong2":minStr(dic[@"frequency"]), @"strong3":minStr(dic[@"voltage"]), @"strong4":minStr(dic[@"duration"])}];
                    }else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"2", @"strong2":minStr(dic[@"frequency"]), @"strong3":minStr(dic[@"voltage"]), @"strong4":minStr(dic[@"duration"])}];
                    }
                    
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    
                    
//                    if([minStr(dic[@"openLongShock"]) isEqualToString:@"1"]) {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"1", @"strong2":minStr(dic[@"frequency"]), @"strong3":minStr(dic[@"voltage"]), @"strong4":minStr(dic[@"duration"])}];
//                    }else {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"2", @"strong2":minStr(dic[@"frequency"]), @"strong3":minStr(dic[@"voltage"]), @"strong4":minStr(dic[@"duration"])}];
//                    }
                    
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    
                }else {
                    if([minStr(dic[@"openLongShock"]) isEqualToString:@"1"]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"1", @"strong2":minStr(dic[@"frequency"]), @"strong3":minStr(dic[@"voltage"]), @"strong4":minStr(dic[@"duration"])}];
                    }else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":@"2", @"strong2":minStr(dic[@"frequency"]), @"strong3":minStr(dic[@"voltage"]), @"strong4":minStr(dic[@"duration"])}];
                    }
                }
            }
            
        }else if([type isEqualToString:@"WEARER_FORCEFULLY_UNLINKED"]) { //强制解绑  {"deviceId": 1, "type": "WEARER_FORCEFULLY_UNLINKED", "mac": "xxx", "operateType": 1、主-主 2、主-次。3、次-主}
            NSString *operateType = [NSString stringWithFormat:@"%@", dic[@"operateType"]];
            switch ([operateType intValue]) {
                case 1:
                {
                    if(![self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                        
                        [self requestDeviceDetailMethod];
                    }else {
                        if(self.block_) {
                            self.block_(4);
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.modelM.mac];
                    }
                }
                    break;
                case 2:
                {
                    if(![self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                        if(self.block_) {
                            self.block_(3);
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.modelM.mac];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else {
                        [self requestDeviceDetailMethod];
                    }
                }
                    break;
                case 3:
                {
                    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                        if(self.block_) {
                            self.block_(5);
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.modelM.mac];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else {
                        if(self.block_) {
                            self.block_(4);
                        }
                        [self requestDeviceDetailMethod];
                    }
                }
                    break;
                    
                default:
                    break;
            }
        
        }else if([type isEqualToString:@"GRANTING-PERMISSIONS"]) { //放开权限  {"deviceId": 1, "type": "GRANTING-PERMISSIONS", "mac": "xxx"}
            
            if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
                
                self.roleOneModel.revokePermission = NO;
                
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else {
                    self.lockBtn.hidden = NO;
                    self.lockBtn2.hidden = YES;
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                    
                }
                
                
                if(self.roleOneModel.revokePermission) {
                    self.isRevokePermission = YES;
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateNormal];
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateSelected];
                }else {
                    self.isRevokePermission = NO;
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
                }
                
                self.roleOneOneCVC.isBMMM = self.isRevokePermission;
                [self.roleOneOneCVC uploadUIUIUI];
                
                if ([kCharactName12 isEqualToString:self.modelM.realName] || [kCharactName15 isEqualToString:self.modelM.realName]) {
                    
                    self.roleThrJDMSCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrYYYCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrYYKZCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrSDMSCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrBXGLCVC.isBMMM = self.isRevokePermission;
                    
                }else {
                    self.roleOneTwoCVC.isBMMM = self.isRevokePermission;
                    [self.roleOneTwoCVC uploadUIUIUI];
                    
                    self.MHRoleOneThrCopyC.isBMMM = self.isRevokePermission;
                    [self.MHRoleOneThrCopyC uploadUIUIUITwo];
                    
                    self.pageContentV.contentViewCurrentIndex = 0;
                    self.pageContentV.contentViewCanScroll = !self.isRevokePermission;
                    [self.foundInformationV stopOrStartUIMehtod:self.isRevokePermission];
                    [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                }
  
                
                self.placVVV.hidden = NO;
                self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"msg_UIUIStr6")];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.placVVV.hidden = YES;
                });
            }
        }else if([type isEqualToString:@"REVOKING-PERMISSIONS"]) { //回收权限  {"deviceId": 1, "type": "REVOKING-PERMISSIONS", "mac": "xxx"}
            
            if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
                
                self.roleOneModel.revokePermission = YES;
                self.roleOneModel.allowServantUnlock = NO; //是否可以开锁
                
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                    self.lockBtn.hidden = YES;
                    self.lockBtn2.hidden = YES;
                }else {
                    self.lockBtn.hidden = NO;
                    self.lockBtn2.hidden = YES;
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                }
                
                if(self.roleOneModel.revokePermission) {
                    self.isRevokePermission = YES;
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateNormal];
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateSelected];
                }else {
                    self.isRevokePermission = NO;
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                    [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
                }
                
                self.roleOneOneCVC.isBMMM = self.isRevokePermission;
                [self.roleOneOneCVC uploadUIUIUI];
                
                if ([kCharactName12 isEqualToString:self.modelM.realName] || [kCharactName15 isEqualToString:self.modelM.realName]) {
                    
                    self.roleThrJDMSCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrYYYCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrYYKZCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrSDMSCVC.isBMMM = self.isRevokePermission;
                    
                    self.roleThrBXGLCVC.isBMMM = self.isRevokePermission;
                    
                }else {
                    self.roleOneTwoCVC.isBMMM = self.isRevokePermission;
                    [self.roleOneTwoCVC uploadUIUIUI];
                    
                    self.MHRoleOneThrCopyC.isBMMM = self.isRevokePermission;
                    [self.MHRoleOneThrCopyC uploadUIUIUITwo];
                    
                    self.pageContentV.contentViewCurrentIndex = 0;
                    self.pageContentV.contentViewCanScroll = !self.isRevokePermission;
                    [self.foundInformationV stopOrStartUIMehtod:self.isRevokePermission];
                    [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                }
                
                self.placVVV.hidden = NO;
                self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"msg_UIUIStr5")];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.placVVV.hidden = YES;
                });
            }
        }else if ([type isEqualToString:@"BOTH-ONLINE"]) {
            
            if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
                [self.view addSubview:self.roleConnetV];
                self.roleConnetV.hidden = NO;
                
                if(self.roleOneModel.locationSERVANTLatitude) {
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"SEND-SERVANT-COORDINATE", @"deviceId":minIntStr(self.modelM.id), @"latitude":self.roleOneModel.locationSERVANTLatitude, @"longitude":self.roleOneModel.locationSERVANTLongitude}];
                }
            }
        }else if ([type isEqualToString:@"CONNECTION-INTERRUPTED"]) {
            
            if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                
                if(self.block_) {
                    self.block_(1);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else if ([type isEqualToString:@"SERVANT-COORDINATE"]) { //佩戴者坐标
            
            NSLog(@"-位置B-Socket--%@---%@", dic[@"latitude"], dic[@"longitude"]);
            self.roleOneModel.locationSERVANTLongitude = minStr(dic[@"longitude"]);
            self.roleOneModel.locationSERVANTLatitude = minStr(dic[@"latitude"]);
            self.roleOneOneCVC.roleOneModel = self.roleOneModel;
            self.roleOneTwoCVC.roleOneModel = self.roleOneModel;

            [self.MHRoleOneThrCopyC uploadUIUILatitude:minStr(dic[@"latitude"]) longitude:minStr(dic[@"longitude"])];
        }else if([type isEqualToString:@"UNREAD-MESSAGE"]) { //存在未读消息
            
            [self uploadMehtodUnread];
        }else if([type isEqualToString:@"AGREE-INVITATION"]) { //接受邀请
            
            [self requestDeviceDetailMethod];
        }else if([type isEqualToString:@"AGREE-PERMISSION-TRANSFER"]) { //权限转移成功
            self.isRoleBBBTwo = YES;
            if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                if(self.isRoleBBB) {
                    if(self.block_) {
                        self.block_(2);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else {
                [self requestDeviceDetailMethod];
            }
        }else if([type isEqualToString:@"DEVICE-CONNECT-CHANGE"]) { //是否连接
            if(([minStr(dic[@"masterConnectStatus"]) intValue] == 1) || ([minStr(dic[@"servantConnectStatus"]) intValue] == 1)) {
                self.isConnDevic = YES;
                self.roleOneOneCVC.isConnDevic = YES;
                self.roleOneTwoCVC.isConnDevic = YES;
                self.roleTwoSDDJCVC.isConnDevic = YES;
                self.roleTwoYSBXCVC.isConnDevic = YES;
                self.roleThrJDMSCVC.isConnDevic = YES;
                self.roleThrYYYCVC.isConnDevic = YES;
                self.roleThrYYKZCVC.isConnDevic = YES;
                self.roleThrSDMSCVC.isConnDevic = YES;
                self.roleThrBXGLCVC.isConnDevic = YES;
                self.statLLLab.text = eLocalizedString(@"home_nam3");
            }else {
                self.isConnDevic = NO;
                self.roleOneOneCVC.isConnDevic = NO;
                self.roleOneTwoCVC.isConnDevic = NO;
                self.roleTwoSDDJCVC.isConnDevic = NO;
                self.roleTwoYSBXCVC.isConnDevic = NO;
                self.roleThrJDMSCVC.isConnDevic = YES;
                self.roleThrYYYCVC.isConnDevic = YES;
                self.roleThrYYKZCVC.isConnDevic = YES;
                self.roleThrSDMSCVC.isConnDevic = YES;
                self.roleThrBXGLCVC.isConnDevic = YES;
                self.statLLLab.text = eLocalizedString(@"home_nam1");
            }
        }else if([type isEqualToString:@"MANUAL-UNLOCK"]) { //可以手动解锁
            
            self.roleOneModel.allowServantUnlock = YES;
        }else if([type isEqualToString:@"AIRPLANE-BOTTLE-CLASSIC-MODE"]) {
            
            //MARK: 三期 ⻢眼棒 socket - 经典模式1
            if(isEEEqq) {
                
                NSLog(@"-断电--- %@", dic);
                NSString *inRandomMode_str = @"0";
                NSString *inBerserkMode_str = @"0";
                if ([dic.allKeys containsObject:@"inRandomMode"]) {
                    inRandomMode_str = minStr(dic[@"inRandomMode"]);
                }
                if ([dic.allKeys containsObject:@"inBerserkMode"]) {
                    inBerserkMode_str = minStr(dic[@"inBerserkMode"]);
                }
                
                if ([dic.allKeys containsObject:@"shakeIntensity"]) { //振动
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"31", @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinFrequency":minStr(dic[@"spinFrequency"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"voltage":minStr(dic[@"voltage"]), @"electricFrequency":minStr(dic[@"electricFrequency"]), @"inBerserkMode":inBerserkMode_str, @"inRandomMode":inRandomMode_str, @"minVoltage":minStr(dic[@"minVoltage"]), @"maxVoltage":minStr(dic[@"maxVoltage"]), @"shakeIntensity":minStr(dic[@"shakeIntensity"]), @"shakeFrequency":minStr(dic[@"shakeFrequency"])}];
                }else {
                    if ([dic.allKeys containsObject:@"spinIntensity"]) { //旋转
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"31", @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinFrequency":minStr(dic[@"spinFrequency"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"voltage":minStr(dic[@"voltage"]), @"electricFrequency":minStr(dic[@"electricFrequency"]), @"inBerserkMode":inBerserkMode_str, @"inRandomMode":inRandomMode_str, @"minVoltage":minStr(dic[@"minVoltage"]), @"maxVoltage":minStr(dic[@"maxVoltage"]), @"shakeIntensity":minStr(dic[@"spinIntensity"]), @"shakeFrequency":minStr(dic[@"shakeFrequency"])}];
                    }else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"31", @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinFrequency":minStr(dic[@"spinFrequency"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"voltage":minStr(dic[@"voltage"]), @"electricFrequency":minStr(dic[@"electricFrequency"]), @"inBerserkMode":inBerserkMode_str, @"inRandomMode":inRandomMode_str, @"minVoltage":minStr(dic[@"minVoltage"]), @"maxVoltage":minStr(dic[@"maxVoltage"]), @"shakeIntensity":minStr(dic[@"shakeIntensity"]), @"shakeFrequency":minStr(dic[@"shakeFrequency"])}];
                    }
                }
                
            }
        }else if([type isEqualToString:@"AIRPLANE-BOTTLE-SENSOR-MODE"]) {
            
            //MARK: 三期 ⻢眼棒 socket - 摇一摇、语音
            if(isEEEqq) {
                
                NSString *inSpinMode_str = @"1";
                NSString *inElectricMode_str = @"1";
                if ([dic.allKeys containsObject:@"inSpinMode"]) {
                    inSpinMode_str = minStr(dic[@"inSpinMode"]);
                }
                if ([dic.allKeys containsObject:@"inElectricMode"]) {
                    inElectricMode_str = minStr(dic[@"inElectricMode"]);
                }
                
                if ([dic.allKeys containsObject:@"shakeIntensity"]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":inSpinMode_str, @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"inElectricMode":inElectricMode_str, @"voltage":minStr(dic[@"voltage"]), @"shakeIntensity":minStr(dic[@"shakeIntensity"]), @"shakeFrequency":@"1"}];
                }else {
                    if ([dic.allKeys containsObject:@"spinIntensity"]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":inSpinMode_str, @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"inElectricMode":inElectricMode_str, @"voltage":minStr(dic[@"voltage"]), @"shakeIntensity":minStr(dic[@"spinIntensity"]), @"shakeFrequency":@"1"}];
                    }else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":inSpinMode_str, @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"inElectricMode":inElectricMode_str, @"voltage":minStr(dic[@"voltage"]), @"shakeIntensity":minStr(dic[@"shakeIntensity"]), @"shakeFrequency":@"1"}];
                    }
                }
            }
        }else if([type isEqualToString:@"AIRPLANE-BOTTLE-MANUAL-MODE"]) {
            
            //MARK: 三期 ⻢眼棒 socket - 手动模式
            if(isEEEqq) {
                
                if ([dic.allKeys containsObject:@"shakeIntensity"]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"33", @"inSpinMode":minStr(dic[@"inSpinMode"]), @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"inElectricMode":minStr(dic[@"inElectricMode"]), @"voltage":minStr(dic[@"voltage"]), @"frequency":minStr(dic[@"frequency"]), @"shakeIntensity":minStr(dic[@"shakeIntensity"]), @"shakeFrequency":minStr(dic[@"frequency"])}];
                }else {
                    if ([dic.allKeys containsObject:@"spinIntensity"]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"33", @"inSpinMode":minStr(dic[@"inSpinMode"]), @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"inElectricMode":minStr(dic[@"inElectricMode"]), @"voltage":minStr(dic[@"voltage"]), @"frequency":minStr(dic[@"frequency"]), @"shakeIntensity":minStr(dic[@"spinIntensity"]), @"shakeFrequency":minStr(dic[@"frequency"])}];
                    }else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"33", @"inSpinMode":minStr(dic[@"inSpinMode"]), @"spinIntensity":minStr(dic[@"spinIntensity"]), @"spinDirection":minStr(dic[@"spinDirection"]), @"inElectricMode":minStr(dic[@"inElectricMode"]), @"voltage":minStr(dic[@"voltage"]), @"frequency":minStr(dic[@"frequency"]), @"shakeIntensity":minStr(dic[@"shakeIntensity"]), @"shakeFrequency":minStr(dic[@"frequency"])}];
                    }
                }
                
            }
        }else if([type isEqualToString:@"AB-LANTERN-CONTROL-MODE"]) {
            
            //MARK: 三期 肛塞
            if(isEEEqq) {
                
                if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"34", @"inLantern":minStr(dic[@"inLantern"])}];
                }
            }
        }
    }
}


- (void)uploadMehtodUnread
{
    [requestToolClass getNetworkWithUrl:request_message_getMessageOverview andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deviceMessageUnreadCountNotif" object:nil userInfo:@{@"redOne":minStr(info[@"deviceMessageUnreadCount"]), @"redTwo":minStr(info[@"systemMessageUnreadCount"])}];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

//MARK: 未连接设备的提示
- (void)uiuiuiuiMMMMM
{
    if (self.isLimitsAutBoo) {
        return;
    }
    self.isLimitsAutBoo = YES;
    MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    vc.wwwhhhBoo = YES;
    [vc addTwoLimitsAuthorityUIUI:1];
    vc.block_ = ^{
        
        MHAddTOYSController *vc = [[MHAddTOYSController alloc] init];
        vc.arrList = self.arrList;
        vc.macsList = self.macsList;
        vc.ListAAA = self.ListAAA;
        [self.navigationController pushViewController:vc animated:YES];
    };
    vc.twoblock_ = ^{
        self.isLimitsAutBoo = NO;
    };
}

//MARK: 开锁
- (void)lockBtnmethod
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        //主人
        BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(!isEEEqq) {
            if(!self.isConnDevic) {
                [self uiuiuiuiMMMMM];
                return;
            }
        }
        //判断定位锁范围
        if(self.roleOneModel.locationLockEnabled && ([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0)) {
            
            double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];
            
            if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
                
                
            }else {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
                return;
            }
        }
        
        if(self.roleOneModel.lockEnabled) {
            if(self.roleOneModel.timeLockEnabled) {
                //是否强制解除定时锁
                MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:vcLocat];
                vcLocat.roleOneModel = self.roleOneModel;
                [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty]; //MARK: 是否处于开锁惩罚中
                vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                    
                    [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
//                        self.roleOneModel.lockEnabled = NO;
//                        self.lockBtn.selected = self.roleOneModel.lockEnabled;
                        self.isRRRRR = NO;
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                    }];
                };
            }else {
                if(self.isRRRRR) {
                    return;
                }
                self.isRRRRR = YES;
                [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
//                    self.roleOneModel.lockEnabled = NO;
//                    self.lockBtn.selected = self.roleOneModel.lockEnabled;
                    self.isRRRRR = NO;
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                    
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                    self.isRRRRR = NO;
                }];
            }
        }else {
            
            if([self.modelM.realName isEqualToString:kCharactName2]) {
                if(self.isMasryBoo) {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"message_friend3")];
                    return;
                }
            }
            //关锁
            if(self.roleOneModel.timeLockEnabled) {
                
                MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:vcLocat];
                vcLocat.roleOneModel = self.roleOneModel;
                [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty];
                vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                    
                    [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
//                        self.roleOneModel.lockEnabled = YES;
//                        self.lockBtn.selected = self.roleOneModel.lockEnabled;
                        self.isRRRRR = NO;
                        if(![self.modelM.realName isEqualToString:kCharactName2]) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock2")];
                        }
                    } fail:^(NSString * _Nonnull msg) {
                        if(![self.modelM.realName isEqualToString:kCharactName2]) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock4")];
                        }
                        self.isRRRRR = NO;
                    }];
                };
            }else {
                if(self.isRRRRR) {
                    return;
                }
                self.isRRRRR = YES;
                //关锁
                [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
//                    self.roleOneModel.lockEnabled = YES;
//                    self.lockBtn.selected = self.roleOneModel.lockEnabled;
                    self.isRRRRR = NO;
                    if(![self.modelM.realName isEqualToString:kCharactName2]) {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock2")];
                    }
                } fail:^(NSString * _Nonnull msg) {
                    if(![self.modelM.realName isEqualToString:kCharactName2]) {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock4")];
                    }
                    self.isRRRRR = NO;
                }];
            }
        }
    }else {
        
        //佩戴者
        if(self.roleOneModel.revokePermission) {
            //没收佩戴者权限
            if(self.roleOneModel.allowServantUnlock) { //是否有一次开锁机会
                
                BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                if(!isEEEqq) {
                    if(!self.isConnDevic) {
                        [self uiuiuiuiMMMMM];
                        return;
                    }
                }
                
                if(self.roleOneModel.hardcoreModeEnabled) {
                    
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_10")];
                    return;
                }
                if(self.roleOneModel.locationLockEnabled && ([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0)) {
                    
                    double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];
                    
                    if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
                        
                        
                    }else {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
                        return;
                    }
                }
                
                if(self.isRRRRR) {
                    return;
                }
                self.isRRRRR = YES;
                [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    self.roleOneModel.allowServantUnlock = NO;
                    self.isRRRRR = NO;
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                    self.isRRRRR = NO;
                }];
            }else {
                
                if(self.roleOneModel.hardcoreModeEnabled) {
                    
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_10")];
                    return;
                }
                
                if(self.roleOneModel.timeLockEnabled) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vcLocat];
                    vcLocat.roleOneModel = self.roleOneModel;
                    [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty];//MARK: 是否处于开锁惩罚中
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                        
                        [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            self.isRRRRR = NO;
                            if(self.roleOneModel.lockEnabled) {
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                            }else {
//                                if(![self.modelM.realName isEqualToString:kCharactName2]) {
//                                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock2")];
//                                }
                            }
                            
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                            self.isRRRRR = NO;
                        }];
                    };
                }else {
                    if(self.lockBtn.selected == YES) {
                        MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                        [self.view addSubview:vc];
                        [vc addDataToDic:10];
                        vc.block_ = ^(BOOL isBBB) {
                            if(isBBB) {
                                if(self.isRRRRR) {
                                    return;
                                }
                                self.isRRRRR = YES;
                                [requestToolClass getNOMsgNetworkWithUrl:request_device_applyForUnlock andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                    self.isRRRRR = NO;
                                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                                } fail:^(NSString * _Nonnull msg) {
                                    self.isRRRRR = NO;
                                }];
                            }
                        };
                    }else {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"my_about20")];
                    }
                }
            }
        }else {
            
            BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if(!isEEEqq) {
                if(!self.isConnDevic) {
                    [self uiuiuiuiMMMMM];
                    return;
                }
            }
            
            if(self.roleOneModel.hardcoreModeEnabled) {
                
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_10")];
                return;
            }
            
            if(self.roleOneModel.locationLockEnabled && ([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0)) {
                
                double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];
                
                if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
                    
                    
                }else {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
                    return;
                }
            }
            
            if(self.roleOneModel.lockEnabled) {
                if(self.roleOneModel.timeLockEnabled) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vcLocat];
                    vcLocat.roleOneModel = self.roleOneModel;
                    [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                        
                        [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
//                            self.roleOneModel.lockEnabled = YES;
//                            self.lockBtn.selected = self.roleOneModel.lockEnabled;
                            self.isRRRRR = NO;
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                            self.isRRRRR = NO;
                        }];
                    };
                }else {
                    if(self.isRRRRR) {
                        return;
                    }
                    self.isRRRRR = YES;
                    [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        //                    self.roleOneModel.lockEnabled = NO;
                        //                    self.lockBtn.selected = self.roleOneModel.lockEnabled;
                        self.isRRRRR = NO;
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                        
                    } fail:^(NSString * _Nonnull msg) {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                        self.isRRRRR = NO;
                    }];
                }
            }else {
                
                if([self.modelM.realName isEqualToString:kCharactName2]) {
                    if(self.isMasryBoo) {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"message_friend3")];
                        return;
                    }
                }
                
                if(self.roleOneModel.timeLockEnabled) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vcLocat];
                    vcLocat.roleOneModel = self.roleOneModel;
                    [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                        
                        [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
//                            self.roleOneModel.lockEnabled = YES;
//                            self.lockBtn.selected = self.roleOneModel.lockEnabled;
                            self.isRRRRR = NO;
                            if(![self.modelM.realName isEqualToString:kCharactName2]) {
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock2")];
                            }
                        } fail:^(NSString * _Nonnull msg) {
                            if(![self.modelM.realName isEqualToString:kCharactName2]) {
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock4")];
                            }
                            self.isRRRRR = NO;
                        }];
                    };
                }else {
                    if(self.isRRRRR) {
                        return;
                    }
                    self.isRRRRR = YES;
                    if(self.lockBtn.selected == YES) {
                        [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            //                        self.roleOneModel.lockEnabled = !self.roleOneModel.lockEnabled;
                            //                        self.lockBtn.selected = self.roleOneModel.lockEnabled;
                            self.isRRRRR = NO;
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock1")];
                            
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock3")];
                            self.isRRRRR = NO;
                        }];
                    }else {
                        [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            //                        self.roleOneModel.lockEnabled = !self.roleOneModel.lockEnabled;
                            //                        self.lockBtn.selected = self.roleOneModel.lockEnabled;
                            self.isRRRRR = NO;
                            if(![self.modelM.realName isEqualToString:kCharactName2]) {
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock2")];
                            }
                            
                        } fail:^(NSString * _Nonnull msg) {
                            if(![self.modelM.realName isEqualToString:kCharactName2]) {
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_unlock4")];
                            }
                            self.isRRRRR = NO;
                        }];
                    }
                }
            }
        }
    }
}

//MARK:  没收权限
- (void)lockBtnmethodTwo
{
    if(!self.roleOneModel.matchingCompleted) {
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_1")];
        return;
    }
    
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        if(self.roleOneModel.revokePermission) {
            
            MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.view addSubview:vc];
            [vc addDataToDic:9];
            vc.block_ = ^(BOOL isBBB) {
                if(isBBB) {
                    if(self.isRRRRR) {
                        return;
                    }
                    self.isRRRRR = YES;
                    [requestToolClass getNOMsgNetworkWithUrl:request_device_operatingPermissions andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        self.roleOneModel.revokePermission = !self.roleOneModel.revokePermission;
                        self.lockBtn2.selected = self.roleOneModel.revokePermission;
                        self.isRRRRR = NO;
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                    }];
                }
            };
            
        }else {
            
            MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.view addSubview:vc];
            [vc addDataToDic:8];
            vc.block_ = ^(BOOL isBBB) {
                if(isBBB) {
                    if(self.isRRRRR) {
                        return;
                    }
                    self.isRRRRR = YES;

                    [requestToolClass getNOMsgNetworkWithUrl:request_device_operatingPermissions andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        self.roleOneModel.revokePermission = !self.roleOneModel.revokePermission;
                        self.lockBtn2.selected = self.roleOneModel.revokePermission;
                        self.isRRRRR = NO;
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                    }];
                }
            };
        }
    }
}

//MARK: 选择角色
- (void)oneBtnMethod
{
    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    [vc addDataToDic:4];
    vc.block_ = ^(BOOL isBBB) {
        if(isBBB) {
            [self requestMethodType:@"1"];
        }
    };
}

- (void)twoBtnMethod
{
    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    [vc addDataToDic:5];
    vc.block_ = ^(BOOL isBBB) {
        if(isBBB) {
            [self requestMethodType:@"2"];
        }
    };
}

- (void)requestMethodType:(NSString *)typeN
{
    [SVProgressHUD show];
    [requestToolClass postNetworkWithUrl:request_device_chooseRole andParameter:@{@"deviceId":minIntStr(self.modelM.id), @"role":typeN} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.modelM.roleSelection = YES;
        [self requestDeviceDetailMethod];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

//MARK: 是否显示停止按钮  设备5、7
- (void)DeviceFiveToSevenShowMehtod
{
    self.lampBtn57.selected = NO;
    if ([FloatingWindowModel shareInstance].JingDian_thr>0) {
        
        self.lampBtn57.hidden = NO;
    }else {
        if ([FloatingWindowModel shareInstance].JingDian_one_model>0) {

            self.lampBtn57.hidden = NO;
        }else {
            if ([FloatingWindowModel shareInstance].JingDian_two_model>0) {
                
                self.lampBtn57.hidden = NO;
            }else {
                self.lampBtn57.hidden = YES;
            }
        }
    }
}

/***
 
 更新UI界面
 */
- (void)addNewUIUIUIU:(NSString *)typeN
{
    self.placeTwoVV.hidden = YES;
    self.rigBtn.hidden = NO;
    
    CGFloat w_ww = (_window_width-146*2-20)/2;
    self.headBtn1.frame = CGRectMake(w_ww, self.placeOneVV.height-189, 146, 132);
    _roleImgV11.frame = CGRectMake(12, 0, 122, 122);
    
    [self.headBtn1 removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.headBtn2 removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    if(self.roleOneModel.matchingCompleted) {
        
        if([self.roleOneModel.masterProfile  containsString:@"http"]) {
            [_roleImgV11 sd_setImageWithURL:[NSURL URLWithString:self.roleOneModel.masterProfile] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image) {
                    
                    UIImage *newImg = [self squareImageFromImage:image scaledToSize:200];
                    self.roleImgV11.image = [UIImage clipImgWithName:newImg radius:1];
                }else {
                    UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
                    self.roleImgV11.image = [UIImage clipImgWithName:newImg radius:1];
                }
            }];
        }else {
            UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
            self.roleImgV11.image = [UIImage clipImgWithName:newImg radius:1];
        }
        
        if([typeN intValue] == 2) {
            self.headBtn1.userInteractionEnabled = YES;
            [self.headBtn1 addTarget:self action:@selector(headAddOtherBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        }else {
            self.headBtn1.userInteractionEnabled = NO;
        }
        
    }else {
        if([typeN intValue] == 1) {
            
            if([self.roleOneModel.masterProfile containsString:@"http"]) {
                [_roleImgV11 sd_setImageWithURL:[NSURL URLWithString:self.roleOneModel.masterProfile] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if(image) {
                        UIImage *newImg = [self squareImageFromImage:image scaledToSize:200];
                        self.roleImgV11.image = [UIImage clipImgWithName:newImg radius:1];
                    }else {
                        UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
                        self.roleImgV11.image = [UIImage clipImgWithName:newImg radius:1];
                    }
                }];
            }else {
                UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
                self.roleImgV11.image = [UIImage clipImgWithName:newImg radius:1];
            }
            self.headBtn1.userInteractionEnabled = NO;
        }else {
            self.headBtn1.userInteractionEnabled = YES;
            [self.headBtn1 addTarget:self action:@selector(headBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            _roleImgV11.image = [UIImage imageNamed:@"role_imgs11"];
        }
    }
    self.headBtn2.frame = CGRectMake(w_ww+166, self.placeOneVV.height-189, 146, 132);
    
    _roleImgV22.frame = CGRectMake(12, 0, 122, 122);
    if(self.roleOneModel.matchingCompleted) {
        
        self.roleImgV22.image = normal_placeHeadImg;
        if([self.roleOneModel.servantProfile containsString:@"http"]) {
            
            [_roleImgV22 sd_setImageWithURL:[NSURL URLWithString:self.roleOneModel.servantProfile] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image) {
                    UIImage *newImg = [self squareImageFromImage:image scaledToSize:200];
                    self.roleImgV22.image = [UIImage clipImgWithName:newImg radius:1];
                }else {

                    UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
                    self.roleImgV22.image = [UIImage clipImgWithName:newImg radius:1];
                }
            }];
        }else {
            
            UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
            self.roleImgV22.image = [UIImage clipImgWithName:newImg radius:1];
        }
        if([typeN intValue] == 1) {
            
            self.headBtn2.userInteractionEnabled = YES;
            [self.headBtn2 addTarget:self action:@selector(headAddOtherBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        }else {
            self.headBtn2.userInteractionEnabled = NO;
        }
    }else {
        if([typeN intValue] == 2) {
    
            self.roleImgV22.image = normal_placeHeadImg;
            if([self.roleOneModel.servantProfile containsString:@"http"]) {
               
                [_roleImgV22 sd_setImageWithURL:[NSURL URLWithString:self.roleOneModel.servantProfile] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if(image) {
                        UIImage *newImg = [self squareImageFromImage:image scaledToSize:200];
                        self.roleImgV22.image = [UIImage clipImgWithName:newImg radius:1];
                    }else {
                        UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
                        self.roleImgV22.image = [UIImage clipImgWithName:newImg radius:1];
                    }
                }];
            }else {
                UIImage *newImg = [self squareImageFromImage:normal_placeHeadImg scaledToSize:200];
                self.roleImgV22.image = [UIImage clipImgWithName:newImg radius:1];
            }
            self.headBtn2.userInteractionEnabled = NO;
        }else {
            self.headBtn2.userInteractionEnabled = YES;
            [self.headBtn2 addTarget:self action:@selector(headBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            _roleImgV22.image = [UIImage imageNamed:@"role_imgs11"];
        }
    }
    
//    if(self.roleOneModel.matchingCompleted) {
        
        self.lockBtn.selected = self.roleOneModel.lockEnabled;
        if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
            
            if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                self.lockBtn.hidden = YES;
                self.lockBtn2.hidden = YES;
            }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                self.lockBtn.hidden = YES;
                self.lockBtn2.hidden = YES;
                
            }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                self.lockBtn.hidden = YES;
                self.lockBtn2.hidden = YES;
            }
            else if ([kCharactName15 isEqualToString:self.modelM.realName]) {
                self.lockBtn.hidden = NO;
                self.lockBtn2.hidden = YES;
                CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
            }
            else {
                self.lockBtn.hidden = NO;
                
                if (self.roleOneModel.hardcoreModeEnabled) {
                    self.lockBtn2.hidden = YES;
                    CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
                }else {
                    self.lockBtn2.hidden = NO;
                    CGFloat lock_xx = (_window_width-96-self.wwhh_w*2)/2;
                    self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 43+self.wwhh_w, 23+self.wwhh_w2);
                }
                
            }
                
//            [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//            [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
            
            self.lockBtn2.selected = self.roleOneModel.revokePermission;
            self.isRevokePermission = NO;
        }else {
            if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                self.lockBtn.hidden = YES;
                self.lockBtn2.hidden = YES;
            }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                self.lockBtn.hidden = YES;
                self.lockBtn2.hidden = YES;
            }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                self.lockBtn.hidden = YES;
                self.lockBtn2.hidden = YES;
            }else {
                self.lockBtn.hidden = NO;
                self.lockBtn2.hidden = YES;
                CGFloat lock_xx = (_window_width-44-self.wwhh_w)/2;
                self.lockBtn.frame = CGRectMake(lock_xx, self.placeOneVV.height-58-self.wwhh_w3, 44+self.wwhh_w, 23+self.wwhh_w2);
            }
            
            if(self.roleOneModel.revokePermission) {
                self.isRevokePermission = YES;
//                [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateNormal];
//                [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1QX"] forState:UIControlStateSelected];
            }else {
                self.isRevokePermission = NO;
//                [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1"] forState:UIControlStateSelected];
//                [self.lockBtn setBackgroundImage:[UIImage imageNamed:@"role_lockImg1_sel"] forState:UIControlStateNormal];
            }
        }
//    }
    
    UIButton *ToggleBtn = [[UIButton alloc] initWithFrame:CGRectMake(w_ww+128, self.placeOneVV.height-189+43, 54, 36)];
    [ToggleBtn setImage:[UIImage imageNamed:@"role_imgs10"] forState:UIControlStateNormal];
    ToggleBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [ToggleBtn addTarget:self action:@selector(toggleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.placeOneVV addSubview:ToggleBtn];
    
    if (self.roleThrSDMSCVC) {
        self.roleThrSDMSCVC.time_Boo2 = YES;
        [self.roleThrSDMSCVC uploadUIUIUI];
    }
    [self.pageContentV removeFromSuperview];
    self.pageContentV = nil;
    
    NSMutableArray *contentVCs = [NSMutableArray array];
    if([self.modelM.realName isEqualToString:kCharactName2]) {
        self.roleOneOneCVC = [[MHRoleOneOneController alloc] init];
        self.roleOneOneCVC.devicId = minIntStr(self.modelM.id);
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.roleOneOneCVC.devicTyp = self.modelM.realName;
        self.roleOneOneCVC.isBMMM = self.isRevokePermission;
        self.roleOneOneCVC.selfUpVC = self;
        [contentVCs addObject:self.roleOneOneCVC];
        
        WEAKSELF
        self.roleOneOneCVC.block_ = ^{
            
            __strong __typeof(self) self = weakSelf;
            //        weakSelf.roleOneModel.timeLockEnabled = YES;
            [self requestDeviceDetailMethodThr];
        };
        self.roleOneOneCVC.twoBBlock_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self uiuiuiuiMMMMM];
        };
        
        self.MHRoleOneThrCopyC = [[MHRoleOneThrCopyController alloc] init];
        self.MHRoleOneThrCopyC.devicId = minIntStr(self.modelM.id);
        self.MHRoleOneThrCopyC.realName = self.modelM.realName;
        self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
        self.MHRoleOneThrCopyC.selfVVC = self;
        self.MHRoleOneThrCopyC.isBMMM = self.isRevokePermission;
        [contentVCs addObject:self.MHRoleOneThrCopyC];
        
        self.MHRoleOneThrCopyC.block_ = ^{
            
            [weakSelf requestDeviceDetailMethodThr];
        };
        self.MHRoleOneThrCopyC.twoBlock_ = ^(NSString * _Nonnull latnd, NSString * _Nonnull longS) {
            
            __strong __typeof(self) self = weakSelf;
            if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
                
                self.isConnDevic22 = YES;
                NSLog(@"-位置B--%@---%@", latnd, longS);
                self.roleOneModel.locationSERVANTLongitude = longS;
                self.roleOneModel.locationSERVANTLatitude = latnd;
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"SEND-SERVANT-COORDINATE", @"deviceId":minIntStr(self.modelM.id), @"latitude":latnd, @"longitude":longS}];
            }
        };
    }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
        
        //MARK: 二期 开发
        self.roleOneOneCVC = [[MHRoleOneOneController alloc] init];
        self.roleOneOneCVC.devicId = minIntStr(self.modelM.id);
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.roleOneOneCVC.devicTyp = self.modelM.realName;
        self.roleOneOneCVC.isBMMM = self.isRevokePermission;
        self.roleOneOneCVC.selfUpVC = self;
        self.roleOneOneCVC.isTwoBoo = YES;
        [contentVCs addObject:self.roleOneOneCVC];
        WEAKSELF
        self.roleOneOneCVC.block_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self requestDeviceDetailMethodThr];
        };
        self.roleOneOneCVC.twoBBlock_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self uiuiuiuiMMMMM];
        };
        self.roleOneOneCVC.stopBBlock_ = ^{
          
            //停止 定时
            [weakSelf stopTimeLockBtnmethod];
        };
        self.roleOneOneCVC.stopBXBBlock_ = ^{
            weakSelf.roleTwoSDDJCVC.time_Boo2 = YES;
            weakSelf.roleTwoYSBXCVC.time_Boo2 = YES;
        };
        
        self.roleTwoSDDJCVC = [[MHRoleTwoSDDJController alloc] init];
        self.roleTwoSDDJCVC.devicId = minIntStr(self.modelM.id);
        self.roleTwoSDDJCVC.roleOneModel = self.roleOneModel;
        self.roleTwoSDDJCVC.devicTyp = self.modelM.realName;
        self.roleTwoSDDJCVC.isBMMM = self.isRevokePermission;
        self.roleTwoSDDJCVC.selfUpVC = self;
        [contentVCs addObject:self.roleTwoSDDJCVC];
        self.roleTwoSDDJCVC.block_ = ^{
            
            weakSelf.pageContentV.contentViewCurrentIndex = 2;
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:2];
        };
        self.roleTwoSDDJCVC.twoBBlock_ = ^{
            [weakSelf uiuiuiuiMMMMM];
        };
        self.roleTwoSDDJCVC.thrBBlock_ = ^{
          
            weakSelf.roleTwoYSBXCVC.time_Boo2 = YES;
        };
        
        self.roleTwoYSBXCVC = [[MHRoleTwoYSBXController alloc] init];
        self.roleTwoYSBXCVC.devicId = minIntStr(self.modelM.id);
        self.roleTwoYSBXCVC.roleOneModel = self.roleOneModel;
        self.roleTwoYSBXCVC.devicTyp = self.modelM.realName;
        self.roleTwoYSBXCVC.isBMMM = self.isRevokePermission;
        self.roleTwoYSBXCVC.selfUpVC = self;
        [contentVCs addObject:self.roleTwoYSBXCVC];
        self.roleTwoYSBXCVC.block_ = ^(int typeM) {
            
            weakSelf.pageContentV.contentViewCurrentIndex = 1;
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
            if (typeM == 1) {
                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
            }else if (typeM == 2) {
                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
            }
        };
        self.roleTwoYSBXCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
    }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
        
        if ([self.modelM.realName isEqualToString:kCharactName8] || [self.modelM.realName isEqualToString:kCharactName9] || [self.modelM.realName isEqualToString:kCharactName10] || [self.modelM.realName isEqualToString:kCharactName11]|| [self.modelM.realName isEqualToString:kCharactName16]|| [self.modelM.realName isEqualToString:kCharactName17]) {
            self.lampBtn.hidden = NO;
        }
        
        //MARK: 三期 开发 马眼棒
        
        WEAKSELF
        self.roleThrJDMSCVC = [[MHRoleThrJDMSController alloc] init];
        self.roleThrJDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrJDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrJDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrJDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrJDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrJDMSCVC];
        self.roleThrJDMSCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrJDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        self.roleThrJDMSCVC.device7Block_ = ^(int typeM) {
          
            [weakSelf DeviceFiveToSevenShowMehtod];
        };
        
        self.roleThrYYYCVC = [[MHRoleThrYYYController alloc] init];
        self.roleThrYYYCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYYCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYYCVC.devicTyp = self.modelM.realName;
        self.roleThrYYYCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYYCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYYCVC];
        self.roleThrYYYCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrYYYCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        self.roleThrYYKZCVC = [[MHRoleThrYYKZController alloc] init];
        self.roleThrYYKZCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYKZCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYKZCVC.devicTyp = self.modelM.realName;
        self.roleThrYYKZCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYKZCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYKZCVC];
        self.roleThrYYKZCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrYYKZCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrSDMSCVC = [[MHRoleThrSDMSController alloc] init];
        self.roleThrSDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrSDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrSDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrSDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrSDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrSDMSCVC];
        self.roleThrSDMSCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrSDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrBXGLCVC = [[MHRoleThrBXGLController alloc] init];
        self.roleThrBXGLCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrBXGLCVC.roleOneModel = self.roleOneModel;
        self.roleThrBXGLCVC.devicTyp = self.modelM.realName;
        self.roleThrBXGLCVC.isBMMM = self.isRevokePermission;
        self.roleThrBXGLCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrBXGLCVC];
        self.roleThrBXGLCVC.block_ = ^(int typeM) {
            
            weakSelf.pageContentV.contentViewCurrentIndex = typeM;
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:typeM];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrBXGLCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
    }else if ([self.modelM.realName isEqualToString:kCharactName12]) {
        
        //MARK: 贞操锁 定时锁、马眼棒集合    加没收权限功能
        self.roleOneOneCVC = [[MHRoleOneOneController alloc] init];
        self.roleOneOneCVC.devicId = minIntStr(self.modelM.id);
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.roleOneOneCVC.isBMMM = self.isRevokePermission;
        self.roleOneOneCVC.selfUpVC = self;
        [contentVCs addObject:self.roleOneOneCVC];
        WEAKSELF
        self.roleOneOneCVC.block_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self requestDeviceDetailMethodThr];
        };
        self.roleOneOneCVC.twoBBlock_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self uiuiuiuiMMMMM];
        };
        
        self.roleThrJDMSCVC = [[MHRoleThrJDMSController alloc] init];
        self.roleThrJDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrJDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrJDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrJDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrJDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrJDMSCVC];
        self.roleThrJDMSCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrJDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrYYYCVC = [[MHRoleThrYYYController alloc] init];
        self.roleThrYYYCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYYCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYYCVC.devicTyp = self.modelM.realName;
        self.roleThrYYYCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYYCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYYCVC];
        self.roleThrYYYCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrYYYCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        self.roleThrYYKZCVC = [[MHRoleThrYYKZController alloc] init];
        self.roleThrYYKZCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYKZCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYKZCVC.devicTyp = self.modelM.realName;
        self.roleThrYYKZCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYKZCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYKZCVC];
        self.roleThrYYKZCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrYYKZCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrSDMSCVC = [[MHRoleThrSDMSController alloc] init];
        self.roleThrSDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrSDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrSDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrSDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrSDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrSDMSCVC];
        self.roleThrSDMSCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrSDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrBXGLCVC = [[MHRoleThrBXGLController alloc] init];
        self.roleThrBXGLCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrBXGLCVC.roleOneModel = self.roleOneModel;
        self.roleThrBXGLCVC.devicTyp = self.modelM.realName;
        self.roleThrBXGLCVC.isBMMM = self.isRevokePermission;
        self.roleThrBXGLCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrBXGLCVC];
        self.roleThrBXGLCVC.block_ = ^(int typeM) {
            
            weakSelf.pageContentV.contentViewCurrentIndex = typeM;
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:typeM];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrBXGLCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
    }else if ([self.modelM.realName isEqualToString:kCharactName15]) {
        
        self.roleThrJDMSCVC = [[MHRoleThrJDMSController alloc] init];
        self.roleThrJDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrJDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrJDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrJDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrJDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrJDMSCVC];
        self.roleThrJDMSCVC.block_ = ^(int typeM) {

        };
        WEAKSELF
        self.roleThrJDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrYYYCVC = [[MHRoleThrYYYController alloc] init];
        self.roleThrYYYCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYYCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYYCVC.devicTyp = self.modelM.realName;
        self.roleThrYYYCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYYCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYYCVC];
        self.roleThrYYYCVC.block_ = ^(int typeM) {
            
        };
        self.roleThrYYYCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        self.roleThrYYKZCVC = [[MHRoleThrYYKZController alloc] init];
        self.roleThrYYKZCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYKZCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYKZCVC.devicTyp = self.modelM.realName;
        self.roleThrYYKZCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYKZCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYKZCVC];
        self.roleThrYYKZCVC.block_ = ^(int typeM) {

        };
        self.roleThrYYKZCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrSDMSCVC = [[MHRoleThrSDMSController alloc] init];
        self.roleThrSDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrSDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrSDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrSDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrSDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrSDMSCVC];
        self.roleThrSDMSCVC.block_ = ^(int typeM) {
            
        };
        self.roleThrSDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        self.roleThrBXGLCVC = [[MHRoleThrBXGLController alloc] init];
        self.roleThrBXGLCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrBXGLCVC.roleOneModel = self.roleOneModel;
        self.roleThrBXGLCVC.devicTyp = self.modelM.realName;
        self.roleThrBXGLCVC.isBMMM = self.isRevokePermission;
        self.roleThrBXGLCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrBXGLCVC];
        self.roleThrBXGLCVC.block_ = ^(int typeM) {
            
            weakSelf.pageContentV.contentViewCurrentIndex = typeM;
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:typeM];
        };
        self.roleThrBXGLCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
    }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
        
        //MARK: 四期 开发  飞机杯
        
        WEAKSELF
        self.roleThrJDMSCVC = [[MHRoleThrJDMSController alloc] init];
        self.roleThrJDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrJDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrJDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrJDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrJDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrJDMSCVC];
        self.roleThrJDMSCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrJDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        self.roleThrJDMSCVC.device7Block_ = ^(int typeM) {
          
            [weakSelf DeviceFiveToSevenShowMehtod];
        };
        
        self.roleThrYYYCVC = [[MHRoleThrYYYController alloc] init];
        self.roleThrYYYCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYYCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYYCVC.devicTyp = self.modelM.realName;
        self.roleThrYYYCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYYCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYYCVC];
        self.roleThrYYYCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrYYYCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        self.roleThrYYKZCVC = [[MHRoleThrYYKZController alloc] init];
        self.roleThrYYKZCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrYYKZCVC.roleOneModel = self.roleOneModel;
        self.roleThrYYKZCVC.devicTyp = self.modelM.realName;
        self.roleThrYYKZCVC.isBMMM = self.isRevokePermission;
        self.roleThrYYKZCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrYYKZCVC];
        self.roleThrYYKZCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrYYKZCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrSDMSCVC = [[MHRoleThrSDMSController alloc] init];
        self.roleThrSDMSCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrSDMSCVC.roleOneModel = self.roleOneModel;
        self.roleThrSDMSCVC.devicTyp = self.modelM.realName;
        self.roleThrSDMSCVC.isBMMM = self.isRevokePermission;
        self.roleThrSDMSCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrSDMSCVC];
        self.roleThrSDMSCVC.block_ = ^(int typeM) {
            
//            weakSelf.pageContentV.contentViewCurrentIndex = 1;
//            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:1];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrSDMSCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
        
        self.roleThrBXGLCVC = [[MHRoleThrBXGLController alloc] init];
        self.roleThrBXGLCVC.devicId = minIntStr(self.modelM.id);
        self.roleThrBXGLCVC.roleOneModel = self.roleOneModel;
        self.roleThrBXGLCVC.devicTyp = self.modelM.realName;
        self.roleThrBXGLCVC.isBMMM = self.isRevokePermission;
        self.roleThrBXGLCVC.selfUpVC = self;
        [contentVCs addObject:self.roleThrBXGLCVC];
        self.roleThrBXGLCVC.block_ = ^(int typeM) {
            
            weakSelf.pageContentV.contentViewCurrentIndex = typeM;
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:typeM];
//            if (typeM == 1) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:YES];
//            }else if (typeM == 2) {
//                [weakSelf.roleTwoSDDJCVC uploadUIUIUIPlay:NO];
//            }
            
        };
        self.roleThrBXGLCVC.twoBBlock_ = ^(int typeM) {
            [weakSelf uiuiuiuiMMMMM];
        };
        
    }else {
        self.roleOneOneCVC = [[MHRoleOneOneController alloc] init];
        self.roleOneOneCVC.devicId = minIntStr(self.modelM.id);
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.roleOneOneCVC.isBMMM = self.isRevokePermission;
        self.roleOneOneCVC.selfUpVC = self;
        [contentVCs addObject:self.roleOneOneCVC];
        WEAKSELF
        self.roleOneOneCVC.block_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self requestDeviceDetailMethodThr];
        };
        self.roleOneOneCVC.twoBBlock_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self uiuiuiuiMMMMM];
        };
        
        self.roleOneTwoCVC = [[MHRoleOneTwoController alloc] init];
        self.roleOneTwoCVC.devicId = minIntStr(self.modelM.id);
        self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
        self.roleOneTwoCVC.isBMMM = self.isRevokePermission;
        [contentVCs addObject:self.roleOneTwoCVC];
        self.roleOneTwoCVC.twoBBlock_ = ^{
            __strong __typeof(self) self = weakSelf;
            [self uiuiuiuiMMMMM];
        };
        
        self.MHRoleOneThrCopyC = [[MHRoleOneThrCopyController alloc] init];
        self.MHRoleOneThrCopyC.devicId = minIntStr(self.modelM.id);
        self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
        self.MHRoleOneThrCopyC.realName = self.modelM.realName;
        self.MHRoleOneThrCopyC.selfVVC = self;
        self.MHRoleOneThrCopyC.isBMMM = self.isRevokePermission;
        [contentVCs addObject:self.MHRoleOneThrCopyC];
        self.MHRoleOneThrCopyC.block_ = ^{
            
            [weakSelf requestDeviceDetailMethodThr];
        };
        self.MHRoleOneThrCopyC.twoBlock_ = ^(NSString * _Nonnull latnd, NSString * _Nonnull longS) {
            
            __strong __typeof(self) self = weakSelf;
            if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
                
                self.roleOneModel.locationSERVANTLongitude = longS;
                self.roleOneModel.locationSERVANTLatitude = latnd;
                
                self.isConnDevic22 = YES;
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"SEND-SERVANT-COORDINATE", @"deviceId":minIntStr(self.modelM.id), @"latitude":latnd, @"longitude":longS}];
            }
        };
    }
    
    self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.placeOneVV.frame)+54, _window_width, _window_height-(CGRectGetMaxY(self.placeOneVV.frame)+54)) childVCs:contentVCs parentVC:self delegate:self];
    self.pageContentV.contentViewCanScroll = self.roleOneModel.matchingCompleted;
    [self.view addSubview:self.pageContentV];
    self.pageContentV.contentViewCanScroll = NO;
    
    self.pageContentV.contentViewCurrentIndex = 0;
    
//    self.pageContentV.contentViewCanScroll = !self.isRevokePermission;
    
    if(!self.foundInformationV) {
        self.foundInformationV = [[foundInformationView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.placeOneVV.frame)+10, _window_width, 44)];
//        self.foundInformationV.isScrollBoo = !self.roleOneModel.matchingCompleted;
        [self.view addSubview:self.foundInformationV];
        self.foundInformationV.backgroundColor = UIColor.clearColor;
        if([self.modelM.realName isEqualToString:kCharactName2]) {
            
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"role_name3"), eLocalizedString(@"role_name5")]];
        }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
            
            //MARK: 二期
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"role_name39_39"), eLocalizedString(@"two_nams18"), eLocalizedString(@"two_nams19")]];
        }else if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
            
            //MARK: 三期
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"thr_nams1"), eLocalizedString(@"thr_nams2"), eLocalizedString(@"thr_nams3"), eLocalizedString(@"thr_nams4"), eLocalizedString(@"thr_nams5")]];
        }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
            
            //MARK: 三期
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"thr_nams1"), eLocalizedString(@"thr_nams2"), eLocalizedString(@"thr_nams3"), eLocalizedString(@"thr_nams4"), eLocalizedString(@"thr_nams5")]];
        }else if ([kCharactName12 isEqualToString:self.modelM.realName]) {
            
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"role_name3"), eLocalizedString(@"thr_nams1"), eLocalizedString(@"thr_nams2"), eLocalizedString(@"thr_nams3"), eLocalizedString(@"thr_nams4"), eLocalizedString(@"thr_nams5")]];
        }else if ([kCharactName15 isEqualToString:self.modelM.realName]) {
            
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"thr_nams1"), eLocalizedString(@"thr_nams2"), eLocalizedString(@"thr_nams3"), eLocalizedString(@"thr_nams4"), eLocalizedString(@"thr_nams5")]];
        }else {
            [self.foundInformationV addVIdeoTopTitleMethodDataToDic:@[eLocalizedString(@"role_name3"), eLocalizedString(@"role_name4"), eLocalizedString(@"role_name5")]];
        }
        WEAKSELF
        self.foundInformationV.block_ = ^(NSInteger type, NSInteger num) {
            
            __strong __typeof(self)self = weakSelf;
            if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
                
                [self uploadThrQQQQMehtodTag:num];

            }else if ([kCharactName5 isEqualToString:self.modelM.realName]) {
                
                [self uploadThrQQQQMehtodTag:num];

            }else if ([kCharactName12 isEqualToString:self.modelM.realName]) {
                
                [self uploadThrQQQQMehtodTagMax:num];

            }else if ([kCharactName15 isEqualToString:self.modelM.realName]) {
                
                [self uploadThrQQQQMehtodTagMax15:num];

            }else {
                if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                    
                    self.pageContentV.contentViewCurrentIndex = num;
                }else {
                    if (self.isRevokePermission) {
                        [self.foundInformationV changeVIdeoTopTitleXIndex:self.pageContentV.contentViewCurrentIndex];
                    }else {
                        if(self.roleOneModel.hardcoreModeEnabled) {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            self.pageContentV.contentViewCurrentIndex = num;
                        }
                    }
                }
                
                if (self.roleTwoSDDJCVC) {
                    if (num==1) {
                        self.roleTwoSDDJCVC.time_Boo2 = NO;
                    }else {
                        self.roleTwoSDDJCVC.time_Boo2 = YES;
                    }
                }
                
                if (self.roleTwoYSBXCVC) {
                    if (num==2) {
                        self.roleTwoYSBXCVC.time_Boo2 = NO;
                    }else {
    //                    weakSelf.roleTwoYSBXCVC.time_Boo2 = YES;
                    }
                }
            }
            
        };
    }
    [self.foundInformationV stopOrStartUIMehtod:self.isRevokePermission];
    
    if((self.roleOneModel.masterConnectStatus == 1) || (self.roleOneModel.servantConnectStatus == 1)) {
        self.roleOneOneCVC.isConnDevic = YES;
        self.roleOneTwoCVC.isConnDevic = YES;
        self.roleTwoSDDJCVC.isConnDevic = YES;
        self.roleTwoYSBXCVC.isConnDevic = YES;
        self.roleThrJDMSCVC.isConnDevic = YES;
        self.roleThrYYYCVC.isConnDevic = YES;
        self.roleThrYYKZCVC.isConnDevic = YES;
        self.roleThrSDMSCVC.isConnDevic = YES;
        self.roleThrBXGLCVC.isConnDevic = YES;
    }else {
        BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            self.roleOneOneCVC.isConnDevic = YES;
            self.roleOneTwoCVC.isConnDevic = YES;
            self.roleTwoSDDJCVC.isConnDevic = YES;
            self.roleTwoYSBXCVC.isConnDevic = YES;
            self.roleThrJDMSCVC.isConnDevic = YES;
            self.roleThrYYYCVC.isConnDevic = YES;
            self.roleThrYYKZCVC.isConnDevic = YES;
            self.roleThrSDMSCVC.isConnDevic = YES;
            self.roleThrBXGLCVC.isConnDevic = YES;
        }
    }
    
    if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
        
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName] || [kCharactName5 isEqualToString:self.modelM.realName]) {
            
        }else {
            if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
                [self.locationManager requestWhenInUseAuthorization];
            }
            [self.locationManager startUpdatingLocation];
        }
    }
    
    if(!self.placVVV) {
        self.placVVV = [HistoryRecordModel createViewUIUI];
        [self.view addSubview:self.placVVV];
        [self.placVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.height.offset(40);
            make.width.mas_greaterThanOrEqualTo(40);
        }];
        
        self.placLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:15 textAlignment:NSTextAlignmentCenter];
        [self.placVVV addSubview:self.placLab];
        [self.placLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.placVVV);
            make.left.equalTo(self.placVVV.mas_left).offset(12);
            make.right.equalTo(self.placVVV.mas_right).offset(-12);
        }];
        self.placVVV.hidden = YES;
    }
    [self.view addSubview:self.placVVV];
    
    [self.view addSubview:self.roleConnetV];
    
    
    
    BOOL isEEEqq = [minStr(self.modelM.mac) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if (isEEEqq) {
        
        if ([kCharactName7 isEqualToString:self.modelM.realName]) {
            self.pageContentV.contentViewCurrentIndex = [FloatingWindowModel shareInstance].choose_numW;
            [self.foundInformationV changeVIdeoTopTitleXIndex:[FloatingWindowModel shareInstance].choose_numW];
        }
    }
    
}

//MARK: 经典模式-关闭指令
- (void)lamp57BtnmethodMethodclick
{
    self.lampBtn57.selected = !self.lampBtn57.selected;
    
    if (self.lampBtn57.selected == YES) {
        BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":@"0", @"spinIntensity":@"0", @"spinDirection":@"0", @"inElectricMode":@"0", @"voltage":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0"}];
        }else {
            if(self.isConnDevic) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"32", @"inSpinMode":@"0", @"spinIntensity":@"0", @"spinDirection":@"0", @"inElectricMode":@"0", @"voltage":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0"}];
            }
        }
    }else {
        [self.roleThrJDMSCVC recoveryControlMethodZL];
    }
}

//MARK: 开关七彩灯
- (void)lampBtnmethodMethodclick
{
    self.lampBtn.selected = !self.lampBtn.selected;
    
    if (self.lampBtn.selected == YES) {
        BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AB-LANTERN-CONTROL-UPLOAD", @"deviceId":minIntStr(self.modelM.id), @"inLantern":@"1"}];
        }else {
            if(self.isConnDevic) {
                
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AB-LANTERN-CONTROL-UPLOAD", @"deviceId":minIntStr(self.modelM.id), @"inLantern":@"1"}];
            }
        }
    }else {
        BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AB-LANTERN-CONTROL-UPLOAD", @"deviceId":minIntStr(self.modelM.id), @"inLantern":@"0"}];
        }else {
            if(self.isConnDevic) {
                
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AB-LANTERN-CONTROL-UPLOAD", @"deviceId":minIntStr(self.modelM.id), @"inLantern":@"0"}];
            }
        }
    }
}

- (void)uploadThrQQQQMehtodTagMax15:(NSInteger)num
{
    switch (num) {
        case 0:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 1:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 2:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 3:
        {
            if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 4:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax15:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
            
        default:
            break;
    }
}

//MARK: 贞操锁 组合版  切换提示 是否退出此模式
- (void)uploadThrQQQQMehtodTagMax:(NSInteger)num
{
    switch (num) {
        case 0:
        {
            if (self.pageContentV.contentViewCurrentIndex==4) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==5) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:5];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==1) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:1];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 1:
        {
            if (self.pageContentV.contentViewCurrentIndex==4) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==5) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:5];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==1) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:1];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 2:
        {
            if (self.pageContentV.contentViewCurrentIndex==4) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==5) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:5];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==1) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:1];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 3:
        {
            if (self.pageContentV.contentViewCurrentIndex==5) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:5];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==1) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:1];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 4:
        {
            if (self.pageContentV.contentViewCurrentIndex==5) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:5];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==1) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:1];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 5:
        {
            if (self.pageContentV.contentViewCurrentIndex==4) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==1) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:1];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUUMax:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
            
        default:
            break;
    }
}


//MARK: 三期 切换提示 是否退出此模式
- (void)uploadThrQQQQMehtodTag:(NSInteger)num
{
    switch (num) {
        case 0:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 1:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 2:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 3:
        {
            if (self.pageContentV.contentViewCurrentIndex==4) {
                if ([self.roleThrBXGLCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:4];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
        case 4:
        {
            if (self.pageContentV.contentViewCurrentIndex==3) {
                
                if ([self.roleThrSDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:3];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleThrJDMSCVC getBooMEthod]) {
                    
                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vcLocat];
                    [vcLocat addTwoNewTextfUIUIMethod:6];
                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                      
                        if (arrList.count>0) {
                            
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        }
                    };
                }else {
                    [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                }
            }else {
                
                [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
            }
        }
            break;
            
        default:
            break;
    }
}

//MARK: 12贞操锁专用
- (void)subGetThrQQQTagoldMax15:(NSInteger)numOld
{
    switch (numOld) {
        case 0:
        {
            self.roleThrJDMSCVC.time_Boo2_old = YES;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 1:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = YES;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 2:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = YES;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 3:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = YES;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 4:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = YES;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)subGetThrQQQTagoldMax:(NSInteger)numOld
{
    switch (numOld) {
        case 1:
        {
            self.roleThrJDMSCVC.time_Boo2_old = YES;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 2:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = YES;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 3:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = YES;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 4:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = YES;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 5:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = YES;
        }
            break;
        case 0:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)uploadThrQQQQMehtodTagTwoUUUMax:(NSInteger)num old:(NSInteger)numOld
{
    self.pageContentV.contentViewCurrentIndex = num;
    switch (num) {
        case 0:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 1:
        {
            self.roleThrJDMSCVC.time_Boo2 = NO;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 2:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = NO;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 3:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = NO;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 4:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = NO;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 5:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = NO;
            
            [self subGetThrQQQTagoldMax:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
            
        default:
            break;
    }
}

- (void)uploadThrQQQQMehtodTagTwoUUUMax15:(NSInteger)num old:(NSInteger)numOld
{
    self.pageContentV.contentViewCurrentIndex = num;
    switch (num) {
        case 0:
        {
            self.roleThrJDMSCVC.time_Boo2 = NO;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax15:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 1:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = NO;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax15:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 2:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = NO;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax15:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 3:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = NO;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagoldMax15:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
        case 4:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = NO;
            
            [self subGetThrQQQTagoldMax15:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
        }
            break;
            
        default:
            break;
    }
}


//MARK: 多数

- (void)subGetThrQQQTagold:(NSInteger)numOld
{
    switch (numOld) {
        case 0:
        {
            self.roleThrJDMSCVC.time_Boo2_old = YES;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 1:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = YES;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 2:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = YES;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 3:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = YES;
            self.roleThrBXGLCVC.time_Boo2_old = NO;
        }
            break;
        case 4:
        {
            self.roleThrJDMSCVC.time_Boo2_old = NO;
            self.roleThrYYYCVC.time_Boo2_old = NO;
            self.roleThrYYKZCVC.time_Boo2_old = NO;
            self.roleThrSDMSCVC.time_Boo2_old = NO;
            self.roleThrBXGLCVC.time_Boo2_old = YES;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)uploadThrQQQQMehtodTagTwoUUU:(NSInteger)num old:(NSInteger)numOld
{
    self.pageContentV.contentViewCurrentIndex = num;
    switch (num) {
        case 0:
        {
            self.roleThrJDMSCVC.time_Boo2 = NO;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
            
            if ([self.statLLLab.text isEqualToString:eLocalizedString(@"home_nam3")] && ([self.modelM.realName isEqualToString:kCharactName5] || [self.modelM.realName isEqualToString:kCharactName7])) {
                [self DeviceFiveToSevenShowMehtod];
            }
        }
            break;
        case 1:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = NO;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
            
            self.lampBtn57.hidden = YES;
        }
            break;
        case 2:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = NO;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
            
            self.lampBtn57.hidden = YES;
        }
            break;
        case 3:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = NO;
            self.roleThrBXGLCVC.time_Boo2 = YES;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
            
            self.lampBtn57.hidden = YES;
        }
            break;
        case 4:
        {
            self.roleThrJDMSCVC.time_Boo2 = YES;
            self.roleThrYYYCVC.time_Boo2 = YES;
            self.roleThrYYKZCVC.time_Boo2 = YES;
            self.roleThrSDMSCVC.time_Boo2 = YES;
            self.roleThrBXGLCVC.time_Boo2 = NO;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleThrJDMSCVC uploadUIUIUI];
            [self.roleThrYYYCVC uploadUIUIUI];
            [self.roleThrYYKZCVC uploadUIUIUI];
            [self.roleThrSDMSCVC uploadUIUIUI];
            [self.roleThrBXGLCVC uploadUIUIUI];
            
            self.lampBtn57.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}


//MARK: 停止定时
- (void)stopTimeLockBtnmethod
{
    BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(!isEEEqq) {
        if(!self.isConnDevic) {
            [self uiuiuiuiMMMMM];
            return;
        }
    }
    
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        //主人
        if(self.roleOneModel.timeLockEnabled) {
            //是否强制解除定时锁
            MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.view addSubview:vcLocat];
            vcLocat.roleOneModel = self.roleOneModel;
            [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty]; //MARK: 是否处于开锁惩罚中
            vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                
                [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    self.isRRRRR = NO;
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                } fail:^(NSString * _Nonnull msg) {
                    self.isRRRRR = NO;
                }];
            };
        }else {
            if(self.isRRRRR) {
                return;
            }
            self.isRRRRR = YES;
            [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                self.isRRRRR = NO;
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRRR = NO;
            }];
        }
        
    }else {
        //佩戴者
        if(self.roleOneModel.timeLockEnabled) {
            
            MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.view addSubview:vcLocat];
            vcLocat.roleOneModel = self.roleOneModel;
            [vcLocat addUnlockingMethod:self.roleOneModel.isPenalty];
            vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                
                [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                    self.isRRRRR = NO;
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                } fail:^(NSString * _Nonnull msg) {
                    self.isRRRRR = NO;
                }];
            };
        }else {
            if(self.isRRRRR) {
                return;
            }
            self.isRRRRR = YES;
            [requestToolClass getNOMsgNetworkWithUrl:request_device_forcedUnlocks andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"location":self.addresStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                self.isRRRRR = NO;
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
            } fail:^(NSString * _Nonnull msg) {

                self.isRRRRR = NO;
            }];
        }
    }
}



- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    [self.foundInformationV changeVIdeoTopTitleXIndex:endIndex];
    
    if (self.roleTwoSDDJCVC) {
        if (endIndex==1) {
            self.roleTwoSDDJCVC.time_Boo2 = NO;
        }else {
            self.roleTwoSDDJCVC.time_Boo2 = YES;
        }
    }
    
    if (self.roleTwoYSBXCVC) {
        if (endIndex==2) {
            self.roleTwoYSBXCVC.time_Boo2 = NO;
        }else {
//            self.roleTwoYSBXCVC.time_Boo2 = YES;
        }
    }
}


//MARK: 定位
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
 
    if(locations.count > 0) {
        
        CLLocation * location1 = [locations lastObject];
        [self.locationManager stopUpdatingLocation];
        if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
            self.roleOneModel.locationSERVANTLongitude = [NSString stringWithFormat:@"%f", location1.coordinate.longitude];
            self.roleOneModel.locationSERVANTLatitude = [NSString stringWithFormat:@"%f", location1.coordinate.latitude];
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"SEND-SERVANT-COORDINATE", @"deviceId":minIntStr(self.modelM.id), @"latitude":[NSString stringWithFormat:@"%f", location1.coordinate.latitude], @"longitude":[NSString stringWithFormat:@"%f", location1.coordinate.longitude]}];
        }
        

        [self.geocoder reverseGeocodeLocation:location1 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error == nil)
            {
                CLPlacemark *pl = [placemarks firstObject];
                //获得的定位信息
                NSString * str = pl.name;
        
                NSString * str2 = pl.thoroughfare;
                //获得所在的位置(某市)
                NSString * str3 = pl.locality;
                //获得所在市的某区
                NSString * str4 = pl.subLocality;
                //获得省份(形成区域)
                NSString * str5 = pl.administrativeArea;
                if(str4) {
                    self.addresStr = [NSString stringWithFormat:@"%@%@%@%@", str5, str3, str4, str];
                }else {
                    self.addresStr = [NSString stringWithFormat:@"%@%@%@%@", str5, str3, str2, str];
                }
            }else {
                NSLog(@"错误");
            }
        }];
    }
}

- (void)rightImageUIUIUI
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        MHRoleMoreController *vc = [[MHRoleMoreController alloc] init];
        vc.roleOneModel = self.roleOneModel;
        vc.macStrL = self.modelM.mac;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^{
            [self requestDeviceDetailMethodTwo:3];
        };
    }else {
        MHRoleMoreController *vc = [[MHRoleMoreController alloc] init];
        vc.roleOneModel = self.roleOneModel;
        vc.isBooMM = YES;
        vc.macStrL = self.modelM.mac;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^{
            [self requestDeviceDetailMethodTwo:3];
        };
    }
}

- (void)headBtnMethod:(UIButton *)btn
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        NSArray *array = @[@{@"name":eLocalizedString(@"role_name6"),@"id":@"3"},@{@"name":eLocalizedString(@"home_Cancel")}];
        PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
        pop.cancelColor = GrayTextColor;
        pop.data = array;
        pop.blockCallBackIndex = ^(NSDictionary *dictionary){

            if ([dictionary[@"id"]intValue] == 3) {
                
                MHRoleFriendSelectController *vc = [[MHRoleFriendSelectController alloc] init];
                if(btn == self.headBtn1) {
                    vc.typeMM = @"6"; //邀请对方成为被控制者
                }else {
                    vc.typeMM = @"7"; //邀请对方成为控制者
                }
                vc.typeId = @"1";
                vc.deviceId = minIntStr(self.modelM.id);
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        [pop viewShow];
    }else {
        NSArray *array = @[@{@"name":eLocalizedString(@"role_name6"),@"id":@"3"},@{@"name":eLocalizedString(@"role_name7"),@"id":@"2"},@{@"name":eLocalizedString(@"home_Cancel")}];
        PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
        pop.cancelColor = GrayTextColor;
        pop.data = array;
        pop.blockCallBackIndex = ^(NSDictionary *dictionary){

            if ([dictionary[@"id"]intValue] == 3) {
                
                MHRoleFriendSelectController *vc = [[MHRoleFriendSelectController alloc] init];
                if(btn == self.headBtn1) {
                    vc.typeMM = @"6";
                }else {
                    vc.typeMM = @"7";
                }
                vc.typeId = @"2";
                vc.deviceId = minIntStr(self.modelM.id);
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([dictionary[@"id"]intValue] == 2) {
                
                MHPostRoleController *vc = [[MHPostRoleController alloc] init];
                vc.modelM = self.modelM;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        [pop viewShow];
    }
}

//MARK: 切换角色
- (void)toggleBtnMethod
{
    if(!self.roleOneModel.matchingCompleted) {

        [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"role_setting13") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
            if (index == 1) {
                [SVProgressHUD show];
                [requestToolClass postNetworkWithUrl:request_device_changeRole andParameter:@{@"deviceId":minIntStr(self.modelM.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                    [self requestDeviceDetailMethod];
                } fail:^(NSString * _Nonnull msg) {

                }];
            }
        }];
    }
}

- (void)requestDeviceDetailMethod
{
    self.statLLLab.hidden = NO;
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%d", request_device_detail, self.modelM.id];
    [requestToolClass getNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *infDic = info;
        if(self.roleOneModel.locationSERVANTLatitude) {
            NSString *longgg = self.roleOneModel.locationSERVANTLongitude;
            NSString *latgg = self.roleOneModel.locationSERVANTLatitude;
            
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
            self.roleOneModel.locationSERVANTLongitude = longgg;
            self.roleOneModel.locationSERVANTLatitude = latgg;
        }else {
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        }
        
        if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
            [self addNewUIUIUIU:@"1"];
        }else {
            [self addNewUIUIUIU:@"2"];
        }
        
        if ([kCharactName isEqualToString:self.modelM.realName] || [kCharactName2 isEqualToString:self.modelM.realName]) {
            
            if(![self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                
                if (self.isRevokePermission) {
                    [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                    self.pageContentV.contentViewCurrentIndex = 0;
                }else {
                    if(self.roleOneModel.hardcoreModeEnabled) {
                        [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        self.pageContentV.contentViewCurrentIndex = 0;
                    }
                }
            }
        }
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([kCharactName5 isEqualToString:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)requestDeviceDetailMethodJoinMethod
{
    self.statLLLab.hidden = NO;
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%d", request_device_detail, self.modelM.id];
    [requestToolClass getNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.placVVV_vv.hidden = YES;
        [self.placVVV_vv removeFromSuperview];
        
        NSDictionary *infDic = info;
        NSLog(@"---%@", infDic);
        if(self.roleOneModel.locationSERVANTLatitude) {
            NSString *longgg = self.roleOneModel.locationSERVANTLongitude;
            NSString *latgg = self.roleOneModel.locationSERVANTLatitude;
            
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
            self.roleOneModel.locationSERVANTLongitude = longgg;
            self.roleOneModel.locationSERVANTLatitude = latgg;
        }else {
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        }
        //MARK: 是否加定时锁同步时间
        if (self.roleOneModel.timeLockEnabled) {
            
            if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
                
                if (!([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName] || [kCharactName5 isEqualToString:self.modelM.realName])) {
                    BOOL isEEEqq = [minStr(self.roleOneModel.mac) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                    if (isEEEqq) {
                        
                        if(self.roleOneModel.timeLockReleaseSeconds>10) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":minIntStr(self.roleOneModel.timeLockReleaseSeconds/60+1), @"strong2":@"1", @"strong3":@"2", @"strong4":minIntStr(self.roleOneModel.timeLockReleaseVoltage)}];
                        }else {
                            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"3", @"strong":@"0", @"strong2":@"1", @"strong3":@"2", @"strong4":minIntStr(self.roleOneModel.timeLockReleaseVoltage)}];
                        }
                    }
                }
            }
        }
        
        if((self.roleOneModel.masterConnectStatus == 1) || (self.roleOneModel.servantConnectStatus == 1)) {
            self.isConnDevic = YES;
            self.roleOneOneCVC.isConnDevic = YES;
            self.roleOneTwoCVC.isConnDevic = YES;
            self.roleTwoSDDJCVC.isConnDevic = YES;
            self.roleTwoYSBXCVC.isConnDevic = YES;
            self.roleThrJDMSCVC.isConnDevic = YES;
            self.roleThrYYYCVC.isConnDevic = YES;
            self.roleThrYYKZCVC.isConnDevic = YES;
            self.roleThrSDMSCVC.isConnDevic = YES;
            self.roleThrBXGLCVC.isConnDevic = YES;
            self.statLLLab.text = eLocalizedString(@"home_nam3");
        }else {
            BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if(isEEEqq) {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"1"}];
                self.isConnDevic = YES;
                self.roleOneOneCVC.isConnDevic = YES;
                self.roleOneTwoCVC.isConnDevic = YES;
                self.roleTwoSDDJCVC.isConnDevic = YES;
                self.roleTwoYSBXCVC.isConnDevic = YES;
                self.roleThrJDMSCVC.isConnDevic = YES;
                self.roleThrYYYCVC.isConnDevic = YES;
                self.roleThrYYKZCVC.isConnDevic = YES;
                self.roleThrSDMSCVC.isConnDevic = YES;
                self.roleThrBXGLCVC.isConnDevic = YES;
                self.statLLLab.text = eLocalizedString(@"home_nam3");
            }else {
                self.statLLLab.text = eLocalizedString(@"home_nam1");
            }
        }
        
        if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
            [self addNewUIUIUIU:@"1"];
        }else {
            [self addNewUIUIUIU:@"2"];
        }
        [self UUUUULLLInt];
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([kCharactName5 isEqualToString:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)UUUUULLLInt
{
    [requestToolClass getNOMsgNetworkWithUrl:request_device_connectOrDisconnect andParameter:@{@"deviceId":minIntStr(self.modelM.id), @"type":@"1"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)requestDeviceDetailMethodTwo:(NSInteger)typMMM
{
    if(self.isRRRRR) {
        return;
    }
    self.isRRRRR = YES;
    self.statLLLab.hidden = NO;
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%d", request_device_detail, self.modelM.id];
    if(typMMM==3) {
        NSLog(@"-测试发现123--%@", url_dev);
    }
    [requestToolClass getNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.isRRRRR = NO;
        NSDictionary *infDic = info;
        if(self.roleOneModel.locationSERVANTLatitude) {
            NSString *longgg = self.roleOneModel.locationSERVANTLongitude;
            NSString *latgg = self.roleOneModel.locationSERVANTLatitude;
            
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
            self.roleOneModel.locationSERVANTLongitude = longgg;
            self.roleOneModel.locationSERVANTLatitude = latgg;
        }else {
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        }
        if(typMMM==1) {
//            self.lockBtn.selected = NO;
        }else if (typMMM == 2) {
//            self.lockBtn.selected = YES;
        }else {
            self.lockBtn.selected = self.roleOneModel.lockEnabled;
        }
        
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
        [self.roleOneOneCVC uploadUIUIUI];
        [self.MHRoleOneThrCopyC uploadUIUIUI];
        
        if ([kCharactName isEqualToString:self.modelM.realName] || [kCharactName2 isEqualToString:self.modelM.realName]) {
            
            if(![self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                
                if (self.isRevokePermission) {
                    [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                    self.pageContentV.contentViewCurrentIndex = 0;
                }else {
                    if(self.roleOneModel.hardcoreModeEnabled) {
                        [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        self.pageContentV.contentViewCurrentIndex = 0;
                    }
                }
            }
        }
        
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([kCharactName5 isEqualToString:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
    } fail:^(NSString * _Nonnull msg) {
        self.isRRRRR = NO;
    }];
}

- (void)requestDeviceDetailMethodThr
{
    self.statLLLab.hidden = NO;
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%d", request_device_detail, self.modelM.id];
    [requestToolClass getNOMsgNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *infDic = info;
        if(self.roleOneModel.locationSERVANTLatitude) {
            NSString *longgg = self.roleOneModel.locationSERVANTLongitude;
            NSString *latgg = self.roleOneModel.locationSERVANTLatitude;
            
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
            self.roleOneModel.locationSERVANTLongitude = longgg;
            self.roleOneModel.locationSERVANTLatitude = latgg;
        }else {
            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        }
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
        
//        self.lockBtn.selected = self.roleOneModel.lockEnabled;
        
        self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
        [self.MHRoleOneThrCopyC uploadUIUIUI];
        
        //MARK: 硬核模式 只显示定时锁界面
        if ([kCharactName isEqualToString:self.modelM.realName] || [kCharactName2 isEqualToString:self.modelM.realName]) {
            
            if(![self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
                
                if (self.isRevokePermission) {
                    [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                    self.pageContentV.contentViewCurrentIndex = 0;
                }else {
                    if(self.roleOneModel.hardcoreModeEnabled) {
                        [self.foundInformationV changeVIdeoTopTitleXIndex:0];
                        self.pageContentV.contentViewCurrentIndex = 0;
                    }
                }
            }
        }
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
        if ([kCharactName5 isEqualToString:self.modelM.realName]) {
            self.lockBtn.hidden = YES;
            self.lockBtn2.hidden = YES;
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)headAddOtherBtnMethod
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {

        MHOthrMyController *vc = [[MHOthrMyController alloc] init];
        vc.otherId = self.roleOneModel.servant;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
//        [[FloatingWindowModel shareInstance] switchChatDetailControlNick:self.roleOneModel.masterNickName hostId:self.roleOneModel.master];
        MHOthrMyController *vc = [[MHOthrMyController alloc] init];
        vc.otherId = self.roleOneModel.master;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//MARK: UIImage切正方形
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
