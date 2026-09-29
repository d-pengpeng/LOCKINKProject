//
//  MHRoleTwoSDDJController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import "MHRoleTwoSDDJController.h"
#import "eDrawingView.h"
#import "MHManualOperationSubOneView.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHRoleTwoSDDJStartView.h"

@interface MHRoleTwoSDDJController ()
{
    NSTimer *messsageTimer;
}
@property (nonatomic, strong) eDrawingView *eDrawingV;
@property (nonatomic, strong) UIView *oneUIVVV;
//@property (nonatomic, strong) MHRoleTwoSDDJStartView *MHRoleTwoSDDJStartV;
@property (nonatomic, strong) UIImageView *switImgV;
@property (nonatomic, strong) UILabel *time_Lab;
@property (nonatomic, assign) int time_num;
@property (nonatomic, assign) int time_num2;
@property (nonatomic, assign) BOOL time_Boo;
@property (nonatomic, assign) BOOL xx_Boo; //关闭
@property (nonatomic, assign) BOOL xxx_Boo2;
@property (nonatomic, strong) MHManualOperationSubOneView *MHManualOperationSubOneV;
@property (nonatomic, strong) NSArray *listFeel_arr;
@property (nonatomic, copy) NSString *bxSave_str;
@property (nonatomic, strong) UIButton *selBBtn_btn;

@end

@implementation MHRoleTwoSDDJController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.oneUIVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width,  _window_height-334)];
    self.oneUIVVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.oneUIVVV];
    
    //手动电击
    UIView *oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.oneUIVVV.height)];
    oneVV.layer.cornerRadius = 0;
    oneVV.clipsToBounds = YES;
    oneVV.backgroundColor = RGBA(130, 54, 231, 0.76);
    [self.oneUIVVV addSubview:oneVV];
    
    CGFloat ff_hig = oneVV.height/3;
    NSArray *namArr = @[@"new_msg_5", @"new_msg_6", @"new_msg_7"];
    NSArray *colorArr = @[RGBA(212, 115, 255, 0.4), RGBA(187, 110, 255, 0.24), RGBA(130, 54, 231, 0.76)];
    for (int i=0; i<3; i++) {
        
        UILabel *cenLabLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:30 textAlignment:NSTextAlignmentCenter];
        cenLabLab.frame = CGRectMake(0, ff_hig*i, _window_width, ff_hig);
        cenLabLab.font = [UIFont systemFontOfSize:30 weight:2];
        cenLabLab.text = eLocalizedString(namArr[i]);
        cenLabLab.textColor = RGBA(255, 255, 255, 0.5);
        [self.oneUIVVV addSubview:cenLabLab];
        
        UIView *thrMMVV = [[UIView alloc] initWithFrame:CGRectMake(0, ff_hig*i, _window_width, ff_hig)];
        thrMMVV.layer.cornerRadius = 0;
        thrMMVV.clipsToBounds = YES;
        thrMMVV.backgroundColor = colorArr[i];
        [self.oneUIVVV addSubview:thrMMVV];
        
    }
    
    self.eDrawingV = [[eDrawingView alloc] initWithFrame:CGRectMake(0, 0, _window_width, oneVV.height)];
    self.eDrawingV.lineWidth = 34;
    self.eDrawingV.lineColor = UIColor.clearColor;
    [self.oneUIVVV addSubview:self.eDrawingV];
    WEAKSELF
    self.eDrawingV.block_ = ^(NSArray * _Nonnull arrMM) {
      
        [weakSelf startTimeMehtod];
        
    };
    
    UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-78, oneVV.height-TARBARHEIGHT-55, 78, 70)];
    [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneUIVVV addSubview:selBBtn];
    self.selBBtn_btn = selBBtn;
    
    UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
    hhhImgV.frame = CGRectMake(17, 0, 44, 44);
    hhhImgV.image = [UIImage imageNamed:@"center_img17"];
    [selBBtn addSubview:hhhImgV];
    
    self.switImgV = [HistoryRecordModel createImgImgView];
    self.switImgV.frame = CGRectMake(22, 49, 34, 12);
    self.switImgV.image = [UIImage imageNamed:@"switch_norlImg2"]; //switch_selImg
    [selBBtn addSubview:self.switImgV];
    
    self.time_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:20 textAlignment:NSTextAlignmentCenter];
    self.time_Lab.frame = CGRectMake(20, 0, oneVV.width-40, 60);
    self.time_Lab.text = @"00:00";
    [self.oneUIVVV addSubview:self.time_Lab];
    
    UIButton *saveBBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-46, 7, 46, 46)];
    [saveBBtn setImage:[UIImage imageNamed:@"twoImgsName1"] forState:UIControlStateNormal];
    [saveBBtn addTarget:self action:@selector(saveBBtnMethodUIUIUI) forControlEvents:UIControlEventTouchUpInside];
    [self.oneUIVVV addSubview:saveBBtn];
    
    [requestToolClass getNOMsgNetworkWithUrl:request_waveform_listFeel andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.listFeel_arr = info;
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    if (![LYUserDefault userDefault].isFirstLogin1) {
        [LYUserDefault saveisFirstLogin1:YES];
        
        MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vcLocat];
        [vcLocat addTwoNewTextfUIUIMethod:7];
        
    }
    
//    self.MHRoleTwoSDDJStartV = [[MHRoleTwoSDDJStartView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.oneUIVVV.height)];
//    [self.view addSubview:self.MHRoleTwoSDDJStartV];
//    self.MHRoleTwoSDDJStartV.block_ = ^{
//      
//        weakSelf.oneUIVVV.hidden = NO;
//        weakSelf.MHRoleTwoSDDJStartV.hidden = YES;
//        if (weakSelf.block_) {
//            weakSelf.block_();
//        }
//    };
//    
//    self.MHRoleTwoSDDJStartV.hidden = YES;
    
    
    messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
    self.time_Boo = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadEnterForwodMethodTag:) name:kNeedEnterForegroundNote object:nil];
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

//MARK: 播放界面
- (void)uploadUIUIUIPlay:(BOOL)booo
{
//    if (booo) {
//        self.oneUIVVV.hidden = YES;
//        self.MHRoleTwoSDDJStartV.hidden = NO;
//        [self.MHRoleTwoSDDJStartV addBXUploadMethod];
//    }else {
//        self.oneUIVVV.hidden = NO;
//        self.MHRoleTwoSDDJStartV.hidden = YES;
//    }
    
}

- (void)stopMethodUIUIUI
{
    [self->messsageTimer invalidate];
    self->messsageTimer = nil;
    
    
}

- (void)startTimeMehtod
{
//    if (self->messsageTimer == nil) {
//        self->messsageTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
//    }
    
    self.time_Boo = NO;
    self.xx_Boo = NO;
    self.xxx_Boo2 = NO;
    if (self.thrBBlock_) {
        self.thrBBlock_();
    }
}

//MARK: 定时 取值
- (void)daojishiMethodUIUI
{
    if (self.xxx_Boo2) {
        if (!self.xx_Boo) {
            self.xx_Boo = YES;
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
        }
    }else {
        
        if (!self.time_Boo2) {
            
            if (!self.time_Boo) {
                
                self.xx_Boo = NO;
                BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
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
                
                
                CGFloat wwYYY = [self.eDrawingV getPointYY];
                
                self.bxSave_str = self.bxSave_str.length>0 ? [NSString stringWithFormat:@"%@,%.f", self.bxSave_str, wwYYY] : [NSString stringWithFormat:@"%.f", wwYYY];
                //            [self.eDrawingV clean]; true false
                
                
                if(isEEEqq) {
                    
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"true", @"frequency":@"1", @"voltage":[NSString stringWithFormat:@"%.f", wwYYY]}];
                }else {
                    if(self.isConnDevic) {
                        
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"true", @"frequency":@"1", @"voltage":[NSString stringWithFormat:@"%.f", wwYYY]}];
                    }
                }
            }else {
                if (!self.xx_Boo) {
                    self.xx_Boo = YES;
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
                }
            }
        }else {
            if (!self.xx_Boo) {
                self.xx_Boo = YES;
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
            }
        }
    }
    
//    if (self.MHRoleTwoSDDJStartV.hidden == NO) {
//        if (self.MHRoleTwoSDDJStartV.play_Btn.selected == YES) {
//            if(isEEEqq) {
//                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":minIntStr([self.MHRoleTwoSDDJStartV getPlayFFFHHH])}];
//            }else {
//                if(self.isConnDevic) {
//                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":minIntStr([self.MHRoleTwoSDDJStartV getPlayFFFHHH])}];
//                }
//            }
//        }
//    }
}

- (void)selBBtnMethod:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected == YES) {
        self.switImgV.image = [UIImage imageNamed:@"switch_selImg2"];
        self.eDrawingV.isShowImg = YES;
    }else {
        self.switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
        self.eDrawingV.isShowImg = NO;
    }
}

//MARK: 保存
- (void)saveBBtnMethodUIUIUI
{
    if (self.time_num >= 30) {
        self.time_Boo = YES;
        self.xx_Boo = NO;
        
        MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vcLocat];
        [vcLocat addTwoNewTextfUIUIMethod:2];
        vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
          
            if (arrList.count > 0) {
                
                self.oneUIVVV.hidden = YES;
                
                self.MHManualOperationSubOneV = [[MHManualOperationSubOneView alloc] initWithFrame:CGRectMake(0, 0, self.eDrawingV.width, self.eDrawingV.height)];
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
//                self.time_Boo = NO;
                
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
                
                self.bxSave_str = @"";
                self.time_num = 0;
                self.time_num2 = 0;
                self.time_Lab.text = @"00:00";
                self.switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                self.eDrawingV.isShowImg = NO;
                self.selBBtn_btn.selected = NO;
                
                [self.eDrawingV clean];
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
                    
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
                    
                    self.bxSave_str = @"";
                    self.time_num = 0;
                    self.time_num2 = 0;
                    self.time_Lab.text = @"00:00";
                    self.switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                    self.eDrawingV.isShowImg = NO;
                    self.selBBtn_btn.selected = NO;
                    
                    [self.eDrawingV clean];
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
    [SVProgressHUD show];
    
    NSDictionary *dicWW = @{@"title":namStr, @"content":self.bxSave_str, @"duration":minIntStr(self.time_num), @"feel":feelstr};
    [requestToolClass postNetworkWithUrl:request_waveform_save andParameter:dicWW success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
//        [self->messsageTimer invalidate];
//        self->messsageTimer = nil;
//        self.time_Boo = NO;
        self.time_num = 0;
        self.time_num2 = 0;
        self.time_Lab.text = @"00:00";
        self.switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
        self.eDrawingV.isShowImg = NO;
        self.selBBtn_btn.selected = NO;
        self.bxSave_str = @"";
        [self.eDrawingV clean];
        self.oneUIVVV.hidden = NO;
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
        
    } fail:^(NSString * _Nonnull msg) {
//        [self->messsageTimer invalidate];
//        self->messsageTimer = nil;
//        self.time_Boo = NO;
        self.time_num = 0;
        self.time_num2 = 0;
        self.time_Lab.text = @"00:00";
        self.switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
        self.eDrawingV.isShowImg = NO;
        self.selBBtn_btn.selected = NO;
        self.bxSave_str = @"";
        [self.eDrawingV clean];
        self.oneUIVVV.hidden = NO;
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
    }];
}

- (void)uploadUIUIUI
{
    
}

@end
