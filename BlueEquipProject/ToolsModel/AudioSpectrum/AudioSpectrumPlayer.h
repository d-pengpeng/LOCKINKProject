//
//  AudioSpectrumPlayer.h
//  AudioSpectrumDemo
//
//  Created by user on 2019/5/8.
//  Copyright © 2019 adu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AudioSpectrumPlayerDelegate <NSObject>

@optional
- (void)playerDidGenerateSpectrum:(NSArray *)spectrums;

- (void)playerAgainDGenerateSpectrum:(long)num;

@end

@interface AudioSpectrumPlayer : NSObject

@property (nonatomic, weak) id <AudioSpectrumPlayerDelegate> delegate;

- (void)playWithFileName:(NSString *)fileName;
- (void)stop;
- (void)playWithNoSoundFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
