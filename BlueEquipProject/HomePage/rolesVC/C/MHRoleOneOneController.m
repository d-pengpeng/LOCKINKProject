//
//  MHRoleOneOneController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "MHRoleOneOneController.h"
#import "MHRoleOneOneCell.h"
#import "MHRoleSettingController.h"
#import "MHRoleOneOneSubCell.h"
#import "MHLimitsAuthorityView.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHRecordingAuthenticationController.h"

@interface MHRoleOneOneController ()<UITableViewDelegate, UITableViewDataSource, roleOneModesDelegate>
{
    NSTimer *messsageTimer;
}
@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *arrMuut;
@property (nonatomic, strong) NSArray *oneArr;
@property (nonatomic, strong) UILabel *rigLLL;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *timeBtn2;

@property (nonatomic, strong) UIButton *chatBtn;
@property (nonatomic, strong) UIButton *chatBtn2;
@property (nonatomic, assign) int secdNum;
@property (nonatomic, assign) int secdNum_js;
@property (nonatomic, assign) BOOL isBBBB; //定时结束刷新
@property (nonatomic, assign) BOOL isRequestBoo;
@end

@implementation MHRoleOneOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    UILabel *onelab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    onelab.frame = CGRectMake(20, 10, _window_width/2, 34);
    onelab.text = eLocalizedString(@"find_choose1");
    [self.view addSubview:onelab];
    
    self.rigLLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
    self.rigLLL.text = self.roleOneModel.timeLockEnabled ? eLocalizedString(@"role_name16_16"):eLocalizedString(@"role_name16");
    [self.view addSubview:self.rigLLL];
    [self.rigLLL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.centerY.equalTo(onelab.mas_centerY);
        make.height.offset(34);
    }];
    
    NSString *timeSS = @"00:00:00:00";
    
    if(self.roleOneModel.timeLockEnabled) {
        
        if(self.roleOneModel.timeLockReleaseSeconds >= 0) {
            self.roleOneModeltwo = self.roleOneModel;
            self.secdNum = 0;
            
            timeSS = [HistoryRecordModel secondDayToHourMinutesSecond:self.roleOneModel.timeLockReleaseSeconds];
            
            if (messsageTimer == nil) {
                messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
            }
        }
    }
    
    UIView *heaVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 208)];
    heaVV.backgroundColor = UIColor.clearColor;
    
    
    self.timeBtn = [HistoryRecordModel createImgBtn];
    self.timeBtn.frame = CGRectMake((_window_width-188)/2, 0, 188, 188);
    [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"role_imgs13"] forState:UIControlStateNormal];
    [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"role_imgs13_13"] forState:UIControlStateSelected];
    [self.timeBtn setTitle:timeSS forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font = SYS_Font(24); //34
    [heaVV addSubview:self.timeBtn];
    
    if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
        heaVV.frame = CGRectMake(0, 0, _window_width, 208+66);
        
        self.timeBtn2 = [HistoryRecordModel createImgBtn];
//        [self.timeBtn2 setTitle:eLocalizedString(@"two_nams27") forState:UIControlStateNormal];
//        [self.timeBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        self.timeBtn2.titleLabel.font = SYS_Font(16);
        [self.timeBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        [self.timeBtn2 addTarget:self action:@selector(stopTimeBtnMethodTwoNew) forControlEvents:UIControlEventTouchUpInside];
        [heaVV addSubview:self.timeBtn2];
        [self.timeBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeBtn.mas_bottom).offset(30);
            make.centerX.equalTo(self.timeBtn.mas_centerX);
            make.height.offset(36);
            make.width.mas_greaterThanOrEqualTo(100);
        }];
        UILabel *tz_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        tz_lab.text = eLocalizedString(@"two_nams27");
        [self.timeBtn2 addSubview:tz_lab];
        [tz_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeBtn2.mas_left).offset(12);
            make.top.bottom.equalTo(self.timeBtn2);
            make.right.equalTo(self.timeBtn2.mas_right).offset(-12);
        }];
        
        self.timeBtn2.hidden = YES;
    }
    
    
    CGFloat hh_hh = CGRectGetMaxY(onelab.frame)+13;//CGRectGetMaxY(self.timeBtn.frame)+30;
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, hh_hh, _window_width, _window_height-280-54-hh_hh-TARBARHEIGHT-30) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHRoleOneOneCell class] forCellReuseIdentifier:@"MHRoleOneOneCell"];
    [self.appTableView registerClass:[MHRoleOneOneSubCell class] forCellReuseIdentifier:@"MHRoleOneOneSubCell"];
    [self.view addSubview:_appTableView];
    _appTableView.tableHeaderView = heaVV;
    
    self.chatBtn = [HistoryRecordModel createImgBtn];
    self.chatBtn.frame = CGRectMake((_window_width-210)/2, _window_height-280-54-TARBARHEIGHT-30+20, 210, 46);
    [self.chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [self.chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
    [self.chatBtn setTitle:eLocalizedString(@"role_name21") forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.chatBtn.titleLabel.font = SYS_Font(14);
//    [self.chatBtn setImage:[UIImage imageNamed:@"msg_ImImg"] forState:UIControlStateNormal];
//    self.chatBtn.imageEdgeInsets = UIEdgeInsetsMake(14, 70, 16, 124);
//    self.chatBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 96, 0, 10);
//    self.chatBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [self.chatBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chatBtn];
    self.chatBtn.hidden = YES;
    
    self.chatBtn2 = [HistoryRecordModel createImgBtn];
    self.chatBtn2.frame = CGRectMake(_window_width/2+15, _window_height-280-54-TARBARHEIGHT-30+20, 122, 36);
    [self.chatBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [self.chatBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
    [self.chatBtn2 setTitle:eLocalizedString(@"role_setting51") forState:UIControlStateNormal];
    [self.chatBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.chatBtn2.titleLabel.font = SYS_Font(14);
    [self.chatBtn2 addTarget:self action:@selector(chatRemarkBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chatBtn2];
    self.chatBtn2.hidden = YES;
    
    if(self.roleOneModel.matchingCompleted) {
        self.chatBtn.hidden = NO;
//        self.chatBtn.selected = self.isBMMM;
        
        if(self.roleOneModel.hardcoreModeEnabled) {
            self.chatBtn.frame = CGRectMake(_window_width/2-122-15, _window_height-280-54-TARBARHEIGHT-30+20, 122, 36);
            self.chatBtn2.hidden = NO;
//            self.chatBtn2.selected = self.isBMMM;
        }
    }else {
        _appTableView.frame = CGRectMake(0, hh_hh, _window_width, _window_height-280-54-hh_hh);
    }
    
    self.arrMuut = [NSMutableArray array];
    self.oneArr = @[@{@"img":@"role_imgs14", @"name":eLocalizedString(@"role_name17")}, @{@"img":@"role_imgs15", @"name":eLocalizedString(@"role_name18")}, @{@"img":@"role_imgs16", @"name":eLocalizedString(@"role_name19")}];
//    if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
//        if(self.isBMMM) {
//            self.oneArr = @[@{@"img":@"role_imgs14_14", @"name":eLocalizedString(@"role_name17")}, @{@"img":@"role_imgs15_15", @"name":eLocalizedString(@"role_name18")}, @{@"img":@"role_imgs16_16", @"name":eLocalizedString(@"role_name19")}];
//        }
//    }
//    self.timeBtn.selected = self.isBMMM;
    
    [self requestVoucherListMehtod:NO];
    [self.appTableView reloadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadEnterForwodMethod) name:kNeedEnterForegroundNote object:nil];
    
}

//MARK: 停止定时
- (void)stopTimeBtnMethodTwoNew
{
//    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
//    if(!isEEEqq) {
//        if(!self.isConnDevic) {
//            if(self.twoBBlock_) {
//                self.twoBBlock_();
//            }
//            return;
//        }
//    }
    
    if (self.stopBBlock_) {
        self.stopBBlock_();
    }
}


- (void)uploadEnterForwodMethod
{
    [self requestVoucherListMehtod:YES];
}

- (void)uploadUIUIUI
{
    if(self.roleOneModel.matchingCompleted) {
        self.chatBtn.hidden = NO;
//        self.chatBtn.selected = self.isBMMM;
        
        if(self.roleOneModel.hardcoreModeEnabled) {
            self.chatBtn.frame = CGRectMake(_window_width/2-122-15, _window_height-280-54-TARBARHEIGHT-30+20, 122, 36);
            self.chatBtn2.hidden = NO;
//            self.chatBtn2.selected = self.isBMMM;
        }
    }
//    if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
//        if(self.isBMMM) {
//            self.oneArr = @[@{@"img":@"role_imgs14_14", @"name":eLocalizedString(@"role_name17")}, @{@"img":@"role_imgs15_15", @"name":eLocalizedString(@"role_name18")}, @{@"img":@"role_imgs16_16", @"name":eLocalizedString(@"role_name19")}];
//        }
//    }
//    self.timeBtn.selected = self.isBMMM;
    self.rigLLL.text = self.roleOneModel.timeLockEnabled ? eLocalizedString(@"role_name16_16"):eLocalizedString(@"role_name16");
    [self requestVoucherListMehtod:YES];
//    [self.appTableView reloadData];
}

- (void)requestVoucherListMehtod:(BOOL)isRRRR
{
    NSLog(@"-测试发现234--%@", minIntStr(self.roleOneModel.id));
    [requestToolClass getNetworkWithUrl:request_device_getTimeVoucherList andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.arrMuut removeAllObjects];
        for (NSDictionary *dicTT in info) {
            [self.arrMuut addObject:@{@"time":minStr(dicTT[@"duration"]), @"id":minStr(dicTT[@"id"])}];
        }
        [self.appTableView reloadData];
        
        if(isRRRR) {
            
            [self requestDeviceDetailMethod];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)requestDeviceDetailMethod
{
    if (self.isRequestBoo) {
        return;
    }
    self.isRequestBoo = YES;
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%d", request_device_detail, self.roleOneModel.id];
    NSLog(@"-测试发现345--%@", url_dev);
    [requestToolClass getNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.isRequestBoo = NO;
        NSDictionary *infDic = info;
        self.roleOneModel = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        self.roleOneModeltwo = [MHRoleOneModel mj_objectWithKeyValues:infDic];
        
        if(self.roleOneModel.matchingCompleted) {
            self.chatBtn.hidden = NO;
//            self.chatBtn.selected = self.isBMMM;
            
            if(self.roleOneModel.hardcoreModeEnabled) {
                self.chatBtn.frame = CGRectMake(_window_width/2-122-15, _window_height-280-54-TARBARHEIGHT-30+20, 122, 36);
                self.chatBtn2.hidden = NO;
//                self.chatBtn2.selected = self.isBMMM;
            }else {
                self.chatBtn.frame = CGRectMake((_window_width-210)/2, _window_height-280-54-TARBARHEIGHT-30+20, 210, 46);
                self.chatBtn2.hidden = YES;
//                self.chatBtn2.selected = self.isBMMM;
            }
        }else {
            self.chatBtn.hidden = YES;
            self.chatBtn2.hidden = YES;
        }
        self.secdNum = 0;
        if(self.roleOneModeltwo.timeLockEnabled) {
            
            if (self->messsageTimer == nil) {
                self->messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
            }
            
            self.timeBtn2.hidden = NO;
        }else {
            self.rigLLL.text = eLocalizedString(@"role_name16");
            [self->messsageTimer invalidate];
            self->messsageTimer = nil;
            [self.timeBtn setTitle:@"00:00:00:00" forState:UIControlStateNormal];
            self.timeBtn2.hidden = YES;
        }
    } fail:^(NSString * _Nonnull msg) {
        self.isRequestBoo = NO;
    }];
}

- (void)daojishi
{
    self.secdNum = self.secdNum+1;
    if(self.roleOneModeltwo.timeLockReleaseSeconds > self.secdNum) {
        
        self.timeBtn2.hidden = NO;
        self.rigLLL.text = eLocalizedString(@"role_name16_16");
        NSString *timeSS = [HistoryRecordModel secondDayToHourMinutesSecond:self.roleOneModeltwo.timeLockReleaseSeconds-self.secdNum];
        [self.timeBtn setTitle:timeSS forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadRoleTimelock" object:@"1"];
    }else {

        [self.timeBtn setTitle:@"00:00:00:00" forState:UIControlStateNormal];
        self.rigLLL.text = eLocalizedString(@"role_name16");
        if(self.roleOneModeltwo.timeLockReleaseSeconds == self.secdNum) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadRoleTimelock" object:@"0"];
        }
        self.timeBtn2.hidden = YES;
    }
}

//MARK: 私聊
- (void)chatBtnMethod
{
    if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
        if(self.isBMMM) {
            MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.tabBarController.view addSubview:vc];
            return;
        }
    }
    
    if([self.roleOneModel.master isEqualToString:[LYUserDefault userDefault].t_id]) {
        [[FloatingWindowModel shareInstance] switchChatDetailControlNick:self.roleOneModel.servantNickName hostId:self.roleOneModel.servant];
    }else {
        [[FloatingWindowModel shareInstance] switchChatDetailControlNick:self.roleOneModel.masterNickName hostId:self.roleOneModel.master];
    }
}

//MARK: 解除硬核模式
- (void)chatRemarkBtnMethod
{
//    if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
//        if(self.isBMMM) {
//            MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//            [self.tabBarController.view addSubview:vc];
//            return;
//        }
//    }
    
    MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.selfUpVC.view addSubview:vc];
    [vc addUIUIUIUMethodType:6];
    vc.block_ = ^(NSArray * _Nonnull arrList) {
        
        [self recordingVoiceMethod];
    };
}

//MARK: 录音认证
- (void)recordingVoiceMethod
{
    MHRecordingAuthenticationController *vc = [[MHRecordingAuthenticationController alloc] init];
    vc.roleOneModel = self.roleOneModel;
    vc.isRecivBoo = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^{
        
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return self.oneArr.count;
    }else {
        return self.arrMuut.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        MHRoleOneOneCell *cell = [MHRoleOneOneCell cellWithTabelView:tableView];
        [cell addModelToDataModel:self.oneArr[indexPath.row] choseName:1];
//        if(self.isBMMM) {
//            cell.placVV.backgroundColor = RGBA(169, 169, 169, 0.5);
//            cell.nexImgv.image = [UIImage imageNamed:@"home_next2_22"];
//        }else {
            cell.placVV.backgroundColor = RGBA(176, 51, 228, 0.5);
            cell.nexImgv.image = [UIImage imageNamed:@"home_next2"];
//        }
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MHRoleOneOneSubCell *cell = [MHRoleOneOneSubCell cellWithTabelView:tableView];
        cell.rowMML = indexPath.row;
        [cell addModelToDataModel:self.arrMuut[indexPath.row] choseName:1];
//        if(self.isBMMM) {
//            cell.placVV.backgroundColor = RGBA(169, 169, 169, 0.5);
//        }else {
            cell.placVV.backgroundColor = RGBA(176, 51, 228, 0.5);
//        }
        cell.delegate_ = self;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)roleOneModesDelegateRow:(NSInteger)rowlL
{
    [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"homeMsg_delete") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
        if (index == 1) {
            NSDictionary *dicDic = self.arrMuut[rowlL];
            [SVProgressHUD show];
            [requestToolClass getNetworkWithUrl:request_device_deleteTimeVoucher andParameter:@{@"timeVoucherId":minStr(dicDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                [self requestVoucherListMehtod:YES];
            } fail:^(NSString * _Nonnull msg) {

            }];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(!isEEEqq) {
        if(!self.isConnDevic) {
            if(self.twoBBlock_) {
                self.twoBBlock_();
            }
            return;
        }
    }
    
    if(![self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        if(self.roleOneModel.hardcoreModeEnabled) {
            
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_10")];
            return;
        }
    }
   
    if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
        if(self.isBMMM) {
            MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.tabBarController.view addSubview:vc];
            return;
        }
    }

    if(indexPath.section == 0) {
//        if(self.roleOneModel.matchingCompleted) {
        if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
            //微智贞操锁、钥匙盒
            if(self.roleOneModel.locationLockEnabled) {
                
                if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
                    
                    double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];

                    if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {

                        //是否可以操控
                        if(self.roleOneModel.timeVoucherList.count < 2) {
                            MHRoleSettingController *vc = [[MHRoleSettingController alloc] init];
                            vc.numTpy = (int)indexPath.row;
                            vc.devicTyp = self.devicTyp;
                            vc.devicId = self.devicId;
                            vc.selfUpVC = self.selfUpVC;
                            [self.navigationController pushViewController:vc animated:YES];
                            vc.block_ = ^(BOOL isboo) {
                                
                                if(isboo) {
                                    if(self.block_) {
                                        self.block_();
                                    }
                                    [self requestDeviceDetailMethod];
                                }else {
                                    [self requestVoucherListMehtod:YES];
                                }
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err8")];
                                });
                                
                            };
                        }else {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting56")];
                        }
                    }else {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
                    }
                }else {
                    if(self.roleOneModel.timeVoucherList.count < 2) {
                        MHRoleSettingController *vc = [[MHRoleSettingController alloc] init];
                        vc.numTpy = (int)indexPath.row;
                        vc.devicTyp = self.devicTyp;
                        vc.devicId = self.devicId;
                        vc.selfUpVC = self.selfUpVC;
                        [self.navigationController pushViewController:vc animated:YES];
                        vc.block_ = ^(BOOL isboo) {
                            
                            if(isboo) {
                                if(self.block_) {
                                    self.block_();
                                }
                                [self requestDeviceDetailMethod];
                            }else {
                                [self requestVoucherListMehtod:YES];
                            }
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err8")];
                            });
                        };
                    }else {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting56")];
                    }
                }
            }else {
                if(self.roleOneModel.timeVoucherList.count < 2) {
                    MHRoleSettingController *vc = [[MHRoleSettingController alloc] init];
                    vc.numTpy = (int)indexPath.row;
                    vc.devicTyp = self.devicTyp;
                    vc.devicId = self.devicId;
                    vc.selfUpVC = self.selfUpVC;
                    [self.navigationController pushViewController:vc animated:YES];
                    vc.block_ = ^(BOOL isboo) {
                        
                        if(isboo) {
                            if(self.block_) {
                                self.block_();
                            }
                            [self requestDeviceDetailMethod];
                        }else {
                            [self requestVoucherListMehtod:YES];
                        }
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err8")];
                        });
                    };
                }else {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting56")];
                }
            }
        }else {
            if(self.roleOneModel.timeVoucherList.count < 2) {
                MHRoleSettingController *vc = [[MHRoleSettingController alloc] init];
                vc.numTpy = (int)indexPath.row;
                vc.devicTyp = self.devicTyp;
                vc.devicId = self.devicId;
                vc.selfUpVC = self.selfUpVC;
                [self.navigationController pushViewController:vc animated:YES];
                vc.block_ = ^(BOOL isboo) {
                    
                    if(isboo) {
                        if(self.block_) {
                            self.block_();
                        }
                        [self requestDeviceDetailMethod];
                    }else {
                        [self requestVoucherListMehtod:YES];
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.stopBXBBlock_) {
                            self.stopBXBBlock_();
                        }
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err8")];
                    });
                };
            }else {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting56")];
            }
        }
    }else {
        if (![[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyp]) {
            if(self.roleOneModel.locationLockEnabled) {
                
                if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
                    
                    double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];
                    
                    if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
                        
                        //是否可以操控
                        NSDictionary *dicDic = self.arrMuut[indexPath.row];
                        
                        //                    self.roleOneModel.timeLockEnabled
                        
                        [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"role_setting49") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                            if (index == 1) {
                                [SVProgressHUD show];
                                [requestToolClass getNOMsgNetworkWithUrl:request_device_useTimeVoucher andParameter:@{@"timeVoucherId":minStr(dicDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                    if(self.block_) {
                                        self.block_();
                                    }
                                    [self requestVoucherListMehtod:YES];
                                } fail:^(NSString * _Nonnull msg) {
                                    
                                }];
                            }
                        }];
                    }else {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
                    }
                }else {
                    NSDictionary *dicDic = self.arrMuut[indexPath.row];
                    [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"role_setting49") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                        if (index == 1) {
                            [SVProgressHUD show];
                            [requestToolClass getNOMsgNetworkWithUrl:request_device_useTimeVoucher andParameter:@{@"timeVoucherId":minStr(dicDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    if(self.block_) {
                                        self.block_();
                                    }
                                    [self requestVoucherListMehtod:YES];
                                });
                            } fail:^(NSString * _Nonnull msg) {
                                
                            }];
                        }
                    }];
                }
            }else {
                
                NSDictionary *dicDic = self.arrMuut[indexPath.row];
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"role_setting49") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        [SVProgressHUD show];
                        [requestToolClass getNOMsgNetworkWithUrl:request_device_useTimeVoucher andParameter:@{@"timeVoucherId":minStr(dicDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                if(self.block_) {
                                    self.block_();
                                }
                                [self requestVoucherListMehtod:YES];
                            });
                        } fail:^(NSString * _Nonnull msg) {
                            
                        }];
                    }
                }];
            }
        }else {
            NSDictionary *dicDic = self.arrMuut[indexPath.row];
            [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"role_setting49") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                if (index == 1) {
                    [SVProgressHUD show];
                    [requestToolClass getNOMsgNetworkWithUrl:request_device_useTimeVoucher andParameter:@{@"timeVoucherId":minStr(dicDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            if(self.block_) {
                                self.block_();
                            }
                            if (self.stopBXBBlock_) {
                                self.stopBXBBlock_();
                            }
                            [self requestVoucherListMehtod:YES];
                        });
                        
                    } fail:^(NSString * _Nonnull msg) {
                        
                    }];
                }
            }];
        }
    }
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(indexPath.section == 1) {
//        return YES;
//    }else {
//        return NO;
//    }
//}
//
//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(indexPath.section == 1) {
//        
//        UIContextualAction *delelMMRow = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:eLocalizedString(@"home_delete") handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//            
//            [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"homeMsg_delete") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
//                if (index == 1) {
//                    NSDictionary *dicDic = self.arrMuut[indexPath.row];
//                    [SVProgressHUD show];
//                    [requestToolClass getNetworkWithUrl:request_device_deleteTimeVoucher andParameter:@{@"timeVoucherId":minStr(dicDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                        if(self.block_) {
//                            self.block_();
//                        }
//                        [self requestVoucherListMehtod:YES];
//                    } fail:^(NSString * _Nonnull msg) {
//                        
//                    }];
//                }
//            }];
//        }];
//        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[delelMMRow]];
//        config.performsFirstActionWithFullSwipe = NO;
//        return config;
//    }else {
//        return nil;
//    }
//}

@end
