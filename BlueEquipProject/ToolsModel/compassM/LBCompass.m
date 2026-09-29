//
//  LBCompass.m
//  LPJCompassDemo
//
//  Created by fighting on 17/3/2.
//  Copyright © 2017年 JuLiHuYu. All rights reserved.
//

#import "LBCompass.h"
#import "LBSenderManager.h"
#import "LBHorizonView.h"
#import "LPJDialView.h"
#define defaultRadius 80//100
#define LPJCOLOR(x,y,z,a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]
@interface LBCompass ()
@property (nonatomic, assign)CGFloat radius;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGFloat scale;
//表盘
@property (nonatomic, weak) UIView *dialView;
//显示角度lable
@property (nonatomic, weak) UILabel * angleLabel;
//方向Label
@property (nonatomic, weak) UILabel * directionLaebl;
//经纬度label
@property (nonatomic, weak) UILabel * coordinateLabel;
//水平仪
@property (nonatomic, weak) LBHorizonView * horizonView;

@property (nonatomic, strong) LBSenderManager *manager;
@end

@implementation LBCompass

+ (instancetype)sharedWithFrame:(CGRect)frame andRadius:(CGFloat)radius
{
    return [[self alloc]initWithFrame:frame andRadius:radius];
}

- (instancetype)initWithFrame:(CGRect)frame andRadius:(CGFloat)radius
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _point = CGPointMake(frame.size.width/2, frame.size.width/2);
        _radius = radius;
        _scale = radius/100;
        [self createUI];
        [self startSensor];
    }
    return self;
}

- (void)createUI
{
    //创建水平仪
//    [self createHorizonView];
    //创建表盘
    [self createDial];
    //创建刻度盘
    [self createCalibration];
    //重置尺寸
    [self resetSize];
    
}

- (void)createHorizonView
{
    LBHorizonView * horizonView = [LBHorizonView sharedWithFrame:CGRectMake(0, 0, 46, 46) andRadius:23];
    horizonView.center = _point;
    _horizonView = horizonView;
    [self addSubview:_horizonView];
}

/**
 *  重置尺寸
 */
- (void)resetSize
{
    _dialView.transform = CGAffineTransformScale(_dialView.transform, _scale, _scale);
}


/**
 *  启动传感器
 */
- (void)startSensor
{
    __weak typeof(self)mySelf = self;
    _manager = [LBSenderManager shared];
    
    _manager.didUpdateHeadingBlock = ^(CLLocationDirection theHeading){
        [mySelf updateHeading:theHeading];
    };
    _manager.updateDeviceMotionBlock = ^(CMDeviceMotion *data){
        
        mySelf.horizonView.center = CGPointMake(self->_point.x + data.gravity.x*self->_radius*0.5, self->_point.y + data.gravity.y*self->_radius*0.5);
    };
    _manager.updateCoordinateBlock = ^(CLLocationCoordinate2D coor){
        mySelf.coordinateLabel.text = [NSString stringWithFormat:@"纬度：%.2f 经度：%.2f",coor.latitude,coor.longitude];
    };
    [_manager startGyroscope];
    [_manager startSensor];
}
- (void)updateHeading:(CLLocationDirection)theHeading
{
    int angle = (int)theHeading;
    _angleLabel.text = [NSString stringWithFormat:@"%d°",angle];
    switch (angle) {
        case 0:
            _directionLaebl.text = @"北";
            break;
        case 90:
            _directionLaebl.text = @"东";
            break;
        case 180:
            _directionLaebl.text = @"南";
            break;
        case 270:
            _directionLaebl.text = @"西";
            break;
            
        default:
            break;
    }
    if (angle > 0 && angle < 90) {
        _directionLaebl.text = @"东北";
    }else if (angle > 90 && angle < 180){
        _directionLaebl.text = @"东南";
    }else if (angle > 180 && angle < 270){
        _directionLaebl.text = @"西南";
    }else if (angle > 270 ){
        _directionLaebl.text = @"西北";
    }
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGAffineTransform headingRotation;
                         headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)-(theHeading*M_PI/180));
                         
                         headingRotation = CGAffineTransformScale(headingRotation, _scale, _scale);
                         _dialView.transform = headingRotation;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    // Animate Pointer
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGAffineTransform headingRotation;
                         headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)0 * M_PI/180-theHeading * M_PI/180);
                         
                         headingRotation = CGAffineTransformScale(headingRotation, _scale, _scale);
                         _dialView.transform = headingRotation;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

/**
 *  创建表盘
 */
- (void)createDial
{
    LPJDialView * view = [LPJDialView sharedWithFrame:CGRectMake(0, 0, defaultRadius*2, defaultRadius*2) andRadius:_radius andScale:_scale];
    view.center =_point;
    [self addSubview:view];
    UIView *dialView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, defaultRadius*2, defaultRadius*2)];
    dialView.center = _point;
    _dialView = dialView;
    [self addSubview:_dialView];
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_dialView.frame.size.width/2, _dialView.frame.size.height/2) radius:defaultRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [LPJCOLOR(100,100,100,1) CGColor];//UIColor.whiteColor.CGColor;
    shapeLayer.path = path.CGPath;
    [_dialView.layer addSublayer:shapeLayer];
}
/**
 *  创建表盘上的刻度
 */
- (void)createCalibration
{
    CGFloat perAngle = M_PI/90;
    
    NSArray *array = @[@"N",@"E",@"S",@"W"];
    
    for (int i = 0; i < 180; i++) {
        
        CGFloat startAngle = (-(M_PI_2+M_PI/180/2)+perAngle*i);
        CGFloat endAngle = startAngle+perAngle/2;
        
//        UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_dialView.frame.size.width/2, _dialView.frame.size.height/2) radius:defaultRadius*0.9 startAngle:startAngle endAngle:endAngle clockwise:YES];
        UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_dialView.frame.size.width/2, _dialView.frame.size.height/2) radius:defaultRadius*0.97 startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        if (i == 0) {
            shapeLayer.strokeColor = [[UIColor redColor]CGColor];
            shapeLayer.lineWidth = 10;
        }
        else if (i%15 == 0) {
            shapeLayer.strokeColor = [LPJCOLOR(50,50,50,1) CGColor];
            shapeLayer.lineWidth = 10;
        }else{
            shapeLayer.strokeColor = [LPJCOLOR(100,100,100,1) CGColor];
            shapeLayer.lineWidth = 5;
        }
        
        shapeLayer.path = bezPath.CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [_dialView.layer addSublayer:shapeLayer];
        
        if (i%15 == 0){
            //刻度的标注 0 30 60...
            NSString *tickText = [NSString stringWithFormat:@"%d",i * 2];
            CGFloat textAngel = startAngle+(endAngle-startAngle)/2;
//            CGPoint point = [self calculateTextPositonWithArcCenter:CGPointMake(_dialView.frame.size.width/2, _dialView.frame.size.height/2)Angle:textAngel andScale:1.1];
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, 30, 15)];
//            label.center = point;
//            label.text = tickText;
//            label.textColor = LPJCOLOR(100,100,100,1);//LPJCOLOR(200,200,200,1);
//            label.font = [UIFont systemFontOfSize:15];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)(i * 2)*(M_PI/180));
//            [_dialView addSubview:label];
            if (i%45 == 0){
                //北 东 南 西
                tickText = array[i/45];
                CGPoint point = [self calculateTextPositonWithArcCenter:CGPointMake(_dialView.frame.size.width/2, _dialView.frame.size.height/2)Angle:textAngel andScale:0.725];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, 30, 30)];
                label.center = point;
                label.text = tickText;
                label.textColor = LPJCOLOR(50,50,50,1);
                label.font = [UIFont systemFontOfSize:16];
                label.textAlignment = NSTextAlignmentCenter;
                label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)(i * 2)*(M_PI/180));
                
                [_dialView addSubview:label];
            }
        }
    }
}

//计算中心坐标
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center
                                       Angle:(CGFloat)angel andScale:(CGFloat)scale
{
    CGFloat x = defaultRadius*scale * cosf(angel);
    CGFloat y = defaultRadius*scale * sinf(angel);
    
    return CGPointMake(center.x + x, center.y + y);
}

//-(void)drawRect:(CGRect)rect
//{
//    CGFloat lineLength = defaultRadius * 0.6 * _scale;
//    CGFloat heardLength = 5 * _scale;
//    //获得处理的上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //指定直线样式
//    CGContextSetLineCap(context,kCGLineCapSquare);
//    //直线宽度
//    CGContextSetLineWidth(context,1.0);
//    //设置颜色
//    CGContextSetRGBStrokeColor(context,1, 1, 1, 1.0);
//    
//    //开始绘制水平线
//    CGContextBeginPath(context);
//    //画笔的起点
//    CGContextMoveToPoint(context, _dialView.center.x - lineLength, _dialView.center.y);
//    //画笔终点
//    CGContextAddLineToPoint(context, _dialView.center.x + lineLength, _dialView.center.y);
//    //绘制完成
//    CGContextStrokePath(context);
//    
//    //开始绘制竖直线
//    CGContextBeginPath(context);
//    //画笔起点
//    CGContextMoveToPoint(context, _dialView.center.x, _dialView.center.y - lineLength);
//    //画笔终点
//    CGContextAddLineToPoint(context, _dialView.center.x, _dialView.center.y + lineLength);
//    //绘制完成
//    CGContextStrokePath(context);
//    
//    for (int i = 0; i < 4; i++) {
//        //开始绘制小指针
//        CGContextBeginPath(context);
//        if (i == 0) {
//            //画笔起点
//            CGContextMoveToPoint(context, _dialView.center.x - heardLength, _dialView.center.y - lineLength + heardLength);
//            //画笔转点
//            CGContextAddLineToPoint(context, _dialView.center.x, _dialView.center.y - lineLength);
//            //画笔终点
//            CGContextAddLineToPoint(context, _dialView.center.x + heardLength, _dialView.center.y - lineLength + heardLength);
//        }else if (i == 1){
//            //画笔的起点
//            CGContextMoveToPoint(context, _dialView.center.x - lineLength + heardLength, _dialView.center.y - heardLength);
//            //画笔转点
//            CGContextAddLineToPoint(context, _dialView.center.x - lineLength, _dialView.center.y);
//            //画笔终点
//            CGContextAddLineToPoint(context, _dialView.center.x - lineLength + heardLength, _dialView.center.y + heardLength);
//        }else if (i == 2){
//            //画笔起点
//            CGContextMoveToPoint(context, _dialView.center.x - heardLength, _dialView.center.y + lineLength - heardLength);
//            //画笔转点
//            CGContextAddLineToPoint(context, _dialView.center.x, _dialView.center.y + lineLength);
//            //画笔终点
//            CGContextAddLineToPoint(context, _dialView.center.x + heardLength, _dialView.center.y + lineLength - heardLength);
//        }else{
//            //画笔的起点
//            CGContextMoveToPoint(context, _dialView.center.x + lineLength - heardLength, _dialView.center.y - heardLength);
//            //画笔转点
//            CGContextAddLineToPoint(context, _dialView.center.x + lineLength, _dialView.center.y);
//            //画笔终点
//            CGContextAddLineToPoint(context, _dialView.center.x + lineLength - heardLength, _dialView.center.y + heardLength);
//        }
//        
//        //绘制完成
//        CGContextStrokePath(context);
//    }
//    
//    
////    //画矩形
////    CGContextAddRect(context, CGRectMake(self.center.x - _scale, self.center.y - _radius * 1.15, 2 * _scale, 30 * _scale));
////    [[UIColor whiteColor] set];
////    CGContextFillPath(context);
//    
////    //画的小三角
////    CGContextBeginPath(context);
////    CGContextMoveToPoint(context, self.center.x, self.center.y - _radius-5); // 第一个点
////    CGContextAddLineToPoint(context, self.center.x - 5, self.center.y - _radius + 4); // 第二个点
////    CGContextAddLineToPoint(context, self.center.x + 5, self.center.y - _radius + 4); // 第三个点
////    [[UIColor redColor] set];
////    CGContextClosePath(context);
////    CGContextFillPath(context);
//    
//}

@end
