//
//  MHRoleThrYYYController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/11.
//

#import "MHRoleThrYYYController.h"
#import <CoreMotion/CoreMotion.h>
#import "MHLimitsAuthorityView.h"

@interface MHRoleThrYYYController ()

@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) CGFloat point_YY;
@property (nonatomic, assign) CGFloat point_YY2;
@property (nonatomic, assign) CGFloat point_YY3;
@property (nonatomic, assign) int js_num;

@property (nonatomic, copy) NSString *xz_type;
@property (nonatomic, copy) NSString *dj_type;
@property (nonatomic, copy) NSString *xz_type2;
@property (nonatomic, assign) BOOL controling_boo; //是否是 被控制设备
@property (nonatomic, assign) BOOL controling_boo2;
@end

@implementation MHRoleThrYYYController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.xz_type = @"false";
    self.dj_type = @"false";
    self.xz_type2 = @"1";
    
    self.oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    self.oneVV.layer.cornerRadius = 0;
    self.oneVV.clipsToBounds = YES;
    self.oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.oneVV];
    
    UIView *plaVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    plaVV.layer.cornerRadius = 0;
    plaVV.clipsToBounds = YES;
    plaVV.backgroundColor = RGBA(130, 54, 231, 0.76);
    [self.oneVV addSubview:plaVV];
    
    CGFloat ww_uuY = 1;
    if (475>self.oneVV.height) {
        ww_uuY = self.oneVV.height/475;
    }
    
    UIImageView *cenLogImgV = [HistoryRecordModel createImgImgView];
    cenLogImgV.image = [UIImage imageNamed:@"three_imgs1"];
    [self.oneVV addSubview:cenLogImgV];
    [cenLogImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneVV.mas_top).offset(54*ww_uuY);
        make.centerX.equalTo(self.oneVV.mas_centerX);
        make.width.offset(290*ww_uuY);
        make.height.offset(265*ww_uuY);
    }];
    
    if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp]) {
        
        if ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11]) {
            
            NSArray *nam_ar = @[@"thr_nams8_2"];
            NSArray *img_ar = @[@"three_imgs3_zhendong"];
            NSArray *tagsA = @[@"0"];
            for (int i=0; i<nam_ar.count; i++) {
                
                UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-100*ww_uuY)/2, 330*ww_uuY, 100*ww_uuY, 110*ww_uuY)];
                selBBtn.tag = 10000+[minStr(tagsA[i]) intValue];
                [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [self.oneVV addSubview:selBBtn];
                
                UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
                hhhImgV.frame = CGRectMake(17*ww_uuY, 0, 64*ww_uuY, 67*ww_uuY);
                hhhImgV.image = [UIImage imageNamed:img_ar[i]];
                hhhImgV.tag = 12000+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:hhhImgV];
                
                UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14*ww_uuY textAlignment:NSTextAlignmentCenter];
                nam_LLL.frame = CGRectMake(0, 67*ww_uuY, 100*ww_uuY, 30*ww_uuY);
                nam_LLL.text = eLocalizedString(nam_ar[i]);
                nam_LLL.tag = 13000+[minStr(tagsA[i]) intValue];
                nam_LLL.numberOfLines = 2;
                [selBBtn addSubview:nam_LLL];
                
                UIImageView *switImgV = [HistoryRecordModel createImgImgView];
                switImgV.frame = CGRectMake(33*ww_uuY, 97*ww_uuY, 34*ww_uuY, 12*ww_uuY);
                switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                switImgV.tag = 11000+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:switImgV];
            }
        }else {
            
            CGFloat ww_lef = (_window_width-200*ww_uuY)/3.f;
            NSArray *nam_ar = @[@"thr_nams8_2", @"thr_nams7"];
            if ([self.devicTyp isEqualToString:kCharactName7]) {
                nam_ar = @[@"thr_nams8_3", @"thr_nams7"];
            }
            NSArray *img_ar = @[@"three_imgs3_zhendong", @"three_imgs3"];
            NSArray *tagsA = @[@"0", @"2"];
            for (int i=0; i<nam_ar.count; i++) {
                
                UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(ww_lef+i*(100*ww_uuY+ww_lef), 330*ww_uuY, 100*ww_uuY, 110*ww_uuY)];
                selBBtn.tag = 10000+[minStr(tagsA[i]) intValue];
                [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [self.oneVV addSubview:selBBtn];
                
                UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
                hhhImgV.frame = CGRectMake(17*ww_uuY, 0, 64*ww_uuY, 67*ww_uuY);
                hhhImgV.image = [UIImage imageNamed:img_ar[i]];
                hhhImgV.tag = 12000+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:hhhImgV];
                
                UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14*ww_uuY textAlignment:NSTextAlignmentCenter];
                nam_LLL.frame = CGRectMake(0, 67*ww_uuY, 100*ww_uuY, 30*ww_uuY);
                nam_LLL.text = eLocalizedString(nam_ar[i]);
                nam_LLL.tag = 13000+[minStr(tagsA[i]) intValue];
                nam_LLL.numberOfLines = 2;
                [selBBtn addSubview:nam_LLL];
                
                UIImageView *switImgV = [HistoryRecordModel createImgImgView];
                switImgV.frame = CGRectMake(33*ww_uuY, 97*ww_uuY, 34*ww_uuY, 12*ww_uuY);
                switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                switImgV.tag = 11000+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:switImgV];
            }
        }
    }else if ([self.devicTyp isEqualToString:kCharactName15]) {
        
        CGFloat ww_lef = (_window_width-200*ww_uuY)/3.f;
        NSArray *nam_ar = @[@"thr_nams8_2", @"thr_nams7"];
        NSArray *img_ar = @[@"three_imgs3_zhendong", @"three_imgs3"];
        NSArray *tagsA = @[@"0", @"2"];
        for (int i=0; i<nam_ar.count; i++) {
            
            UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(ww_lef+i*(100*ww_uuY+ww_lef), 330*ww_uuY, 100*ww_uuY, 110*ww_uuY)];
            selBBtn.tag = 10000+[minStr(tagsA[i]) intValue];
            [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.oneVV addSubview:selBBtn];
            
            UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
            hhhImgV.frame = CGRectMake(17*ww_uuY, 0, 64*ww_uuY, 67*ww_uuY);
            hhhImgV.image = [UIImage imageNamed:img_ar[i]];
            hhhImgV.tag = 12000+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:hhhImgV];
            
            UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14*ww_uuY textAlignment:NSTextAlignmentCenter];
            nam_LLL.frame = CGRectMake(0, 67*ww_uuY, 100*ww_uuY, 30*ww_uuY);
            nam_LLL.text = eLocalizedString(nam_ar[i]);
            nam_LLL.tag = 13000+[minStr(tagsA[i]) intValue];
            nam_LLL.numberOfLines = 2;
            [selBBtn addSubview:nam_LLL];
            
            UIImageView *switImgV = [HistoryRecordModel createImgImgView];
            switImgV.frame = CGRectMake(33*ww_uuY, 97*ww_uuY, 34*ww_uuY, 12*ww_uuY);
            switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
            switImgV.tag = 11000+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:switImgV];
        }
    }else if ([self.devicTyp isEqualToString:kCharactName12]) {
        
        NSArray *nam_ar = @[@"thr_nams7"];
        NSArray *img_ar = @[@"three_imgs3"];
        NSArray *tagsA = @[@"2"];
        for (int i=0; i<nam_ar.count; i++) {
            
            UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-100*ww_uuY)/2, 330*ww_uuY, 100*ww_uuY, 110*ww_uuY)];
            selBBtn.tag = 10000+[minStr(tagsA[i]) intValue];
            [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.oneVV addSubview:selBBtn];
            
            UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
            hhhImgV.frame = CGRectMake(17*ww_uuY, 0, 64*ww_uuY, 67*ww_uuY);
            hhhImgV.image = [UIImage imageNamed:img_ar[i]];
            hhhImgV.tag = 12000+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:hhhImgV];
            
            UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14*ww_uuY textAlignment:NSTextAlignmentCenter];
            nam_LLL.frame = CGRectMake(0, 67*ww_uuY, 100*ww_uuY, 30*ww_uuY);
            nam_LLL.text = eLocalizedString(nam_ar[i]);
            nam_LLL.tag = 13000+[minStr(tagsA[i]) intValue];
            nam_LLL.numberOfLines = 2;
            [selBBtn addSubview:nam_LLL];
            
            UIImageView *switImgV = [HistoryRecordModel createImgImgView];
            switImgV.frame = CGRectMake(33*ww_uuY, 97*ww_uuY, 34*ww_uuY, 12*ww_uuY);
            switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
            switImgV.tag = 11000+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:switImgV];
        }
    }else {
        CGFloat ww_lef = (_window_width-300*ww_uuY)/4.f;
        NSArray *nam_ar = @[@"thr_nams8", @"thr_nams10", @"thr_nams7"];
        NSArray *img_ar = @[@"three_imgs2", @"three_imgs7_sel", @"three_imgs3"];
        
        for (int i=0; i<nam_ar.count; i++) {
            
            UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(ww_lef+i*(100*ww_uuY+ww_lef), 330*ww_uuY, 100*ww_uuY, 110*ww_uuY)];
            selBBtn.tag = 10000+i;
            [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.oneVV addSubview:selBBtn];

            UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
            hhhImgV.frame = CGRectMake(17*ww_uuY, 0, 64*ww_uuY, 67*ww_uuY);
            hhhImgV.image = [UIImage imageNamed:img_ar[i]];
            hhhImgV.tag = 12000+i;
            [selBBtn addSubview:hhhImgV];
            
            UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14*ww_uuY textAlignment:NSTextAlignmentCenter];
            nam_LLL.frame = CGRectMake(0, 67*ww_uuY, 100*ww_uuY, 30*ww_uuY);
            nam_LLL.text = eLocalizedString(nam_ar[i]);
            nam_LLL.tag = 13000+i;
            nam_LLL.numberOfLines = 2;
            [selBBtn addSubview:nam_LLL];
            
            UIImageView *switImgV = [HistoryRecordModel createImgImgView];
            switImgV.frame = CGRectMake(33*ww_uuY, 97*ww_uuY, 34*ww_uuY, 12*ww_uuY);
            switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
            switImgV.tag = 11000+i;
            [selBBtn addSubview:switImgV];
        }
    }
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq && [self.devicTyp isEqualToString:kCharactName7]) {
        self.controling_boo = YES;
    }
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    
    
    if (self.controling_boo) {
        
        if (self.controling_boo2) {
            return;
        }
        self.controling_boo2 = YES;
        
        UIButton *selBBtn = [self.oneVV viewWithTag:10000];
        UIButton *selBBtn3 = [self.oneVV viewWithTag:10002];
        UIImageView *switImgV = [selBBtn viewWithTag:11000];
        UIImageView *switImgV3 = [selBBtn3 viewWithTag:11002];
        
        if ([FloatingWindowModel shareInstance].yaoyiyao_one) {
            selBBtn.selected = YES;
            switImgV.image = [UIImage imageNamed:@"switch_selImg2"];
            self.xz_type = @"true";
        }
        
        if ([FloatingWindowModel shareInstance].yaoyiyao_thr) {
            selBBtn3.selected = YES;
            switImgV3.image = [UIImage imageNamed:@"switch_selImg2"];
            self.dj_type = @"true";
        }
    }
    
}

//MARK: 旋转功能、电击模式
- (void)selBBtnMethod:(UIButton *)btn
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
    
    UIButton *selBBtn = [self.oneVV viewWithTag:10000];
    UIButton *selBBtn2 = [self.oneVV viewWithTag:10001];
    UIButton *selBBtn3 = [self.oneVV viewWithTag:10002];
    
    if ([self.devicTyp isEqualToString:kCharactName5]) {
    
        UIImageView *switImgV = [selBBtn viewWithTag:11000];
        UIImageView *switImgV2 = [selBBtn2 viewWithTag:11001];
        UIImageView *switImgV3 = [selBBtn3 viewWithTag:11002];
    
        UIImageView *logImgV2 = [selBBtn2 viewWithTag:12001];
        UILabel *logLabV2 = [selBBtn2 viewWithTag:13001];
    
    
        if (btn.tag == 10000) {
            btn.selected = !btn.selected;
            if (btn.selected == YES) {
                switImgV.image = [UIImage imageNamed:@"switch_selImg2"];
                self.xz_type = @"true";
                
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_one = YES;
            }else {
                switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                self.xz_type = @"false";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_one = NO;
            }
    
        }else if (btn.tag == 10001) {
    
            btn.selected = !btn.selected;
            if (btn.selected == YES) {
                switImgV2.image = [UIImage imageNamed:@"switch_selImg2"];
                logImgV2.image = [UIImage imageNamed:@"three_imgs7_nor"];
                logLabV2.text = eLocalizedString(@"thr_nams10_10");
    
                self.xz_type2 = @"2";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_two = YES;
            }else {
                switImgV2.image = [UIImage imageNamed:@"switch_norlImg2"];
                logImgV2.image = [UIImage imageNamed:@"three_imgs7_sel"];
                logLabV2.text = eLocalizedString(@"thr_nams10");
                self.xz_type2 = @"1";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_two = NO;
            }
    
        }else {
    
            btn.selected = !btn.selected;
            if (btn.selected == YES) {
                switImgV3.image = [UIImage imageNamed:@"switch_selImg2"];
                self.dj_type = @"true";
                
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_thr = YES;
            }else {
                switImgV3.image = [UIImage imageNamed:@"switch_norlImg2"];
                self.dj_type = @"false";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_thr = NO;
            }
        }
    }else {
        
        UIImageView *switImgV = [selBBtn viewWithTag:11000];
        UIImageView *switImgV3 = [selBBtn3 viewWithTag:11002];
        
        
        if (btn.tag == 10000) {
            btn.selected = !btn.selected;
            if (btn.selected == YES) {
                switImgV.image = [UIImage imageNamed:@"switch_selImg2"];
                self.xz_type = @"true";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_one = YES;
            }else {
                switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                self.xz_type = @"false";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_one = NO;
            }
            
        }else if (btn.tag == 10002) {
            
            btn.selected = !btn.selected;
            if (btn.selected == YES) {
                switImgV3.image = [UIImage imageNamed:@"switch_selImg2"];
                self.dj_type = @"true";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_thr = YES;
            }else {
                switImgV3.image = [UIImage imageNamed:@"switch_norlImg2"];
                self.dj_type = @"false";
                if (self.controling_boo) [FloatingWindowModel shareInstance].yaoyiyao_thr = NO;
            }
        }
    }
    
    if ((selBBtn.selected == NO) && (selBBtn3.selected == NO)) {
        [self stopGyroUpdate];
    }else {
        [self startGyroUpdatePush];
    }
}

- (void)uploadUIUIUI
{
    if (!self.time_Boo2) {
        if ([self.xz_type isEqualToString:@"true"]||[self.dj_type isEqualToString:@"true"]) {
            
            [self startGyroUpdatePush];
        }
        
        
        
    }else {
        
        [self stopGyroUpdate];
    }
}

- (void)stopMethodUIUIUI
{
    [self stopGyroUpdate];
}

- (void)startGyroUpdatePush {
    
    if ([_motionManager isGyroAvailable] && ![_motionManager isGyroActive]) {
        _motionManager.gyroUpdateInterval = 0.5; //频率
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        WEAKSELF
        [_motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (error) {
                [self stopGyroUpdate];
            }else {
                
                CGFloat flot_x = gyroData.rotationRate.x*10;
                CGFloat flot_y = gyroData.rotationRate.y*10;
                CGFloat flot_z = gyroData.rotationRate.z*10;
                
                BOOL boo_o = (fabs(flot_x) > fabs(flot_y)) && (fabs(flot_x) > fabs(flot_z));
                BOOL boo_t = (fabs(flot_y) > fabs(flot_x)) && (fabs(flot_y) > fabs(flot_z));
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (boo_o) {
                        [weakSelf changeFFFF:fabs(flot_x)];
                    }else if (boo_t){
                        [weakSelf changeFFFF:fabs(flot_y)];
                    }else {
                        [weakSelf changeFFFF:fabs(flot_z)];
                    }
                });
            }
        }];
    }
}

- (void)changeFFFF:(float)flot
{

    if (flot>100) {
        flot = 100;
    }
    
//    if (flot<5) {
//        flot = 0;
//    }
    float ww_yy = flot;
    
    NSLog(@"数据陀螺仪 ----%.f", ww_yy);
    
//    if (self.point_YY3==0) {
//        self.point_YY3 = flot;
//    }
//    
//    if (flot >= self.point_YY) {
//        self.point_YY = flot;
//    }
//    if (flot < self.point_YY2) {
//        self.point_YY2 = flot;
//    }
//    
//    self.js_num = self.js_num+1;
//    
//    if (self.js_num == 2) {
//        float ww_yy = self.point_YY;
//        if (self.point_YY == self.point_YY3) {
//            ww_yy = self.point_YY2;
//        }
//        
//        self.point_YY = 0;
//        self.point_YY2 = 0;
//        self.point_YY3 = 0;
//        self.js_num = 0;
        

        BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            
            if (ww_yy > 0) {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-SENSOR-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":self.xz_type, @"spinDirection":self.xz_type2, @"spinIntensity":[NSString stringWithFormat:@"%.f", ww_yy], @"shakeIntensity":[NSString stringWithFormat:@"%.f", ww_yy], @"inElectricMode":self.dj_type, @"voltage":[NSString stringWithFormat:@"%.f", ww_yy]}];
            }else {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-SENSOR-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"0", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0"}];
            }
            
        }else {
            if(self.isConnDevic) {
                
                if (ww_yy > 0) {
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-SENSOR-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":self.xz_type, @"spinDirection":self.xz_type2, @"spinIntensity":[NSString stringWithFormat:@"%.f", ww_yy], @"shakeIntensity":[NSString stringWithFormat:@"%.f", ww_yy], @"inElectricMode":self.dj_type, @"voltage":[NSString stringWithFormat:@"%.f", ww_yy]}];
                }else {
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-SENSOR-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"0", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0"}];
                }
            }
        }
//    }

}

//停止获取陀螺仪数据
- (void)stopGyroUpdate {

    if ([_motionManager isGyroActive]) {
        [_motionManager stopGyroUpdates];
        [self sendSocketThreeDataMethodstop];
    }
   
}

- (void)sendSocketThreeDataMethodstop
{

    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-SENSOR-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"0", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0"}];
    }else {
        if(self.isConnDevic) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-SENSOR-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"0", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0"}];
        }else {
//            if(self.twoBBlock_) {
//                self.twoBBlock_(1);
//            }
        }
    }
    
}


@end

