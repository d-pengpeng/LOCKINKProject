//
//  MHFourthRoleYYYController.m
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "MHFourthRoleYYYController.h"
#import <CoreMotion/CoreMotion.h>

@interface MHFourthRoleYYYController ()
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) UILabel *strong_Lab;
@property (nonatomic, assign) int strongType;
//@property (nonatomic, assign) int strongTypeB;
//@property (nonatomic, strong) UILabel *channlelef_Lab;
//@property (nonatomic, strong) UILabel *channlerig_Lab;
//@property (nonatomic, strong) UIImageView *channlelef_Img;
//@property (nonatomic, strong) UIImageView *channlerig_Img;

@property (nonatomic, assign) BOOL isContinuBoo;
//@property (nonatomic, assign) BOOL isChannelBoo;
//@property (nonatomic, assign) BOOL isChannelBoo_play;

@end

@implementation MHFourthRoleYYYController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    UIImageView *oneImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334-34)];
    oneImgV.image = [UIImage imageNamed:@"fourth_backSub_Img"];
    [self.view addSubview:oneImgV];
    
    self.oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334-34)];
    self.oneVV.layer.cornerRadius = 0;
    self.oneVV.clipsToBounds = YES;
    self.oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.oneVV];
    
    
    UIImageView *tit_lab2 = [HistoryRecordModel createImgImgView];
    tit_lab2.frame = CGRectMake(16, 28, _window_width-32, 36);
    tit_lab2.image = [UIImage imageNamed:@"fourth_strongBack_Img"];
    [self.oneVV addSubview:tit_lab2];
    
    UIButton *lefNumBtn2 = [HistoryRecordModel createImgBtn];
    lefNumBtn2.frame = CGRectMake(0, tit_lab2.y-10, 76, 56);
    lefNumBtn2.tag = 1002;
    [lefNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneVV addSubview:lefNumBtn2];
    UIImageView *lef_subIII_2 = [HistoryRecordModel createImgImgView];
    lef_subIII_2.frame = CGRectMake(29, 19, 18, 18);
    lef_subIII_2.image = [UIImage imageNamed:@"fourth_strongSub_Img"];
    [lefNumBtn2 addSubview:lef_subIII_2];
    
    UIButton *rigNumBtn2 = [HistoryRecordModel createImgBtn];
    rigNumBtn2.frame = CGRectMake(_window_width-56-20, tit_lab2.y-10, 76, 56);
    rigNumBtn2.tag = 1003;
    [rigNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneVV addSubview:rigNumBtn2];
    UIImageView *rig_subIII_2 = [HistoryRecordModel createImgImgView];
    rig_subIII_2.frame = CGRectMake(29, 19, 18, 18);
    rig_subIII_2.image = [UIImage imageNamed:@"fourth_strongAdd_Img"];
    [rigNumBtn2 addSubview:rig_subIII_2];
    
    UIImageView *numberImg1 = [HistoryRecordModel createImgImgView];
    numberImg1.frame = CGRectMake(tit_lab2.center.x-57, 12, 114, 68);
    numberImg1.image = [UIImage imageNamed:@"fourth_strongCent_Img"];
    [self.oneVV addSubview:numberImg1];
    self.strong_Lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:40 textAlignment:NSTextAlignmentCenter];
    self.strong_Lab.frame = CGRectMake(0, 0, 114, 68);
    self.strong_Lab.text = @"50";
    [numberImg1 addSubview:self.strong_Lab];
    self.strongType = 50;
//    self.strongTypeB = 50;
    
    CGFloat ff_hig = self.oneVV.height-50-80;
    if (ff_hig > 272) {
        
        UIImageView *cenLogImgV = [HistoryRecordModel createImgImgView];
        cenLogImgV.image = [UIImage imageNamed:@"fourth_yaoyiyao_img"];
        [self.oneVV addSubview:cenLogImgV];
        [cenLogImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(numberImg1.mas_bottom).offset(40);
            make.centerX.equalTo(self.oneVV.mas_centerX);
            make.width.height.offset(192);
        }];
    }else {
        UIImageView *cenLogImgV = [HistoryRecordModel createImgImgView];
        cenLogImgV.image = [UIImage imageNamed:@"fourth_yaoyiyao_img"];
        [self.oneVV addSubview:cenLogImgV];
        [cenLogImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(numberImg1.mas_bottom).offset(40);
            make.centerX.equalTo(self.oneVV.mas_centerX);
            make.width.height.offset(ff_hig-80);
        }];
    }
    
//    CGFloat ww_widchan = (_window_width-36-40)/2;
//    NSArray *channel_arr = @[@"fourth_channel_A", @"fourth_channel_B"];
//    for (int i=0; i<channel_arr.count; i++) {
//        
//        UIImageView *channel_imgV1 = [HistoryRecordModel createImgImgView];
//        channel_imgV1.image = [UIImage imageNamed:@"fourth_channel_Img"];
//        [self.oneVV addSubview:channel_imgV1];
//        if (i==0) {
//            channel_imgV1.frame = CGRectMake(18, self.oneVV.height-50, ww_widchan, 36);
//        }else {
//            channel_imgV1.frame = CGRectMake(18+ww_widchan+40, self.oneVV.height-50, ww_widchan, 36);
//        }
//        
//        UIButton *channelBtn = [HistoryRecordModel createImgBtn];
//        channelBtn.tag = 3300+i;
//        [channelBtn addTarget:self action:@selector(channelBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
//        [self.oneVV addSubview:channelBtn];
//        
//        UIButton *channelBtn2 = [HistoryRecordModel createImgBtn];
//        channelBtn2.tag = 3400+i;
//        [channelBtn2 addTarget:self action:@selector(channelBtnMethodPlay:) forControlEvents:UIControlEventTouchUpInside];
//        [self.oneVV addSubview:channelBtn2];
//        
//        if (i==0) {
//            channelBtn.frame = CGRectMake(18, self.oneVV.height-50, ww_widchan-58, 36);
//            channelBtn2.frame = CGRectMake(18+ww_widchan-58, self.oneVV.height-50, 58, 36);
//            
//            self.channlelef_Lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:13 textAlignment:NSTextAlignmentLeft];
//            self.channlelef_Lab.frame = CGRectMake(14, 0, channelBtn.width-14, 36);
//            self.channlelef_Lab.text = eLocalizedString(channel_arr[0]);
//            [channelBtn addSubview:self.channlelef_Lab];
//            
//            self.channlelef_Img = [HistoryRecordModel createImgImgView];
//            self.channlelef_Img.frame = CGRectMake(20, 9, 18, 18);
//            self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//            [channelBtn2 addSubview:self.channlelef_Img];
//            
//        }else {
//            channelBtn.frame = CGRectMake(18+ww_widchan+40, self.oneVV.height-50, ww_widchan-58, 36);
//            channelBtn2.frame = CGRectMake(channel_imgV1.x+ww_widchan-58, self.oneVV.height-50, 58, 36);
//            
//            self.channlerig_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:13 textAlignment:NSTextAlignmentLeft];
//            self.channlerig_Lab.frame = CGRectMake(14, 0, channelBtn.width-14, 36);
//            self.channlerig_Lab.text = eLocalizedString(channel_arr[i]);
//            [channelBtn addSubview:self.channlerig_Lab];
//            
//            self.channlerig_Img = [HistoryRecordModel createImgImgView];
//            self.channlerig_Img.frame = CGRectMake(20, 9, 18, 18);
//            self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//            [channelBtn2 addSubview:self.channlerig_Img];
//        }
//    }
    
    self.motionManager = [[CMMotionManager alloc] init];
    
}

- (void)channelBtnChooseMethodOne{
    
    self.strong_Lab.text = minIntStr(self.strongType);
}
- (void)channelStartChooseMethodTwo
{
    if ((self.isChannelBoo>0) && (self.isChannelBoo_play>0)) {

        [self startGyroUpdatePush];
    }else {

        [self stopGyroUpdate];
    }
}

//MARK: 通道选择
- (void)channelBtnMethod:(UIButton *)btn
{
//    if (btn.tag == 3300) {
//        
//        if (self.isChannelBoo) {
//            
//            if (!self.isChannelBoo_play) {
//                self.isChannelBoo = NO;
//                self.channlelef_Lab.textColor = normalColors;
//                self.channlerig_Lab.textColor = UIColor.whiteColor;
//                
//                self.strong_Lab.text = minIntStr(self.strongType);
//            }
//        }else {
//            self.isChannelBoo = NO;
//            self.channlelef_Lab.textColor = normalColors;
//            self.channlerig_Lab.textColor = UIColor.whiteColor;
//        }
//        
//    }else {
//        if (!self.isChannelBoo) {
//            
//            if (!self.isChannelBoo_play) {
//                self.isChannelBoo = YES;
//                self.channlerig_Lab.textColor = normalColors;
//                self.channlelef_Lab.textColor = UIColor.whiteColor;
//                
//                self.strong_Lab.text = minIntStr(self.strongTypeB);
//            }
//        }else {
//            self.isChannelBoo = YES;
//            self.channlerig_Lab.textColor = normalColors;
//            self.channlelef_Lab.textColor = UIColor.whiteColor;
//        }
//    }
}

//MARK: 通道 播放
- (void)channelBtnMethodPlay:(UIButton *)btn
{
//    if (btn.tag == 3400) {
//        
//        if (!self.isChannelBoo) {
//            
//            self.isChannelBoo_play = !self.isChannelBoo_play;
//            
//            if (self.isChannelBoo_play) {
//                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playSel_Img"];
//                
//                [self startGyroUpdatePush];
//            }else {
//                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                
//                [self stopGyroUpdate];
//            }
//        }
//    }else {
//        if (self.isChannelBoo) {
//            
//            self.isChannelBoo_play = !self.isChannelBoo_play;
//            
//            if (self.isChannelBoo_play) {
//                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playSel_Img"];
//                
//                [self startGyroUpdatePush];
//            }else {
//                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                
//                [self stopGyroUpdate];
//            }
//        }
//    }
}

//MARK: 强度 加 减
- (void)btnAllBtnMethodTag:(UIButton *)btn
{
    if (self.isContinuBoo) {
        return;
    }
    self.isContinuBoo = YES;
    
//    if (self.isChannelBoo) {
//        
//        int ff_aa = [minStr(self.strong_Lab.text) intValue];
//        if (btn.tag == 1002) {
//            if (ff_aa >= 10) {
//                self.strong_Lab.text = minIntStr(ff_aa-10);
//                self.strongTypeB = ff_aa-10;
//               
//            }
//        }else {
//            if (ff_aa < 100) {
//                self.strong_Lab.text = minIntStr(ff_aa+10);
//                self.strongTypeB = ff_aa+10;
//               
//            }
//        }
//    }else {
//        
//        int ff_aa = [minStr(self.strong_Lab.text) intValue];
//        if (btn.tag == 1002) {
//            if (ff_aa >= 10) {
//                self.strong_Lab.text = minIntStr(ff_aa-10);
//                self.strongType = ff_aa-10;
//                
//            }
//        }else {
//            if (ff_aa < 100) {
//                self.strong_Lab.text = minIntStr(ff_aa+10);
//                self.strongType = ff_aa+10;
//                
//            }
//        }
//    }
    int ff_aa = [minStr(self.strong_Lab.text) intValue];
    if (btn.tag == 1002) {
        if (ff_aa >= 1) {
            self.strong_Lab.text = minIntStr(ff_aa-1);
            self.strongType = ff_aa-1;
            
        }
    }else {
        if (ff_aa < 100) {
            self.strong_Lab.text = minIntStr(ff_aa+1);
            self.strongType = ff_aa+1;
            
        }
    }
    
    self.isContinuBoo = NO;
}

- (void)uploadUIUIUI
{
    if (!self.time_Boo2) {
        if (self.isChannelBoo_play>0) {
            
            [self startGyroUpdatePush];
        }
    }else {
        
        [self stopGyroUpdate];
    }
}

- (void)stopMethodUIUIUI
{
    self.isChannelBoo_play = 0;
//    self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//    self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
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
    int flot_yy = (int)flot;
    
    if ((self.isChannelBoo > 0) && self.isChannelBoo_play > 0) {
        NSString *channel_ab = minIntStr(self.isChannelBoo_play); //@"1";
//        if (self.isChannelBoo_play==2) {
//            channel_ab = @"2";
//        }else if (self.isChannelBoo_play==3) {
//            channel_ab = @"3";
//        }
        
    //    if (self.isChannelBoo) {
    //        channel_ab = @"2";
    //
    //        if (flot_yy>self.strongTypeB) {
    //            flot_yy = self.strongTypeB;
    //        }
    //    }else {
    //        if (flot_yy>self.strongType) {
    //            flot_yy = self.strongType;
    //        }
    //    }
        
        if (flot_yy>self.strongType) {
            flot_yy = self.strongType;
        }
        int ww_yy = flot_yy;
        
        NSLog(@"发送指令-摇一摇-qiui%d", ww_yy);
        
        BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
        if(isEEEqq) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":@"1", @"channel":channel_ab, @"voltage":minIntStr(ww_yy)}];
        }else {
            if(self.isConnDevic) {
                
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":@"1", @"channel":channel_ab, @"voltage":minIntStr(ww_yy)}];
            }
        }
    }
    
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
    
    NSLog(@"发送暂停指令-摇一摇-qiui");
    NSString *channel_ab = @"3";
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":@"1", @"channel":channel_ab, @"voltage":@"0"}];
    }else {
        if(self.isConnDevic) {
           
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":@"1", @"channel":channel_ab, @"voltage":@"0"}];
        }
    }
    
}

@end
