//
//  eSliderNewView.h
//  beijing
//
//  东莞梦幻网络科技有限公司 注 on 2021/3/2.
//  Copyright © 2021 zhou last. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^eSliderNewVBlock)(CGFloat valuF);

@interface eSliderNewView : UIView

@property (nonatomic, copy) eSliderNewVBlock esliderBlock;
- (void)eSliderNewWithPlayTime:(NSInteger)playTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue;
@end

NS_ASSUME_NONNULL_END
