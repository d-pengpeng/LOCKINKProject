//
//  MHhomeManageController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/20.
//

#import "MHhomeManageController.h"
#import "MHAddTOYSController.h"
#import "eSecurityCodeView.h"
#import "MHwelcomLoginController.h"
#import "MHPrivacyProtectionVView.h"

#import <SDCycleScrollView/SDCycleScrollView.h>
#import "MHEquipmentCell.h"
#import "MHEquipmentModel.h"
#import "PopModifyView.h"
#import "MHRoleOneController.h"
#import "MHPlaceVCell.h"

#import "MHFourthRoleOneController.h"


@interface MHhomeManageController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UILabel *oneNumLab;

//@property (nonatomic, assign) BOOL bleLBooThr;//是否进入蓝牙连接界面
//@property (nonatomic, assign) NSInteger isFirstMAC;
//@property (nonatomic, assign) BOOL isListBle;

@property (nonatomic, strong) UIButton *bluetoothBtn;
//@property (nonatomic, copy) NSString *macStMMM;
//@property (nonatomic, copy) NSString *macStMMM2;
//@property (nonatomic, copy) NSString *namStMMM;//设备名
//@property (nonatomic, assign) BOOL isAddEquip;
@property (nonatomic, assign) int oneIn;
@property (nonatomic, assign) BOOL isEnterBol;

@property (nonatomic, strong) MHPrivacyProtectionVView *privacyProtectionVV;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollV;
@property (nonatomic, strong) UITableView *appTableView;
//@property (nonatomic, strong) NSMutableArray *datasMut;
//@property (nonatomic, strong) NSMutableArray *datasMut2;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) BOOL isBlueStartBoo;
@property (nonatomic, strong) NSArray *cycLisAr;
@property (nonatomic, strong) UILabel *placLab;
@property (nonatomic, strong) UIView *placVVV;
//@property (nonatomic, copy) NSString *ElecStr;
//@property (nonatomic, assign) BOOL isWWWWBoo;
@property (nonatomic, assign) BOOL isWWWWBoo2;
@property (nonatomic, assign) BOOL isWWWWBoo3;


@end

@implementation MHhomeManageController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
    
    //设置常亮不锁屏
//    [[UIApplication sharedApplication] setIdleTimerDisabled:[LYUserDefault userDefault].isScreenAwake];
    [[UIApplication sharedApplication] setIdleTimerDisabled:[FloatingWindowModel shareInstance].bluetoothBtn_bo];
    
//    if(self.privacyProtectionVV) {
//        self.privacyProtectionVV.hidden = NO;
//    }
    
    if([LYUserDefault userDefault].countries_Arr.count <= 0) {
        [requestToolClass getNetworkWithUrl:request_login_countries andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            [LYUserDefault saveCountiesArr:info];
        } fail:^(NSString * _Nonnull msg) {

        }];
    }
    [FloatingWindowModel shareInstance].isWWWWBoo = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [FloatingWindowModel shareInstance].isWWWWBoo = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"2"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [FloatingWindowModel shareInstance].bleLBooThr = NO;

    if ([[eSocketRocketUtility sharedInstance] getSocketCloseBoo]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //MARK: 开启tcp
            NSURL *urlSS = [NSURL URLWithString:socketWSUrl];
            NSString *scheme = urlSS.scheme.lowercaseString;
            if([scheme isEqualToString:@"ws"] || [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"wss"] || [scheme isEqualToString:@"https"]) {
                [[eSocketRocketUtility sharedInstance] SRWebSocketOpenWithURLString:socketWSUrl];
                self.isWWWWBoo2 = YES;
            }
        });
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi2 object:@"1"];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:[FloatingWindowModel shareInstance].bluetoothBtn_bo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideBackBnt = YES;
    self.redNavView = YES;
    self.backImgV.image = [UIImage imageNamed:@"allBackImgs"];
    self.titleName.text = eLocalizedString(@"tabbar_tit1");
    self.showImgVV = YES;
    
    [FloatingWindowModel shareInstance].devicNameArr = @[kCharactName3];  //MARK: 二期
    [FloatingWindowModel shareInstance].devicNameArr3 = @[kCharactName4, kCharactName6, kCharactName7, kCharactName8, kCharactName9, kCharactName10, kCharactName11, kCharactName14]; //MARK: 三期
    
    self.oneIn = 0;
    [LYUserDefault saveMacName:@""];
    [LYUserDefault saveMacElec:@""];
    [LYUserDefault saveIsEnterBackground:NO];
    if([LYUserDefault userDefault].isLoginBoo) {
        [HistoryRecordModel deletAllDataPlist];
        [HistoryRecordModel deletAllDataPlayListPlist];
    }

    _bluetoothBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bluetoothBtn.clipsToBounds = YES;
    _bluetoothBtn.backgroundColor = UIColor.whiteColor;
    _bluetoothBtn.layer.cornerRadius = 13;
    [_bluetoothBtn addTarget:self action:@selector(rightImageMMMM) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bluetoothBtn];
    [_bluetoothBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(TIMESTATUSHEIGHT+9);
        make.height.offset(26);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
    
    UIImageView *bluImgV = [HistoryRecordModel createImgImgView];
    bluImgV.frame = CGRectMake(6, 4, 15, 18);
    bluImgV.image = [UIImage imageNamed:@"home_img1"];
    [_bluetoothBtn addSubview:bluImgV];
    [bluImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bluetoothBtn.mas_left).offset(6);
        make.top.equalTo(self.bluetoothBtn.mas_top).offset(4);
        make.width.offset(15);
        make.height.offset(18);
    }];
    
    _oneNumLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:10 textAlignment:NSTextAlignmentCenter];
    _oneNumLab.frame = CGRectMake(24, 0, 24, 26);
    _oneNumLab.text = eLocalizedString(@"home_nam1");
    [_bluetoothBtn addSubview:_oneNumLab];
    [self.oneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bluImgV.mas_right).offset(3);
        make.top.bottom.equalTo(self.bluetoothBtn);
        make.right.equalTo(self.bluetoothBtn.mas_right).offset(-6);
    }];
    [self DeviceMethodUploadKZ];
    
    CGFloat yy_y = (_window_width-24)*137/351;
    if(yy_y>200) {
        yy_y = 200;
    }

    UIView *imgsVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, yy_y+10)];
    imgsVVV.backgroundColor = UIColor.clearColor;
    
    self.cycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(12, 0, _window_width-24, yy_y) delegate:self placeholderImage:[UIImage imageNamed:@"cyc_placeImg"]];
    self.cycleScrollV.clipsToBounds = YES;
    self.cycleScrollV.layer.cornerRadius = 8;
    self.cycleScrollV.autoScrollTimeInterval = 3;
    self.cycleScrollV.currentPageDotColor = UIColor.whiteColor;
    [self.cycleScrollV disableScrollGesture];
    self.cycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [imgsVVV addSubview:self.cycleScrollV];
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+3, _window_width, _window_height-NAVHEIGHT-3) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHEquipmentCell class] forCellReuseIdentifier:@"MHEquipmentCell"];
    [self.appTableView registerClass:[MHPlaceVCell class] forCellReuseIdentifier:@"MHPlaceVCell"];
    [self.view addSubview:_appTableView];
    
    self.appTableView.tableHeaderView = imgsVVV;
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+yy_y+12, _window_width, _window_height-NAVHEIGHT-yy_y-12)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    
    [self loadrefreshing];
    
    [requestToolClass getNetworkWithUrl:request_carousel_listAll andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.cycLisAr = info;
        NSMutableArray *lisMAr = [NSMutableArray array];
        for (NSDictionary *dicM in self.cycLisAr) {
            [lisMAr addObject:dicM[@"url"]];
        }
        self.cycleScrollV.imageURLStringsGroup = lisMAr;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [requestToolClass getNetworkWithUrl:request_config_get andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            if([info[@"adList"] isKindOfClass:[NSArray class]]) {
                [LYUserDefault saveAdListArr:info[@"adList"]];
            }
        }
        
    } fail:^(NSString * _Nonnull msg) {

    }];

    [self uploadMehtodUnread];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kNeedChangeGoodsNNN:) name:kNeedChangeGoodsNote object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HomeListUploadNotifMEthod) name:@"HomeListUploadNotif" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(broadAlertMessageName:) name:@"blueMsgBlueMsgNotiffName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blueNameStatusNotiffNameName:) name:@"blueNameStatusNotiffName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blueNameStatusNotiffNameUploadDataName) name:@"blueNameStatusNotiffNameUploadData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadTableViewNameNotifName:) name:@"uploadTableViewNameNotif" object:nil];
    
    
    
    self.placVVV = [HistoryRecordModel createViewUIUI];
    [self.tabBarController.view addSubview:self.placVVV];
    [self.placVVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tabBarController.view);
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

    
    //MARK: 获取客服ID
    [requestToolClass getNetworkWithUrl:request_other_getAllServiceUid andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSString class]]) {
            [LYUserDefault saveKefuId:minStr(info)];
        }else {
            [LYUserDefault saveKefuId:@""];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
}

- (void)HomeListUploadNotifMEthod
{
    [self loadHeadData];
}

- (void)kNeedChangeGoodsNNN:(NSNotification *)usfo {
    
    NSString * strD  = [NSString stringWithFormat:@"%@", usfo.object];
    NSData *jsonData = [strD dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (dic) {
        NSString *type = [NSString stringWithFormat:@"%@", dic[@"type"]];
        if([type isEqualToString:@"UNREAD-MESSAGE"]) { //存在未读消息
            
            [self uploadMehtodUnread];
        }
    }
}

- (void)uploadMehtodUnread
{
    [requestToolClass getNetworkWithUrl:request_message_getMessageOverview andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            NSString *numStr = minStr(info[@"deviceMessageUnreadCount"]);
            [LYUserDefault saveMsgNoRedStart:[numStr integerValue]];
            
            NSString *numStr2 = minStr(info[@"systemMessageUnreadCount"]);
            [LYUserDefault saveMsgNoRedStart2:[numStr2 integerValue]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deviceMessageUnreadCountNotif" object:nil userInfo:@{@"redOne":numStr, @"redTwo":numStr2}];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

//MARK:  轮播图点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.cycLisAr.count > index) {
        MHEquipmentModel_linkUrl *model = [MHEquipmentModel_linkUrl mj_objectWithKeyValues:self.cycLisAr[index]];
        if (model.linkUrl && model.linkUrl.length>0) {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:minStr(model.linkUrl)]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:minStr(model.linkUrl)] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }
        }
    }
}

- (void)blueNameStatusNotiffNameUploadDataName
{
    [self RequestListData];
}

- (void)uploadTableViewNameNotifName:(NSNotification *)notiff
{
    switch ([minStr(notiff.object) intValue]) {
        case 1:
        {
            [self.appTableView reloadData];
        }
            break;
        case 2:
        {
            NSString *row_row = minStr(notiff.userInfo[@"rowRow"]);
            [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[row_row integerValue] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [self request_saveAddEquipMethodTwo];
        }
            break;
        case 3:
        {
            [self request_saveAddEquipMethod];
        }
            break;
        case 4:
        {
       
        }
            break;
            
        default:
            break;
    }
}

//MARK: tableview代理方法
-(void)loadrefreshing {
    
    WEAKSELF
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeadData];
    }];
    
    // 马上进入刷新状态
    [self.appTableView.mj_header beginRefreshing];

}

- (void)loadHeadData {

    [self RequestListData];
}

- (void)RequestListData
{
    [requestToolClass getNetworkWithUrl:request_device_listAll andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        
        NSArray *datadata = info;
        [[FloatingWindowModel shareInstance].datasMut removeAllObjects];
        [[FloatingWindowModel shareInstance].datasMut2 removeAllObjects];

        BOOL booMM = NO;
        for (NSDictionary *dicdic in datadata) {
            MHEquipmentModel *model = [MHEquipmentModel mj_objectWithKeyValues:dicdic];
            if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                if(isEEEqq) {
                    model.isShowLinks = YES;
                    booMM = YES;
                }else {
                    model.isShowLinks = NO;
                }
            }else {
                model.isShowLinks = NO;
                if(self.isWWWWBoo2 && !self.isWWWWBoo3) {
                    self.isWWWWBoo2 = NO;
                    self.isWWWWBoo3 = YES;
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":minIntStr(model.id), @"operate":@"2"}];
                }
            }
            [[FloatingWindowModel shareInstance].datasMut addObject:model];
            [[FloatingWindowModel shareInstance].datasMut2 addObject:[model.mac uppercaseString]];
            
            if(model.bothConnected) {

                model.bothConnected = NO;
                [requestToolClass getNOMsgNetworkWithUrl:request_device_connectOrDisconnect andParameter:@{@"deviceId":minIntStr(model.id), @"type":@"2"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                } fail:^(NSString * _Nonnull msg) {
                    
                }];
            }
        }
      
        if (datadata.count <= 0) {
            [self.appTableView.mj_footer endRefreshingWithNoMoreData];
        }

        if(!self.isBlueStartBoo) {
            self.isBlueStartBoo = YES;
//            [self startBlueToothisBoo:@"1"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifStartScanBlueServiceName" object:nil];
        }
        
        if ([FloatingWindowModel shareInstance].datasMut.count > 0) {
            self.noDataImgV.hidden = YES;
            [self.appTableView.mj_footer setHidden:NO];
        }else {
            self.noDataImgV.hidden = NO;
            [self.appTableView.mj_footer setHidden:YES];
        }
        [self.appTableView reloadData];
        
    } fail:^(NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1) {
        return 1;
    }else {
        return [FloatingWindowModel shareInstance].datasMut.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        
        MHPlaceVCell *cell = [MHPlaceVCell cellWithTabelView:tableView];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MHEquipmentCell *cell = [MHEquipmentCell cellWithTabelView:tableView];
        [cell addDataToDic:[FloatingWindowModel shareInstance].datasMut[indexPath.row] row:indexPath.row];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0) {
        [FloatingWindowModel shareInstance].bleLBooThr = YES;
        
        MHEquipmentModel *modelM = [FloatingWindowModel shareInstance].datasMut[indexPath.row];
        if ([modelM.realName isEqualToString:kCharactName13]) {
            MHFourthRoleOneController *vc = [[MHFourthRoleOneController alloc] init];
            vc.modelM = modelM;
            vc.arrList = [FloatingWindowModel shareInstance].serviceArrs ? [FloatingWindowModel shareInstance].serviceArrs:@[];
            vc.macsList = [FloatingWindowModel shareInstance].idArrs ? [FloatingWindowModel shareInstance].idArrs:@[];
            vc.ListAAA = [FloatingWindowModel shareInstance].datasMut ? [FloatingWindowModel shareInstance].datasMut:@[];
            [self.navigationController pushViewController:vc animated:YES];
            vc.block_ = ^(NSInteger typMM) {
                
                if(typMM == 1) {

                    self.placVVV.hidden = NO;
                    self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"role_connect1")];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.placVVV.hidden = YES;
                    });
                    [self loadHeadData];
                }else {
                    if(typMM == 3) {
                        self.placVVV.hidden = NO;
                        self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"role_setting16_16")];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.placVVV.hidden = YES;
                        });
                        [self loadHeadData];
                    }if(typMM == 4) {
                        self.placVVV.hidden = NO;
                        self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"new_msg_2")];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.placVVV.hidden = YES;
                        });
                        [self loadHeadData];
                    }
                    if(typMM == 5) {
                        self.placVVV.hidden = NO;
                        self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"role_name55")];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.placVVV.hidden = YES;
                        });
                    }
                }
            };
        }else {
            MHRoleOneController *vc = [[MHRoleOneController alloc] init];
            vc.modelM = modelM;
            vc.arrList = [FloatingWindowModel shareInstance].serviceArrs ? [FloatingWindowModel shareInstance].serviceArrs:@[];
            vc.macsList = [FloatingWindowModel shareInstance].idArrs ? [FloatingWindowModel shareInstance].idArrs:@[];
            vc.ListAAA = [FloatingWindowModel shareInstance].datasMut ? [FloatingWindowModel shareInstance].datasMut:@[];
            [self.navigationController pushViewController:vc animated:YES];
            vc.block_ = ^(NSInteger typMM) {
                
                if(typMM == 1) {

                    self.placVVV.hidden = NO;
                    self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"role_connect1")];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.placVVV.hidden = YES;
                    });
                    [self loadHeadData];
                }else {
                    if(typMM == 3) {
                        self.placVVV.hidden = NO;
                        self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"role_setting16_16")];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.placVVV.hidden = YES;
                        });
                        [self loadHeadData];
                    }if(typMM == 4) {
                        self.placVVV.hidden = NO;
                        self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"new_msg_2")];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.placVVV.hidden = YES;
                        });
                        [self loadHeadData];
                    }
                    if(typMM == 5) {
                        self.placVVV.hidden = NO;
                        self.placLab.text = [NSString stringWithFormat:@"   %@    ", eLocalizedString(@"role_name55")];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.placVVV.hidden = YES;
                        });
                    }
                }
            };
        }
        
    }
}

- (void)rightImageMMMM
{
    if(![LYUserDefault userDefault].isLoginBoo) {
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"please_login")];
        return;
    }
    [FloatingWindowModel shareInstance].bleLBooThr = YES;
    MHAddTOYSController *vc = [[MHAddTOYSController alloc] init];
    vc.arrList = [FloatingWindowModel shareInstance].serviceArrs ? [FloatingWindowModel shareInstance].serviceArrs:@[];
    vc.macsList = [FloatingWindowModel shareInstance].idArrs ? [FloatingWindowModel shareInstance].idArrs:@[];
    vc.ListAAA = [FloatingWindowModel shareInstance].datasMut ? [FloatingWindowModel shareInstance].datasMut:@[];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)blueNameStatusNotiffNameName:(NSNotification *)notiff
{
    self.oneNumLab.text = minStr(notiff.object);
}

- (void)broadAlertMessageName:(NSNotification *)notiff
{
    
    NSString *mesg = minStr(notiff.object);
    
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:eLocalizedString(@"toys_all6") message:mesg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:eLocalizedString(@"toys_all7") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        
    }];
    [alertContro addAction:cancleAction];
    
    UIAlertAction *ccccAction = [UIAlertAction actionWithTitle:eLocalizedString(@"home_Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:ccccAction];
    [self presentViewController:alertContro animated:YES completion:nil];
    
}

//MARK: 添加设备

- (void)request_saveAddEquipMethod
{
    if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
        
        NSDictionary *dicWW = @{@"realName":[FloatingWindowModel shareInstance].namStMMM, @"mac":[FloatingWindowModel shareInstance].macStMMM2, @"model":@"", @"remainingCharge":[FloatingWindowModel shareInstance].ElecStr};
        NSLog(@"添加设备1-- %@", dicWW);
        [requestToolClass postNetworkWithUrl:request_device_saveOrUpdate andParameter:dicWW success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            self.oneNumLab.text = eLocalizedString(@"home_nam3");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif" object:@{@"status":@"1", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
            
            [FloatingWindowModel shareInstance].device_namL = [FloatingWindowModel shareInstance].namStMMM;
            
            [self loadHeadData];
        } fail:^(NSString * _Nonnull msg) {
            NSArray *arrM = [msg componentsSeparatedByString:@","];
            if(arrM.count == 2) {
                if([minStr(arrM[0]) isEqualToString:@"60056"]) {//MARK: 第三个设备连接 提示语
                    self.oneNumLab.text = eLocalizedString(@"home_nam1");
                    [self DeviceMethodUploadKZ];
//                    if (self.peripheral != nil) {
//                        self.isListBle = YES;
//                        [self.myCentralManager cancelPeripheralConnection:self.peripheral];
//                        self.peripheral = nil;
//                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"closePeripheralNameNotif" object:@"1"];
                    
                    self.placVVV.hidden = NO;
                    self.placLab.text = [NSString stringWithFormat:@"  %@   ", arrM[1]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.placVVV.hidden = YES;
                    });
                }
            }
        }];
        
    }else {
        _oneNumLab.text = eLocalizedString(@"home_nam1");
        [self DeviceMethodUploadKZ];
//        if (self.peripheral != nil) {
//            self.isListBle = YES;
//            [self.myCentralManager cancelPeripheralConnection:self.peripheral];
//            self.peripheral = nil;
//        }
//        self.isFirstMAC = 0;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closePeripheralNameNotif" object:@"2"];
    }
}

/***
 清空缓存设备值
 */
- (void)DeviceMethodUploadKZ
{
    [FloatingWindowModel shareInstance].choose_numW = 0;
    [FloatingWindowModel shareInstance].JingDian_one_strong = 0;
    [FloatingWindowModel shareInstance].JingDian_one_model = 0;
    [FloatingWindowModel shareInstance].JingDian_two_strong = 0;
    [FloatingWindowModel shareInstance].JingDian_two_model = 0;
    [FloatingWindowModel shareInstance].JingDian_thr = 0;
    [FloatingWindowModel shareInstance].JingDian_thr_strong = 0;
    [FloatingWindowModel shareInstance].JingDian_thr_strong2 = 0;
    
    [FloatingWindowModel shareInstance].yaoyiyao_one = 0;
    [FloatingWindowModel shareInstance].yaoyiyao_two = 0;
    [FloatingWindowModel shareInstance].yaoyiyao_thr = 0;
    
    [FloatingWindowModel shareInstance].yuyin_play = 0;
    [FloatingWindowModel shareInstance].yuyin_one = 0;
    [FloatingWindowModel shareInstance].yuyin_two = 0;
    [FloatingWindowModel shareInstance].yuyin_thr = 0;
    
    [FloatingWindowModel shareInstance].shoudong_one = 0;
    [FloatingWindowModel shareInstance].shoudong_two = 0;
    [FloatingWindowModel shareInstance].shoudong_oneStrong = 0;
    [FloatingWindowModel shareInstance].shoudong_twoStrong = 0;
    [FloatingWindowModel shareInstance].shoudong_model = 0;
    [FloatingWindowModel shareInstance].boxing_play = 0;
}

- (void)request_saveAddEquipMethodTwo
{
    if(self.oneIn > 30) {
        self.oneIn = 0;
        if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
            
            NSDictionary *dicMMM = @{@"realName":[FloatingWindowModel shareInstance].namStMMM, @"mac":[FloatingWindowModel shareInstance].macStMMM2, @"model":@"", @"remainingCharge":[FloatingWindowModel shareInstance].ElecStr};
            
            [requestToolClass postNetworkWithUrl:request_device_saveOrUpdate andParameter:dicMMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
    }else {
        self.oneIn = self.oneIn + 1;
    }
}


@end

