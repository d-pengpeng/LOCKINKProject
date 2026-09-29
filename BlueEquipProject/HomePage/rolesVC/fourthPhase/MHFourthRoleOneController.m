//
//  MHFourthRoleOneController.m
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "MHFourthRoleOneController.h"
#import "MHFourthRoleJDBXController.h"
#import "MHFourthRoleYYYController.h"
#import "MHFourthRoleYYKZController.h"
#import "MHFourthRoleMoreController.h"

#import "MHRankingPlaceView.h"
#import "FSPageContentView.h"
#import "PopBottomView.h"
#import "MHRoleFriendSelectController.h"
#import "MHPostRoleController.h"
#import "MHRoleOneModel.h"
#import "MHOthrMyController.h"
#import "MHRoleConnectView.h"
#import "MHLimitsAuthorityView.h"
#import "MHAddTOYSController.h"
#import "MHRoleSetCoreLocatView.h"

@interface MHFourthRoleOneController ()<FSPageContentViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;

@property (nonatomic, strong) UIView *placeOneVV;
@property (nonatomic, strong) UIView *placeTwoVV;
@property (nonatomic, strong) UIButton *headBtn1;
@property (nonatomic, strong) UIButton *headBtn2;
@property (nonatomic, strong) UIButton *rigBtn;

@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, assign) BOOL isRevokePermission;

@property (nonatomic, strong) MHFourthRoleJDBXController *roleOneOneCVC;
@property (nonatomic, strong) MHFourthRoleYYYController *roleOneTwoCVC;
@property (nonatomic, strong) MHFourthRoleYYKZController *MHRoleOneThrCopyC;
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
@property (nonatomic, strong) UIView *placVVV_vv;
@property (nonatomic, strong) UIImageView *lefImgV;
@property (nonatomic, strong) UIImageView *rigImgV;
@property (nonatomic, strong) UIImageView *logoImgV;
@property (nonatomic, strong) UIImageView *kkImgV;

@property (nonatomic, assign) BOOL isLimitsAutBoo;
@property (nonatomic, copy) NSString *channel_ab;
@property (nonatomic, copy) NSString *frequency_ab;
@property (nonatomic, strong) UIView *titOneVV;

@property (nonatomic, strong) UIView *channl_SubV;
@property (nonatomic, strong) UILabel *channlelef_Lab;
@property (nonatomic, strong) UILabel *channlerig_Lab;
@property (nonatomic, strong) UIImageView *channlelef_Img;
@property (nonatomic, strong) UIImageView *channlerig_Img;
@property (nonatomic, assign) int isChannelBoo;
@property (nonatomic, assign) int isChannelBoo_play;

@end

@implementation MHFourthRoleOneController

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
        
        if (self.channel_ab) {
            
            [self.roleOneOneCVC stopMethodUIUIUI];
            [self.roleOneTwoCVC stopMethodUIUIUI];
            [self.MHRoleOneThrCopyC stopMethodUIUIUI];
            
            BOOL isEEEqq = [minStr(self.modelM.mac) compare:[LYUserDefault userDefault].macId options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if (isEEEqq) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"35", @"frequency":self.frequency_ab, @"voltage":@"0", @"channel":self.channel_ab}];
                
            }
        }
    }
    self.isRoleBBB = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.redNavView = YES;
    [self.backBnt setImage:[UIImage imageNamed:@"fourth_backImg"] forState:0];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    UIImageView *oneImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    oneImgV.image = [UIImage imageNamed:@"fourth_backal_Img"];
    [self.view addSubview:oneImgV];
    
    CGFloat hhh_all = 255;

    _logoImgV = [[UIImageView alloc] initWithFrame:CGRectMake((_window_width-95)/2, NAVHEIGHT-33, 95, 22)];
    _logoImgV.image = [UIImage imageNamed:@"fourth_logo_Img"];
    [self.navView addSubview:_logoImgV];
    _lefImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, hhh_all-103, 92, 72)];
    _lefImgV.image = [UIImage imageNamed:@"fourth_headLef_Img"];
    [self.view addSubview:_lefImgV];
    _rigImgV = [[UIImageView alloc] initWithFrame:CGRectMake(_window_width-92, hhh_all-103, 92, 72)];
    _rigImgV.image = [UIImage imageNamed:@"fourth_headRig_Img"];
    [self.view addSubview:_rigImgV];
    _lefImgV.hidden = YES;
    _rigImgV.hidden = YES;
    _logoImgV.hidden = YES;
    
    self.placeOneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, hhh_all)];
    self.placeOneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.placeOneVV];
    [self.view addSubview:self.navView];
    
    self.rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rigBtn.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    self.rigBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rigBtn setImage:[UIImage imageNamed:@"fourth_more_Img"] forState:UIControlStateNormal];
    [self.rigBtn addTarget:self action:@selector(rightImageUIUIUI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rigBtn];
    self.rigBtn.hidden = YES;
    
    CGFloat w_xx = (_window_width-217)/2;
    self.headBtn1 = [HistoryRecordModel createImgBtn];
    self.headBtn1.frame = CGRectMake(w_xx+95, hhh_all-205+25, 122, 122);
    [self.headBtn1 setBackgroundImage:[UIImage imageNamed:@"role_imgs2"] forState:UIControlStateNormal];
    [self.placeOneVV addSubview:self.headBtn1];
    
    _roleImgV11 = [HistoryRecordModel createImgImgView];
    _roleImgV11.frame = CGRectMake(10, 0, 102, 102);
    _roleImgV11.image = [UIImage imageNamed:@"role_imgs9"];
    [self.headBtn1 addSubview:_roleImgV11];

    self.headBtn2 = [HistoryRecordModel createImgBtn];
    self.headBtn2.frame = CGRectMake(w_xx, hhh_all-218+25, 166, 166);
    [self.headBtn2 setBackgroundImage:[UIImage imageNamed:@"role_imgs2"] forState:UIControlStateNormal];
    [self.placeOneVV addSubview:self.headBtn2];
    
    _roleImgV22 = [HistoryRecordModel createImgImgView];
    _roleImgV22.frame = CGRectMake(13, 13, 140, 140);
    _roleImgV22.image = [UIImage imageNamed:@"role_imgs8"];
    [self.headBtn2 addSubview:_roleImgV22];
    
    self.statLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    self.statLLLab.frame = CGRectMake(50, self.placeOneVV.height-58-40+25, self.placeOneVV.width-100, 30);
    self.statLLLab.text = eLocalizedString(@"home_nam1");
    [self.placeOneVV addSubview:self.statLLLab];
    
    BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        self.statLLLab.text = eLocalizedString(@"home_nam3");
    }
    
    self.channl_SubV = [[UIView alloc] initWithFrame:CGRectMake(0, self.placeOneVV.height-30, _window_width, 36)];
    self.channl_SubV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.channl_SubV];
    
    CGFloat ww_widchan = (_window_width-36-40)/2;
    NSArray *channel_arr = @[@"fourth_channel_A", @"fourth_channel_B"];
    for (int i=0; i<channel_arr.count; i++) {
        
        UIImageView *channel_imgV1 = [HistoryRecordModel createImgImgView];
        channel_imgV1.image = [UIImage imageNamed:@"fourth_channel_Img"];
        [self.channl_SubV addSubview:channel_imgV1];
        if (i==0) {
            channel_imgV1.frame = CGRectMake(18, self.channl_SubV.height-36, ww_widchan, 36);
        }else {
            channel_imgV1.frame = CGRectMake(18+ww_widchan+40, self.channl_SubV.height-36, ww_widchan, 36);
        }
        
        UIButton *channelBtn = [HistoryRecordModel createImgBtn];
        channelBtn.tag = 3300+i;
        [channelBtn addTarget:self action:@selector(channelBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.channl_SubV addSubview:channelBtn];
        
        UIButton *channelBtn2 = [HistoryRecordModel createImgBtn];
        channelBtn2.tag = 3400+i;
        [channelBtn2 addTarget:self action:@selector(channelBtnMethodPlay:) forControlEvents:UIControlEventTouchUpInside];
        [self.channl_SubV addSubview:channelBtn2];
        
        if (i==0) {
            channelBtn.frame = CGRectMake(18, self.channl_SubV.height-36, ww_widchan-58, 36);
            channelBtn2.frame = CGRectMake(18+ww_widchan-58, self.channl_SubV.height-36, 58, 36);
            
            self.channlelef_Lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:13 textAlignment:NSTextAlignmentLeft];
            self.channlelef_Lab.frame = CGRectMake(14, 0, channelBtn.width-14, 36);
            self.channlelef_Lab.text = eLocalizedString(channel_arr[0]);
            [channelBtn addSubview:self.channlelef_Lab];
            
            self.channlelef_Img = [HistoryRecordModel createImgImgView];
            self.channlelef_Img.frame = CGRectMake(20, 9, 18, 18);
            self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
            [channelBtn2 addSubview:self.channlelef_Img];
            
        }else {
            channelBtn.frame = CGRectMake(18+ww_widchan+40, self.channl_SubV.height-36, ww_widchan-58, 36);
            channelBtn2.frame = CGRectMake(channel_imgV1.x+ww_widchan-58, self.channl_SubV.height-36, 58, 36);
            
//            self.channlerig_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:13 textAlignment:NSTextAlignmentLeft];
            self.channlerig_Lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:13 textAlignment:NSTextAlignmentLeft];
            self.channlerig_Lab.frame = CGRectMake(14, 0, channelBtn.width-14, 36);
            self.channlerig_Lab.text = eLocalizedString(channel_arr[i]);
            [channelBtn addSubview:self.channlerig_Lab];
            
            self.channlerig_Img = [HistoryRecordModel createImgImgView];
            self.channlerig_Img.frame = CGRectMake(20, 9, 18, 18);
            self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
            [channelBtn2 addSubview:self.channlerig_Img];
        }
    }
    self.isChannelBoo = 3;
    self.isChannelBoo_play = 0;
    self.channl_SubV.hidden = YES;
    

    self.placeTwoVV = [[UIView alloc] initWithFrame:CGRectMake(0, self.placeOneVV.height+30, _window_width, 268)];
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
        self.placVVV_vv.backgroundColor = UIColor.clearColor;
        [self.view addSubview:self.placVVV_vv];
        
        UIImageView *oneImgVppp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        oneImgVppp.image = [UIImage imageNamed:@"fourth_backal_Img"];
        [self.placVVV_vv addSubview:oneImgVppp];

        UIButton *backBntTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        backBntTwo.frame = CGRectMake(10, TIMESTATUSHEIGHT+2, 40, 40);
        backBntTwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [backBntTwo setImage:[UIImage imageNamed:@"fourth_backImg"] forState:UIControlStateNormal];
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
        
//        NSLog(@"- socket接到指令 - %@", dic);
        NSString *type = [NSString stringWithFormat:@"%@", dic[@"type"]];
        if([type isEqualToString:@"QIUI-COLLAR-CONTROL"]) {
            
            //MARK: qiui -灰色UI设备
            if(isEEEqq) {
                
//                {"deviceId": 8132,"mac":"D9:00:Z5:D6:01:01","frequency": 1,"voltage":10,"channel": 1,"type": "QIUI-COLLAR-CONTROL"}
                
                if ([self.modelM.realName isEqualToString:kCharactName13]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"35", @"frequency":minStr(dic[@"frequency"]), @"voltage":minStr(dic[@"voltage"]), @"channel":minStr(dic[@"channel"])}];
                    self.channel_ab = minStr(dic[@"channel"]);
                    self.frequency_ab = minStr(dic[@"frequency"]);
                }
            }
        }else if([type isEqualToString:@"QIUI-COLLAR-COUNT-DOWN"]) {
            
            //MARK: qiui -灰色UI设备 倒计时
            if(isEEEqq) {
                
//                {"deviceId": 8132,"mac": "D9:00:Z5:D6:01:01","countDown": 50,"type": "QIUI-COLLAR-COUNT-DOWN"}
                if ([self.modelM.realName isEqualToString:kCharactName13]) {
                    
                }
            }
        }else if([type isEqualToString:@"CUSTOM-COMMAND-MODE"]) {
            
            //MARK: qiui 已废弃
            if(isEEEqq) {

//                if ([self.modelM.realName isEqualToString:kCharactName13]) {
//                    
//                    NSData *jsonData = [minStr(dic[@"commandData"]) dataUsingEncoding:NSUTF8StringEncoding];
//                    NSError *error;
//                    if(jsonData) {
//                        NSDictionary *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
//                        if (!error) {
//                            
//                            self.channel_ab = minStr(dic[@"channel"]);
//                            self.frequency_ab = @"1";
//                            
//                            if ([minStr(dicSub[@"type"]) isEqualToString:@"1"]) {
//                                
//                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"36", @"addSub":minStr(dicSub[@"addSub"]), @"voltage":minStr(dicSub[@"voltage"]), @"channel":minStr(dicSub[@"channel"])}];
//                            }
//                            if ([minStr(dicSub[@"type"]) isEqualToString:@"2"]) {
//                                
//                                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"37", @"addSub":minStr(dicSub[@"addSub"]), @"voltage":minStr(dicSub[@"voltage"]), @"channel":minStr(dicSub[@"channel"])}];
//                            }
//                        }
//                    }
//                }
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

//MARK: 选择角色
- (void)oneBtnMethod
{
    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    [vc addFourthDataToDic:1];
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
    [vc addFourthDataToDic:2];
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

- (void)addNewUIUIUIU:(NSString *)typeN
{
    _logoImgV.hidden = NO;
    _lefImgV.hidden = NO;
    _rigImgV.hidden = NO;
    
    self.placeTwoVV.hidden = YES;
    self.rigBtn.hidden = NO;
    
    CGFloat w_ww = (_window_width-146*2-20)/2;
    self.headBtn1.frame = CGRectMake(w_ww, self.placeOneVV.height-189+25, 146, 132);
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
    self.headBtn2.frame = CGRectMake(w_ww+166, self.placeOneVV.height-189+25, 146, 132);
    
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
    
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        
        self.isRevokePermission = NO;
    }else {
        
        if(self.roleOneModel.revokePermission) {
            self.isRevokePermission = YES;
        }else {
            self.isRevokePermission = NO;
        }
    }
    
    UIButton *ToggleBtn = [[UIButton alloc] initWithFrame:CGRectMake(w_ww+128, self.placeOneVV.height-189+43+25, 54, 36)];
    [ToggleBtn setImage:[UIImage imageNamed:@"role_imgs10"] forState:UIControlStateNormal];
    ToggleBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [ToggleBtn addTarget:self action:@selector(toggleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.placeOneVV addSubview:ToggleBtn];
    
    [self.pageContentV removeFromSuperview];
    self.pageContentV = nil;
    
    NSMutableArray *contentVCs = [NSMutableArray array];
//    if ([self.modelM.realName isEqualToString:kCharactName13]) {

    WEAKSELF
    self.roleOneOneCVC = [[MHFourthRoleJDBXController alloc] init];
    self.roleOneOneCVC.devicId = minIntStr(self.modelM.id);
    self.roleOneOneCVC.roleOneModel = self.roleOneModel;
    self.roleOneOneCVC.devicTyp = self.modelM.realName;
    self.roleOneOneCVC.isBMMM = self.isRevokePermission;
    self.roleOneOneCVC.selfUpVC = self;
    [contentVCs addObject:self.roleOneOneCVC];
    self.roleOneOneCVC.block_ = ^(int typeM) {
        
    };
    self.roleOneOneCVC.twoBBlock_ = ^(int typeM) {
        [weakSelf uiuiuiuiMMMMM];
    };
    self.roleOneOneCVC.stopWBlock_ = ^(int typeM) {
        STRONG_SELF
        self.isChannelBoo_play = 0;
        self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
        self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
    };
        
    self.roleOneTwoCVC = [[MHFourthRoleYYYController alloc] init];
    self.roleOneTwoCVC.devicId = minIntStr(self.modelM.id);
    self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
    self.roleOneTwoCVC.devicTyp = self.modelM.realName;
    self.roleOneTwoCVC.isBMMM = self.isRevokePermission;
    self.roleOneTwoCVC.selfUpVC = self;
    [contentVCs addObject:self.roleOneTwoCVC];
    self.roleOneTwoCVC.block_ = ^(int typeM) {
        
    };
    self.roleOneTwoCVC.twoBBlock_ = ^(int typeM) {
        [weakSelf uiuiuiuiMMMMM];
    };
    
    self.MHRoleOneThrCopyC = [[MHFourthRoleYYKZController alloc] init];
    self.MHRoleOneThrCopyC.devicId = minIntStr(self.modelM.id);
    self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
    self.MHRoleOneThrCopyC.devicTyp = self.modelM.realName;
    self.MHRoleOneThrCopyC.isBMMM = self.isRevokePermission;
    self.MHRoleOneThrCopyC.selfUpVC = self;
    [contentVCs addObject:self.MHRoleOneThrCopyC];
    self.MHRoleOneThrCopyC.block_ = ^(int typeM) {
        
    };
    self.MHRoleOneThrCopyC.twoBBlock_ = ^(int typeM) {
        [weakSelf uiuiuiuiMMMMM];
    };
        
//    }
    
    CGFloat yy_yflo = CGRectGetMaxY(self.placeOneVV.frame);
    self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, yy_yflo+54+25, _window_width, _window_height-(CGRectGetMaxY(self.placeOneVV.frame)+54+25)) childVCs:contentVCs parentVC:self delegate:self];
    self.pageContentV.contentViewCanScroll = self.roleOneModel.matchingCompleted;
    [self.view addSubview:self.pageContentV];
    self.pageContentV.contentViewCanScroll = NO;
    self.pageContentV.contentViewCurrentIndex = 0;
    
    [self.titOneVV removeFromSuperview];
    
    self.titOneVV = [[UIView alloc] initWithFrame:CGRectMake(0, yy_yflo, _window_width, 52)];
    self.titOneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.titOneVV];
    
    NSArray *names_ar = @[eLocalizedString(@"fourth_nams1"), eLocalizedString(@"thr_nams2"), eLocalizedString(@"thr_nams3")];
    UIImageView *linImg_lef = [HistoryRecordModel createImgImgView];
    linImg_lef.frame = CGRectMake(6, 20, 80, 14);
    linImg_lef.image = [UIImage imageNamed:@"fourth_lineLeft_Img"];
    [self.titOneVV addSubview:linImg_lef];
    UIImageView *linImg_rig = [HistoryRecordModel createImgImgView];
    linImg_rig.frame = CGRectMake(_window_width-86, 20, 80, 14);
    linImg_rig.image = [UIImage imageNamed:@"fourth_lineRight_Img"];
    [self.titOneVV addSubview:linImg_rig];
    
    CGFloat ww_fourth = (_window_width-172)/3;
    for (int i=0; i<names_ar.count; i++) {
        
        UIButton *tit_selB = [[UIButton alloc] initWithFrame:CGRectMake(86+i*ww_fourth, 0, ww_fourth, 52)];
        [tit_selB setTitle:names_ar[i] forState:UIControlStateNormal];
        [tit_selB setTitleColor:RGBA(255, 255, 255, 0.3) forState:UIControlStateNormal];
        [tit_selB setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        tit_selB.titleLabel.font = SYS_Font(14);
        tit_selB.titleLabel.numberOfLines = 2;
        tit_selB.tag = 70100+i;
        [tit_selB addTarget:self action:@selector(titSelBMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.titOneVV addSubview:tit_selB];
        
        if (i==0) {
            tit_selB.selected = YES;

            self.kkImgV = [HistoryRecordModel createImgImgView];
            self.kkImgV.frame = CGRectMake(tit_selB.x+(ww_fourth-8)/2, 44, 8, 8);
            self.kkImgV.image = [UIImage imageNamed:@"fourth_select_Img"];
            [self.titOneVV addSubview:self.kkImgV];
        }
    }
    
    if((self.roleOneModel.masterConnectStatus == 1) || (self.roleOneModel.servantConnectStatus == 1)) {
        self.roleOneOneCVC.isConnDevic = YES;
        self.roleOneTwoCVC.isConnDevic = YES;
        
    }else {
        BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            self.roleOneOneCVC.isConnDevic = YES;
            self.roleOneTwoCVC.isConnDevic = YES;
           
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
    
    
    //通道 A  B
    self.channl_SubV.hidden = NO;
    [self.view addSubview:self.channl_SubV];
    
}

//MARK: 通道选择
- (void)channelBtnMethod:(UIButton *)btn
{
//    if (btn.tag == 3300) {
//        
//        if ((self.isChannelBoo==0) || (self.isChannelBoo==2)) {
//            
//            self.isChannelBoo = self.isChannelBoo==2 ? 3:1;
//            self.channlelef_Lab.textColor = normalColors;
//            
//        }else {
//            if ((self.isChannelBoo_play==0) || (self.isChannelBoo_play==2)) {
//                
//                self.isChannelBoo = self.isChannelBoo==3 ? 2:0;
//                self.channlelef_Lab.textColor = UIColor.whiteColor;
//                
//            }
//        }
//        
//    }else {
//        if ((self.isChannelBoo==0) || (self.isChannelBoo==1)) {
//            
//            self.isChannelBoo = self.isChannelBoo==1 ? 3:2;
//            self.channlerig_Lab.textColor = normalColors;
//            
//        }else {
//            if ((self.isChannelBoo_play==0) || (self.isChannelBoo_play==1)) {
//                
//                self.isChannelBoo = self.isChannelBoo==3 ? 1:0;
//                self.channlerig_Lab.textColor = UIColor.whiteColor;
//                
//            }
//        }
//    }
//    
//    self.roleOneOneCVC.isChannelBoo = self.isChannelBoo;
//    self.roleOneOneCVC.isChannelBoo_play = self.isChannelBoo_play;
//    [self.roleOneOneCVC channelBtnChooseMethodOne];
//    
//    self.roleOneTwoCVC.isChannelBoo = self.isChannelBoo;
//    self.roleOneTwoCVC.isChannelBoo_play = self.isChannelBoo_play;
//    [self.roleOneTwoCVC channelBtnChooseMethodOne];
//    
//    self.MHRoleOneThrCopyC.isChannelBoo = self.isChannelBoo;
//    self.MHRoleOneThrCopyC.isChannelBoo_play = self.isChannelBoo_play;
//    [self.MHRoleOneThrCopyC channelBtnChooseMethodOne];
}

//MARK: 通道 播放
- (void)channelBtnMethodPlay:(UIButton *)btn
{
    if (self.pageContentV.contentViewCurrentIndex==0 && ![self.roleOneOneCVC getBooMEthod]) {
        return;
    }
    
    if (btn.tag == 3400) {
        
        if ((self.isChannelBoo==1) || (self.isChannelBoo==3)) {
            
            switch (self.isChannelBoo_play) {
                case 0:
                {
                    self.isChannelBoo_play = 1;
                }
                    break;
                case 1:
                {
                    self.isChannelBoo_play = 0;
                }
                    break;
                case 2:
                {
                    self.isChannelBoo_play = 3;
                }
                    break;
                case 3:
                {
                    self.isChannelBoo_play = 2;
                }
                    break;
                    
                default:
                    break;
            }
            
            if ((self.isChannelBoo_play==1) || (self.isChannelBoo_play==3)) {
                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playSel_Img"];
    
            }else {
                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
            }
            [self channelUploadMethodBoo];
        }
    }else {
        if ((self.isChannelBoo==2) || (self.isChannelBoo==3)) {
            
            switch (self.isChannelBoo_play) {
                case 0:
                {
                    self.isChannelBoo_play = 2;
                }
                    break;
                case 1:
                {
                    self.isChannelBoo_play = 3;
                }
                    break;
                case 2:
                {
                    self.isChannelBoo_play = 0;
                }
                    break;
                case 3:
                {
                    self.isChannelBoo_play = 1;
                }
                    break;
                    
                default:
                    break;
            }
            
            if ((self.isChannelBoo_play==2) || (self.isChannelBoo_play==3)) {
                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playSel_Img"];
               
            }else {
                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
                
            }
            [self channelUploadMethodBoo];
        }
    }
}

- (void)channelUploadMethodBoo
{
    switch (self.pageContentV.contentViewCurrentIndex) {
        case 0:
        {
            self.roleOneOneCVC.isChannelBoo = self.isChannelBoo;
            self.roleOneOneCVC.isChannelBoo_play = self.isChannelBoo_play;
            [self.roleOneOneCVC channelStartChooseMethodTwo];
        }
            break;
        case 1:
        {
            self.roleOneTwoCVC.isChannelBoo = self.isChannelBoo;
            self.roleOneTwoCVC.isChannelBoo_play = self.isChannelBoo_play;
            [self.roleOneTwoCVC channelStartChooseMethodTwo];
        }
            break;
        case 2:
        {
            self.MHRoleOneThrCopyC.isChannelBoo = self.isChannelBoo;
            self.MHRoleOneThrCopyC.isChannelBoo_play = self.isChannelBoo_play;
            [self.MHRoleOneThrCopyC channelStartChooseMethodTwo];
        }
            break;
            
        default:
            break;
    }
}


- (void)titSelBMethodTag:(UIButton *)btn
{
    CGFloat ww_fourth = (_window_width-172)/3;
    for (int i=0; i<3; i++) {
        
        UIButton *tit_selB = [self.view viewWithTag:70100+i];
        if (tit_selB.tag==btn.tag) {
            tit_selB.selected = YES;

            self.kkImgV.x = tit_selB.x+(ww_fourth-8)/2;
            
            [self uploadThrQQQQMehtodTag:i];
        }else {
            tit_selB.selected = NO;
        }
    }
}

//MARK: 三期 切换提示 是否退出此模式
- (void)uploadThrQQQQMehtodTag:(NSInteger)num
{
    switch (num) {
        case 0:
        {
            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
        }
            break;
        case 1:
        {
            if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleOneOneCVC getBooMEthod] && self.isChannelBoo>0 && self.isChannelBoo_play>0) {
                    
                    
                    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vc];
                    [vc addFourthDataToDicTypeNum:2];
                    vc.block_ = ^(BOOL isBBB) {
                        if(isBBB) {
                        
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            
                            CGFloat ww_fourth = (_window_width-172)/3;
                            for (int i=0; i<3; i++) {
                                
                                UIButton *tit_selB = [self.view viewWithTag:70100+i];
                                if (tit_selB.tag-70100==self.pageContentV.contentViewCurrentIndex) {
                                    tit_selB.selected = YES;
                                    
                                    self.kkImgV.x = tit_selB.x+(ww_fourth-8)/2;
                                }else {
                                    tit_selB.selected = NO;
                                }
                            }
                        }
                    };
                    
                    
                    
//                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//                    [self.tabBarController.view addSubview:vcLocat];
//                    [vcLocat addTwoNewTextfUIUIMethod:6];
//                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
//                      
//                        if (arrList.count>0) {
//                            
//                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
//                        }else {
//                            
//                            CGFloat ww_fourth = (_window_width-172)/3;
//                            for (int i=0; i<3; i++) {
//                                
//                                UIButton *tit_selB = [self.view viewWithTag:70100+i];
//                                if (tit_selB.tag-70100==self.pageContentV.contentViewCurrentIndex) {
//                                    tit_selB.selected = YES;
//                                    
//                                    self.kkImgV.x = tit_selB.x+(ww_fourth-8)/2;
//                                }else {
//                                    tit_selB.selected = NO;
//                                }
//                            }
//                        }
//                    };
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
            if (self.pageContentV.contentViewCurrentIndex==0) {
                if ([self.roleOneOneCVC getBooMEthod] && self.isChannelBoo>0 && self.isChannelBoo_play>0) {
                    
                    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vc];
                    [vc addFourthDataToDicTypeNum:2];
                    vc.block_ = ^(BOOL isBBB) {
                        if(isBBB) {
                        
                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
                        }else {
                            
                            CGFloat ww_fourth = (_window_width-172)/3;
                            for (int i=0; i<3; i++) {
                                
                                UIButton *tit_selB = [self.view viewWithTag:70100+i];
                                if (tit_selB.tag-70100==self.pageContentV.contentViewCurrentIndex) {
                                    tit_selB.selected = YES;
                                    
                                    self.kkImgV.x = tit_selB.x+(ww_fourth-8)/2;
                                }else {
                                    tit_selB.selected = NO;
                                }
                            }
                        }
                    };
                    
//                    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//                    [self.tabBarController.view addSubview:vcLocat];
//                    [vcLocat addTwoNewTextfUIUIMethod:6];
//                    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
//                      
//                        if (arrList.count>0) {
//                            
//                            [self uploadThrQQQQMehtodTagTwoUUU:num old:self.pageContentV.contentViewCurrentIndex];
//                        }else {
//                            CGFloat ww_fourth = (_window_width-172)/3;
//                            for (int i=0; i<3; i++) {
//                                
//                                UIButton *tit_selB = [self.view viewWithTag:70100+i];
//                                if (tit_selB.tag-70100==self.pageContentV.contentViewCurrentIndex) {
//                                    tit_selB.selected = YES;
//                                    
//                                    self.kkImgV.x = tit_selB.x+(ww_fourth-8)/2;
//                                }else {
//                                    tit_selB.selected = NO;
//                                }
//                            }
//                        }
//                    };
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

//MARK: 多数
- (void)subGetThrQQQTagold:(NSInteger)numOld
{
    switch (numOld) {
        case 0:
        {
            self.roleOneOneCVC.time_Boo2_old = YES;
            self.roleOneTwoCVC.time_Boo2_old = NO;
            self.MHRoleOneThrCopyC.time_Boo2_old = NO;
        }
            break;
        case 1:
        {
            self.roleOneOneCVC.time_Boo2_old = NO;
            self.roleOneTwoCVC.time_Boo2_old = YES;
            self.MHRoleOneThrCopyC.time_Boo2_old = NO;
        }
            break;
        case 2:
        {
            self.roleOneOneCVC.time_Boo2_old = NO;
            self.roleOneTwoCVC.time_Boo2_old = NO;
            self.MHRoleOneThrCopyC.time_Boo2_old = YES;
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
            if (![self.roleOneOneCVC getBooMEthod]) {
//                self.isChannelBoo = 0;
                self.isChannelBoo_play = 0;
                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
            }
            self.roleOneOneCVC.isChannelBoo = self.isChannelBoo;
            self.roleOneOneCVC.isChannelBoo_play = self.isChannelBoo_play;
            
            self.roleOneOneCVC.time_Boo2 = NO;
            self.roleOneTwoCVC.time_Boo2 = YES;
            self.MHRoleOneThrCopyC.time_Boo2 = YES;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleOneOneCVC uploadUIUIUI];
            [self.roleOneTwoCVC uploadUIUIUI];
            [self.MHRoleOneThrCopyC uploadUIUIUI];
            
        }
            break;
        case 1:
        {
            self.roleOneTwoCVC.isChannelBoo = self.isChannelBoo;
            self.roleOneTwoCVC.isChannelBoo_play = self.isChannelBoo_play;
            
            self.roleOneOneCVC.time_Boo2 = YES;
            self.roleOneTwoCVC.time_Boo2 = NO;
            self.MHRoleOneThrCopyC.time_Boo2 = YES;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleOneOneCVC uploadUIUIUI];
            [self.roleOneTwoCVC uploadUIUIUI];
            [self.MHRoleOneThrCopyC uploadUIUIUI];
        }
            break;
        case 2:
        {
            self.MHRoleOneThrCopyC.isChannelBoo = self.isChannelBoo;
            self.MHRoleOneThrCopyC.isChannelBoo_play = self.isChannelBoo_play;
            
            self.roleOneOneCVC.time_Boo2 = YES;
            self.roleOneTwoCVC.time_Boo2 = YES;
            self.MHRoleOneThrCopyC.time_Boo2 = NO;
            
            [self subGetThrQQQTagold:numOld];
            
            [self.roleOneOneCVC uploadUIUIUI];
            [self.roleOneTwoCVC uploadUIUIUI];
            [self.MHRoleOneThrCopyC uploadUIUIUI];
        }
            break;
            
        default:
            break;
    }
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{

}

- (void)rightImageUIUIUI
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        
        MHFourthRoleMoreController *vc = [[MHFourthRoleMoreController alloc] init];
        vc.roleOneModel = self.roleOneModel;
        vc.macStrL = self.modelM.mac;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^{
            [self requestDeviceDetailMethodTwo:3];
        };
    }else {
        
        MHFourthRoleMoreController *vc = [[MHFourthRoleMoreController alloc] init];
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

        MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.view addSubview:vc];
        [vc addFourthDataToDicTypeNum:1];
        vc.block_ = ^(BOOL isBBB) {
            if(isBBB) {
                [SVProgressHUD show];
                [requestToolClass postNetworkWithUrl:request_device_changeRole andParameter:@{@"deviceId":minIntStr(self.modelM.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                    [self requestDeviceDetailMethod];
                } fail:^(NSString * _Nonnull msg) {

                }];
            }
        };
        
//        [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"role_setting13") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
//            if (index == 1) {
//                [SVProgressHUD show];
//                [requestToolClass postNetworkWithUrl:request_device_changeRole andParameter:@{@"deviceId":minIntStr(self.modelM.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                    [self requestDeviceDetailMethod];
//                } fail:^(NSString * _Nonnull msg) {
//
//                }];
//            }
//        }];
    }
    
}

- (void)requestDeviceDetailMethod
{
    self.statLLLab.hidden = NO;
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%d", request_device_detail, self.modelM.id];
    [requestToolClass getNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *infDic = info;
        self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        
        if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
            [self addNewUIUIUIU:@"1"];
        }else {
            [self addNewUIUIUIU:@"2"];
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
        self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        
        if((self.roleOneModel.masterConnectStatus == 1) || (self.roleOneModel.servantConnectStatus == 1)) {
            self.isConnDevic = YES;
            self.roleOneOneCVC.isConnDevic = YES;
            self.roleOneTwoCVC.isConnDevic = YES;
            self.MHRoleOneThrCopyC.isConnDevic = YES;
           
            self.statLLLab.text = eLocalizedString(@"home_nam3");
        }else {
            BOOL isEEEqq = [self.modelM.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if(isEEEqq) {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(self.modelM.id), @"operate":@"1"}];
                self.isConnDevic = YES;
                self.roleOneOneCVC.isConnDevic = YES;
                self.roleOneTwoCVC.isConnDevic = YES;
                self.MHRoleOneThrCopyC.isConnDevic = YES;
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
//        if(self.roleOneModel.locationSERVANTLatitude) {
//            NSString *longgg = self.roleOneModel.locationSERVANTLongitude;
//            NSString *latgg = self.roleOneModel.locationSERVANTLatitude;
//            
//            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
//            self.roleOneModel.locationSERVANTLongitude = longgg;
//            self.roleOneModel.locationSERVANTLatitude = latgg;
//        }else {
//            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
//        }
        self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
        [self.roleOneOneCVC uploadUIUIUI];
        [self.MHRoleOneThrCopyC uploadUIUIUI];
        
        
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
//        if(self.roleOneModel.locationSERVANTLatitude) {
//            NSString *longgg = self.roleOneModel.locationSERVANTLongitude;
//            NSString *latgg = self.roleOneModel.locationSERVANTLatitude;
//            
//            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
//            self.roleOneModel.locationSERVANTLongitude = longgg;
//            self.roleOneModel.locationSERVANTLatitude = latgg;
//        }else {
//            self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
//        }
        
        self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        self.roleOneOneCVC.roleOneModel = self.roleOneModel;
        self.roleOneTwoCVC.roleOneModel = self.roleOneModel;
        
        self.MHRoleOneThrCopyC.roleOneModel = self.roleOneModel;
        [self.MHRoleOneThrCopyC uploadUIUIUI];
        
        
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
