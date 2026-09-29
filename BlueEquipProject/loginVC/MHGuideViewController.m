//
//  MHGuideViewController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/4.
//

#import "MHGuideViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface MHGuideViewController ()<SDCycleScrollViewDelegate>
{
    CAShapeLayer* _trackLayer;
    CAShapeLayer* _progressLayer;
    int curIndex;
}
@property (nonatomic, strong) SDCycleScrollView *cycleScrollV;
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSArray *listArray2;
@property (nonatomic,strong) NSTimer *progressTimer;
@property (nonatomic,assign) int showTime;
@property (nonatomic,assign) int allTime;
@property (nonatomic,assign) CGFloat countTime;
@property (nonatomic,strong) UIButton *circleBtn;
@property (nonatomic,strong) UIButton *jumpBtn;

@end

@implementation MHGuideViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hideNavView = YES;
    
    self.cycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _window_width, _window_height) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    self.cycleScrollV.clipsToBounds = YES;
    self.cycleScrollV.layer.cornerRadius = 8;
    self.cycleScrollV.currentPageDotColor = UIColor.whiteColor;
    [self.cycleScrollV disableScrollGesture];
    self.cycleScrollV.autoScrollTimeInterval = 1;
    self.cycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    self.cycleScrollV.showPageControl = NO;
    self.cycleScrollV.backgroundColor = GrayTextColor;
    [self.view addSubview:self.cycleScrollV];

    NSMutableArray *lisMAr = [NSMutableArray array];
    NSMutableArray *lisMAr2 = [NSMutableArray array];
    for (NSDictionary *dicM in [LYUserDefault userDefault].adListArr) {
        [lisMAr addObject:dicM[@"url"]];
        [lisMAr2 addObject:dicM[@"link"]];
    }
    self.listArray = lisMAr;
    self.listArray2 = lisMAr2;
    self.cycleScrollV.imageURLStringsGroup = lisMAr;
    
    [self oneUIUIUIUIUMethod];
}

//MARK: 轮播图点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSString *url_str = minStr(self.listArray2[index]);
    NSString *safari_url = [url_str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (safari_url.length > 0) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:safari_url]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:safari_url] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }
}

- (void)oneUIUIUIUIUMethod
{
    _countTime = 0.1;
    _allTime = (int)self.listArray.count*2;
    
    CGFloat w_hh = [HistoryRecordModel jiSuanWith:eLocalizedString(@"home_skip") font:15];
    if(w_hh<40) {
        w_hh = 40;
    }
    _circleBtn = [UIButton buttonWithType:0];
    _circleBtn.frame = CGRectMake(_window_width-w_hh-10, 40+TIMESTATUSHEIGHT, w_hh, w_hh);
    [_circleBtn setTitle:eLocalizedString(@"home_skip") forState:0];
    _circleBtn.titleLabel.font = SYS_Font(13);
    _circleBtn.layer.cornerRadius = w_hh/2;
    _circleBtn.layer.masksToBounds = YES;
    [_circleBtn addTarget:self action:@selector(jumpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_circleBtn setBackgroundColor:RGB_COLOR(@"#000000", 0.5)];
    [self.view addSubview:_circleBtn];
    float centerX = _circleBtn.width/2.0;
    float centerY = _circleBtn.height/2.0;
    //半径
    float radius = (_circleBtn.width-3)/2.0;

    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:YES];

    //添加背景圆环

    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.frame = _circleBtn.bounds;
    backLayer.fillColor =  [[UIColor clearColor] CGColor];
    backLayer.strokeColor  = [UIColor whiteColor].CGColor;
    backLayer.lineWidth = 3;
    backLayer.path = [path CGPath];
    backLayer.strokeEnd = 1;
    [_circleBtn.layer addSublayer:backLayer];

    //创建进度layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = _circleBtn.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    //指定path的渲染颜色
    _progressLayer.strokeColor  = [[UIColor blackColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = 3;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 0;

    //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = _circleBtn.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[RGB_COLOR(@"#ff7200", 1) CGColor],(id)[RGB_COLOR(@"#ff7200", 1) CGColor], nil]];//normalColors
    gradientLayer.startPoint = CGPointMake(1, 1);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [_circleBtn.layer addSublayer:gradientLayer];
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:_countTime target:self selector:@selector(progresTimeDaoJiShi) userInfo:nil repeats:YES];
}

- (void)progresTimeDaoJiShi {
    _countTime += 0.1;
    _progressLayer.strokeEnd = _countTime/_allTime;
    [_progressLayer removeAllAnimations];
    if (_countTime >= _allTime) {
        [self jumpBtnClick];
    }
}

- (void)jumpBtnClick{
    [self stopMEtthod];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
}

- (void)stopMEtthod {
    if (_progressTimer) {
        [_progressTimer invalidate];
        _progressTimer = nil;
    }
}

@end
