//
//  MHFourthRoleYYKZController.m
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "MHFourthRoleYYKZController.h"
#import <AVFAudio/AVFAudio.h>
@interface MHFourthRoleYYKZController ()
@property (nonatomic , strong) AVAudioRecorder *audioRecorder;//录音
@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic, strong) UIView *oneVV;
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

@implementation MHFourthRoleYYKZController

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
        cenLogImgV.image = [UIImage imageNamed:@"fourth_yuyin_img"];
        [self.oneVV addSubview:cenLogImgV];
        [cenLogImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(numberImg1.mas_bottom).offset(40);
            make.centerX.equalTo(self.oneVV.mas_centerX);
            make.width.height.offset(192);
        }];
    }else {
        UIImageView *cenLogImgV = [HistoryRecordModel createImgImgView];
        cenLogImgV.image = [UIImage imageNamed:@"fourth_yuyin_img"];
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
//            self.channlelef_Lab.text = eLocalizedString(channel_arr[i]);
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
    
    [self startMethod];
}

- (void)channelBtnChooseMethodOne{
    
    self.strong_Lab.text = minIntStr(self.strongType);
}
- (void)channelStartChooseMethodTwo
{
    if ((self.isChannelBoo>0) && (self.isChannelBoo_play>0)) {

        [_audioRecorder record];
    }else {

        [_audioRecorder pause];
        [self sendSocketThreeDataMethodstop];
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
//                [_audioRecorder record];
//            }else {
//                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                
//                [_audioRecorder pause];
//                [self sendSocketThreeDataMethodstop];
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
//                [_audioRecorder record];
//            }else {
//                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                
//                [_audioRecorder pause];
//                [self sendSocketThreeDataMethodstop];
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
//            }
//        }else {
//            if (ff_aa < 100) {
//                self.strong_Lab.text = minIntStr(ff_aa+10);
//                self.strongTypeB = ff_aa+10;
//            }
//        }
//    }else {
//        
//        int ff_aa = [minStr(self.strong_Lab.text) intValue];
//        if (btn.tag == 1002) {
//            if (ff_aa >= 10) {
//                self.strong_Lab.text = minIntStr(ff_aa-10);
//                self.strongType = ff_aa-10;
//            }
//        }else {
//            if (ff_aa < 100) {
//                self.strong_Lab.text = minIntStr(ff_aa+10);
//                self.strongType = ff_aa+10;
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

- (void)startMethod
{
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                      [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                      [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                      [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                                      nil];
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];//只监听不写入，所以空地址
    NSError *error;
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    _audioRecorder.meteringEnabled = YES;
    [_audioRecorder prepareToRecord];
//    [self.audioRecorder record];
    
    _timer = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.audioRecorder.isRecording) {
            [self.audioRecorder updateMeters];
            
            float level;
            float minDecibels = - 80.0f;
            float decibels = [self.audioRecorder averagePowerForChannel:0];
            if(decibels < minDecibels) {
                level = 0.0f;
            }else if (decibels >= 0.0f) {
                level = 1.0f;
            }else {
                float root = 2.0f;
                float minAmp = powf(10.0f, 0.05f*minDecibels);
                float inverseAmpRange = 1.0f / (1.0f - minAmp);
                float amp = powf(10.0f, 0.05f*decibels);
                float adjAmp = (amp - minAmp) * inverseAmpRange;
                
                level = powf(adjAmp, 1.0f/root)+0.25;
            }
            
            [self changeFFFF:level*100];
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)changeFFFF:(float)flot
{
    int flot_yy = (int)flot;
    if (flot_yy > 30) {
        flot_yy = flot_yy-30;
    }else {
        flot_yy = 0;
    }
    
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
        
        NSLog(@"发送指令-语音控制-qiui%d", ww_yy);
        
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

- (void)stopMethod
{
    [_audioRecorder stop];
    _audioRecorder = nil;
    [_timer invalidate];
    _timer = nil;
}

- (void)uploadUIUIUI
{
    if (!self.time_Boo2) {
        if (self.isChannelBoo_play>0) {
            [_audioRecorder record];
        }
    }else {
        [_audioRecorder pause];
        if (self.time_Boo2_old) {
            
            [self sendSocketThreeDataMethodstop];
        }
    }
}

- (void)sendSocketThreeDataMethodstop
{
    NSLog(@"发送暂停指令-语音控制-qiui");
    
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

- (void)stopMethodUIUIUI
{
    self.isChannelBoo_play = 0;
//    self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//    self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
    [self stopMethod];
}

@end
