//
//  MHRoleOneTwoController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "MHRoleOneTwoController.h"
#import "sliderVVView.h"
#import "MHRoleTwoTimingClickController.h"
#import "MHRoleOneTwoModel.h"
#import "MHLimitsAuthorityView.h"
#import "drawLVVVV.h"

@interface MHRoleOneTwoController ()<TPVerticalVideoSliderViewDelegate>
{
    NSTimer *messsageTimer;
}
@property (nonatomic, strong) UIScrollView *scrollVV;
@property (nonatomic, strong) UIScrollView *scrollVVsub;
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) UIView *twoVV;
@property (nonatomic, strong) UIView *thrVV;
@property (nonatomic, strong) UIView *fouVV;
@property (nonatomic, strong) sliderVVView *twoScrollV;
@property (nonatomic, strong) drawLVVVV *showColoUIUIUIV;
@property (nonatomic, assign) int addTimeNu;
@property (nonatomic, assign) int gameType;
@property (nonatomic, copy) NSString *isLongBoo;
@property (nonatomic, strong) NSMutableArray *djLisAr;
@property (nonatomic, assign) BOOL isStartDJ;
@property (nonatomic, strong) NSMutableArray *ar_mut;
@property (nonatomic, strong) UIButton *chatBtn;
@property (nonatomic, assign) float x_wwid;
@property (nonatomic, assign) BOOL isRRRRR;
@end

@implementation MHRoleOneTwoController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSArray *viewCtrolsArr = self.navigationController.viewControllers;
    if ([viewCtrolsArr indexOfObject:self] == NSNotFound) {
        [messsageTimer invalidate];
        messsageTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.ar_mut = [NSMutableArray array];

    self.gameType = 1;
    self.isLongBoo = @"false";
    _scrollVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-280-54-TARBARHEIGHT+49)];
    _scrollVV.backgroundColor = UIColor.clearColor;
    _scrollVV.showsVerticalScrollIndicator = NO;
    _scrollVV.showsHorizontalScrollIndicator = NO;
    _scrollVV.bounces = NO;
    [self.view addSubview:_scrollVV];
    
    self.djLisAr = [NSMutableArray array];
    //添加电击
    self.oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
    self.oneVV.backgroundColor = UIColor.clearColor;
    [self.scrollVV addSubview:self.oneVV];
    
//    UIButton *addElecBtn = [HistoryRecordModel createImgBtn];
//    addElecBtn.frame = CGRectMake(12, 10, _window_width-24, 36);
//    [addElecBtn setBackgroundImage:[UIImage imageNamed:@"role_imgs21"] forState:UIControlStateNormal];
//    [addElecBtn setTitle:eLocalizedString(@"role_name39") forState:UIControlStateNormal];
//    [addElecBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    addElecBtn.titleLabel.font = SYS_Font(14);
//    [addElecBtn addTarget:self action:@selector(addElectBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//    [self.oneVV addSubview:addElecBtn];
    
    //第二部分
    self.twoVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneVV.frame), _window_width, 46)];
    self.twoVV.backgroundColor = UIColor.clearColor;
    [self.scrollVV addSubview:self.twoVV];
    
    UILabel *two_llab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    two_llab.frame = CGRectMake(20, 9, 160, 34);
    two_llab.text = eLocalizedString(@"role_name42");
    [self.twoVV addSubview:two_llab];
    
    UIButton *swithbtn = [HistoryRecordModel createImgBtn];
    [swithbtn setBackgroundImage:[UIImage imageNamed:@"switch_norlImg"] forState:UIControlStateNormal];
    [swithbtn setBackgroundImage:[UIImage imageNamed:@"switch_selImg"] forState:UIControlStateSelected];
    [swithbtn addTarget:self action:@selector(switBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoVV addSubview:swithbtn];
    [swithbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.twoVV.mas_right).offset(-12);
        make.centerY.equalTo(two_llab.mas_centerY);
        make.height.offset(20);
        make.width.offset(40);
    }];
    
    NSArray *namsAr = @[@"role_name43", @"role_name44", @"role_name45"];
    NSArray *imgsAr = @[@"role_electImgs1", @"role_electImgs2", @"role_electImgs3"];
    CGFloat w_xx = (_window_width-88*3)/3;
    for (int i=0; i<namsAr.count; i++) {
        
        UIButton *thrBtnBB = [[UIButton alloc] initWithFrame:CGRectMake(w_xx/2 + i*(w_xx+88), CGRectGetMaxY(two_llab.frame)+20, 88, 64)];
        [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgNor"] forState:UIControlStateNormal];
        [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgSel"] forState:UIControlStateSelected];
        [thrBtnBB setTitle:eLocalizedString(namsAr[i]) forState:UIControlStateNormal];
        [thrBtnBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [thrBtnBB setImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
        thrBtnBB.imageEdgeInsets = UIEdgeInsetsMake(12, 11, 30, 11);
        [thrBtnBB layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleTop imageTitleSpace:4];
//        thrBtnBB.titleEdgeInsets = UIEdgeInsetsMake(34, 0, 4, 0);
        thrBtnBB.titleLabel.font = SYS_Font(14);
        thrBtnBB.tag = 9200+i;
        [thrBtnBB addTarget:self action:@selector(thrBtnMethodS:) forControlEvents:UIControlEventTouchUpInside];
        [self.twoVV addSubview:thrBtnBB];
        if(i==0) {
            thrBtnBB.selected = YES;
        }
    }
    
    self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(two_llab.frame)+125, _window_width-92, 24)];
    self.twoScrollV.delegate = self;
    self.twoScrollV.miniMumTIMg = @"role_imgs17";
    self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
    self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
    self.twoScrollV.value = 0.0;
    self.twoScrollV.bufferValue = 0.3;
    self.twoScrollV.sliderHeight = 12;
    self.twoScrollV.allowTapped = YES;
    self.twoScrollV.slidIMg = @"equipmentImgs3";
    self.twoScrollV.thumbSize = CGSizeMake(16, 16);
    [self.twoVV addSubview:self.twoScrollV];
    
    for (int i=0; i<2; i++) {
        UIImageView *imgElec = [HistoryRecordModel createImgImgView];
        [self.twoVV addSubview:imgElec];
        if(i==0) {
            imgElec.frame = CGRectMake(17, CGRectGetMaxY(two_llab.frame)+120, 17, 24);
            imgElec.image = [UIImage imageNamed:@"role_imgs19"];
        }else {
            imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(two_llab.frame)+120, 17, 24);
            imgElec.image = [UIImage imageNamed:@"role_imgs20"];
        }
    }
    
    _chatBtn = [HistoryRecordModel createImgBtn];
    _chatBtn.frame = CGRectMake((_window_width-200)/2, CGRectGetMaxY(self.twoScrollV.frame)+40, 200, 38);
    [_chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [_chatBtn setTitle:eLocalizedString(@"role_name46") forState:UIControlStateNormal];
    [_chatBtn setTitle:eLocalizedString(@"role_name46_46") forState:UIControlStateSelected];
    [_chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _chatBtn.titleLabel.font = SYS_Font(14);
    [_chatBtn addTarget:self action:@selector(startElectMethodUIUIUIU:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoVV addSubview:_chatBtn];
    
    self.twoVV.frame = CGRectMake(0, CGRectGetMaxY(self.oneVV.frame), _window_width, CGRectGetMaxY(_chatBtn.frame)+20);
    
    //曲线
    self.thrVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoVV.frame)+5, _window_width, 156+18)];
    self.thrVV.backgroundColor = UIColor.clearColor;
    [self.scrollVV addSubview:self.thrVV];
    
    self.scrollVVsub = [[UIScrollView alloc] initWithFrame:CGRectMake(47, 10, _window_width-67, 156)];
    self.scrollVVsub.showsVerticalScrollIndicator = NO;
    self.scrollVVsub.showsHorizontalScrollIndicator = NO;
    self.scrollVVsub.bounces = NO;
    [self.thrVV addSubview:self.scrollVVsub];
    
    self.x_wwid = 50;
    self.showColoUIUIUIV = [[drawLVVVV alloc] initWithFrame:CGRectMake(0, 0, _window_width-67, 156)];
    self.showColoUIUIUIV.lineColor = UIColor.whiteColor;
    self.showColoUIUIUIV.backgroundColor = UIColor.clearColor;
    [self.scrollVVsub addSubview:self.showColoUIUIUIV];
    
    NSArray *numAr = @[@"1.2", @"1.0", @"0.8", @"0.6", @"0.4", @"0.2", @"0"];
    for (int i=0; i<numAr.count; i++) {
        UILabel *lefSubLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
        lefSubLab.frame = CGRectMake(0, i*24, 46, 24);
        lefSubLab.text = numAr[i];
        [self.thrVV addSubview:lefSubLab];
    }
    
    self.fouVV = [[UIView alloc] initWithFrame:CGRectMake(46, 156+10, _window_width-66, 8)];
    self.fouVV.backgroundColor = UIColor.clearColor;
    [self.thrVV addSubview:self.fouVV];
    
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    linVV.backgroundColor = UIColor.whiteColor;
    [self.fouVV addSubview:linVV];
    [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.fouVV);
        make.height.offset(1);
    }];
    
    int w_num = (_window_width-66)/self.x_wwid;
    for (int i=0; i<w_num; i++) {
        UIView *linF = [[UIView alloc] initWithFrame:CGRectMake(i*self.x_wwid, 1, 1, 7)];
        linF.backgroundColor = UIColor.whiteColor;
        [self.fouVV addSubview:linF];
    }
    
//    self.thrVV.frame = CGRectMake(0, CGRectGetMaxY(self.twoVV.frame)+5, _window_width, self.showColoUIUIUIV.height+10);
    self.scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thrVV.frame)+60);
    
    [self requestUIUIMethod];
}

//MARK:  更新
- (void)uploadUIUIUI
{
    if(self.isBMMM) {
        [_chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateNormal];
        _chatBtn.userInteractionEnabled = NO;
    }else {
        [_chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        _chatBtn.userInteractionEnabled = YES;
    }
}

- (void)requestUIUIMethod
{
    NSString *url_dev = [NSString stringWithFormat:@"%@?deviceId=%@", request_device_getScheduledElectricShockList, self.devicId];
    [requestToolClass getNOMsgNetworkWithUrl:url_dev andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSArray *ddM = info;
        self.addTimeNu = 0;
        [self.oneVV removeAllSubviews];
        self.oneVV.frame = CGRectMake(0, 0, _window_width, 46+ddM.count*64);
        
        [self.djLisAr removeAllObjects];
        for (int i=0; i<ddM.count; i++) {
            
            MHRoleOneTwoModel *model = [MHRoleOneTwoModel mj_objectWithKeyValues:ddM[i]];
            [self.djLisAr addObject:model];
            if(i+1 == ddM.count) {
                [self createUIUIUIU:model isShow:NO frameL:CGRectMake(0, i*64, _window_width, 64) tag:i+880];
            }else {
                [self createUIUIUIU:model isShow:YES frameL:CGRectMake(0, i*64, _window_width, 64) tag:i+880];
            }
        }
        
//        UIButton *addElecBtn = [HistoryRecordModel createImgBtn];
//        addElecBtn.frame = CGRectMake(12, 10+ddM.count*64, _window_width-24, 36);
//        [addElecBtn setBackgroundImage:[UIImage imageNamed:@"role_imgs21"] forState:UIControlStateNormal];
//        [addElecBtn setTitle:eLocalizedString(@"role_name39") forState:UIControlStateNormal];
//        [addElecBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        addElecBtn.titleLabel.font = SYS_Font(14);
//        addElecBtn.layer.cornerRadius = 4;
//        [addElecBtn addTarget:self action:@selector(addElectBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//        [self.oneVV addSubview:addElecBtn];
        
        self.twoVV.frame = CGRectMake(0, CGRectGetMaxY(self.oneVV.frame), _window_width, self.twoVV.height);
//        self.thrVV.frame = CGRectMake(0, CGRectGetMaxY(self.twoVV.frame)+5, _window_width, self.showColoUIUIUIV.height+10);
        self.thrVV.frame = CGRectMake(0, CGRectGetMaxY(self.twoVV.frame)+5, _window_width, 156+18);
        self.scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thrVV.frame)+60);
        
        if (self->messsageTimer == nil) {
            self->messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)daojishi
{
    self.addTimeNu = self.addTimeNu+1;
    for (int i=0; i<self.djLisAr.count; i++) {
        
        MHRoleOneTwoModel *model = self.djLisAr[i];
        UILabel *timeMML = [self.oneVV viewWithTag:880+i];
        if(!model.isDeleteBoo) {
            if(model.countdownSeconds > self.addTimeNu) {
                model.isDeleteBoo = NO;
                timeMML.text = [HistoryRecordModel secondDayToHourMinutesSecondTwo:model.countdownSeconds-self.addTimeNu];
            }else {
                model.isDeleteBoo = YES;
                timeMML.text = [HistoryRecordModel secondDayToHourMinutesSecondTwo:0];
                
                //MARK: 定时电击
                [self requestUIUIMethod];
            }
        }
    }
    
    if([self.isLongBoo isEqualToString:@"true"] && self.isStartDJ) {
        
        [self.ar_mut addObject:[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]];
        if(self.ar_mut.count*self.x_wwid < (_window_width-66)) {
            self.scrollVVsub.contentSize = CGSizeMake(_window_width-67, 156);
            self.showColoUIUIUIV.frame = CGRectMake(0, 0, _window_width-67, 156);
        }else {
            self.scrollVVsub.contentSize = CGSizeMake(self.ar_mut.count*self.x_wwid, 156);
            self.showColoUIUIUIV.frame = CGRectMake(0, 0, self.ar_mut.count*self.x_wwid, 156);
        }
        [self.showColoUIUIUIV addDataToArr:@[[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]]];
        if(self.ar_mut.count*self.x_wwid > (_window_width-66)) {
            self.scrollVVsub.contentOffset = CGPointMake(self.ar_mut.count*self.x_wwid-(_window_width-66), 0);
        }
    }
    
}

- (void)sliderTouchEnded:(float)value
{
    if([self.isLongBoo isEqualToString:@"true"] && self.isStartDJ) {
        
        [self.ar_mut addObject:[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]];
        if(self.ar_mut.count*self.x_wwid < (_window_width-66)) {
            self.scrollVVsub.contentSize = CGSizeMake(_window_width-67, 156);
            self.showColoUIUIUIV.frame = CGRectMake(0, 0, _window_width-67, 156);
        }else {
            self.scrollVVsub.contentSize = CGSizeMake(self.ar_mut.count*self.x_wwid, 156);
            self.showColoUIUIUIV.frame = CGRectMake(0, 0, self.ar_mut.count*self.x_wwid, 156);
        }
        [self.showColoUIUIUIV addDataToArr:@[[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]]];
        if(self.ar_mut.count*self.x_wwid > (_window_width-66)) {
            self.scrollVVsub.contentOffset = CGPointMake(self.ar_mut.count*self.x_wwid-(_window_width-67), 0);
        }
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":self.isLongBoo, @"frequency":minIntStr(self.gameType), @"voltage":[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]}];
    }
}

//MARK: 开始电击
- (void)startElectMethodUIUIUIU:(UIButton *)btn
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"2", @"strong":self.isLongBoo, @"strong2":minIntStr(self.gameType), @"strong3":[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]}];
 
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(!isEEEqq) {
        if(!self.isConnDevic) {
            if(self.twoBBlock_) {
                self.twoBBlock_();
            }
            return;
        }
    }
    
    if(self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    if(self.roleOneModel.locationLockEnabled) {
        
        if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
            
            double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];

            if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {

                //是否可以操控
                btn.selected = !btn.selected;
                self.isStartDJ = btn.selected;
                if(self.isStartDJ) {
                    [self.ar_mut addObject:[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]];
                    if(self.ar_mut.count*self.x_wwid < (_window_width-66)) {
                        self.scrollVVsub.contentSize = CGSizeMake(_window_width-67, 156);
                        self.showColoUIUIUIV.frame = CGRectMake(0, 0, _window_width-67, 156);
                    }else {
                        self.scrollVVsub.contentSize = CGSizeMake(self.ar_mut.count*self.x_wwid, 156);
                        self.showColoUIUIUIV.frame = CGRectMake(0, 0, self.ar_mut.count*self.x_wwid, 156);
                    }
                    [self.showColoUIUIUIV addDataToArr:@[[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]]];
                    if(self.ar_mut.count*self.x_wwid > (_window_width-66)) {
                        self.scrollVVsub.contentOffset = CGPointMake(self.ar_mut.count*self.x_wwid-(_window_width-67), 0);
                    }
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":self.isLongBoo, @"frequency":minIntStr(self.gameType), @"voltage":[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]}];
                }else {
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":minIntStr(self.gameType), @"voltage":@"0"}];
                }
                
                if([self.isLongBoo isEqualToString:@"true"]) {
                    self.isStartDJ = btn.selected;
                }else {
                    btn.selected = NO;
                    self.isStartDJ = NO;
                }
            }else {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
            }
        }else {
            btn.selected = !btn.selected;
            self.isStartDJ = btn.selected;
            if(self.isStartDJ) {
                [self.ar_mut addObject:[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]];
                if(self.ar_mut.count*self.x_wwid < (_window_width-66)) {
                    self.scrollVVsub.contentSize = CGSizeMake(_window_width-67, 156);
                    self.showColoUIUIUIV.frame = CGRectMake(0, 0, _window_width-67, 156);
                }else {
                    self.scrollVVsub.contentSize = CGSizeMake(self.ar_mut.count*self.x_wwid, 156);
                    self.showColoUIUIUIV.frame = CGRectMake(0, 0, self.ar_mut.count*self.x_wwid, 156);
                }
                [self.showColoUIUIUIV addDataToArr:@[[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]]];
                if(self.ar_mut.count*self.x_wwid > (_window_width-66)) {
                    self.scrollVVsub.contentOffset = CGPointMake(self.ar_mut.count*self.x_wwid-(_window_width-67), 0);
                }
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":self.isLongBoo, @"frequency":minIntStr(self.gameType), @"voltage":[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]}];
            }else {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":minIntStr(self.gameType), @"voltage":@"0"}];
            }
            
            if([self.isLongBoo isEqualToString:@"true"]) {
                self.isStartDJ = btn.selected;
            }else {
                btn.selected = NO;
                self.isStartDJ = NO;
            }
        }
    }else {
        
        btn.selected = !btn.selected;
        self.isStartDJ = btn.selected;
        if(self.isStartDJ) {
            [self.ar_mut addObject:[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]];
            if(self.ar_mut.count*self.x_wwid < (_window_width-66)) {
                self.scrollVVsub.contentSize = CGSizeMake(_window_width-67, 156);
                self.showColoUIUIUIV.frame = CGRectMake(0, 0, _window_width-67, 156);
            }else {
                self.scrollVVsub.contentSize = CGSizeMake(self.ar_mut.count*self.x_wwid, 156);
                self.showColoUIUIUIV.frame = CGRectMake(0, 0, self.ar_mut.count*self.x_wwid, 156);
            }
            [self.showColoUIUIUIV addDataToArr:@[[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]]];
            if(self.ar_mut.count*self.x_wwid > (_window_width-66)) {
                self.scrollVVsub.contentOffset = CGPointMake(self.ar_mut.count*self.x_wwid-(_window_width-67), 0);
            }
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":self.isLongBoo, @"frequency":minIntStr(self.gameType), @"voltage":[NSString stringWithFormat:@"%.f", self.twoScrollV.value*100]}];
        }else {
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":minIntStr(self.gameType), @"voltage":@"0"}];
            
        }
        
        if([self.isLongBoo isEqualToString:@"true"]) {
            self.isStartDJ = btn.selected;
        }else {
            btn.selected = NO;
            self.isStartDJ = NO;
        }
    }
}

- (void)thrBtnMethodS:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        UIButton *mmBtn = [self.view viewWithTag:9200+i];
        if(btn == mmBtn) {
            mmBtn.selected = YES;
            self.gameType = i+1;
        }else {
            mmBtn.selected = NO;
        }
    }
}

- (void)addElectBtnMethod
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
    
    if(self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if(self.roleOneModel.locationLockEnabled) {
        if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
            
            double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:[self.roleOneModel.locationSERVANTLatitude doubleValue] Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:[self.roleOneModel.locationSERVANTLongitude doubleValue]];
            
            if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
                
                //是否可以操控
                if(self.djLisAr.count >= 3) {
                    
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting57")];
                    return;
                }
                MHRoleTwoTimingClickController *vc = [[MHRoleTwoTimingClickController alloc] init];
                vc.devicId = self.devicId;
                [self.navigationController pushViewController:vc animated:YES];
                vc.block_ = ^{
                    
                    [self requestUIUIMethod];
                };
            }else {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err5")];
            }
        }else {
            
            if(self.djLisAr.count >= 3) {
                
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting57")];
                return;
            }
            MHRoleTwoTimingClickController *vc = [[MHRoleTwoTimingClickController alloc] init];
            vc.devicId = self.devicId;
            [self.navigationController pushViewController:vc animated:YES];
            vc.block_ = ^{
                
                [self requestUIUIMethod];
            };
        }
    }else {
        if(self.djLisAr.count >= 3) {
            
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting57")];
            return;
        }
        MHRoleTwoTimingClickController *vc = [[MHRoleTwoTimingClickController alloc] init];
        vc.devicId = self.devicId;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^{
            
            [self requestUIUIMethod];
        };
    }
}
//MARK: 长电击模式
- (void)switBtnMethod:(UIButton *)btn
{
    if(!self.isStartDJ) {
        btn.selected = !btn.selected;
        if(btn.selected) {
            self.isLongBoo = @"true";
        }else {
            self.isLongBoo = @"false";
        }
    }
}

//MARK: 删除定时电击
- (void)addDeleBtnMethod:(UIButton *)btn
{
    if(self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    if(self.isRRRRR) {
        return;
    }
    self.isRRRRR = YES;
    
    MHRoleOneTwoModel *model = self.djLisAr[btn.tag-880-2300];
    [SVProgressHUD show];
    [requestToolClass getNOMsgNetworkWithUrl:request_device_deleteScheduledElectricShock andParameter:@{@"recordId":minIntStr(model.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.addTimeNu = 0;
        [self.oneVV removeAllSubviews];
        
        [self.djLisAr removeObjectAtIndex:btn.tag-880-2300];
        
        self.oneVV.frame = CGRectMake(0, 0, _window_width, 46+self.djLisAr.count*64);
        
        for (int i=0; i<self.djLisAr.count; i++) {
            
            MHRoleOneTwoModel *model = self.djLisAr[i];
            if(i+1 == self.djLisAr.count) {
                [self createUIUIUIU:model isShow:NO frameL:CGRectMake(0, i*64, _window_width, 64) tag:i+880];
            }else {
                [self createUIUIUIU:model isShow:YES frameL:CGRectMake(0, i*64, _window_width, 64) tag:i+880];
            }
        }
//        UIButton *addElecBtn = [HistoryRecordModel createImgBtn];
//        addElecBtn.frame = CGRectMake(12, 10+self.djLisAr.count*64, _window_width-24, 36);
//        [addElecBtn setBackgroundImage:[UIImage imageNamed:@"role_imgs21"] forState:UIControlStateNormal];
//        [addElecBtn setTitle:eLocalizedString(@"role_name39") forState:UIControlStateNormal];
//        [addElecBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        addElecBtn.titleLabel.font = SYS_Font(14);
//        addElecBtn.layer.cornerRadius = 4;
//        [addElecBtn addTarget:self action:@selector(addElectBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//        [self.oneVV addSubview:addElecBtn];
        
        self.twoVV.frame = CGRectMake(0, CGRectGetMaxY(self.oneVV.frame), _window_width, self.twoVV.height);
//        self.thrVV.frame = CGRectMake(0, CGRectGetMaxY(self.twoVV.frame)+5, _window_width, self.showColoUIUIUIV.height+10);
        self.thrVV.frame = CGRectMake(0, CGRectGetMaxY(self.twoVV.frame)+5, _window_width, 156+18);
        self.scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thrVV.frame)+60);
        
        self.isRRRRR = NO;
    } fail:^(NSString * _Nonnull msg) {
        self.isRRRRR = NO;
    }];
    
    
}

- (void)createUIUIUIU:(MHRoleOneTwoModel *)model isShow:(BOOL)isSh frameL:(CGRect)frameMM tag:(int)tagLL
{
    UIView *FFVV = [[UIView alloc] initWithFrame:frameMM]; //64
    FFVV.backgroundColor = UIColor.clearColor;
    
    UILabel *timeMML = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timeMML.tag = tagLL;
    timeMML.text = [HistoryRecordModel secondToHourMinutesSecond:model.countdownSeconds];
    [FFVV addSubview:timeMML];
    [timeMML mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FFVV.mas_left).offset(22);
        make.top.equalTo(FFVV.mas_top).offset(9);
        make.height.offset(24);
    }];
    UILabel *timeMML2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timeMML2.text = eLocalizedString(@"role_name40");
    [FFVV addSubview:timeMML2];
    [timeMML2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeMML.mas_right).offset(2);
        make.top.equalTo(FFVV.mas_top).offset(9);
        make.height.offset(24);
    }];
    
    UILabel *timeMML3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    if(model.frequency == 1) {
        timeMML3.text = [NSString stringWithFormat:@"%@ %d%@", eLocalizedString(@"role_name43"), model.duration, @"s"];
    }else if(model.frequency == 2) {
        timeMML3.text = [NSString stringWithFormat:@"%@ %d%@", eLocalizedString(@"role_name44"), model.duration, @"s"];
    }else {
        timeMML3.text = [NSString stringWithFormat:@"%@ %d%@", eLocalizedString(@"role_name45"), model.duration, @"s"];
    }
    [FFVV addSubview:timeMML3];
    [timeMML3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FFVV.mas_left).offset(22);
        make.top.equalTo(timeMML.mas_bottom).offset(1);
        make.height.offset(24);
    }];
    
    UIButton *deleBtn = [HistoryRecordModel createImgBtn];
    [deleBtn setImage:[UIImage imageNamed:@"role_deleteImgs"] forState:UIControlStateNormal];
    deleBtn.tag = tagLL + 2300;
    [deleBtn addTarget:self action:@selector(addDeleBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [FFVV addSubview:deleBtn];
    [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(FFVV.mas_right).offset(-12);
        make.centerY.equalTo(FFVV.mas_centerY);
        make.width.height.offset(36);
    }];
    
    if(isSh) {
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        linVV.frame = CGRectMake(22, FFVV.height-1, FFVV.width-44, 1);
        [FFVV addSubview:linVV];
    }
    
    [self.oneVV addSubview:FFVV];
}

@end
