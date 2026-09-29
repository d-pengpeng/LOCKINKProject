//
//  MHVioceRecordView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/8.
//

#import "MHVioceRecordView.h"
#import "TUIRecordView.h"
#import "TUIDefine.h"
#import "TUITool.h"
#import "TUIDefine.h"
#import <AVFoundation/AVFoundation.h>
#import "ReactiveObjC.h"
#import "UIView+TUILayout.h"
#import "TUIDarkModel.h"
#import "TUIGlobalization.h"

@interface MHVioceRecordView ()<AVAudioRecorderDelegate>
@property (nonatomic, strong) TUIRecordView *record;
@property (nonatomic, strong) NSDate *recordStartTime;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *recordTimer;
@property (nonatomic, strong) UILabel *voiceLab;
@property (nonatomic, strong) UIButton *recordButton;
@end
@implementation MHVioceRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIButton *deleteBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deleteBB.backgroundColor = RGBA(0, 0, 0, 0.3);
        [deleteBB addTarget:self action:@selector(deleteBtnmethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBB];
        
//        _recordButton = [[UIButton alloc] initWithFrame:CGRectMake(_window_width/4, _window_height/2-30, _window_width/2, 60)];
//        [_recordButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
//        _recordButton.backgroundColor = UIColor.whiteColor;
//        [_recordButton.layer setMasksToBounds:YES];
//        [_recordButton.layer setCornerRadius:4.0f];
//        [_recordButton.layer setBorderWidth:0.5f];
//        [_recordButton.layer setBorderColor:GrayText.CGColor];
//        [_recordButton addTarget:self action:@selector(recordBtnDown:) forControlEvents:UIControlEventTouchDown];
//        [_recordButton addTarget:self action:@selector(recordBtnUp:) forControlEvents:UIControlEventTouchUpInside];
//        [_recordButton addTarget:self action:@selector(recordBtnCancel:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
//        [_recordButton addTarget:self action:@selector(recordBtnExit:) forControlEvents:UIControlEventTouchDragExit];
//        [_recordButton addTarget:self action:@selector(recordBtnEnter:) forControlEvents:UIControlEventTouchDragEnter];
//        [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal];
//        [_recordButton setTitleColor:GrayTextColor forState:UIControlStateNormal];
//        [self addSubview:_recordButton];
        
        UIView *OneVVVV = [HistoryRecordModel createViewUIUI];
        OneVVVV.frame = CGRectMake(0, _window_height-TARBARHEIGHT-135, _window_width, TARBARHEIGHT+135+20);
        [self addSubview:OneVVVV];
        
        _voiceLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        _voiceLab.font = [UIFont systemFontOfSize:16 weight:0.5];
        _voiceLab.frame = CGRectMake(0, 0, _window_width, 52);
        _voiceLab.text = eLocalizedString(@"plaza_all22");
        [OneVVVV addSubview:_voiceLab];
        
        _recordButton = [[UIButton alloc] initWithFrame:CGRectMake(_window_width/2 - 35, 84, 70, 70)];
        [_recordButton setBackgroundImage:[UIImage imageNamed:@"voiceImg_normal"] forState:UIControlStateNormal];
        [_recordButton setBackgroundImage:[UIImage imageNamed:@"voiceImg_select"] forState:UIControlStateSelected];
        [_recordButton addTarget:self action:@selector(recordBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [OneVVVV addSubview:_recordButton];
        
    }
    return self;
}

- (void)recordBtnMethod
{
    _recordButton.selected = !_recordButton.selected;
    
    if(_recordButton.selected) {
        AVAudioSessionRecordPermission permission = AVAudioSession.sharedInstance.recordPermission;
        //在此添加新的判定 undetermined，否则新安装后的第一次询问会出错。新安装后的第一次询问为 ufblock_ndetermined，而非 denied。
        if (permission == AVAudioSessionRecordPermissionDenied || permission == AVAudioSessionRecordPermissionUndetermined) {
            [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
                if (!granted) {
                    UIAlertController *ac = [UIAlertController alertControllerWithTitle:TUIKitLocalizableString(TUIKitInputNoMicTitle) message:TUIKitLocalizableString(TUIKitInputNoMicTips) preferredStyle:UIAlertControllerStyleAlert];
                    [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitInputNoMicOperateLater) style:UIAlertActionStyleCancel handler:nil]];
                    [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitInputNoMicOperateEnable) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        UIApplication *app = [UIApplication sharedApplication];
                        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([app canOpenURL:settingsURL]) {
                            [app openURL:settingsURL options:@{} completionHandler:^(BOOL success) {
                                
                            }];
                        }
                    }]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.mm_viewController presentViewController:ac animated:YES completion:nil];
                    });
                }
            }];
            _recordButton.selected = !_recordButton.selected;
            return;
        }
        //在此包一层判断，添加一层保护措施。
        if(permission == AVAudioSessionRecordPermissionGranted){
            
            _recordStartTime = [NSDate date];
            [self startRecord];
            _voiceLab.text = eLocalizedString(@"plaza_all22_22");
        }else {
            _recordButton.selected = !_recordButton.selected;
        }
    }else {
        _voiceLab.text = eLocalizedString(@"plaza_all22");
        if (AVAudioSession.sharedInstance.recordPermission == AVAudioSessionRecordPermissionDenied) {
            return;
        }

        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_recordStartTime];
        if(interval < 1){
            [self cancelRecord];
        } else if(interval > 60) {
            if (self.recordTimer == nil) {
                // 此时超时回调已经在处理了，忽略
                return;
            }
            [self cancelRecord];
        } else{
            NSString *path = [self stopRecord];
            if (path) {
                [self MMMUIString:path];
            }
        }
    }
}

- (void)MMMUIString:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    int duration = (int)CMTimeGetSeconds(audioAsset.duration);
    int length = (int)[[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
    
    if(duration > 1) {
        if(self.block_) {
            self.block_(path, duration, length);
        }
        
        [self removeFromSuperview];
    }
}



- (void)recordBtnDown:(UIButton *)sender
{
    AVAudioSessionRecordPermission permission = AVAudioSession.sharedInstance.recordPermission;
    //在此添加新的判定 undetermined，否则新安装后的第一次询问会出错。新安装后的第一次询问为 ufblock_ndetermined，而非 denied。
    if (permission == AVAudioSessionRecordPermissionDenied || permission == AVAudioSessionRecordPermissionUndetermined) {
        [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
            if (!granted) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:TUIKitLocalizableString(TUIKitInputNoMicTitle) message:TUIKitLocalizableString(TUIKitInputNoMicTips) preferredStyle:UIAlertControllerStyleAlert];
                [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitInputNoMicOperateLater) style:UIAlertActionStyleCancel handler:nil]];
                [ac addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitInputNoMicOperateEnable) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIApplication *app = [UIApplication sharedApplication];
                    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([app canOpenURL:settingsURL]) {
                        [app openURL:settingsURL];
                    }
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mm_viewController presentViewController:ac animated:YES completion:nil];
                });
            }
        }];
        return;
    }
    //在此包一层判断，添加一层保护措施。
    if(permission == AVAudioSessionRecordPermissionGranted){
        if(!_record){
            _record = [[TUIRecordView alloc] init];
            _record.frame = [UIScreen mainScreen].bounds;
        }
        [self.window addSubview:_record];
        _recordStartTime = [NSDate date];
        [_record setStatus:Record_Status_Recording];
        _recordButton.backgroundColor = GrayText204;
        [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputReleaseToSend) forState:UIControlStateNormal];  // @"松开 结束"
        [self startRecord];
    }
}

- (void)recordBtnUp:(UIButton *)sender
{
    if (AVAudioSession.sharedInstance.recordPermission == AVAudioSessionRecordPermissionDenied) {
        return;
    }
    _recordButton.backgroundColor = [UIColor clearColor];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal]; // @"按住 说话"
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_recordStartTime];
    if(interval < 1){
        [_record setStatus:Record_Status_TooShort];
        [self cancelRecord];
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.record removeFromSuperview];
        });
    } else if(interval > 60) {
        [_record setStatus:Record_Status_TooLong];
        if (self.recordTimer == nil) {
            // 此时超时回调已经在处理了，忽略
            return;
        }
        [self cancelRecord];
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.record removeFromSuperview];
        });
    } else{
        [_record removeFromSuperview];
        NSString *path = [self stopRecord];
        _record = nil;
        if (path) {
            [self MMMUIString:path];
        }
    }
}

- (void)startRecord
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [session setActive:YES error:&error];

    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatMPEG4AAC],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];

    NSString *defultPath = [self getVideoCompressionPathCache];
    NSString *outputFielPath= [defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"m4a"]];
    
//    NSString *path = [TUIKit_Voice_Path stringByAppendingString:[TUITool genVoiceName:nil withExtension:@"m4a"]];
    NSURL *url = [NSURL fileURLWithPath:outputFielPath];
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    [_recorder record];
    [_recorder updateMeters];

    _recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(recordTick:) userInfo:nil repeats:YES];
}

- (NSString *)getVideoNameWithType:(NSString *)fileType
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"voice_%@.%@",timeStr,fileType];
    return fileName;
}

- (NSString *)getVideoCompressionPathCache
{
    NSString *videoCache = [NSTemporaryDirectory() stringByAppendingPathComponent:@"voiceffmpeg"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}

- (void)recordTick:(NSTimer *)timer{
    [_recorder updateMeters];
    float power = [_recorder averagePowerForChannel:0];
    [_record setPower:power];
    
    //在此处添加一个时长判定，如果时长超过60s，则取消录制，提示时间过长,同时不再显示 recordView。
    //此处使用 recorder 的属性，使得录音结果尽量精准。注意：由于语音的时长为整形，所以 60.X 秒的情况会被向下取整。但因为 ticker 0.5秒执行一次，所以因该都会在超时时显示为60s
    NSTimeInterval interval = _recorder.currentTime;
    if(interval >= 55 && interval < 60){
        NSInteger seconds = 60 - interval;
        NSString *secondsString = [NSString stringWithFormat:TUIKitLocalizableString(TUIKitInputWillFinishRecordInSeconds),(long)seconds + 1];//此处加long，是为了消除编译器警告。此处 +1 是为了向上取整，优化时间逻辑。
        _record.title.text = secondsString;
    }
    if(interval >= 60){
        NSString *path = [self stopRecord];
        [_record setStatus:Record_Status_TooLong];
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.record removeFromSuperview];
        });
        if (path) {
            [self MMMUIString:path];
        }
    }
    
}

- (void)recordBtnCancel:(UIButton *)sender
{
    [_record removeFromSuperview];
    _recordButton.backgroundColor = [UIColor clearColor];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputHoldToTalk) forState:UIControlStateNormal]; // @"按住 说话"
    [self cancelRecord];
}

- (void)recordBtnExit:(UIButton *)sender
{
    [_record setStatus:Record_Status_Cancel];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputReleaseToCancel) forState:UIControlStateNormal]; //  @"松开 取消"
}

- (void)recordBtnEnter:(UIButton *)sender
{
    [_record setStatus:Record_Status_Recording];
    [_recordButton setTitle:TUIKitLocalizableString(TUIKitInputReleaseToSend) forState:UIControlStateNormal]; //  @"松开 结束"
}

- (NSString *)stopRecord
{
    if(_recordTimer){
        [_recordTimer invalidate];
        _recordTimer = nil;
    }
    if([_recorder isRecording]){
        [_recorder stop];
    }
    return _recorder.url.path;
}

- (void)cancelRecord
{
    if(_recordTimer){
        [_recordTimer invalidate];
        _recordTimer = nil;
    }
    if([_recorder isRecording]){
        [_recorder stop];
    }
    NSString *path = _recorder.url.path;
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (void)deleteBtnmethod
{
    if(_recordButton.selected) {
        if (AVAudioSession.sharedInstance.recordPermission == AVAudioSessionRecordPermissionDenied) {
            return;
        }
        [self cancelRecord];
    }
    
    if(self.blockTwo_) {
        self.blockTwo_(@"", 1, 2);
    }
    [self removeFromSuperview];
}

@end
