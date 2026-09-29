//
//  MHRecordingAuthenticationController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "MHRecordingAuthenticationController.h"
#import "MHVioceRecordView.h"
#import <AFNetworking/AFNetworking.h>
#import "UIView+RecordingMH.h"

@interface MHRecordingAuthenticationController ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, copy) NSString *wavPath;

@property (nonatomic, strong) UIImage *voiceImage;
@property (nonatomic, strong) NSArray *voiceAnimationImages;
@property (nonatomic, strong) UIImageView *voice;
@property (nonatomic, strong) UILabel *duration;
@property (nonatomic, strong) UIButton *ceterBtnLL;
@property (nonatomic, copy) NSString *pathOne;
@property (nonatomic, assign) BOOL isPPlayb;
@property (nonatomic, copy) NSString *text_id;
@end

@implementation MHRecordingAuthenticationController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = NO;
    self.titleName.text = eLocalizedString(@"role_setting43");
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.text_id = @"";
    UILabel *onelLL = [HistoryRecordModel createLabLabTextColor:RGB(94, 94, 94) fontFloat:14 textAlignment:NSTextAlignmentCenter];
    onelLL.frame = CGRectMake(20, NAVHEIGHT+110, _window_width-40, 40);
    onelLL.text = eLocalizedString(@"role_setting45");
    [self.view addSubview:onelLL];
    
    UIView *twoVV = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(onelLL.frame)+10, _window_width-24, 80)];
    twoVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:twoVV];
    [twoVV showLine];

    
    UILabel *twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    twoLab.frame = CGRectMake(16, 0, twoVV.width-32, twoVV.height);
    twoLab.numberOfLines = 0;
    [twoVV addSubview:twoLab];
    
    CGFloat w_xx = (_window_width-90-76-140)/2;
    UIButton *lefBtn = [HistoryRecordModel createImgBtn];
    lefBtn.frame = CGRectMake(w_xx, CGRectGetMaxY(twoVV.frame)+100+12, 70, 70);
    [lefBtn setBackgroundImage:[UIImage imageNamed:@"role_setting47"] forState:UIControlStateNormal];
    [lefBtn addTarget:self action:@selector(lefBtnMethodPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lefBtn];
    
    UIButton *centerBtn = [HistoryRecordModel createImgBtn];
    centerBtn.frame = CGRectMake(w_xx+108, CGRectGetMaxY(twoVV.frame)+100, 90, 90);
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"RecordingAuth_img2"] forState:UIControlStateNormal];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"RecordingAuth_img2_sel"] forState:UIControlStateSelected];
    [centerBtn addTarget:self action:@selector(centerBtnMethodPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBtn];
    self.ceterBtnLL = centerBtn;
    
    UIButton *rigBtn = [HistoryRecordModel createImgBtn];
    rigBtn.frame = CGRectMake(_window_width/2 + 83, CGRectGetMaxY(twoVV.frame)+100+12, 70, 70);
    [rigBtn setBackgroundImage:[UIImage imageNamed:@"RecordingAuth_img1"] forState:UIControlStateNormal];
    [rigBtn addTarget:self action:@selector(clearBtnTitleMehtod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigBtn];
    
    [requestToolClass getNetworkWithUrl:request_device_getRandomPhrase andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        twoLab.text = minStr(info[@"text"]);
        self.text_id = minStr(info[@"id"]);
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    self.pathOne = @"";

}

//MARK:  完成
- (void)clearBtnTitleMehtod
{
    if((self.pathOne.length>0)&&(self.text_id.length>0)) {
        
        if (self.msgModel) {
            
            if (self.isRecivBoo2) {
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"voice_Recorded") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        
                        [SVProgressHUD show];
                        NSURL *url = [NSURL fileURLWithPath:self.pathOne];
                        NSData *dataVideo = [NSData dataWithContentsOfURL:url];
                        
                        NSDictionary *dicM = @{@"messageId":minIntStr(self.msgModel.messageId), @"accepted":self.accepted_str, @"phraseId":self.text_id};
                        [requestToolClass postNetworkRecordVoiceWithUrl:request_message_acceptOrDeclineRelieveHardcoreMode typMehtod:dataVideo andImageData:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if (self.block_) {
                                self.block_();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD dismiss];
                        }];
                    }
                }];
            }else {
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"voice_Recorded") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        
                        [SVProgressHUD show];
                        NSURL *url = [NSURL fileURLWithPath:self.pathOne];
                        NSData *dataVideo = [NSData dataWithContentsOfURL:url];
                        
                        NSDictionary *dicM = @{@"messageId":minIntStr(self.msgModel.messageId), @"accepted":self.accepted_str, @"phraseId":self.text_id};
                        [requestToolClass postNetworkRecordVoiceWithUrl:request_message_acceptOrDeclineActiveHardcoreMode typMehtod:dataVideo andImageData:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if (self.block_) {
                                self.block_();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD dismiss];
                        }];
                    }
                }];
            }

        }else {
            
            if (self.isRecivBoo) {
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"voice_Recorded") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        
                        [SVProgressHUD show];
                        NSURL *url = [NSURL fileURLWithPath:self.pathOne];
                        NSData *dataVideo = [NSData dataWithContentsOfURL:url];
                        
                        [requestToolClass postNetworkRecordVoiceWithUrl:request_device_relieveHardcoreMode typMehtod:dataVideo andImageData:@{@"deviceId":minIntStr(self.roleOneModel.id), @"phraseId":self.text_id} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if (self.block_) {
                                self.block_();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD dismiss];
                        }];
                    }
                }];
            }else {
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"voice_Recorded") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        
                        [SVProgressHUD show];
                        NSURL *url = [NSURL fileURLWithPath:self.pathOne];
                        NSData *dataVideo = [NSData dataWithContentsOfURL:url];
                        
                        [requestToolClass postNetworkRecordVoiceWithUrl:request_device_activeHardcoreMode typMehtod:dataVideo andImageData:@{@"deviceId":minIntStr(self.roleOneModel.id), @"phraseId":self.text_id} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if (self.block_) {
                                self.block_();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD dismiss];
                        }];
                    }
                }];
            }
            
        }
    }else {
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"voice_Recorded2")];
    }
}

//MARK: 播放
- (void)lefBtnMethodPlay
{
    [self voiceMMMMMM];
}

//MARK: 录制
- (void)centerBtnMethodPlay
{
    self.ceterBtnLL.selected = YES;
    [self stopVoiceMessage];
    self.pathOne = @"";
    MHVioceRecordView *vc = [[MHVioceRecordView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    vc.blockTwo_ = ^(NSString * _Nonnull pathUrl, int oneIn, int twoIn) {
        self.ceterBtnLL.selected = NO;
    };
    vc.block_ = ^(NSString * _Nonnull pathUrl, int oneIn, int twoIn) {
      
        self.pathOne = pathUrl;
        self.ceterBtnLL.selected = NO;
//        CGFloat w_max = 80+oneIn*1;
//        if(w_max>240) {
//            w_max = 240;
//        }
//        UIButton *imgBtn = [HistoryRecordModel createImgBtn];
//        imgBtn.frame = CGRectMake(0, 26, w_max, 40);
//        imgBtn.backgroundColor = normalColors;
//        imgBtn.layer.cornerRadius = 5;
//        [imgBtn addTarget:self action:@selector(voiceMMMMMM) forControlEvents:UIControlEventTouchUpInside];
//        [self.two_VV addSubview:imgBtn];
//
//        UIButton *deleteBtn = [HistoryRecordModel createImgBtn];
//        deleteBtn.frame = CGRectMake(imgBtn.width, 20, 20, 20);
//        [deleteBtn setImage:[UIImage imageNamed:@"startL_vipbtnDelet"] forState:UIControlStateNormal];
//        [deleteBtn addTarget:self action:@selector(deleVoiceMMmethod) forControlEvents:UIControlEventTouchUpInside];
//        [self.two_VV addSubview:deleteBtn];
//
//        [self.voice removeFromSuperview];
//        self.voice = nil;
//        [self.duration removeFromSuperview];
//        self.duration = nil;
//
//        self.voice = [[UIImageView alloc] initWithFrame:CGRectMake(imgBtn.width-40, 5, 30, 30)];
//        self.voice.animationDuration = 1;
//        [imgBtn addSubview:self.voice];
//
//        self.duration = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, imgBtn.width-45, 30)];
//        self.duration.textAlignment = NSTextAlignmentRight;
//        self.duration.font = [UIFont systemFontOfSize:10];
//        self.duration.textColor = [UIColor whiteColor];
//        [imgBtn addSubview:self.duration];
//
//        self.duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:oneIn]];
//
//        self.voice.image = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_normal")];
//        self.voice.animationImages = [NSArray arrayWithObjects:
//                                  [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_1")],
//                                  [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_2")],
//                                  [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_3")], nil];
    };
}

//MARK: 播放语音
- (void)voiceMMMMMM
{
    if(self.pathOne.length > 0) {
        
        if(self.isPPlayb) {
            return;
        }
        self.isPPlayb = YES;
        
        if ([self.audioPlayer isPlaying]) {

            [self stopVoiceMessage];
        }else {
    
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            NSURL *url = [NSURL fileURLWithPath:self.pathOne];
            
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            self.audioPlayer.delegate = self;
            bool result = [self.audioPlayer play];
            if (!result) {
                self.wavPath = [[self.pathOne stringByDeletingPathExtension] stringByAppendingString:@".wav"];
                NSURL *url = [NSURL fileURLWithPath:self.wavPath];
                [self.audioPlayer stop];
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                self.audioPlayer.delegate = self;
                [self.audioPlayer play];
            }
          
        }
        
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    self.isPPlayb = NO;
//    [self.voice stopAnimating];
    [[NSFileManager defaultManager] removeItemAtPath:self.wavPath error:nil];
    [self stopVoiceMessage];
}

- (void)stopVoiceMessage
{
    self.isPPlayb = NO;
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
    }
}

@end
