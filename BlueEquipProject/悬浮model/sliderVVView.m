//
//  sliderVVView.m
//  testPayProject
//
//  Created by Edwin on 2023/9/5.
//

#import "sliderVVView.h"
#import "UIView+Frame.h"

#define _window_width    [[UIScreen mainScreen] bounds].size.width
#define _window_height   [[UIScreen mainScreen] bounds].size.height

static const CGFloat kVProgressH = 2.0;

@implementation TPVerticalVideoSliderButton// 重写此方法将按钮的点击范围扩大
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;// 扩大点击区域
    bounds = CGRectInset(bounds, -20, -20);// 若点击的点在新的bounds里面。就返回yes
    return CGRectContainsPoint(bounds, point);
}
@end

@interface sliderVVView ()
/** 进度背景 */
@property (nonatomic, strong) UIImageView *bgProgressView;
/** 滑动进度 */
@property (nonatomic, strong) UIImageView *sliderProgressView;
/** 滑块 */
@property (nonatomic, strong) TPVerticalVideoSliderButton *sliderBtn;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation sliderVVView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.allowTapped = YES;
        self.clipsToBounds = YES;
        [self addSubViews];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.allowTapped = YES;
    [self addSubViews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (isnan(self.value) || isnan(self.bufferValue)) return;
    CGFloat min_x = 12;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_h = self.bounds.size.height;
    self.sliderBtn.yz_centerX = self.bgProgressView.width * self.value;
    if (self.sliderBtn.hidden) {
        min_w = self.bgProgressView.width * self.value;
    }else {
        min_w = self.sliderBtn.yz_centerX;
    }
    min_h = self.sliderHeight;
    self.sliderProgressView.frame = CGRectMake(min_x, min_y, min_w, CGRectGetHeight(self.sliderProgressView.frame));
    self.bgProgressView.bottom = min_view_h - 8;
    self.sliderProgressView.bottom = min_view_h - 8;
    self.sliderBtn.yz_centerY = self.sliderProgressView.yz_centerY;
    self.sliderBtn.bounds = CGRectMake(self.bgProgressView.width * self.value, 0, self.thumbSize.width, self.thumbSize.height);
    self.bgProgressView.layer.cornerRadius = self.sliderHeight/2;
    self.sliderProgressView.layer.cornerRadius = self.sliderHeight/2;
    
    self.sliderBtn.yz_centerX = self.bgProgressView.width * self.value+12;
}
- (void)addSubViews {
    self.thumbSize = CGSizeMake(10, 10);
    self.sliderHeight = kVProgressH;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgProgressView];
    [self addSubview:self.sliderProgressView];
    [self addSubview:self.sliderBtn]; //添加点击手势
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:self.tapGesture]; //添加滑动手势
    
    UIPanGestureRecognizer *sliderGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliderGesture:)];
    [self addGestureRecognizer:sliderGesture];
    
    self.backgroundColor = [UIColor clearColor];
}
- (void)showContentWithBeginDragging:(BOOL)dragging
{
    self.sliderBtn.hidden = NO;
    self.sliderProgressView.hidden = NO;
    self.bgProgressView.hidden = NO;
//    CGFloat height = 2 ;CGFloat buttonWidth = 4; CGFloat buttonHeight = 4;
//    UIColor *minimumTrackTintColor = self.minimumTrackTintColor;
//    CGFloat cornerRadius = 2;
//    if (dragging) {
//        height = 10;buttonWidth = 18;buttonHeight = 18;
//        minimumTrackTintColor = [UIColor greenColor];
//        cornerRadius = 9;
//    }
    
    CGFloat height = self.sliderHeight;
    CGFloat buttonWidth = self.thumbSize.width;
    CGFloat buttonHeight = self.thumbSize.width;
    UIColor *minimumTrackTintColor = self.minimumTrackTintColor;
    CGFloat cornerRadius = self.sliderHeight/2;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.sliderProgressView.bounds = CGRectMake(12, 0, CGRectGetWidth(self.sliderProgressView.bounds), height);
        self.bgProgressView.bounds = CGRectMake(12, 0, CGRectGetWidth(self.bgProgressView.bounds), height);
        self.sliderBtn.bounds = CGRectMake(12, 0, buttonWidth, buttonHeight);
        self.sliderProgressView.backgroundColor = minimumTrackTintColor;
        self.sliderBtn.layer.cornerRadius = cornerRadius;
    }];
}
#pragma mark - Setter
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;
    self.bgProgressView.backgroundColor = maximumTrackTintColor;
}
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _minimumTrackTintColor = minimumTrackTintColor;
    self.sliderProgressView.backgroundColor = minimumTrackTintColor;
    self.sliderProgressView.image = [UIImage imageNamed:self.miniMumTIMg];
}

- (void)setSlidIMg:(NSString *)slidIMg
{
    [self.sliderBtn setBackgroundImage:[UIImage imageNamed:slidIMg] forState:UIControlStateNormal];
}

- (void)setValue:(float)value {
    if (isnan(value)) return;
    value = MIN(1.0, value);
    _value = value;
    if (self.sliderBtn.hidden) {
        self.sliderProgressView.width = self.bgProgressView.width * value;
    }else {
        self.sliderBtn.yz_centerX = 12+self.bgProgressView.width * value;
        self.sliderProgressView.width = self.sliderBtn.yz_centerX;
    }
}
- (void)setBufferValue:(float)bufferValue {
    if (isnan(bufferValue)) return;
    bufferValue = MIN(1.0, bufferValue);
    _bufferValue = bufferValue;
}
- (void)setAllowTapped:(BOOL)allowTapped {
    _allowTapped = allowTapped;
    if (!allowTapped) {
        [self removeGestureRecognizer:self.tapGesture];
    }
}
- (void)setSliderHeight:(CGFloat)sliderHeight {
    if (isnan(sliderHeight)) return;
    _sliderHeight = sliderHeight;
    self.bgProgressView.height = sliderHeight;
    self.sliderProgressView.height = sliderHeight;
}
#pragma mark - User Action
- (void)sliderGesture:(UIGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            [self sliderBtnTouchBegin:self.sliderBtn];
        }break;
        case UIGestureRecognizerStateChanged: {
            [self sliderBtnDragMoving:self.sliderBtn point:[gesture locationInView:self.bgProgressView]];
        }break;
        case UIGestureRecognizerStateEnded: {
            [self sliderBtnTouchEnded:self.sliderBtn];
        }break;
        default:
        break;
    }
}
- (void)sliderBtnTouchBegin:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sliderTouchBegan:)]) {
        [self.delegate sliderTouchBegan:self.value];
    }
    [self showContentWithBeginDragging:YES];
}
- (void)sliderBtnTouchEnded:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sliderTouchEnded:)]) {
        [self.delegate sliderTouchEnded:self.value];
    }
    if ([self.delegate respondsToSelector:@selector(sliderVVView:sliderTouchEnded:)]) {
        [self.delegate sliderVVView:self sliderTouchEnded:self.value];
    }
    [self showContentWithBeginDragging:NO];
}
- (void)sliderBtnDragMoving:(UIButton *)btn point:(CGPoint)touchPoint {
    // 点击的位置
    CGPoint point = touchPoint;// 获取进度值 由于btn是从 0-(self.width - btn.width)
    CGFloat value = (point.x - btn.width * 0.5) / self.bgProgressView.width;// value的值需在0-1之间
    value = value >= 1.0 ? 1.0 : value <= 0.0 ? 0.0 : value;
    if (self.value == value) return;
    self.isForward = self.value < value;
    self.value = value;
    if ([self.delegate respondsToSelector:@selector(sliderValueChanged:)]) {
        [self.delegate sliderValueChanged:value];
    }
}
- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.bgProgressView];// 获取进度
    CGFloat value = (point.x - self.sliderBtn.width * 0.5) * 1.0 / self.bgProgressView.width;
    value = value >= 1.0 ? 1.0 : value <= 0 ? 0 : value;
    self.value = value;
    if ([self.delegate respondsToSelector:@selector(sliderTapped:)]) {
        [self.delegate sliderTapped:value];
    }
}
#pragma mark - getter
- (UIView *)bgProgressView {
    if (!_bgProgressView) {
        _bgProgressView = [UIImageView new];
        _bgProgressView.frame = CGRectMake(12, 0, self.width-24, 2);
        _bgProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _bgProgressView.clipsToBounds = YES;
    }
    return _bgProgressView;
}
- (UIView *)sliderProgressView {
    if (!_sliderProgressView) {
        _sliderProgressView = [UIImageView new];
        _sliderProgressView.backgroundColor = [UIColor grayColor];
        _sliderProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _sliderProgressView.clipsToBounds = YES;
    }
    return _sliderProgressView;
}
- (TPVerticalVideoSliderButton *)sliderBtn {
    if (!_sliderBtn) {
        _sliderBtn = [TPVerticalVideoSliderButton buttonWithType:UIButtonTypeCustom];
        [_sliderBtn setAdjustsImageWhenHighlighted:NO];
        _sliderBtn.frame = CGRectMake(12, 0, 4, 4);
        _sliderBtn.layer.masksToBounds = YES;
        _sliderBtn.layer.cornerRadius = 2;
    }
    return _sliderBtn;
}

@end
