//
//  sliderVVView.h
//  testPayProject
//
//  Created by Edwin on 2023/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class sliderVVView;
@protocol TPVerticalVideoSliderViewDelegate <NSObject>
@optional
// 滑块滑动开始
- (void)sliderTouchBegan:(float)value;
// 滑块滑动中
- (void)sliderValueChanged:(float)value;
// 滑块滑动结束
- (void)sliderTouchEnded:(float)value;
// 滑杆点击
- (void)sliderTapped:(float)value;

- (void)sliderVVView:(sliderVVView *)sliderVV sliderTouchEnded:(float)value;
@end
@interface TPVerticalVideoSliderButton : UIButton
@end

@interface sliderVVView : UIView

@property (nonatomic, weak) id<TPVerticalVideoSliderViewDelegate> delegate;/** 滑块 */
@property (nonatomic, strong, readonly) TPVerticalVideoSliderButton *sliderBtn;/** 默认滑杆的颜色 */
@property (nonatomic, strong) UIColor *maximumTrackTintColor;/** 滑杆进度颜色 */
@property (nonatomic, strong) UIColor *minimumTrackTintColor;/** 滑杆进度 */
@property (nonatomic, assign) float value;/** 缓存进度 */
@property (nonatomic, assign) float bufferValue;/** 是否允许点击，默认是YES */
@property (nonatomic, assign) BOOL allowTapped;/** 设置滑杆的高度 */
@property (nonatomic, assign) CGFloat sliderHeight;/// 是否正在拖动
@property (nonatomic, assign) BOOL isdragging;/// 向前还是向后拖动
@property (nonatomic, assign) BOOL isForward;
@property (nonatomic, assign) CGSize thumbSize;
@property (nonatomic, copy) NSString *slidIMg;
@property (nonatomic, copy) NSString *miniMumTIMg;
@end

NS_ASSUME_NONNULL_END
