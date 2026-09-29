//
//  musicWindowModel.h
//  testPayProject
//
//  Created by Edwin on 2023/8/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^FinishBlock)(NSString *filePath);
typedef void(^Failed)(void);

typedef void(^musicWindowModelVVBlock)(NSArray *arr);
@interface musicWindowModel : NSObject
+ (id)shareInstance;

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) int playTime;
@property (nonatomic, copy) NSString *playDuration;
@property (nonatomic, strong) UIImage *coverImg;
@property (nonatomic, copy) NSString *nameMusic;
@property (nonatomic, assign) int numLLL;

@property (nonatomic, copy) musicWindowModelVVBlock block_;
@property (nonatomic, copy) FinishBlock finishBlock_;
@property (nonatomic, strong) NSArray *musicListAr;
@property (nonatomic, strong) NSArray *nameListAr;


- (void)playNextSong;
- (void)stopPlayNoVoiceMP3;
- (CGFloat)getpeakPowerForChannelMM;
- (void)clearCacheDataMethod;
- (void)newStartPlayNoVoiceMP3;
- (void)pausePlay;

- (void)playPlayMethod;

- (BOOL)getPlayVice;

- (void)playSliderUIUIUIMethod;

- (void)downloadMuiscUrl:(NSString *)urlStr name:(NSString *)titlN blockMM:(FinishBlock)block_;


//- (void)addViewLoadMethod;
//- (void)startPlay;
//- (void)pausePlay;
//- (void)downloadAudioWithUrl:(NSString *)url saveDirectoryPath:(NSString *)directoryPath fileName:(NSString *)fileName finish:(FinishBlock )finishBlock failed:(Failed)failed;

@end

NS_ASSUME_NONNULL_END
