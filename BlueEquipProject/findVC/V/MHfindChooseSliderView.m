//
//  MHfindChooseSliderView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "MHfindChooseSliderView.h"

@implementation MHfindChooseSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIView *placVV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.width, 10)];
        placVV.backgroundColor = RGBA(186, 80, 191, 0.27);
        [self addSubview:placVV];

        self.slidVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.width, 10)];
        self.slidVVV.backgroundColor = RGBA(202, 76, 255, 1);
        [self addSubview:self.slidVVV];
        
        self.leftBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2.5, 18, 25)];
        self.leftBtn.image = [UIImage imageNamed:@"age_sliderImg1"];
        [self addSubview:self.leftBtn];
        
        self.rigBtn = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-18, 2.5, 18, 25)];
        self.rigBtn.image = [UIImage imageNamed:@"age_sliderImg2"];
        [self addSubview:self.rigBtn];
        
        [self.slidVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftBtn.mas_centerX);
            make.right.equalTo(self.rigBtn.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.offset(10);
        }];
        
        self.leftBtnsub = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        [self.leftBtnsub setBackgroundImage:[UIImage imageNamed:@"age_sliderImg5"] forState:UIControlStateNormal];
        [self.leftBtnsub setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.leftBtnsub.titleLabel.font = SYS_Font(14);
        self.leftBtnsub.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 6, 0);
        [self.leftBtnsub setTitle:@"18" forState:UIControlStateNormal];
        [self addSubview:self.leftBtnsub];
        [self.leftBtnsub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftBtn.mas_top);
            make.centerX.equalTo(self.leftBtn.mas_centerX);
            make.width.offset(30);
            make.height.offset(20);
        }];

        self.rigBtnsub = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        [self.rigBtnsub setBackgroundImage:[UIImage imageNamed:@"age_sliderImg5"] forState:UIControlStateNormal];
        [self.rigBtnsub setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.rigBtnsub.titleLabel.font = SYS_Font(14);
        self.rigBtnsub.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 6, 0);
        [self.rigBtnsub setTitle:@"70" forState:UIControlStateNormal];
        [self addSubview:self.rigBtnsub];
        [self.rigBtnsub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.rigBtn.mas_top);
            make.centerX.equalTo(self.rigBtn.mas_centerX);
            make.width.offset(30);
            make.height.offset(20);
        }];
        
        //255 52
    }
    return self;
}

- (void)addLeftStr:(int)leftStr righStr:(int)rigStr
{
    self.leftBtn.x = leftStr*self.width/52;
    self.rigBtn.x = rigStr*self.width/52-18;
    [self.leftBtnsub setTitle:minIntStr(leftStr+18) forState:UIControlStateNormal];
    [self.rigBtnsub setTitle:minIntStr(rigStr+18) forState:UIControlStateNormal];
}

- (NSArray *)getStartToEnd
{
    return @[self.leftBtnsub.titleLabel.text, self.rigBtnsub.titleLabel.text];
}

- (void)touchesMoved:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
{
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        UIImageView *bbMM = self.leftBtn;
        CGPoint currentPosition = [[bbMM.layer presentationLayer] position];
        if (touchPoint.x > currentPosition.x - 20 && touchPoint.x < currentPosition.x + 20 && touchPoint.y > currentPosition.y - 20 && touchPoint.y < currentPosition.y + 20) {
            
            if(touchPoint.x < self.width-36) {
                if(touchPoint.x > 0) {
                    self.leftBtn.x = touchPoint.x;
                }else {
                    self.leftBtn.x = 0;
                }
            }else {
                self.leftBtn.x = self.width-36;
            }
            if(self.leftBtn.x+20 > self.rigBtn.x) {
                self.rigBtn.x = self.leftBtn.x+20;
                
                int h_hh = (int)(self.leftBtn.x * 52)/self.width;
                int h_hh2 = (int)(self.rigBtn.x * 52)/(self.width-16);
                if(h_hh2 >= 51) {
                    h_hh2 = 52;
                }
                [self.leftBtnsub setTitle:minIntStr(h_hh+18) forState:UIControlStateNormal];
                [self.rigBtnsub setTitle:minIntStr(h_hh2+18) forState:UIControlStateNormal];
            }else {
                int h_hh = (int)(self.leftBtn.x * 52)/self.width;
                [self.leftBtnsub setTitle:minIntStr(h_hh+18) forState:UIControlStateNormal];
            }
        }
        
        UIImageView *bbMM2 = self.rigBtn;
        CGPoint currentPosition2 = [[bbMM2.layer presentationLayer] position];
        if (touchPoint.x > currentPosition2.x - 20 && touchPoint.x < currentPosition2.x + 20 && touchPoint.y > currentPosition2.y - 20 && touchPoint.y < currentPosition2.y + 20) {
            
            if(touchPoint.x < self.width-16) {
                self.rigBtn.x = touchPoint.x;
            }else {
                self.rigBtn.x = self.width-16;
            }
            
            if(self.rigBtn.x-20 < self.leftBtn.x) {
                self.leftBtn.x = self.rigBtn.x-20;
                
                int h_hh = (int)(self.leftBtn.x * 52)/self.width;
                int h_hh2 = (int)(self.rigBtn.x * 52)/(self.width-16);
                
                [self.leftBtnsub setTitle:minIntStr(h_hh+18) forState:UIControlStateNormal];
                [self.rigBtnsub setTitle:minIntStr(h_hh2+18) forState:UIControlStateNormal];
            }else {
                
                int h_hh2 = (int)(self.rigBtn.x * 52)/(self.width-16);
                [self.rigBtnsub setTitle:minIntStr(h_hh2+18) forState:UIControlStateNormal];
            }
        }
    }
}

@end
