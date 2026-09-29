//
//  HYBVideoCollectionCell.m
//  yunbaolive
//
//  Created by Edwin on 2023/2/20.
//  Copyright © 2023 cat. All rights reserved.
//

#import "HYBVideoCollectionCell.h"
//#import <TXLiteAVSDK_Professional/TXVodPlayer.h>


@interface HYBVideoCollectionCell ()
//<TXVodPlayListener>

@property (nonatomic, strong) UIControl *overlayControl; //控制层
//@property (nonatomic, strong) TXVodPlayer *xPlayer;
@property (nonatomic, strong) UIImageView *placeImgV;
@property (nonatomic, strong) UIView *bigLivingView;
@property (nonatomic, strong) UIButton *clicBBB;
@property (nonatomic, strong) UIButton *mutBBB;
@property (nonatomic, strong) UIButton *fullBBB;
@property (nonatomic, assign) BOOL isStaa;
@property (nonatomic, assign) BOOL isOneBoo;
@end

@implementation HYBVideoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
//        self.bigLivingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
//        self.bigLivingView.backgroundColor = RGB(51, 51, 51);
//        [self.contentView addSubview:self.bigLivingView];
//
//        if(!self.xPlayer) {
//            self.xPlayer = [[TXVodPlayer alloc] init];
//        }
//        TXVodPlayConfig *config = [[TXVodPlayConfig alloc] init];
//        config.progressInterval = 0.02;
//        config.maxBufferSize = 500; //缓存大小 单位M
//        config.playerType = 1;
//        self.xPlayer.loop = YES;
//        self.xPlayer.vodDelegate = self;
//        [self.xPlayer setConfig:config];
//        self.xPlayer.enableHWAcceleration = YES;
//        [self.xPlayer setRenderMode:RENDER_MODE_FILL_EDGE];
//        [self.xPlayer setupVideoWidget:self.bigLivingView insertIndex:0];
//        [self.xPlayer setMute:YES];
//
//        self.placeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
//        self.placeImgV.backgroundColor = UIColor.clearColor;
//        [self.contentView addSubview:self.placeImgV];
//
//        [self.contentView addSubview:self.overlayControl];
//        self.overlayControl.frame = self.bounds;
//
//        _clicBBB = [[UIButton alloc] initWithFrame:CGRectMake(self.overlayControl.width/2-25, self.overlayControl.height/2-25, 50, 50)];
//        [_clicBBB setImage:[UIImage imageNamed:@"btn_player_pause"] forState:UIControlStateNormal];
//        [_clicBBB setImage:[UIImage imageNamed:@"btn_player_play"] forState:UIControlStateSelected];
//        [_clicBBB setBackgroundImage:nil forState:UIControlStateSelected];
//        [_clicBBB addTarget:self action:@selector(clickMMMMM) forControlEvents:UIControlEventTouchUpInside];
//        [self.overlayControl addSubview:_clicBBB];
//        _clicBBB.selected = YES;
//
//        self.mutBBB = [[UIButton alloc] initWithFrame:CGRectMake(20, self.overlayControl.height-120, 40, 40)];
//        [self.mutBBB setImage:[UIImage imageNamed:@"mute_stopImg"] forState:UIControlStateNormal];
//        [self.mutBBB setImage:[UIImage imageNamed:@"mute_startImg"] forState:UIControlStateSelected];
//        [self.mutBBB addTarget:self action:@selector(mutBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//        [self.overlayControl addSubview:self.mutBBB];
//
//        self.fullBBB = [[UIButton alloc] initWithFrame:CGRectMake(self.overlayControl.width-60, self.overlayControl.height-120, 40, 40)];
//        [self.fullBBB setImage:[UIImage imageNamed:@"fullVideo_Img"] forState:UIControlStateNormal];
//        [self.fullBBB addTarget:self action:@selector(fullBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//        [self.overlayControl addSubview:self.fullBBB];
        
//        self.mutBBB.hidden = YES;
    }
    return self;
}

- (void)addUIUIDic:(NSDictionary *)dicDic
{
//    if(!self.isStaa) {
//        if(self.video_url.length > 0) {
//            int staySta = [self.xPlayer startVodPlay:self.video_url];
//            if(staySta == 0){
//                NSLog(@"播放视频2");
//            }
//        }
//    }
}

- (void)stopVideoBoo
{
//    [self.xPlayer stopPlay];
}

- (void)pauseResumeVideoBoo:(BOOL)boo
{
//    self.isOneBoo = !boo;
//    if(self.xPlayer){
//        if(boo) {
//
//            self.mutBBB.hidden = self.clicBBB.hidden;
//            self.fullBBB.hidden = self.clicBBB.hidden;
//            if(self.isStaa) {
//                if(self.block_ && (self.xPlayer.duration > 0)) {
//                    self.block_(self.clicBBB.hidden, 0.0f, self.xPlayer.duration);
//                }
//            }
//            self.mutBBB.hidden = NO;
//            self.fullBBB.hidden = NO;
//            self.clicBBB.selected = YES;
//            self.placeImgV.hidden = YES;
//            [self.xPlayer resume];
//        }else {
//            self.clicBBB.selected = NO;
//            self.placeImgV.hidden = NO;
//            [self.xPlayer pause];
//            self.mutBBB.selected = NO;
//            [self.xPlayer setMute:YES];
//            self.mutBBB.hidden = YES;
//            self.fullBBB.hidden = YES;
//            if(self.isStaa) {
//                if(self.block_ && (self.xPlayer.duration > 0)) {
//                    self.block_(YES, 0.0f, self.xPlayer.duration);
//                }
//            }
//
//        }
//    }else {
//        self.clicBBB.selected = NO;
//        self.placeImgV.hidden = NO;
//        self.mutBBB.hidden = YES;
//        self.fullBBB.hidden = YES;
//        if(self.isStaa) {
//            if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                self.block_(YES, 0.0f, self.xPlayer.duration);
//            }
//        }
//    }
}

- (void)clickMMMMM
{
//    if(self.isStaa) {
//        _clicBBB.selected = !_clicBBB.selected;
//        if(self.clicBBB.selected == YES) {
//
//            self.placeImgV.hidden = YES;
//            [self.xPlayer resume];
//
//            self.mutBBB.hidden = self.clicBBB.hidden;
//            self.fullBBB.hidden = self.clicBBB.hidden;
//            if(self.isStaa) {
//                if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                    self.block_(self.clicBBB.hidden, self.xPlayer.currentPlaybackTime, self.xPlayer.duration);
//                }
//            }
//        }else {
//            [self.xPlayer pause];
//            self.placeImgV.hidden = NO;
//            self.mutBBB.hidden = YES;
//            self.fullBBB.hidden = YES;
//            if(self.isStaa) {
//                if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                    self.block_(YES, self.xPlayer.currentPlaybackTime, self.xPlayer.duration);
//                }
//            }
//        }
//    }
}

- (void)mutBtnMethod
{
//    if(self.isStaa) {
//        self.mutBBB.selected = !self.mutBBB.selected;
//        if(self.mutBBB.selected == YES) {
//            [self.xPlayer setMute:NO];
//        }else {
//            [self.xPlayer setMute:YES];
//        }
//    }
}

- (void)fullBtnMethod
{
//    self.mutBBB.selected = NO;
//    [self.xPlayer setMute:YES];
//    if(self.thrblock_) {
//        self.thrblock_();
//    }
}

//-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (EvtID == PLAY_EVT_CONNECT_SUCC) {
//
//            NSLog(@"moviplay不连麦已经连接服务器 - %@", param);
//        }
//        else if (EvtID == PLAY_EVT_RTMP_STREAM_BEGIN){
//            NSLog(@"moviplay不连麦已经连接服务器，开始拉流 - %@", param);
//        }
//        else if (EvtID == PLAY_EVT_PLAY_BEGIN){
//            NSLog(@"moviplay不连麦视频播放开始 - %@", param);
//
//            self.isStaa = YES;
//            if(self.isOneBoo) {
//                [self.xPlayer pause];
//            }
//
//        }else if (EvtID== PLAY_EVT_PLAY_PROGRESS){
//
//            if(self.isStaa) {
//                if(self.clicBBB.selected == YES) {
//                    if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                        self.block_(self.clicBBB.hidden, self.xPlayer.currentPlaybackTime, self.xPlayer.duration);
//                    }
//                }else {
//                    [self.xPlayer pause];
//                }
//            }
//        }
//        else if (EvtID== PLAY_WARNING_VIDEO_PLAY_LAG){
//            NSLog(@"moviplay不连麦当前视频播放出现卡顿（用户直观感受） - %@", param);
//
//        }
//        else if (EvtID == PLAY_EVT_PLAY_END){
//            NSLog(@"moviplay不连麦视频播放结束 - %@", param);
//            self.clicBBB.selected = NO;
//            self.placeImgV.hidden = NO;
//            [self.xPlayer pause];
//            self.mutBBB.selected = NO;
//            [self.xPlayer setMute:YES];
//            self.mutBBB.hidden = YES;
//            self.fullBBB.hidden = YES;
//            if(self.isStaa) {
//                if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                    self.block_(YES, 0.0f, self.xPlayer.duration);
//                }
//            }
//        }
//        else if (EvtID == PLAY_ERR_NET_DISCONNECT) {
//            //视频播放结束
//            NSLog(@"moviplay不连麦网络断连,且经多次重连抢救无效,可以放弃治疗,更多重试请自行重启播放 - %@", param);
//
//        }else if (EvtID == PLAY_EVT_CHANGE_RESOLUTION) {
//            NSLog(@"主播连麦分辨率改变 - %@", param);
//        }
//    });
//}
//
//-(void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary*)param
//{
//
//}
//
//- (void)onClickOverlayControlAction:(UIControl *)control {
//
//    _clicBBB.hidden = !_clicBBB.hidden;
//
//    if(self.clicBBB.selected == NO) {
//
//        self.mutBBB.hidden = YES;
//        self.fullBBB.hidden = YES;
//        if(self.isStaa) {
//            if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                self.block_(YES, self.xPlayer.currentPlaybackTime, self.xPlayer.duration);
//            }
//        }
//    }else {
//        self.mutBBB.hidden = self.clicBBB.hidden;
//        self.fullBBB.hidden = self.clicBBB.hidden;
//        if(self.isStaa) {
//            if(self.block_ && self.xPlayer && (self.xPlayer.duration > 0)) {
//                self.block_(self.clicBBB.hidden, self.xPlayer.currentPlaybackTime, self.xPlayer.duration);
//            }
//        }
//    }
//}
//
//- (void)seeToFloatMehtod:(CGFloat)fl_see
//{
//    if(self.xPlayer) {
//        [self.xPlayer pause];
//        [self.xPlayer seek:fl_see];
//        [self.xPlayer resume];
//    }
//    if(self.twoblock_) {
//        self.twoblock_(NO);
//    }
//}
//
//- (UIControl *)overlayControl {
//    if (!_overlayControl) {
//        _overlayControl = [[UIControl alloc] init];
//        [_overlayControl addTarget:self action:@selector(onClickOverlayControlAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _overlayControl;
//}

@end
