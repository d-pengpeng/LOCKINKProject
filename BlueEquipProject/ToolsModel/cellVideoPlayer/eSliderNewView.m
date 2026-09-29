//
//  eSliderNewView.m
//  beijing
//
//  东莞梦幻网络科技有限公司 注 on 2021/3/2.
//  Copyright © 2021 zhou last. All rights reserved.
//

#import "eSliderNewView.h"
#import "UIView+Frame.h"

@interface eSliderNewView ()

@property (nonatomic, strong) UIView *twoV;
@property (nonatomic, strong) UIView *oneV;
@property (nonatomic, strong) UIView *pointV;
@property (nonatomic, strong) UILabel *currentLab;
@property (nonatomic, strong) UILabel*totalLab;

@property (nonatomic, strong) UILabel*ggLab;

@property (nonatomic, assign) BOOL bboo;
@end

@implementation eSliderNewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentLab = [[UILabel alloc] init];
        self.currentLab.font = SYS_Font(16);
        self.currentLab.textColor = normalBlueColors;
        [self addSubview:self.currentLab];
        [self.currentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_centerX).offset(-5);
            make.height.offset(20);
        }];
        
        self.ggLab = [[UILabel alloc] init];
        self.ggLab.font = SYS_Font(16);
        self.ggLab.text = @"/";
        self.ggLab.textColor = GrayText;
        [self addSubview:self.ggLab];
        [self.ggLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            make.height.offset(20);
        }];
        
        self.totalLab = [[UILabel alloc] init];
        self.totalLab.font = SYS_Font(16);
        self.totalLab.textColor = normalOrangeColors;
        [self addSubview:self.totalLab];
        [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.mas_centerX).offset(5);
            make.height.offset(20);
        }];
        
        self.currentLab.hidden = YES;
        self.totalLab.hidden = YES;
        self.ggLab.hidden = YES;
        
        self.twoV = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-10, frame.size.width, 1)];
        self.twoV.backgroundColor = GroupBackColor;
        [self addSubview:self.twoV];
        
        self.oneV = [[UIView alloc] initWithFrame:CGRectMake(-frame.size.width, frame.size.height-10, frame.size.width, 1)];
        self.oneV.backgroundColor = normalBlueColors;
        [self addSubview:self.oneV];
        
        self.pointV = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-12.5, 6, 6)];
        self.pointV.backgroundColor = normalBlueColors;
        self.pointV.layer.cornerRadius = 3;
        self.pointV.clipsToBounds = YES;
        [self addSubview:self.pointV];
        self.pointV.hidden = YES;
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.twoV.frame = CGRectMake(0, self.frame.size.height-11.0, self.frame.size.width, 3);
    self.oneV.frame = CGRectMake(self.oneV.x, self.frame.size.height-11.0, self.frame.size.width, 3);
    self.pointV.frame = CGRectMake(self.oneV.x+ self.frame.size.width, self.frame.size.height-12.5, 6, 6);
    self.pointV.hidden = NO;
    
    self.currentLab.hidden = NO;
    self.totalLab.hidden = NO;
    self.ggLab.hidden = NO;
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.bboo = YES;
    
    UITouch *touch = [touches anyObject];

    //求偏移量 = 手指当前点的X - 手指上一个点的X
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    
    CGFloat offSetY = currentPoint.x - prePoint.x;
                    
    if (self.oneV.x+offSetY > 0) {
        
        
    }else {
        self.oneV.transform = CGAffineTransformTranslate(self.oneV.transform, offSetY, 0);
        self.pointV.transform = CGAffineTransformTranslate(self.pointV.transform, offSetY, 0);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat valss = (self.oneV.x + self.frame.size.width) / self.frame.size.width;
    if (self.esliderBlock) {
        self.esliderBlock(valss);
    }

    int64_t delayInSeconds = 1000; // 延迟的时间
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
    
        weakSelf.bboo = NO;
    });
    
    int64_t delSeconds = 3000; // 延迟的时间

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delSeconds * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{

        weakSelf.twoV.frame = CGRectMake(0, self.frame.size.height-10, self.frame.size.width, 1);
        weakSelf.oneV.frame = CGRectMake(self.oneV.x, self.frame.size.height-10, self.frame.size.width, 1);
        weakSelf.pointV.hidden = YES;
        
        weakSelf.bboo = NO;
        weakSelf.currentLab.hidden = YES;
        weakSelf.totalLab.hidden = YES;
        weakSelf.ggLab.hidden = YES;
    });
}

- (void)eSliderNewWithPlayTime:(NSInteger)playTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue
{
    if (self.bboo) {
        
    }else {
        
        //当前时长进度progress
        NSInteger proMin = playTime / 60;//当前秒
        NSInteger proSec = playTime % 60;//当前分钟
        //duration 总时长
        NSInteger durMin = totalTime / 60;//总秒
        NSInteger durSec = totalTime % 60;//总分钟
        
        //更新当前播放时间
        CGFloat ww_w = self.frame.size.width * sliderValue;
        
        if (self.currentLab.hidden == YES) {
            self.oneV.frame = CGRectMake(ww_w-self.frame.size.width, self.frame.size.height-10, self.frame.size.width, 1);
        }else {
            self.oneV.frame = CGRectMake(ww_w-self.frame.size.width, self.frame.size.height-11.0, self.frame.size.width, 3);
        }
        
        self.currentLab.text = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
        //更新总时间
        self.totalLab.text = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];
    }
}

@end
