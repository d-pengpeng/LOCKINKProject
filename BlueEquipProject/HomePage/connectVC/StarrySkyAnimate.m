//
//  StarrySkyAnimate.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/20.
//

#import "StarrySkyAnimate.h"
#import "UIView+Frame.h"
#import "UIButton+MyBtn.h"

@implementation StarrySkyAnimate

{
    NSInteger _arrNu;
    NSTimer *timeLL;
    NSInteger _js_num;
}

-(instancetype)init{
    if (self = [super init]) {
        self.arMut = [NSMutableArray array];
//        self.arMutTwo = [NSMutableArray array];
    }
    return self;
}

-(void)createCircle {
    //创建运动的轨迹动画
    
    CGFloat row_rll = 2*M_PI/self.ar_twoAr.count;
    
    float s_www = 360/self.ar_twoAr.count;
    if(self.ar_twoAr.count > 8) {
        row_rll = 2*M_PI/8;
        s_www = 360/8;
    }
    
    for (int i = 0; i < self.ar_twoAr.count; i++) {
        
        if(i>7) {
            continue;
        }
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.repeatCount = CGFLOAT_MAX;
        
        float ButtonWidth = 0.0;
        //外圆
        float radiuscale = 0.0;
        CGFloat origin_x = 0.0 ;
        CGFloat origin_y = 0.0;
        CGFloat radiusX = 0.0;
        float beginAng = M_PI;
        float endAng = M_PI;
        NSString *imageName = [NSString new];
        
        ////                radiuscale = (SCREEN_WIDTH/2.0-50)/(SCREEN_WIDTH-60);  //h / w
        ////                origin_x = (SCREEN_WIDTH-60)/2+30;  // w/2 + x
        ////                origin_y = (SCREEN_WIDTH/2-50)/2.0+25;  // h/2 + y
        ////                radiusX = (SCREEN_WIDTH-60)/2; // w/2
        
        ButtonWidth = 46;
        pathAnimation.duration = 36.0;
        radiuscale = (SCREEN_WIDTH/2.0)/(SCREEN_WIDTH-20); //调整 椭圆度
        origin_x = (SCREEN_WIDTH-20)/2.0+10;
        origin_y = SCREEN_WIDTH/2.0/2.0+0;
        radiusX = (SCREEN_WIDTH-20)/2.0;
        beginAng = M_PI / 6 + row_rll*i;
        endAng = M_PI/6 + row_rll*i + M_PI*2;
        imageName = @"14";
        
        CGMutablePathRef ovalfromarc = CGPathCreateMutable();
        CGAffineTransform t2 = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x,-origin_y), CGAffineTransformMakeScale(1, radiuscale)), CGAffineTransformMakeTranslation(origin_x, origin_y));
        CGPathAddArc(ovalfromarc, &t2, origin_x, origin_y, radiusX, beginAng, endAng, 0);
        pathAnimation.path = ovalfromarc;
        CGPathRelease(ovalfromarc);
        
        
        UIButton *sButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sButton.bounds = CGRectMake(0, 0, ButtonWidth, ButtonWidth+30);
        sButton.tag = 1300+i;
        sButton.btnAngle = @(s_www * i);
        [sButton zp];
        [sButton changeSize];
        [sButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.layer addSublayer:sButton.layer];
        [self addSubview:sButton];
        [sButton.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
        
        UIImageView *imgVV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, ButtonWidth-10, ButtonWidth-10)];
        imgVV.image = [UIImage imageNamed:@"imgimg1"];
//        imgVV.transform = CGAffineTransformMakeRotation(M_PI_2/2);
        imgVV.tag = i+100;
        imgVV.clipsToBounds = YES;
        imgVV.layer.cornerRadius = (ButtonWidth-10)/2;
        [sButton addSubview:imgVV];
        
        UILabel *nameLL = [[UILabel alloc] initWithFrame:CGRectMake(0, ButtonWidth, ButtonWidth, 20)];
        nameLL.textColor = UIColor.whiteColor;
        nameLL.font = [UIFont systemFontOfSize:10];
        nameLL.textAlignment = NSTextAlignmentCenter;
        [sButton addSubview:nameLL];
        
        NSDictionary *dicm = self.ar_twoAr[i];
        nameLL.text = minStr(dicm[@"nickName"]);
        [imgVV sd_setImageWithURL:[NSURL URLWithString:minStr(dicm[@"profile"])] placeholderImage:normal_placeHeadImg];

        [self.arMut addObject:sButton];
    }
    
    
    
//    CGFloat row_rll = 2*M_PI/(self.ar_twoAr.count+1);
//    if(self.ar_twoAr.count > 8) {
//        row_rll = 2*M_PI/9;
//    }
//
//    for (NSInteger i = 0; i < self.ar_twoAr.count; i++) {
//
//        if(i>7) {
//            continue;
//        }
//
//        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        pathAnimation.calculationMode = kCAAnimationPaced;
//        pathAnimation.fillMode = kCAFillModeForwards;
//        pathAnimation.removedOnCompletion = NO;
//        pathAnimation.repeatCount = CGFLOAT_MAX;
//
//        float ButtonWidth = 0.0;
//        //外圆
//        float radiuscale = 0.0;
//        CGFloat origin_x = 0.0 ;
//        CGFloat origin_y = 0.0;
//        CGFloat radiusX = 0.0;
//        float beginAng = M_PI;
//        float endAng = M_PI;
//        NSString *imageName = [NSString new];
//
//        ////                radiuscale = (SCREEN_WIDTH/2.0-50)/(SCREEN_WIDTH-60);  //h / w
//        ////                origin_x = (SCREEN_WIDTH-60)/2+30;  // w/2 + x
//        ////                origin_y = (SCREEN_WIDTH/2-50)/2.0+25;  // h/2 + y
//        ////                radiusX = (SCREEN_WIDTH-60)/2; // w/2
//
//        ButtonWidth = 46;
//        pathAnimation.duration = 30.0;
//        radiuscale = (SCREEN_WIDTH/2.0)/(SCREEN_WIDTH-20);
//        origin_x = (SCREEN_WIDTH-20)/2.0+10;
//        origin_y = SCREEN_WIDTH/2.0/2.0+0;
//        radiusX = (SCREEN_WIDTH-20)/2.0;
//        beginAng = M_PI / 6 + row_rll*i;
//        endAng = M_PI/6 + row_rll*i + M_PI*2;
//        imageName = @"14";
//
//        CGMutablePathRef ovalfromarc = CGPathCreateMutable();
//        CGAffineTransform t2 = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x,-origin_y), CGAffineTransformMakeScale(1, radiuscale)), CGAffineTransformMakeTranslation(origin_x, origin_y));
//        CGPathAddArc(ovalfromarc, &t2, origin_x, origin_y, radiusX,beginAng,endAng, 0);
//        pathAnimation.path = ovalfromarc;
//        CGPathRelease(ovalfromarc);
//
//        UIButton *sButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [sButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        sButton.frame = CGRectMake(0, 0,ButtonWidth, ButtonWidth);
//        sButton.tag = 1300+i;
//        [sButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:sButton];
//        [sButton.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
//
//        UIImageView *onePPP2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ButtonWidth, ButtonWidth)];
////        onePPP2.transform = CGAffineTransformMakeRotation(M_PI+M_PI_4/2);
//        onePPP2.image = normal_placeHeadImg;
//        onePPP2.clipsToBounds = YES;
//        onePPP2.layer.cornerRadius = ButtonWidth/2;
//        [sButton addSubview:onePPP2];
//        [onePPP2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(sButton);
//        }];
//
//        NSDictionary *dicm = self.ar_twoAr[i];
//        [onePPP2 sd_setImageWithURL:[NSURL URLWithString:minStr(dicm[@"profile"])] placeholderImage:normal_placeHeadImg];
//
//        [self.arMutTwo addObject:onePPP2];
//
//        [self.arMut addObject:sButton];
//    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    //获取动画当前中心点坐标
    for (int i=0; i<self.arMut.count; i++) {
        UIButton *bbMM = self.arMut[i];
        CGPoint currentPosition = [[bbMM.layer presentationLayer] position];
        if (touchPoint.x > currentPosition.x - 20 && touchPoint.x < currentPosition.x + 20 && touchPoint.y > currentPosition.y - 20 && touchPoint.y < currentPosition.y + 20) {
            [self centerButtonAction:bbMM];
        }
    }
    
//    UITouch *touch = touches.allObjects.firstObject;
//    if (touch != nil) {
//        self.isBoo = YES;
//        self.lastPointInSuperView = [self touchPointInScreen:touch];
//    }
}



//按钮点击
- (void)centerButtonAction:(UIButton *)sender{

    NSLog(@"--点击--%ld", (long)sender.tag);
    if ([self.delegate respondsToSelector:@selector(clickButtonAction:)]) {
        [self.delegate clickButtonAction:sender.tag-1300];
    }
}

//字体的动画组
- (void)labelAnimationWithName:(NSArray *)names{
    
    
//    UILabel * label = [[UILabel alloc] init];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:label];
//    label.frame = CGRectMake(View_width/2-25-45, SCREEN_WIDTH/4-20, 50, 20);
////    label.text = @"话题中心";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:12.f];
//    label.transform = CGAffineTransformRotate (label.transform,- (M_PI-M_PI_2/6));
    
    CGFloat row_rll = 2*M_PI/(names.count+1);
    if(names.count > 8) {
        row_rll = 2*M_PI/9;
    }
    
    for (NSInteger i = 0; i < names.count; i++) {
        
        if(i > 7) {
            continue;
        }
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.repeatCount = CGFLOAT_MAX;

        //外圆
        float radiuscale = 0.0;
        CGFloat origin_x = 0.0 ;
        CGFloat origin_y = 0.0;
        CGFloat radiusX = 0.0;
        float beginAng = M_PI;
        float endAng = M_PI;
        CGFloat deviationTextX = 0.0;
        CGFloat deviationTextY = 0.0;
        
//        radiuscale = (SCREEN_WIDTH/2.0-50)/(SCREEN_WIDTH-60);  //h / w
//        origin_x = (SCREEN_WIDTH-60)/2+30;  // w/2 + x
//        origin_y = (SCREEN_WIDTH/2-50)/2.0+25;  // h/2 + y
//        radiusX = (SCREEN_WIDTH-60)/2; // w/2
        
        pathAnimation.duration = 30.0;
        radiuscale = (SCREEN_WIDTH/2.0)/(SCREEN_WIDTH-20);
        origin_x = (SCREEN_WIDTH-20)/2.0+10;
        origin_y = SCREEN_WIDTH/2.0/2.0+70;
        radiusX = (SCREEN_WIDTH-20)/2.0;
        beginAng = M_PI / 6 + row_rll*i;
        endAng = M_PI/6 + row_rll*i + M_PI*2;
//        deviationTextX = origin_x+5;
        deviationTextX = origin_x;
        deviationTextY = origin_y-60;
        
        CGMutablePathRef ovalfromarc = CGPathCreateMutable();
        CGAffineTransform t2 = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x,-origin_y), CGAffineTransformMakeScale(1, radiuscale)), CGAffineTransformMakeTranslation(origin_x, origin_y));
        CGPathAddArc(ovalfromarc, &t2, deviationTextX, deviationTextY, radiusX, beginAng, endAng, 0);
        pathAnimation.path = ovalfromarc;
        CGPathRelease(ovalfromarc);
        
        NSDictionary *diMM = names[i];
        UILabel * label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.frame = CGRectMake(0, 0, 80, 20);
        label.text = minStr(diMM[@"nickName"]);
        label.tag = 1200+i;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10.f];
        label.backgroundColor = UIColor.clearColor;
        //设置运转的动画
        [label.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
//        label.transform = CGAffineTransformRotate (label.transform,- (M_PI-M_PI_2/6)); //MARK: 角度
    }
//    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    centerButton.tag = 999;
//    centerButton.frame = CGRectMake(View_width/2-25, SCREEN_WIDTH/4-25, 50, 50);
//    [centerButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:centerButton];
}
//贝塞尔
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //内园
//    UIBezierPath *ccc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/4+40,  SCREEN_WIDTH/7, SCREEN_WIDTH/2, SCREEN_WIDTH/4.5)];
//    [COLOR(147.f, 151.f, 157.f,0.5f) setStroke];
//    [ccc stroke];
//    //中园
//    UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(30, 25, SCREEN_WIDTH-60,SCREEN_WIDTH/2-50)];
//    [COLOR(147.f, 151.f, 157.f,0.5f)  setStroke];
//    [arc stroke];
    //外圆
//    UIBezierPath *acc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 0, SCREEN_WIDTH-20, SCREEN_WIDTH/2)];
//    [COLOR(147.f, 151.f, 157.f,0.5f)  setStroke];
//    [acc stroke];
//    CGContextRestoreGState(context);
   
}


-(void)setCelestialName:(NSArray *)names {

    self.userInteractionEnabled= YES;
    self.backgroundColor = [UIColor clearColor];
    
//    self.transform = CGAffineTransformRotate (self.transform, M_PI-M_PI_2/6); //改变整体倾斜度
    [self removeAllSubviews];
    [self.arMut removeAllObjects];
//    [self.arMutTwo removeAllObjects];
    self.ar_twoAr = names;
//    [self labelAnimationWithName:names];
    [self createCircle];
    
    [timeLL invalidate];
    timeLL = nil;
    timeLL = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeMethodUI) userInfo:nil repeats:YES];
}

- (void)timeMethodUI
{
    if(!self.isBoo) {

        for (int i = 0; i < self.arMut.count; i ++)
        {
            UIButton *btn = self.arMut[i];
            btn.btnAngle = [NSNumber numberWithFloat: [btn.btnAngle floatValue] + 1];
            [btn zp];
            [btn changeSize];
            btn.userInteractionEnabled = YES;
        }
    }
}

//- (void)touchesMoved:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
//{
//    UITouch *touch = touches.allObjects.firstObject;
//    if (touch != nil) {
//        CGPoint currentpoint = [self touchPointInScreen:touch];
//        self.numYY = self.numYY+1;
//        int num_num = self.numYY%5;
//        if(self.lastPointInSuperView.x > currentpoint.x) {
//
//            if(num_num==1) {
//
//                _js_num = _js_num+1;
//                if(_js_num > 29) {
//                    _js_num = 0;
//                }
//
//                CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//                pathAnimation.calculationMode = kCAAnimationPaced;
//                pathAnimation.fillMode = kCAFillModeForwards;
//                pathAnimation.removedOnCompletion = NO;
//                pathAnimation.repeatCount = CGFLOAT_MAX;
//
//                //外圆
//                float radiuscale = 0.0;
//                CGFloat origin_x = 0.0 ;
//                CGFloat origin_y = 0.0;
//                CGFloat radiusX = 0.0;
//                float beginAng = M_PI;
//                float endAng = M_PI;
//                pathAnimation.duration = 30.0;
//
//                CGFloat deviationTextX = 0.0;
//                CGFloat deviationTextY = 0.0;
//
//                for (int i=0; i<self.arMut.count; i++) {
//                    UIButton *bbMM = self.arMut[i];
//
//                    //外圆
//                    radiuscale = (SCREEN_WIDTH/2.0)/(SCREEN_WIDTH-20);
//                    origin_x = (SCREEN_WIDTH-20)/2.0+10;
//                    origin_y = SCREEN_WIDTH/2.0/2.0+0;
//                    radiusX = (SCREEN_WIDTH-20)/2.0;
//                    beginAng = M_PI/6 + (M_PI*2*8*i)/30 + (M_PI*2*_js_num)/30;
//                    endAng = M_PI/6 + (M_PI*2*8*i)/30 + (M_PI*2*_js_num)/30 +M_PI*2;
//                    deviationTextX = origin_x-47;
//                    deviationTextY = origin_y-36;
//
//                    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
//                    CGAffineTransform t1 = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x,-origin_y), CGAffineTransformMakeScale(1, radiuscale)), CGAffineTransformMakeTranslation(origin_x, origin_y));
//                    CGPathAddArc(ovalfromarc, &t1, origin_x, origin_y, radiusX,beginAng,endAng, 0);
//                    pathAnimation.path = ovalfromarc;
//                    CGPathRelease(ovalfromarc);
//                    [bbMM.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
//
//                    CGMutablePathRef ovalfromarc3 = CGPathCreateMutable();
//                    CGPathAddArc(ovalfromarc3, &t1, deviationTextX, deviationTextY, radiusX, beginAng, endAng, 0);
//                    pathAnimation.path = ovalfromarc3;
//                    CGPathRelease(ovalfromarc3);
//                    UILabel *lla_bb = [self viewWithTag:1200+i];
//                    [lla_bb.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
//                }
//            }
//        }else {
//            if(num_num==1) {
//
//                _js_num = _js_num+1;
//                if(_js_num > 29) {
//                    _js_num = 0;
//                }
//
//                CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//                pathAnimation.calculationMode = kCAAnimationPaced;
//                pathAnimation.fillMode = kCAFillModeForwards;
//                pathAnimation.removedOnCompletion = NO;
//                pathAnimation.repeatCount = CGFLOAT_MAX;
//
//                //外圆
//                float radiuscale = 0.0;
//                CGFloat origin_x = 0.0 ;
//                CGFloat origin_y = 0.0;
//                CGFloat radiusX = 0.0;
//                float beginAng = M_PI;
//                float endAng = M_PI;
//                pathAnimation.duration = 30.0;
//
//                CGFloat deviationTextX = 0.0;
//                CGFloat deviationTextY = 0.0;
//
//                for (int i=0; i<self.arMut.count; i++) {
//                    UIButton *bbMM = self.arMut[i];
//
//                    //外圆
//                    radiuscale = (SCREEN_WIDTH/2.0)/(SCREEN_WIDTH-20);
//                    origin_x = (SCREEN_WIDTH-20)/2.0+10;
//                    origin_y = SCREEN_WIDTH/2.0/2.0+0;
//                    radiusX = (SCREEN_WIDTH-20)/2.0;
//                    beginAng = M_PI/6 + (M_PI*2*8*i)/30 - (M_PI*2*_js_num)/30;
//                    endAng = M_PI/6 + (M_PI*2*8*i)/30 - (M_PI*2*_js_num)/30 +M_PI*2;
//                    deviationTextX = origin_x-47;
//                    deviationTextY = origin_y-36;
//
//                    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
//                    CGAffineTransform t1 = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x,-origin_y), CGAffineTransformMakeScale(1, radiuscale)), CGAffineTransformMakeTranslation(origin_x, origin_y));
//                    CGPathAddArc(ovalfromarc, &t1, origin_x, origin_y, radiusX,beginAng,endAng, 0);
//                    pathAnimation.path = ovalfromarc;
//                    CGPathRelease(ovalfromarc);
//                    [bbMM.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
//
//                    CGMutablePathRef ovalfromarc3 = CGPathCreateMutable();
//                    CGPathAddArc(ovalfromarc3, &t1, deviationTextX, deviationTextY, radiusX, beginAng, endAng, 0);
//                    pathAnimation.path = ovalfromarc3;
//                    CGPathRelease(ovalfromarc3);
//                    UILabel *lla_bb = [self viewWithTag:1200+i];
//                    [lla_bb.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
//                }
//            }
//        }
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
//{
//    self.numYY = 0;
//    self.isBoo = NO;
//}
//
//- (CGPoint)touchPointInScreen:(UITouch *)touch {
//
//    return [self.superview convertPoint:[touch locationInView:self.superview] toCoordinateSpace:[[UIScreen mainScreen] coordinateSpace]];
//}

@end
