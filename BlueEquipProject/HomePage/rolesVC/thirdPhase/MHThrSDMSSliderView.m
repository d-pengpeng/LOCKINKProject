//
//  MHThrSDMSSliderView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/14.
//

#import "MHThrSDMSSliderView.h"

@implementation MHThrSDMSSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIView *placVV = [[UIView alloc] initWithFrame:CGRectMake(8, (self.height-12)/2, self.width-16, 12)];
        placVV.backgroundColor = RGBA(202, 76, 255, 0.3);
        placVV.clipsToBounds = YES;
        placVV.layer.cornerRadius = 6;
        [self addSubview:placVV];

        self.slidVVV = [[UIView alloc] initWithFrame:CGRectMake(8, (self.height-12)/2, self.width-16, 12)];
        self.slidVVV.backgroundColor = normalColors;
        self.slidVVV.clipsToBounds = YES;
        self.slidVVV.layer.cornerRadius = 6;
        [self addSubview:self.slidVVV];
        
        self.leftBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height-16)/2, 16, 16)];
        self.leftBtn.image = [UIImage imageNamed:@"threeAdMut_imgs5"];
        [self addSubview:self.leftBtn];
        
        self.rigBtn = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-16, (self.height-16)/2, 16, 16)];
        self.rigBtn.image = [UIImage imageNamed:@"threeAdMut_imgs5"];
        [self addSubview:self.rigBtn];
        
        [self.slidVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftBtn.mas_centerX);
            make.right.equalTo(self.rigBtn.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.offset(12);
        }];
        
        self.leftBtnsub = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
        [self.leftBtnsub setTitleColor:UIColor.clearColor forState:UIControlStateNormal];
        [self.leftBtnsub setTitle:@"0" forState:UIControlStateNormal];
        [self addSubview:self.leftBtnsub];

        self.rigBtnsub = [[UIButton alloc] initWithFrame:CGRectMake(self.width-1, 0, 1, 20)];
        [self.rigBtnsub setTitleColor:UIColor.clearColor forState:UIControlStateNormal];
        [self.rigBtnsub setTitle:@"100" forState:UIControlStateNormal];
        [self addSubview:self.rigBtnsub];
        
    }
    return self;
}

//更新是否可以操作
- (void)uploadMethodtagboo
{
    if (self.isboo_boo) {
        self.slidVVV.backgroundColor = RGB(141, 112, 176);
        self.leftBtn.image = [UIImage imageNamed:@"threeAdMut_imgs6"];
        self.rigBtn.image = [UIImage imageNamed:@"threeAdMut_imgs6"];
    }else {
        self.slidVVV.backgroundColor = normalColors;
        self.leftBtn.image = [UIImage imageNamed:@"threeAdMut_imgs5"];
        self.rigBtn.image = [UIImage imageNamed:@"threeAdMut_imgs5"];
    }
}

- (void)addLeftStr:(int)leftStr righStr:(int)rigStr
{
    self.leftBtn.x = leftStr*(self.width-16)/100;
    self.rigBtn.x = rigStr*(self.width-16)/100;
    [self.leftBtnsub setTitle:minIntStr(leftStr) forState:UIControlStateNormal];
    [self.rigBtnsub setTitle:minIntStr(rigStr) forState:UIControlStateNormal];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    if(self.isboo_boo) {
        return;
    }
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        UIImageView *bbMM = self.leftBtn;
        CGPoint currentPosition = [[bbMM.layer presentationLayer] position];
        
        UIImageView *bbMM2 = self.rigBtn;
        CGPoint currentPosition2 = [[bbMM2.layer presentationLayer] position];
        if (touchPoint.y > currentPosition.y - 20 && touchPoint.y < currentPosition.y + 20) {
            
            if(fabs(touchPoint.x-currentPosition.x) > fabs(touchPoint.x-currentPosition2.x)) {
                
                if(touchPoint.x > self.leftBtn.x) {
                    
                    if(self.typeN>0) {
                        
                        int h_yyW_12 = (self.width-16)/6.f;
                        
                        int h_yyW = touchPoint.x/h_yyW_12;
                        
                        if(touchPoint.x >= self.width-16) {
                            
                            self.rigBtn.x = self.width-16;
                            [self.rigBtnsub setTitle:minIntStr(6) forState:UIControlStateNormal];
                        }else {
                            self.rigBtn.x = h_yyW*h_yyW_12;
                            [self.rigBtnsub setTitle:minIntStr(h_yyW) forState:UIControlStateNormal];
                        }
                        
                    }else {
                        int h_yyW_12 = (self.width-16)/10.f;
                        
                        int h_yyW = touchPoint.x/h_yyW_12;
                        
                        if(touchPoint.x >= self.width-16) {
                            
                            self.rigBtn.x = self.width-16;
                            [self.rigBtnsub setTitle:minIntStr(100) forState:UIControlStateNormal];
                        }else {
                            self.rigBtn.x = h_yyW*h_yyW_12;
                            [self.rigBtnsub setTitle:minIntStr(h_yyW*10) forState:UIControlStateNormal];
                        }
                    }
                }else {
                    
                    if(self.typeN>0) {
                        
                        int h_yyW_12 = (self.width-16)/6.f;
                        
                        int h_yyW = self.leftBtn.x/h_yyW_12;
                        
                        self.leftBtn.x = h_yyW*h_yyW_12;
                        self.rigBtn.x = self.leftBtn.x;
                        [self.rigBtnsub setTitle:minIntStr(h_yyW) forState:UIControlStateNormal];
                        
                    }else {
                        int h_yyW_12 = (self.width-16)/10.f;
                        
                        int h_yyW = self.leftBtn.x/h_yyW_12;
                        
                        self.leftBtn.x = h_yyW*h_yyW_12;
                        self.rigBtn.x = self.leftBtn.x;
                        [self.rigBtnsub setTitle:minIntStr(h_yyW*10) forState:UIControlStateNormal];
                    }
                }
            }else {
                if(touchPoint.x < self.rigBtn.x) {
                    
                    if(self.typeN>0) {
                        
                        int h_yyW_12 = (self.width-16)/6.f;
                        
                        int h_yyW = touchPoint.x/h_yyW_12;
                        
                        if(touchPoint.x <= 0) {
                            
                            self.leftBtn.x = 0;
                            [self.leftBtnsub setTitle:minIntStr(0) forState:UIControlStateNormal];
                        }else {
                            self.leftBtn.x = h_yyW*h_yyW_12;
                            [self.leftBtnsub setTitle:minIntStr(h_yyW) forState:UIControlStateNormal];
                        }
                        
                    }else {
                        int h_yyW_12 = (self.width-16)/10.f;
                        
                        int h_yyW = touchPoint.x/h_yyW_12;
                        
                        if(touchPoint.x <= 0) {
                            
                            self.leftBtn.x = 0;
                            [self.leftBtnsub setTitle:minIntStr(0) forState:UIControlStateNormal];
                        }else {
                            self.leftBtn.x = h_yyW*h_yyW_12;
                            [self.leftBtnsub setTitle:minIntStr(h_yyW*10) forState:UIControlStateNormal];
                        }
                    }
                }else {

                    if(self.typeN>0) {
                        
                        int h_yyW_12 = (self.width-16)/6.f;
                        
                        int h_yyW = self.rigBtn.x/h_yyW_12;
                        
                        self.leftBtn.x = h_yyW*h_yyW_12;
                        self.rigBtn.x = self.leftBtn.x;
                        [self.leftBtnsub setTitle:minIntStr(h_yyW) forState:UIControlStateNormal];
                        
                    }else {
                        int h_yyW_12 = (self.width-16)/10.f;
                        
                        int h_yyW = self.rigBtn.x/h_yyW_12;
                        
                        self.leftBtn.x = h_yyW*h_yyW_12;
                        self.rigBtn.x = self.leftBtn.x;
                        [self.leftBtnsub setTitle:minIntStr(h_yyW*10) forState:UIControlStateNormal];
                    }
                }
            }
            
            if(self.block_) {
                self.block_(minStr(self.leftBtnsub.titleLabel.text), minStr(self.rigBtnsub.titleLabel.text));
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    if(self.isboo_boo) {
        return;
    }
    NSLog(@"tk-callBegan");
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        
        self.lastPointInSuperView = [[touches anyObject] locationInView:self];
    }
    
    if(self.twoBlock_) {
        self.twoBlock_(NO);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    if(self.isboo_boo) {
        return;
    }
    CGPoint currentpoint = [[touches anyObject] locationInView:self];
    if (CGPointEqualToPoint(self.lastPointInSuperView, currentpoint)) {
        NSLog(@"tk-callClick");
        
        UIImageView *bbMM = self.leftBtn;
        CGPoint currentPosition = [[bbMM.layer presentationLayer] position];
        
        UIImageView *bbMM2 = self.rigBtn;
        CGPoint currentPosition2 = [[bbMM2.layer presentationLayer] position];
        
        if(currentpoint.x > (currentPosition.x+8)) {
            
            if((currentpoint.x - (currentPosition.x+8)) > ((currentPosition2.x+8) - currentpoint.x)) {
                
                if(currentpoint.x+8>self.width) {
                    self.rigBtn.x = self.width-16;
                }else {
                    self.rigBtn.x = currentpoint.x-8;
                }
            }else {
                self.leftBtn.x = currentpoint.x-8;
            }
        }else {
            if(currentpoint.x-8<8) {
                self.leftBtn.x = 0;
            }else {
                self.leftBtn.x = currentpoint.x-8;
            }
        }
        
        int h_hh = (int)((self.leftBtn.x+8) * 100)/(self.width-16);
        int h_hh2 = (int)((self.rigBtn.x+8) * 100)/(self.width-16);
        
        if(self.typeN>0) {
            
            float h_yyW_12 = (self.width-16)/6.f;
            
            int h_yyW = h_hh*6/100;
            self.leftBtn.x = h_yyW*h_yyW_12;
            [self.leftBtnsub setTitle:minIntStr(h_yyW) forState:UIControlStateNormal];
            
            if(h_hh2>94) {
                self.rigBtn.x = self.width - 16;
                [self.rigBtnsub setTitle:minIntStr(100) forState:UIControlStateNormal];
            }else {
                
                int h_yyW2 = h_hh2*6/100;
                self.rigBtn.x = h_yyW2*h_yyW_12;
                [self.rigBtnsub setTitle:minIntStr(h_yyW2) forState:UIControlStateNormal];
            }
            
        }else {
            int h_yyW = h_hh/10;
            self.leftBtn.x = h_yyW*10*(self.width-16)/100.f;
            [self.leftBtnsub setTitle:minIntStr(h_yyW*10) forState:UIControlStateNormal];
            
            if(h_hh2>94) {
                self.rigBtn.x = self.width - 16;
                [self.rigBtnsub setTitle:minIntStr(100) forState:UIControlStateNormal];
            }else {
                int h_yyW2 = h_hh2/10;
                self.rigBtn.x = h_yyW2*10*(self.width-16)/100.f - 14;
                [self.rigBtnsub setTitle:minIntStr(h_yyW2*10) forState:UIControlStateNormal];
            }
        }
        
        if(self.block_) {
            self.block_(minStr(self.leftBtnsub.titleLabel.text), minStr(self.rigBtnsub.titleLabel.text));
        }
        
    }else {
        NSLog(@"tk-callEnded");
    }
    
    if(self.twoBlock_) {
        self.twoBlock_(YES);
    }
}

@end



@implementation MHThrSDMSSliderView_one

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIView *placVV = [[UIView alloc] initWithFrame:CGRectMake(8, (self.height-12)/2, self.width-16, 12)];
        placVV.backgroundColor = RGBA(202, 76, 255, 0.3);
        placVV.clipsToBounds = YES;
        placVV.layer.cornerRadius = 6;
        [self addSubview:placVV];

        self.slidVVV = [[UIView alloc] initWithFrame:CGRectMake(8, (self.height-12)/2, self.width-16, 12)];
        self.slidVVV.backgroundColor = normalColors;
        self.slidVVV.clipsToBounds = YES;
        self.slidVVV.layer.cornerRadius = 6;
        [self addSubview:self.slidVVV];
        
        self.leftBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height-16)/2, 16, 16)];
        self.leftBtn.image = [UIImage imageNamed:@"threeAdMut_imgs5"];
        [self addSubview:self.leftBtn];
        
        [self.slidVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(placVV.mas_left).offset(0);
            make.right.equalTo(self.leftBtn.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.offset(12);
        }];
        
    }
    return self;
}

//更新是否可以操作
- (void)uploadMethodtagboo
{
    if (self.isboo_boo) {
        self.slidVVV.backgroundColor = RGB(141, 112, 176);
        self.leftBtn.image = [UIImage imageNamed:@"threeAdMut_imgs6"];
    }else {
        self.slidVVV.backgroundColor = normalColors;
        self.leftBtn.image = [UIImage imageNamed:@"threeAdMut_imgs5"];
    }
}

- (void)addLeftStr:(int)leftStr
{
    self.sel_val = leftStr;
    
    self.leftBtn.x = leftStr*(self.width-16)/100;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    if(self.isboo_boo) {
        return;
    }
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        UIImageView *bbMM = self.leftBtn;
        CGPoint currentPosition = [[bbMM.layer presentationLayer] position];
        
        if (touchPoint.y > currentPosition.y - 20 && touchPoint.y < currentPosition.y + 20) {
            
            if(touchPoint.x <= 0) {
                
                self.leftBtn.x = 0;
                self.sel_val = 0;
            }else if(touchPoint.x >= self.width-16) {
                
                self.leftBtn.x = self.width-16;
                self.sel_val = 100;
            }else {
                self.leftBtn.centerX = touchPoint.x;
                self.sel_val = 100*touchPoint.x/(self.width-16);
            }
            
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    if(self.isboo_boo) {
        return;
    }
    NSLog(@"tk-callBegan");
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        
        self.lastPointInSuperView = [[touches anyObject] locationInView:self];
    }
    if(self.twoBlock_) {
        self.twoBlock_(NO);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    if(self.isboo_boo) {
        return;
    }
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (CGPointEqualToPoint(self.lastPointInSuperView, touchPoint)) {
        NSLog(@"tk-callClick");
        
        if(touchPoint.x <= 0) {
            
            self.leftBtn.x = 0;
            self.sel_val = 0;
        }else if(touchPoint.x >= self.width-16) {
            
            self.leftBtn.x = self.width-16;
            self.sel_val = 100;
        }else {
            self.leftBtn.centerX = touchPoint.x;
            self.sel_val = 100*touchPoint.x/(self.width-16);
        }
        
        if(self.block_) {
            self.block_(minIntStr(self.sel_val), @"");
        }
        
    }else {
        NSLog(@"tk-callEnded");
        
        if(touchPoint.x <= 0) {
            
            self.leftBtn.x = 0;
            self.sel_val = 0;
        }else if(touchPoint.x >= self.width-16) {
            
            self.leftBtn.x = self.width-16;
            self.sel_val = 100;
        }else {
            self.leftBtn.centerX = touchPoint.x;
            self.sel_val = 100*touchPoint.x/(self.width-16);
        }
        
        if(self.block_) {
            self.block_(minIntStr(self.sel_val), @"");
        }
    }
    if(self.twoBlock_) {
        self.twoBlock_(YES);
    }
}

@end
