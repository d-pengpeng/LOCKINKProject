//
//  MHRoleThrSDMSController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/11.
//

#import "MHRoleThrSDMSController.h"
#import "MHCreatePatternVView.h"
#import "MHNewDrawingView.h"
#import "MHManualOperationSubOneView.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHRoleTwoSDDJStartView.h"
#import "MHRoleThrSDMSView.h"
#import "MHLimitsAuthorityView.h"

@interface MHRoleThrSDMSController ()<CreatePatternVVDelegate>
{
    NSTimer *messsageTimer;
}
@property (nonatomic, strong) UILabel *time_Lab;
@property (nonatomic, assign) int time_num;
@property (nonatomic, assign) int time_num2;
@property (nonatomic, assign) BOOL time_Boo;
@property (nonatomic, assign) BOOL xx_Boo; //关闭
@property (nonatomic, assign) BOOL xxx_Boo2;
@property (nonatomic, strong) MHManualOperationSubOneView *MHManualOperationSubOneV;
@property (nonatomic, strong) NSArray *listFeel_arr;
@property (nonatomic, copy) NSString *bxSave_str;

@property (nonatomic, strong) UIView *oneVV;
//@property (nonatomic, strong) MHNewDrawingView *drawVVV;
@property (nonatomic, strong) MHCreatePatternVView *patternVV;

@property (nonatomic, copy) NSString *xz_str; //旋转 左右旋转
@property (nonatomic, assign) int ms_str; //模式
@property (nonatomic, assign) BOOL link_Boo;

@property (nonatomic, strong) NSMutableArray *dataMut;
@property (nonatomic, assign) BOOL controling_boo; //是否是 被控制设备
@property (nonatomic, assign) BOOL controling_boo2;
@end

@implementation MHRoleThrSDMSController

- (NSMutableArray *)dataMut
{
    if (!_dataMut) {
        _dataMut = [NSMutableArray array];
    }
    return _dataMut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.xz_str = @"false";
    self.ms_str = 1;
    
    
    _oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    _oneVV.layer.cornerRadius = 0;
    _oneVV.clipsToBounds = YES;
    _oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_oneVV];
    
    UIView *plaVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    plaVV.layer.cornerRadius = 0;
    plaVV.clipsToBounds = YES;
    plaVV.backgroundColor = RGBA(130, 54, 231, 0.76);
    [self.oneVV addSubview:plaVV];
    
    CGFloat ff_hig = plaVV.height/3;
    NSArray *namArr = @[@"new_msg_5", @"new_msg_6", @"new_msg_7"];
    NSArray *colorArr = @[RGBA(212, 115, 255, 0.4), RGBA(187, 110, 255, 0.24), RGBA(130, 54, 231, 0.76)];
    for (int i=0; i<3; i++) {
        
        UILabel *cenLabLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:30 textAlignment:NSTextAlignmentCenter];
        cenLabLab.frame = CGRectMake(0, ff_hig*i, _window_width, ff_hig);
        cenLabLab.font = [UIFont systemFontOfSize:30 weight:2];
        cenLabLab.text = eLocalizedString(namArr[i]);
        cenLabLab.textColor = RGBA(255, 255, 255, 0.5);
        [self.oneVV addSubview:cenLabLab];
        
        UIView *thrMMVV = [[UIView alloc] initWithFrame:CGRectMake(0, ff_hig*i, _window_width, ff_hig)];
        thrMMVV.layer.cornerRadius = 0;
        thrMMVV.clipsToBounds = YES;
        thrMMVV.backgroundColor = colorArr[i];
        [self.oneVV addSubview:thrMMVV];
        
    }
    
    self.patternVV = [[MHCreatePatternVView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.oneVV.height)];
    self.patternVV.isBooL = YES;
    self.patternVV.isBooL2 = YES;
    self.patternVV.delegate_ = self;
    self.patternVV.devicTyp = self.devicTyp;
    [self.oneVV addSubview:self.patternVV];
    [self.patternVV addUIUIUIUType:1];
    
    if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp]) {
        
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] && ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11]|| [self.devicTyp isEqualToString:kCharactName16]|| [self.devicTyp isEqualToString:kCharactName17])) {
            
            NSArray *imgsAr = @[@"three_imgs6_nor2", @"three_imgs8"];
            NSArray *imgsAr_sel = @[@"three_imgs6_sel2", @"three_imgs8"];
            NSArray *tagsAr = @[@"1", @"3"];
            for (int i=0; i<imgsAr.count; i++) {
                
                UIButton *fou_bbbb = [HistoryRecordModel createImgBtn];
                fou_bbbb.frame = CGRectMake(_window_width-64, self.oneVV.height-TARBARHEIGHT+49-58*2-6+i*58, 44, 44);
                fou_bbbb.tag = 300+[minStr(tagsAr[i]) intValue];
                [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
                [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr_sel[i]] forState:UIControlStateSelected];
                [fou_bbbb addTarget:self action:@selector(fouBtnMMethodTag:) forControlEvents:UIControlEventTouchUpInside];
                [self.oneVV addSubview:fou_bbbb];
            }
        }else {
            NSArray *imgsAr = @[@"three_imgs5_nor", @"three_imgs6_nor2", @"three_imgs8"];
            NSArray *imgsAr_sel = @[@"three_imgs5_sel", @"three_imgs6_sel2", @"three_imgs8"];
            NSArray *tagsAr = @[@"0", @"1", @"3"];
            for (int i=0; i<imgsAr.count; i++) {
                
                UIButton *fou_bbbb = [HistoryRecordModel createImgBtn];
                fou_bbbb.frame = CGRectMake(_window_width-64, self.oneVV.height-TARBARHEIGHT+49-58*3-6+i*58, 44, 44);
                fou_bbbb.tag = 300+[minStr(tagsAr[i]) intValue];
                [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
                [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr_sel[i]] forState:UIControlStateSelected];
                [fou_bbbb addTarget:self action:@selector(fouBtnMMethodTag:) forControlEvents:UIControlEventTouchUpInside];
                [self.oneVV addSubview:fou_bbbb];
            }
        }
        
    }else if ([self.devicTyp isEqualToString:kCharactName15]) {
        
        NSArray *imgsAr = @[@"three_imgs5_nor", @"three_imgs6_nor2", @"three_imgs8"];
        NSArray *imgsAr_sel = @[@"three_imgs5_sel", @"three_imgs6_sel2", @"three_imgs8"];
        NSArray *tagsAr = @[@"0", @"1", @"3"];
        for (int i=0; i<imgsAr.count; i++) {
            
            UIButton *fou_bbbb = [HistoryRecordModel createImgBtn];
            fou_bbbb.frame = CGRectMake(_window_width-64, self.oneVV.height-TARBARHEIGHT+49-58*3-6+i*58, 44, 44);
            fou_bbbb.tag = 300+[minStr(tagsAr[i]) intValue];
            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr_sel[i]] forState:UIControlStateSelected];
            [fou_bbbb addTarget:self action:@selector(fouBtnMMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.oneVV addSubview:fou_bbbb];
        }
    }else if ([self.devicTyp isEqualToString:kCharactName12]) {
        
        NSArray *imgsAr = @[@"three_imgs5_nor", @"three_imgs8"];
        NSArray *imgsAr_sel = @[@"three_imgs5_sel", @"three_imgs8"];
        NSArray *tagsAr = @[@"0", @"3"];
        for (int i=0; i<imgsAr.count; i++) {
            
            UIButton *fou_bbbb = [HistoryRecordModel createImgBtn];
            fou_bbbb.frame = CGRectMake(_window_width-64, self.oneVV.height-TARBARHEIGHT+49-58*2-6+i*58, 44, 44);
            fou_bbbb.tag = 300+[minStr(tagsAr[i]) intValue];
            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr_sel[i]] forState:UIControlStateSelected];
            [fou_bbbb addTarget:self action:@selector(fouBtnMMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.oneVV addSubview:fou_bbbb];
        }
    }else {
//        NSArray *imgsAr = @[@"three_imgs5_nor", @"three_imgs6_nor", @"three_imgs7_sel", @"three_imgs8"];
//        NSArray *imgsAr_sel = @[@"three_imgs5_sel", @"three_imgs6_sel", @"three_imgs7_nor", @"three_imgs8"];
//        NSArray *tagsAr = @[@"0", @"1", @"2", @"3"];
//        for (int i=0; i<imgsAr.count; i++) {
//            
//            UIButton *fou_bbbb = [HistoryRecordModel createImgBtn];
//            fou_bbbb.frame = CGRectMake(_window_width-64, self.oneVV.height-TARBARHEIGHT+49-58*4-6+i*58, 44, 44);
//            fou_bbbb.tag = 300+[minStr(tagsAr[i]) intValue];
//            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
//            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr_sel[i]] forState:UIControlStateSelected];
//            [fou_bbbb addTarget:self action:@selector(fouBtnMMethodTag:) forControlEvents:UIControlEventTouchUpInside];
//            [self.oneVV addSubview:fou_bbbb];
//        }
        
        NSArray *imgsAr = @[@"three_imgs5_nor", @"three_imgs6_nor", @"three_imgs8"];
        NSArray *imgsAr_sel = @[@"three_imgs5_sel", @"three_imgs6_sel", @"three_imgs8"];
        NSArray *tagsAr = @[@"0", @"1", @"3"];
        for (int i=0; i<imgsAr.count; i++) {
            
            UIButton *fou_bbbb = [HistoryRecordModel createImgBtn];
            fou_bbbb.frame = CGRectMake(_window_width-64, self.oneVV.height-TARBARHEIGHT+49-58*3-6+i*58, 44, 44);
            fou_bbbb.tag = 300+[minStr(tagsAr[i]) intValue];
            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr[i]] forState:UIControlStateNormal];
            [fou_bbbb setBackgroundImage:[UIImage imageNamed:imgsAr_sel[i]] forState:UIControlStateSelected];
            [fou_bbbb addTarget:self action:@selector(fouBtnMMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.oneVV addSubview:fou_bbbb];
        }
        
    }
    
    self.time_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:20 textAlignment:NSTextAlignmentCenter];
    self.time_Lab.frame = CGRectMake(20, 0, self.oneVV.width-40, 60);
    self.time_Lab.text = @"00:00";
    [self.oneVV addSubview:self.time_Lab];
    
    UIButton *saveBBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-46, 7, 46, 46)];
    [saveBBtn setImage:[UIImage imageNamed:@"twoImgsName1"] forState:UIControlStateNormal];
    [saveBBtn addTarget:self action:@selector(saveBBtnMethodUIUIUI) forControlEvents:UIControlEventTouchUpInside];
    [self.oneVV addSubview:saveBBtn];
    
    [requestToolClass getNetworkWithUrl:request_waveform_listFeel andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.listFeel_arr = info;
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
    self.time_Boo = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadEnterForwodMethodTag:) name:kNeedEnterForegroundNote object:nil];
    
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq && [self.devicTyp isEqualToString:kCharactName7]) {
        self.controling_boo = YES;
        
        if ([FloatingWindowModel shareInstance].shoudong_model>0) {
            self.ms_str = [FloatingWindowModel shareInstance].shoudong_model;
        }
    }
    
    
    
    if (self.controling_boo) {
        
        if (self.controling_boo2) {
            return;
        }
        self.controling_boo2 = YES;
        
        BOOL isBoo_boo = NO;
        UIButton *one_bbbb = [self.oneVV viewWithTag:300];
        UIButton *two_bbbb = [self.oneVV viewWithTag:301];
        
        if ([FloatingWindowModel shareInstance].shoudong_one) {
            one_bbbb.selected = YES;
            
            self.patternVV.isBooL = NO;
            [self.patternVV luoMethodokok];
            
            if ([FloatingWindowModel shareInstance].shoudong_oneStrong>0) {
                isBoo_boo = YES;
            }
        }
        if ([FloatingWindowModel shareInstance].shoudong_two) {
            two_bbbb.selected = YES;
            
            self.patternVV.isBooL2 = NO;
            [self.patternVV luoMethodokok];
            if ([FloatingWindowModel shareInstance].shoudong_twoStrong>0) {
                isBoo_boo = YES;
            }
        }
        
        if ([FloatingWindowModel shareInstance].shoudong_model>0) {
            self.ms_str = [FloatingWindowModel shareInstance].shoudong_model;
        }
        
        if (isBoo_boo) {
            [self.patternVV setPatternMethodOne:[FloatingWindowModel shareInstance].shoudong_oneStrong two:[FloatingWindowModel shareInstance].shoudong_twoStrong];
            
            [self startTimeMehtod];
        }
    }
    
    
}

- (BOOL)getBooMEthod
{
    if (self.bxSave_str.length>0) {
        return YES;
    }else {
        return NO;
    }
}

- (void)MHCreatePatternVVDelegateMMM
{
    [self startTimeMehtod];
}

- (void)fouBtnMMethodTag:(UIButton *)btn
{
    
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 300:
        {
//            self.drawVVV.isShowImg2 = btn.selected;
            self.patternVV.isBooL = !btn.selected;
            [self.patternVV luoMethodokok];
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].shoudong_one = btn.selected;
        }
            break;
        case 301:
        {
//            self.drawVVV.isShowImg = btn.selected;
            self.patternVV.isBooL2 = !btn.selected;
            [self.patternVV luoMethodokok];
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].shoudong_two = btn.selected;
        }
            break;
        case 302:
        {
            if (btn.selected == YES) {
                self.xz_str = @"true";
            }else {
                self.xz_str = @"false";
            }
        }
            break;
        case 303:
        {
            MHRoleThrSDMSView *vc = [[MHRoleThrSDMSView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.tabBarController.view addSubview:vc];
            vc.sel_row = self.ms_str;
            [vc addUploadUIUIMethod];
            vc.block_ = ^(NSInteger selNumk, BOOL isBoo) {
                
                if (isBoo) {
                    self.ms_str = (int)selNumk+1;
                    
                    if (self.controling_boo) [FloatingWindowModel shareInstance].shoudong_model = (int)selNumk+1;
                }else {
//                    self.ms_str = 0;
                }
            };
        }
            break;
            
        default:
            break;
    }
}

- (void)uploadEnterForwodMethodTag:(NSNotification *)notifff
{
    NSString *sss_msg = notifff.object;
    if ([minStr(sss_msg) intValue] == 1) {
        self.xxx_Boo2 = NO;
    }else {
        self.xx_Boo = NO;
        self.xxx_Boo2 = YES;
    }
}

- (void)stopMethodUIUIUI
{
    if (messsageTimer) {
        [messsageTimer invalidate];
        messsageTimer = nil;
    }
}

- (void)startTimeMehtod
{
    self.time_Boo = NO;
    self.xx_Boo = NO;
    self.xxx_Boo2 = NO;
    if (self.thrBBlock_) {
        self.thrBBlock_(1);
    }
}

//MARK: 定时 取值
- (void)daojishiMethodUIUI
{
    if (self.xxx_Boo2) {
        if (!self.xx_Boo) {
            self.xx_Boo = YES;

            [self sendSocketThreeDataMethodstop];
        }
    }else {
        
        if (!self.time_Boo2) {
            
            if (!self.time_Boo) {
                
                self.xx_Boo = NO;

                //MARK: 每秒取值次数
                //            self.time_num2 = self.time_num2+1;
                //            int ww_Lll = self.time_num2%2;
                //
                //
                //            if (ww_Lll<=0) {
                //                self.time_num2 = 0;
                
                self.time_num = self.time_num+1;
                self.time_Lab.text = [HistoryRecordModel secondToHourMinutesSecond:self.time_num];
                
                //            }
                
                CGFloat wwYYY_dj = [self.patternVV getPointYYTwo];
                CGFloat wwYYY = [self.patternVV getPointYY];
                if (wwYYY_dj <= 2) {
                    wwYYY_dj = 0;
                }
                if (wwYYY <= 2) {
                    wwYYY = 0;
                }
                
//                [FloatingWindowModel shareInstance].shoudong_oneStrong = wwYYY_dj;
//                [FloatingWindowModel shareInstance].shoudong_twoStrong = wwYYY;
                
                NSLog(@"--999999---%.f%.f", wwYYY, wwYYY_dj);
                
                //电击、旋转、旋转方向、模式
                NSDictionary *dicM = @{@"voltage":[NSString stringWithFormat:@"%.f", wwYYY_dj], @"electricFrequency":minIntStr(self.ms_str), @"shakeIntensity":[NSString stringWithFormat:@"%.f", wwYYY], @"shakeFrequency":minIntStr(self.ms_str), @"spinIntensity":[NSString stringWithFormat:@"%.f", wwYYY], @"spinFrequency":minIntStr(self.ms_str), @"frequency":minIntStr(self.ms_str)};
                
                NSString *jsonString = [HistoryRecordModel stringWithJsonDictionary:dicM];
                if (jsonString.length>0) {
                    self.bxSave_str = self.bxSave_str.length>0 ? [NSString stringWithFormat:@"%@-%@", self.bxSave_str, jsonString] : jsonString;
                    
                    [self.dataMut addObject:dicM];
    
                    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
                        return;
                    }
                    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
                        return;
                    }
                    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                    if(isEEEqq) {
                        
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":[NSString stringWithFormat:@"%.f", wwYYY], @"shakeIntensity":[NSString stringWithFormat:@"%.f", wwYYY], @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", wwYYY_dj], @"frequency":minIntStr(self.ms_str)}];
                    }else {
                        if(self.isConnDevic) {

                            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":[NSString stringWithFormat:@"%.f", wwYYY], @"shakeIntensity":[NSString stringWithFormat:@"%.f", wwYYY], @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", wwYYY_dj], @"frequency":minIntStr(self.ms_str)}];
                        }
                    }
                }
                
            }else {
                if (!self.xx_Boo) {
                    self.xx_Boo = YES;
                    [self sendSocketThreeDataMethodstop];
                    
                }
            }
        }else {
            if (!self.xx_Boo) {
                self.xx_Boo = YES;
                [self sendSocketThreeDataMethodstop];
            }
        }
    }
}

//MARK: 保存
- (void)saveBBtnMethodUIUIUI
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    if (self.time_num >= 30) {
        self.time_Boo = YES;
        self.xx_Boo = NO;
        
        MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vcLocat];
        vcLocat.bx_sstr = eLocalizedString(@"two_nams34");
        [vcLocat addTwoNewTextfUIUIMethod:2];
        vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
          
            if (arrList.count > 0) {
                
                self.oneVV.hidden = YES;
                [self.patternVV hiddenShowMMMMMM:YES];
                
                self.MHManualOperationSubOneV = [[MHManualOperationSubOneView alloc] initWithFrame:CGRectMake(0, 0, self.oneVV.width, self.oneVV.height)];
                if (self.listFeel_arr) {
                    self.MHManualOperationSubOneV.arrList = self.listFeel_arr;
                }
                [self.view addSubview:self.MHManualOperationSubOneV];
                WEAKSELF
                self.MHManualOperationSubOneV.block_ = ^(NSString * _Nonnull strLLM) {
                  
                    [weakSelf textFFieldMethodfeel:strLLM];
                };
                [self.MHManualOperationSubOneV addMEthodArr];
                
            }else {

                [self sendSocketThreeDataMethodstop];
                
                [self.dataMut removeAllObjects];
                self.bxSave_str = @"";
                self.time_num = 0;
                self.time_num2 = 0;
                self.time_Lab.text = @"00:00";
                
//                [self.drawVVV clean];
            }
        };
    }else {
        if (self.time_num > 0) {
            
            self.time_Boo = YES;
            self.xx_Boo = NO;
            
            MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.tabBarController.view addSubview:vcLocat];
            [vcLocat addTwoNewTextfUIUIMethod:4];
            vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
                
                if (arrList.count > 0) {
                    
                    self.time_Boo = NO;
                    
                }else {
                    
                    [self sendSocketThreeDataMethodstop];
                    
                    [self.dataMut removeAllObjects];
                    self.bxSave_str = @"";
                    self.time_num = 0;
                    self.time_num2 = 0;
                    self.time_Lab.text = @"00:00";

                    [self.patternVV chuShiHuaUIUI];
                }
            };
        }
    }
}

- (void)textFFieldMethodfeel:(NSString *)feelstr
{
    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.tabBarController.view addSubview:vcLocat];
    [vcLocat addTwoNewTextfUIUIMethod:1];
    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
      
        if (arrList.count>0) {
            self.MHManualOperationSubOneV.hidden = YES;
            [self.MHManualOperationSubOneV removeFromSuperview];
            [self requestMEthodUrl:minStr(arrList[0]) feel:feelstr];
        }
    };
}

- (void)requestMEthodUrl:(NSString *)namStr feel:(NSString *)feelstr
{
    [self.patternVV hiddenShowMMMMMM:NO];
    
    [SVProgressHUD show];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSArray arrayWithArray:self.dataMut] options:0 error:&error];
    if (jsonData) {
       
        // 将NSData转换为NSString
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
       
//        NSDictionary *dicWW = @{@"deviceId":self.devicId, @"title":namStr, @"content":self.bxSave_str, @"duration":minIntStr(self.time_num), @"feel":feelstr};
        NSDictionary *dicWW = @{@"deviceId":self.devicId, @"title":namStr, @"content":jsonString, @"duration":minIntStr(self.time_num), @"feel":feelstr};
        
        [requestToolClass postRegisterLogNetworkWithUrl:request_waveform_ab_save andParameter:dicWW success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.time_num = 0;
            self.time_num2 = 0;
            self.time_Lab.text = @"00:00";

            [self.dataMut removeAllObjects];
            self.bxSave_str = @"";
            [self.patternVV chuShiHuaUIUI];
            self.oneVV.hidden = NO;
            
            [self sendSocketThreeDataMethodstop];
            
        } fail:^(NSString * _Nonnull msg) {
            self.time_num = 0;
            self.time_num2 = 0;
            self.time_Lab.text = @"00:00";

            [self.dataMut removeAllObjects];
            self.bxSave_str = @"";
            [self.patternVV chuShiHuaUIUI];
            self.oneVV.hidden = NO;
            
            [self sendSocketThreeDataMethodstop];
        }];
        
    }else {
        [SVProgressHUD dismiss];
    }

}

- (void)sendSocketThreeDataMethodstop
{
            
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"1", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0", @"frequency":@"0"}];
    }else {
        if(self.isConnDevic) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"1", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0", @"frequency":@"0"}];
        }else {
//            if (!self.link_Boo) {
//                self.link_Boo = YES;
//                if(self.twoBBlock_) {
//                    self.twoBBlock_(1);
//                }
//            }
        }
    }
    
}

- (void)uploadUIUIUI
{
    [self.patternVV hiddenShowMMMMMM:self.time_Boo2];
    
//    if (!self.time_Boo2) {
//        
//        if (self.controling_boo) {
//            
//            if (self.controling_boo2) {
//                return;
//            }
//            self.controling_boo2 = YES;
//            
//            BOOL isBoo_boo = NO;
//            UIButton *one_bbbb = [self.oneVV viewWithTag:300];
//            UIButton *two_bbbb = [self.oneVV viewWithTag:301];
//            
//            if ([FloatingWindowModel shareInstance].shoudong_one) {
//                one_bbbb.selected = YES;
//                
//                self.patternVV.isBooL = NO;
//                [self.patternVV luoMethodokok];
//                
//                if ([FloatingWindowModel shareInstance].shoudong_oneStrong>0) {
//                    isBoo_boo = YES;
//                }
//            }
//            if ([FloatingWindowModel shareInstance].shoudong_two) {
//                two_bbbb.selected = YES;
//                
//                self.patternVV.isBooL2 = NO;
//                [self.patternVV luoMethodokok];
//                if ([FloatingWindowModel shareInstance].shoudong_twoStrong>0) {
//                    isBoo_boo = YES;
//                }
//            }
//            
//            if ([FloatingWindowModel shareInstance].shoudong_model>0) {
//                self.ms_str = [FloatingWindowModel shareInstance].shoudong_model;
//            }
//            
//            if (isBoo_boo) {
//                [self.patternVV setPatternMethodOne:[FloatingWindowModel shareInstance].shoudong_oneStrong two:[FloatingWindowModel shareInstance].shoudong_twoStrong];
//                
//                [self startTimeMehtod];
//            }
//        }
//    }
}


@end

