//
//  MHCreatePatternVView.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/8.
//

#import "MHCreatePatternVView.h"
#import "FloatingWController.h"

@interface MHCreatePatternVView ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) FloatingWController *floatingWCOne;
@property (nonatomic, strong) FloatingWController *floatingWCTwo;

@property (nonatomic, assign) CGFloat isSwaves;
@property (nonatomic, assign) CGFloat isSwaves2;
@property (nonatomic, assign) CGPoint oneSize;
@property (nonatomic, assign) CGPoint twoSize;
@property (nonatomic, assign) BOOL isOneB;
@property (nonatomic, assign) BOOL isTwoB;
@property (nonatomic, assign) NSInteger numHeFen;//合并后 哪个滑块在动

@property (nonatomic, assign) CGFloat oneHeigF;
@property (nonatomic, assign) CGFloat twoHeigF;
@property (nonatomic, assign) CGFloat HeigF;

@property (nonatomic, copy) NSString *oneStr;
@property (nonatomic, copy) NSString *twoStr;
@property (nonatomic, assign) BOOL isStartB;//是否开始记录

@property (nonatomic, assign) BOOL isBothBoo;
@property (nonatomic, assign) BOOL isCycleBoo;

@property (nonatomic, strong) NSMutableArray *cycleArr;
@property (nonatomic, strong) NSMutableArray *cycleTwoArr;
@property (nonatomic, assign) int isBZeroBMMM;
@property (nonatomic, assign) int cycleNum;
@property (nonatomic, assign) int cycleTwoNum;
@property (nonatomic, assign) int cycleNum2;
@property (nonatomic, assign) int cycleTwoNum2;
@property (nonatomic, assign) int timeJS;

@property (nonatomic, copy) NSString *oneCy;
@property (nonatomic, copy) NSString *twoCy;

@property (nonatomic, assign) CGFloat lef_widff;

@end
@implementation MHCreatePatternVView

- (NSMutableArray *)cycleArr
{
    if (!_cycleArr) {
        _cycleArr = [NSMutableArray array];
    }
    return _cycleArr;
}

- (NSMutableArray *)cycleTwoArr
{
    if(!_cycleTwoArr) {
        _cycleTwoArr = [NSMutableArray array];
    }
    return _cycleTwoArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)stopMethodUI
{
    [self.floatingWCOne clearUIVC];
    [self.floatingWCTwo clearUIVC];
    self.floatingWCOne.view.hidden = YES;
    self.floatingWCTwo.view.hidden = YES;
    
    self.oneCy = @"0";
    self.twoCy = @"0";
    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifNameIM object:nil userInfo:@{@"motor":@"0", @"strong":@"0", @"strong2":@"0"}];
}

- (void)addUIUIUIUType:(NSInteger)typeM
{
    [self removeAllSubviews];
    
    self.oneCy = @"0";
    self.twoCy = @"0";
    
    CGFloat all_y = _window_height - self.height;
    UIView *twoVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.height)];
    twoVV.backgroundColor = UIColor.clearColor;
    [self addSubview:twoVV];
    
    self.timeLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
    self.timeLab.frame = CGRectMake(0, 0, _window_width, 28);
    self.timeLab.text = @"00:00";
    [twoVV addSubview:self.timeLab];
    self.timeLab.hidden = YES;
    
    CGFloat h_all = twoVV.height-31-29;
    self.oneHeigF = h_all+10;
    self.twoHeigF = h_all+10;
    self.HeigF = all_y+30;
    
//    NSArray *imgsA = @[@"pattern_imgs4", @"pattern_imgs5", @"pattern_imgs6_6"];
//    NSArray *imgsASel = @[@"pattern_imgs4_4", @"pattern_imgs5_5", @"pattern_imgs6"];
//    NSArray *namsA = @[@"home_mode24", @"home_mode25", @"home_mode26"];
//    for (int i=0; i<imgsA.count; i++) {
//        UIView *rigSuV = [[UIView alloc] initWithFrame:CGRectMake(_window_width-55, 29+i*(h_all/3), 55, h_all/3)];
//        rigSuV.backgroundColor = UIColor.clearColor;
//        [twoVV addSubview:rigSuV];
//        
//        UIButton *thrBBtn = [HistoryRecordModel createImgBtn];
//        thrBBtn.frame = CGRectMake(0, h_all/6-30, 55, 60);
//        [thrBBtn setImage:[UIImage imageNamed:imgsA[i]] forState:UIControlStateNormal];
//        [thrBBtn setImage:[UIImage imageNamed:imgsASel[i]] forState:UIControlStateSelected];
//        [thrBBtn setTitle:eLocalizedString(namsA[i]) forState:UIControlStateNormal];
//        [thrBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        thrBBtn.titleLabel.font = SYS_Font(12);
//        [thrBBtn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleTop imageTitleSpace:2];
//        thrBBtn.tag = 710+i;
//        [thrBBtn addTarget:self action:@selector(thrBtnmethodS:) forControlEvents:UIControlEventTouchUpInside];
//        [rigSuV addSubview:thrBBtn];
//        if(i==2) {
//            thrBBtn.selected = YES;
//        }
//    }
    
    UIViewController *seleVC = [[FloatingWindowModel shareInstance] getCurrentViewController];
    
    self.floatingWCOne = [[FloatingWController alloc] init];
    self.floatingWCOne.selfVVC = seleVC;
    if ([self.devicTyp isEqualToString:kCharactName12]) {
        
        CGFloat fou_wXX = (_window_width-56-62)/2;
        self.lef_widff = fou_wXX;
        self.floatingWCOne.x_lef = fou_wXX;
    }else {
        CGFloat thr_wXX = (_window_width-56-124)/4;
        self.lef_widff = thr_wXX;
        self.floatingWCOne.x_lef = thr_wXX*3+62;
    }
    self.floatingWCOne.x_boundary = 56;
    self.floatingWCOne.y_boundary = all_y;
    self.floatingWCOne.imgName = @"center_img17";
    if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] && ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11])) {
        
    }else {
        [self.floatingWCOne showVC];
    }
    WEAKSELF
    self.floatingWCOne.FloatingWCCCCVieweBLock = ^(NSString * _Nonnull strLLLL) {
        [weakSelf FloatingWCCCCDelegateMethodTwo:strLLLL];
    };
    self.floatingWCOne.block_ = ^{
        if((self.numHeFen>0)&&!self.isTwoB) {
            weakSelf.isBothBoo = NO;
            if(self.oneSize.x > _window_width-56-124-30) {
                
                weakSelf.twoSize = CGPointMake(weakSelf.twoSize.x-120, weakSelf.twoSize.y);
            }else {
                weakSelf.twoSize = CGPointMake(weakSelf.twoSize.x+100, weakSelf.twoSize.y);
            }
            [weakSelf.floatingWCOne uploadImgMEhodname:@"center_img17"];
            if ([weakSelf.devicTyp isEqualToString:kCharactName4] || [weakSelf.devicTyp isEqualToString:kCharactName15]) {
                [weakSelf.floatingWCTwo uploadPointMethod:weakSelf.twoSize img:@"threeAdMut_imgs1_2"];
            }else {
                [weakSelf.floatingWCTwo uploadPointMethod:weakSelf.twoSize img:@"threeAdMut_imgs1"];
            }
            
            weakSelf.numHeFen = 0;
            
            UIButton *thrBBtn = [weakSelf viewWithTag:711];
            thrBBtn.selected = NO;
        }
    };
    
    self.floatingWCTwo = [[FloatingWController alloc] init];
    self.floatingWCTwo.selfVVC = seleVC;
    if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] && ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11])) {
        CGFloat fou_wXX = (_window_width-56-62)/2;
        
        self.lef_widff = fou_wXX;
        self.floatingWCTwo.x_lef = fou_wXX;
    }else {
        CGFloat thr_wXX = (_window_width-56-124)/4;
        self.floatingWCTwo.x_lef = thr_wXX+62;
    }
    
    self.floatingWCTwo.x_boundary = 56;
    self.floatingWCTwo.y_boundary = all_y;
    if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] || [self.devicTyp isEqualToString:kCharactName15]) {
        self.floatingWCTwo.imgName = @"threeAdMut_imgs1_2";
    }else {
        self.floatingWCTwo.imgName = @"threeAdMut_imgs1";
    }
    if (![self.devicTyp isEqualToString:kCharactName12]) {
        [self.floatingWCTwo showVC];
    }
    
    self.floatingWCTwo.FloatingWCCCCVieweBLock = ^(NSString * _Nonnull strLLLL) {
        [weakSelf FloatingWCCCCDThree:strLLLL];
    };
    self.floatingWCTwo.block_ = ^{
        
        if((self.numHeFen>0)&&!self.isOneB) {
            weakSelf.isBothBoo = NO;
            if(self.oneSize.x > _window_width-56-124-30) {
                
                weakSelf.oneSize = CGPointMake(weakSelf.oneSize.x-120, weakSelf.oneSize.y);
            }else {
                weakSelf.oneSize = CGPointMake(weakSelf.oneSize.x+100, weakSelf.oneSize.y);
            }
            if ([weakSelf.devicTyp isEqualToString:kCharactName4] || [weakSelf.devicTyp isEqualToString:kCharactName15]) {
                [weakSelf.floatingWCTwo uploadImgMEhodname:@"threeAdMut_imgs1_2"];
            }else {
                [weakSelf.floatingWCTwo uploadImgMEhodname:@"threeAdMut_imgs1"];
            }
            [weakSelf.floatingWCOne uploadPointMethod:weakSelf.oneSize img:@"center_img17"];
            weakSelf.numHeFen = 0;
            UIButton *thrBBtn = [weakSelf viewWithTag:711];
            thrBBtn.selected = NO;
        }
    };
    self.isSwaves = 10;
    self.isSwaves2 = 10;
    self.timeJS = 0;
    
}

- (void)chuShiHuaUIUI
{
    [self.floatingWCOne showVC];
    [self.floatingWCTwo showVC];
}

- (void)hiddenShowMMMMMM:(BOOL)isbb
{
    [self.floatingWCOne hiddenShowMMmehtodUIUIBoo:isbb];
    [self.floatingWCTwo hiddenShowMMmehtodUIUIBoo:isbb];
}

- (void)thrBtnmethodS:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    UIButton *oneBB = [self viewWithTag:710];
    UIButton *oneBB2 = [self viewWithTag:712];
    if(btn.tag == 710) {
        
//        self.isCycleBoo = !self.isCycleBoo;
//        oneBB2.selected = !oneBB2.selected;
//        self.isBooL = !self.isBooL;
//        if(self.isBooL) {
//            self.oneHeigF = 10;
//            self.twoHeigF = 10;
//            [self.floatingWCOne botmUIUIUBoo:YES];
//            [self.floatingWCTwo botmUIUIUBoo:YES];
//        }
        
        self.isCycleBoo = !self.isCycleBoo;
        if(self.isCycleBoo) {
            if(self.isBooL) {
                oneBB2.selected = !oneBB2.selected;
                self.isBooL = !self.isBooL;
                if(self.isBooL) {
                    self.oneHeigF = 10;
                    self.twoHeigF = 10;
                    [self.floatingWCOne botmUIUIUBoo:YES];
                    [self.floatingWCTwo botmUIUIUBoo:YES];
                }
            }
        }
        
    }else if (btn.tag == 711) {
        
        self.isBothBoo = !self.isBothBoo;
        if(self.isBothBoo) {
            self.isSwaves = 0;
            self.isSwaves2 = 0;
            if(self.oneSize.x>0) {
                
                self.twoSize = self.oneSize;
                self.numHeFen = 2;
                [self.floatingWCTwo uploadPointMethod:self.oneSize img:@""];
                [self.floatingWCOne uploadPointMethod:self.oneSize img:@"pattern_imgs3"];
    
            }else if(self.twoSize.x>0) {
                
                self.oneSize = self.twoSize;
                self.numHeFen = 1;
                [self.floatingWCTwo uploadPointMethod:self.oneSize img:@""];
                [self.floatingWCOne uploadPointMethod:self.oneSize img:@"pattern_imgs3"];
            }else {
                
                self.twoSize = self.oneSize = CGPointMake((_window_width-56)/2, _window_height-70);
                self.numHeFen = 1;
                [self.floatingWCTwo uploadPointMethod:self.oneSize img:@""];
                [self.floatingWCOne uploadPointMethod:self.oneSize img:@"pattern_imgs3"];

            }
            float kgh_h = _window_height-self.HeigF-30;
            float kk_wh = _window_height-self.oneSize.y-30;//self.oneSize.y-self.HeigF;
            float two_hh = 100*(kk_wh/kgh_h);
            self.twoHeigF = two_hh;
            self.oneHeigF = two_hh;
        }else {
            
            if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] && ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11])) {
//                CGFloat fou_wXX = (_window_width-56-62)/2;
                
                self.oneSize = CGPointMake(0, _window_height-70);
                self.twoSize = CGPointMake(self.lef_widff, _window_height-70);
                [self.floatingWCOne uploadPointMethod:self.oneSize img:@"center_img17"];
                if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp]) {
                    [self.floatingWCTwo uploadPointMethod:self.twoSize img:@"threeAdMut_imgs1_2"];
                }else {
                    [self.floatingWCTwo uploadPointMethod:self.twoSize img:@"threeAdMut_imgs1"];
                }
            }else if ([self.devicTyp isEqualToString:kCharactName12]) {
                                
                self.oneSize = CGPointMake(self.lef_widff, _window_height-70);
                self.twoSize = CGPointMake(0, _window_height-70);
                [self.floatingWCOne uploadPointMethod:self.oneSize img:@"center_img17"];
            
            }else {
                
                CGFloat thr_wXX = (_window_width-56-124)/4;
                self.oneSize = CGPointMake(thr_wXX, _window_height-70);
                self.twoSize = CGPointMake(thr_wXX*3+62, _window_height-70);
                [self.floatingWCOne uploadPointMethod:self.oneSize img:@"center_img17"];
                if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] || [self.devicTyp isEqualToString:kCharactName15]) {
                    [self.floatingWCTwo uploadPointMethod:self.twoSize img:@"threeAdMut_imgs1_2"];
                }else {
                    [self.floatingWCTwo uploadPointMethod:self.twoSize img:@"threeAdMut_imgs1"];
                }
            }
            self.numHeFen = 0;

            float kgh_h = _window_height-self.HeigF-30;
            float kk_wh = _window_height-self.oneSize.y-30;
            float two_hh = 100*(kk_wh/kgh_h);
            self.twoHeigF = two_hh;
            self.oneHeigF = two_hh;
        }
    }else {
//        self.isBooL = !self.isBooL;
//        if(self.isBooL) {
//            self.oneHeigF = 10;
//            self.twoHeigF = 10;
//            [self.floatingWCOne botmUIUIUBoo:YES];
//            [self.floatingWCTwo botmUIUIUBoo:YES];
//        }
//
//        oneBB.selected = !oneBB.selected;
//        self.isCycleBoo = !self.isCycleBoo;
        
        self.isBooL = !self.isBooL;
        if(self.isBooL) {
            self.oneHeigF = 10;
            self.twoHeigF = 10;
            [self.floatingWCOne botmUIUIUBoo:YES];
            [self.floatingWCTwo botmUIUIUBoo:YES];
        }
        if(self.isBooL) {
            if(self.isCycleBoo) {
                oneBB.selected = !oneBB.selected;
                self.isCycleBoo = !self.isCycleBoo;
            }
        }
    }
}

//MARK:  悬浮按钮轨迹
- (void)FloatingWCCCCDelegateMethodTwo:(NSString *)xyPoint
{
//    NSLog(@"--获取值1---%@", xyPoint);
    self.isSwaves = 0;
    NSArray *ar_m = [xyPoint componentsSeparatedByString:@","];
    if([ar_m[0] intValue] == 10000) {
        self.isOneB = NO;
        if(self.isBooL) {
            self.oneHeigF = 10;
            [self.floatingWCOne botmUIUIUBoo:YES];
            
            self.point_YY = 0;
            self.point_YY4 = 0;
        }
    }else {
        self.isOneB = YES;
        self.oneSize = CGPointMake([ar_m[0] floatValue], [ar_m[1] floatValue]);
        
//        if(self.isBothBoo) {
//            self.isTwoB = NO;
//            self.numHeFen = 1;
//        }
        float kgh_h = _window_height-self.HeigF-30;
        float kk_wh = _window_height-[ar_m[1] floatValue]-30;//[ar_m[1] floatValue]-self.HeigF;
        float two_hh = 100*(kk_wh/kgh_h);
//        if(!self.isTwoB || self.isBothBoo) {
//            if(self.isBothBoo) {
//                self.twoSize = self.oneSize;
//                [self.floatingWCTwo uploadPointMethod:self.oneSize img:@""];
//                self.isBothBoo = YES;
//                self.twoHeigF = two_hh;
//                [self.floatingWCOne uploadImgMEhodname:@"pattern_imgs3"];
//                UIButton *thrBBtn = [self viewWithTag:711];
//                thrBBtn.selected = YES;
//            }
//        }
//        NSLog(@"--获取值1---%.f", two_hh);
        self.oneHeigF = two_hh;
        
        if (self.point_YY3==0) {
            self.point_YY3 = two_hh;
        }
        
        if (two_hh >= self.point_YY) {
            self.point_YY = two_hh;
        }
        if (two_hh < self.point_YY2) {
            self.point_YY2 = two_hh;
        }
        
        self.point_YY4 = two_hh;
        
    }
    
    if ([self.delegate_ respondsToSelector:@selector(MHCreatePatternVVDelegateMMM)]) {
        [self.delegate_ MHCreatePatternVVDelegateMMM];
    }
}

- (void)luoMethodokok
{
    self.isOneB = NO;
    if(self.isBooL) {
        self.oneHeigF = 10;
        [self.floatingWCOne botmUIUIUBoo:YES]; //MARK: 落到底部
        
        self.point_YY = 0;
        self.point_YY4 = 0;
    }
    
    self.isTwoB = NO;
    if(self.isBooL2) {
        self.twoHeigF = 10;
        [self.floatingWCTwo botmUIUIUBoo:YES]; //MARK: 落到底部
        
        self.point2_YY = 0;
        self.point2_YY4 = 0;
    }
}

- (void)FloatingWCCCCDThree:(NSString *)xyPoint
{
    
//    NSLog(@"--获取值2---%@", xyPoint);
    
    self.isSwaves2 = 0;
    NSArray *ar_m = [xyPoint componentsSeparatedByString:@","];
    if([ar_m[0] intValue] == 10000) {
        self.isTwoB = NO;
        if(self.isBooL2) {
            self.twoHeigF = 10;
            [self.floatingWCTwo botmUIUIUBoo:YES]; //MARK: 落到底部
            
            self.point2_YY = 0;
            self.point2_YY4 = 0;
        }
    }else {
        self.isTwoB = YES;
        self.twoSize = CGPointMake([ar_m[0] floatValue], [ar_m[1] floatValue]);
        
//        if(self.isBothBoo) {
//            self.isOneB = NO;
//            self.numHeFen = 2;
//        }
        float kgh_h = _window_height-self.HeigF-30;
        float kk_wh = _window_height-[ar_m[1] floatValue]-30;
        float two_hh = 100*(kk_wh/kgh_h);
//        if(!self.isOneB || self.isBothBoo) {
//            if(self.isBothBoo) {
//                self.oneSize = self.twoSize;
//                [self.floatingWCOne uploadPointMethod:self.twoSize img:@""];
//                self.isBothBoo = YES;
//                self.oneHeigF = two_hh;
//                [self.floatingWCTwo uploadImgMEhodname:@"pattern_imgs3"];
//                UIButton *thrBBtn = [self viewWithTag:711];
//                thrBBtn.selected = YES;
//            }
//        }
//        NSLog(@"--获取值2---%.f", two_hh);
        self.twoHeigF = two_hh;
        
        if (self.point2_YY3==0) {
            self.point2_YY3 = two_hh;
        }
        
        if (two_hh >= self.point2_YY) {
            self.point2_YY = two_hh;
        }
        if (two_hh < self.point2_YY2) {
            self.point2_YY2 = two_hh;
        }
        
        self.point2_YY4 = two_hh;
    }
    
    if ([self.delegate_ respondsToSelector:@selector(MHCreatePatternVVDelegateMMM)]) {
        [self.delegate_ MHCreatePatternVVDelegateMMM];
    }
}



//旋转
- (CGFloat)getPointYY
{
    float ww_yy = self.point2_YY;
    if (self.point2_YY == self.point2_YY3) {
        ww_yy = self.point2_YY2;
    }
    if (!self.isBooL2) {
        if (!self.isTwoB) {
            ww_yy = self.point2_YY4;
        }else {
//            self.point2_YY = 0;
            self.point2_YY2 = 0;
            self.point2_YY3 = 0;
        }
        
    }else {
            
//        self.point2_YY = 0;
        self.point2_YY2 = 0;
        self.point2_YY3 = 0;
    }
    [FloatingWindowModel shareInstance].shoudong_twoStrong = ww_yy;
    [FloatingWindowModel shareInstance].shoudong_twoStrongX = (int)self.twoSize.x;
    return ww_yy;
}

//电击
- (CGFloat)getPointYYTwo
{
    float ww_yy = self.point_YY;
    if (self.point_YY == self.point_YY3) {
        ww_yy = self.point_YY2;
    }
    
    if (!self.isBooL) {
        if (!self.isOneB) {
            ww_yy = self.point_YY4;
        }else {
//            self.point_YY = 0;
            self.point_YY2 = 0;
            self.point_YY3 = 0;
        }
        
    }else {
//        self.point_YY = 0;
        self.point_YY2 = 0;
        self.point_YY3 = 0;
    }
    
    [FloatingWindowModel shareInstance].shoudong_oneStrong = ww_yy;
    [FloatingWindowModel shareInstance].shoudong_oneStrongX = (int)self.oneSize.x;
    
    return ww_yy;
}

- (void)setPatternMethodOne:(int)oneFF two:(int)twoFF
{
    self.point_YY = oneFF;
    self.point2_YY = twoFF;
    
    CGFloat fff_hh = self.height-54-TARBARHEIGHT+49;
    if (oneFF > 0) {
        self.isOneB = YES;
        [self.floatingWCOne uploadPointFiveSevenMethod:CGPointMake([FloatingWindowModel shareInstance].shoudong_oneStrongX, _window_height-fff_hh*oneFF/100-54-TARBARHEIGHT+49)];
    }
    
    if (twoFF > 0) {
        self.isTwoB = YES;
        [self.floatingWCTwo uploadPointFiveSevenMethod:CGPointMake([FloatingWindowModel shareInstance].shoudong_twoStrongX, _window_height-fff_hh*twoFF/100-54-TARBARHEIGHT+49)];
    }
}


@end
