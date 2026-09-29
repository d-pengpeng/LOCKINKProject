//
//  musicWindowModel.m
//  testPayProject
//
//  Created by Edwin on 2023/8/31.
//

#import "musicWindowModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AFNetworking/AFNetworking.h>
#import "AudioSpectrumPlayer.h"

@interface musicWindowModel ()<AVAudioPlayerDelegate, AudioSpectrumPlayerDelegate>

@property (nonatomic, strong) AVPlayer *playUrl;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) BOOL isPlayingTwo;
@property (nonatomic, strong) AVAudioPlayer *noVoiceAudioPlayer;
@property (nonatomic, strong) NSTimer *timerMM;
@property (nonatomic, copy) NSString *musicUrl;
@property (nonatomic, strong) AudioSpectrumPlayer *spectPlayer;

@property (nonatomic, strong) FloatingWindowModel *floatMode;
@property (nonatomic, assign) BOOL isRRRusq;
@end

@implementation musicWindowModel

+ (id)shareInstance
{
    static musicWindowModel *giftRedEnv = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!giftRedEnv) {
            giftRedEnv = [musicWindowModel new];
        }
    });
    return giftRedEnv;
}

- (void)playerDidGenerateSpectrum:(NSArray *)spectrums
{
    NSLog(@"播放峰值--%@", spectrums[0]);
}

- (BOOL)getPlayVice
{
    return self.isPlaying;
}

- (void)playSliderUIUIUIMethod
{
    self.noVoiceAudioPlayer.currentTime = self.playTime;
}

- (void)startPlayNoVoiceMP3 {
    
    self.floatMode.isMusicPlay = NO;
    if(self.isPlaying) {
        self.floatMode.isMusicPlay = YES;
        [self.noVoiceAudioPlayer play];
//        if(self.finishBlock_) {
//            self.finishBlock_(@"");
//        }
    }else {
        
        [self.noVoiceAudioPlayer stop];
        BOOL bAudioInputAvailable = FALSE;
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        // 设置会话类型（声音与其他声音共存）
        [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        // 激活会话
        [audioSession setActive:YES error:nil];
        
        bAudioInputAvailable = [audioSession isInputAvailable];
        
        if (bAudioInputAvailable)
        {
            self.noVoiceAudioPlayer = nil;
            
            NSString *soundPath = [[NSBundle mainBundle]pathForResource:self.musicUrl ofType:@"mp3"];
            NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
//            NSURL *soundUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@", self.musicUrl]];
            //初始化播放器对象
            self.noVoiceAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
            //设置声音的大小
            //        self.noVoiceAudioPlayer.volume = 0.8;//范围为（0到1）；
            //设置循环次数，如果为负数，就是无限循环
            self.noVoiceAudioPlayer.numberOfLoops = -1;
            //设置播放进度
            self.noVoiceAudioPlayer.currentTime = self.playTime;
            self.noVoiceAudioPlayer.meteringEnabled = YES;
            //准备播放
            [self.noVoiceAudioPlayer prepareToPlay];
            self.noVoiceAudioPlayer.delegate = self;
            self.isPlaying = [self.noVoiceAudioPlayer play];
            if(!self.isPlaying) {
                NSLog(@"播放失败");
                [[NSFileManager defaultManager] removeItemAtPath:self.musicUrl error:nil];
                if(self.finishBlock_) {
                    self.finishBlock_(@"");
                }
                [SVProgressHUD showInfoWithStatus:@"此音乐链接已失效"];
            }else {
//                NSLog(@"总时长 -- %.f", self.noVoiceAudioPlayer.duration);
                self.floatMode.isMusicPlay = YES;
                
            }
            
//            self.spectPlayer = [[AudioSpectrumPlayer alloc] init];
//            self.spectPlayer.delegate = self;
//            [self.spectPlayer playWithFileName:self.musicUrl];
        }
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放结束
    [self stopPlayNoVoiceMP3];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

- (void)stopPlayNoVoiceMP3 {
    [self.noVoiceAudioPlayer pause];
//    [self.noVoiceAudioPlayer stop];
    self.isPlaying = NO;
//    self.noVoiceAudioPlayer = nil;
}

- (CGFloat)getpeakPowerForChannelMM
{
    [self.noVoiceAudioPlayer updateMeters];
    
    float level;
    float minDecibels = - 80.0f;
    float decibels = [self.noVoiceAudioPlayer averagePowerForChannel:0];
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

        level = powf(adjAmp, 1.0f/root);
    }
    
    return level;
}

- (void)clearCacheDataMethod
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *pathArray = [fileManager contentsOfDirectoryAtPath:cachePath error:nil];
    
    for (NSString *fileName in pathArray) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

- (void)newStartPlayNoVoiceMP3
{
    NSString *url_str = self.musicListAr[self.numLLL];
    NSString *name_str = self.nameListAr[self.numLLL];
    
    self.nameMusic = name_str;
    
    self.isPlaying = NO;
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *direPath = [pathArray lastObject];
    
    NSString *file_path = [direPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@1.mp3", name_str]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // 判断文件是否已经存在
    if ([fm fileExistsAtPath:file_path])
    {
        self.musicUrl = file_path;//file_path; name_str
        [self startPlayNoVoiceMP3];
    }else {
        
        //3.导出music到沙盒路径

        NSString*newPath = [direPath stringByAppendingFormat:@"%@.mov", name_str];

        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:url_str]];

        AVAssetExportSession *session =[[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetPassthrough];

        session.outputURL= [NSURL fileURLWithPath:newPath];

        session.outputFileType = AVFileTypeCoreAudioFormat;

        session.metadata= asset.metadata;

        [session exportAsynchronouslyWithCompletionHandler:^{

            //判断导出状态

            switch(session.status) {

                case AVAssetExportSessionStatusCompleted:{

                    //导出完成

                    NSString *newPath1 = [[newPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@1.mp3", name_str]];

                    NSError*renameError =nil;

                    [[NSFileManager defaultManager] moveItemAtPath:newPath toPath:newPath1 error:&renameError];

                    if(renameError) {

                        NSLog(@"renameError=%@",renameError.localizedDescription);
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"home_musicMsg1")];
                    }else{

                        NSLog (@" No renameError(Success) :: newPath=%@",newPath1);

                        self.musicUrl = newPath1;
                        [self startPlayNoVoiceMP3];
                    }

                    [[NSFileManager defaultManager] removeItemAtPath:newPath error:nil];
                }

                    break;

                case AVAssetExportSessionStatusFailed:{

                    //导出失败
                    NSLog(@"导出错误 %@",session.error);
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"home_musicMsg1")];
                }

                    break;

                default:
                    break;

            }
        }];
        
        //MARK: 下载网络歌曲
        
//        NSURL *URL = [NSURL URLWithString:url_str];
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        //AFN3.0+基于封住URLSession的句柄
//        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//        //请求
//        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//        //下载Task操作
//        NSURLSessionDownloadTask *_downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//            //进度
//        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
////            NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//            NSString *path = [cachesPath stringByAppendingPathComponent:name_str];
//            return [NSURL fileURLWithPath:path];
//
//        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//            // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
//
//            NSLog(@"--下载音乐长度--%lld", response.expectedContentLength);
//            NSString *armFilePath = [filePath path];// 将NSURL转成NSString
//            self.musicUrl = name_str;//armFilePath;
//            [self startPlayNoVoiceMP3];
//        }];
//        [_downloadTask resume];
    }
    
    self.coverImg = [UIImage imageNamed:@"tabbarIcon1_sel"];
}

- (void)playNextSong
{
    [self playNext];
}

- (void)playNext
{
//    self.numLLL = self.numLLL+1;
//    if(self.numLLL>=self.musicListAr.count) {
//        self.numLLL = 0;
//    }
    [self newStartPlayNoVoiceMP3];
}

- (void)pausePlay
{
    [self.noVoiceAudioPlayer pause];
//    [self.spectPlayer stop];
}

- (void)playPlayMethod
{
    if(self.isPlaying) {
        [self.noVoiceAudioPlayer play];
    }else {
        [self newStartPlayNoVoiceMP3];
    }
}

- (void)downloadMuiscUrl:(NSString *)urlStr name:(NSString *)titlN blockMM:(FinishBlock)block_
{
    if(self.isRRRusq) {
        return;
    }
    self.isRRRusq = YES;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *direPath = [pathArray lastObject];
    
    NSString *file_path = [direPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@1.mp3", titlN]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // 判断文件是否已经存在
    if ([fm fileExistsAtPath:file_path]){
        self.isRRRusq = NO;
        block_(file_path);
    }else {
        
        //3.导出music到沙盒路径

        NSString*newPath = [direPath stringByAppendingFormat:@"%@.mov", titlN];

        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:urlStr]];

        AVAssetExportSession *session =[[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetPassthrough];

        session.outputURL= [NSURL fileURLWithPath:newPath];

        session.outputFileType = AVFileTypeCoreAudioFormat;

        session.metadata= asset.metadata;

        [session exportAsynchronouslyWithCompletionHandler:^{

            //判断导出状态

            switch(session.status) {

                case AVAssetExportSessionStatusCompleted:{

                    //导出完成

                    NSString *newPath1 = [[newPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@1.mp3", titlN]];

                    NSError*renameError =nil;

                    [[NSFileManager defaultManager] moveItemAtPath:newPath toPath:newPath1 error:&renameError];

                    if(renameError) {
                        self.isRRRusq = NO;
                        block_(@"");
                        NSLog(@"renameError=%@",renameError.localizedDescription);
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"home_musicMsg1")];
                    }else{

                        NSLog (@" No renameError(Success) :: newPath=%@",newPath1);
                        self.isRRRusq = NO;
                        block_(newPath1);
                    }

                    [[NSFileManager defaultManager] removeItemAtPath:newPath error:nil];
                }

                    break;

                case AVAssetExportSessionStatusFailed:{

                    //导出失败
                    NSLog(@"导出错误 %@",session.error);
                    self.isRRRusq = NO;
                    block_(@"");
                }

                    break;

                default:
                    break;

            }
        }];
    }
}

@end
