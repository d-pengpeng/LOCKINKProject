//
//  questMHuiDrawView.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import "questMHuiDrawView.h"

@interface questMHuiDrawView ()

@property (nonatomic, strong) UIView *floVVV;
@property (nonatomic, strong) CAShapeLayer *circleShap;
@property (nonatomic, strong) UIBezierPath *pathBezier;
@property (nonatomic, strong) UILabel *oneLLab;
@property (nonatomic, strong) UILabel *twoLLab;
@end
@implementation questMHuiDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
//        float angleToStart = 0.72*M_PI;  //2*M_PI 圆
//        float angleToEnd = 2.28f*M_PI;
        float angleToStart = 0.5*M_PI;
        float angleToEnd = 2.5f*M_PI;
        [self createCircleWithStartAngle:angleToStart endAngle:angleToEnd name:@"A"];
        
        self.floVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:self.floVVV];
        
        self.oneLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:44 textAlignment:NSTextAlignmentCenter];
        [self.floVVV addSubview:self.oneLLab];
        [self.oneLLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.floVVV.mas_top).offset(33);
            make.centerX.equalTo(self.floVVV.mas_centerX);
            make.height.offset(56);
        }];
        
        self.twoLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:18 textAlignment:NSTextAlignmentCenter];
        self.twoLLab.text = eLocalizedString(@"home_mode30");
        [self.floVVV addSubview:self.twoLLab];
        [self.twoLLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.oneLLab.mas_bottom);
            make.centerX.equalTo(self.floVVV.mas_centerX);
            make.height.offset(24);
        }];
    }
    return self;
}

- (void)addDataToUIUI:(int)floaN
{
    self.oneLLab.text = self.fbStr;
    float angleToStart = 0.5*M_PI;
    float angleToEnd = 0.5*M_PI + floaN*0.02*M_PI;
    [self uploadCircleWithStartAngle:angleToStart endAngle:angleToEnd name:@"B"];
    [self addSubview:self.floVVV];
}

-(void)uploadCircleWithStartAngle:(float)startAngle endAngle:(float)endAngle name:(NSString *)name{

    [self.circleShap removeFromSuperlayer];
    self.circleShap = nil;
    
    [self.pathBezier removeAllPoints];
    self.pathBezier = nil;
    
    UIView *subView = self;

    // Set up the shape of the circle
    int radius = self.width/2-15;

    self.circleShap = [CAShapeLayer layer];
    // Make a circular shape

    self.pathBezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.circleShap.path = [self.pathBezier CGPath];

    // Center the shape in self.view
    self.circleShap.position = CGPointMake(CGRectGetMidX(subView.bounds)-radius, CGRectGetMidY(subView.bounds)-radius);
    self.circleShap.fillColor = [UIColor clearColor].CGColor;

    //making line end cap round
    self.circleShap.lineCap=kCALineCapRound;

    UIColor *strokeColor;
    if([name isEqualToString:@"A"])
        strokeColor = [UIColor whiteColor];
    else if([name isEqualToString:@"B"])
        strokeColor = normalColors;
    else if([name isEqualToString:@"C"])
        strokeColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];

    self.circleShap.strokeColor = strokeColor.CGColor;
    self.circleShap.lineWidth = 15;

    // Add to parent layer
    [subView.layer addSublayer:self.circleShap];

//    // Configure animation
//    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    drawAnimation.duration            = 0.1;
//    drawAnimation.repeatCount         = 1.0;
//    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
//    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//
//    // Add the animation to the circle
//    [self.circleShap addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}

-(void)createCircleWithStartAngle:(float)startAngle endAngle:(float)endAngle name:(NSString *)name{

    UIView *subView = self;

    // Set up the shape of the circle
    int radius = self.width/2-15;

    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape

    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    circle.path = [path CGPath];

    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(subView.bounds)-radius, CGRectGetMidY(subView.bounds)-radius);
    circle.fillColor = [UIColor clearColor].CGColor;

    //making line end cap round
    circle.lineCap=kCALineCapRound;

    UIColor *strokeColor;
    if([name isEqualToString:@"A"])
        strokeColor = [UIColor whiteColor];
    else if([name isEqualToString:@"B"])
        strokeColor = normalColors;
    else if([name isEqualToString:@"C"])
        strokeColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];

    circle.strokeColor = strokeColor.CGColor;
    circle.lineWidth = 15;

    // Add to parent layer
    [subView.layer addSublayer:circle];

    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 1.0;
    drawAnimation.repeatCount         = 1.0;
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}

@end
