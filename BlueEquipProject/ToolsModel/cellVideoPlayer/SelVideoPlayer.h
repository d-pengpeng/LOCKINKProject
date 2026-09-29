//
//  SelVideoPlayer.h
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelPlaybackControls.h"

@class SelPlayerConfiguration;

typedef void(^SelVideoPBLock)(NSInteger currentS, CGFloat totalS, CGFloat biliS);

@interface SelVideoPlayer : UIView

/**
 初始化播放器
 @param configuration 播放器配置信息
 */
- (instancetype)initWithFrame:(CGRect)frame configuration:(SelPlayerConfiguration *)configuration;

/** 播放视频 */
- (void)_playVideo;
/** 暂停播放 */
- (void)_pauseVideo;
/** 释放播放器 */
- (void)_deallocPlayer;

//历史记录开播
- (void)SpecifyWhereToStartPlaybackMethod:(CGFloat)floatNum;

/** 视频播放控制面板 */
@property (nonatomic, strong) SelPlaybackControls *playbackControls;

@property (nonatomic, copy) SelVideoPBLock SelPBLock;

@end
