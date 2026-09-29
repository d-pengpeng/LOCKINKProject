//
//  MHRoleSetSubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "MHRoleSetSubController.h"
#import "sliderVVView.h"
#import <BRDatePickerView.h>
#import "MHPostConditionsController.h"
#import "MHRoleSetSubRecordsController.h"
#import "MHGearSetView.h"
#import "MHLimitsAuthorityView.h"
#import "MHPostSquareController.h"

@interface MHRoleSetSubController ()<TPVerticalVideoSliderViewDelegate>

@property (nonatomic, strong) sliderVVView *twoScrollV;
@property (nonatomic, strong) UILabel *settingLab;
@property (nonatomic, strong) UILabel *settingLab2;
@property (nonatomic, strong) UILabel *settingLab3;
@property (nonatomic, strong) NSArray *cytjArr;
@property (nonatomic, assign) int starNNN;
@property (nonatomic, assign) int starNNN2;
@property (nonatomic, assign) int starNNN3;
@property (nonatomic, assign) int stopNNN;
@property (nonatomic, assign) int stopNNN2;
@property (nonatomic, assign) int stopNNN3;
@property (nonatomic, assign) int randomNNN;
@property (nonatomic, assign) int randomNNN2;
@property (nonatomic, assign) int randomNNN3;
@property (nonatomic, assign) int al_NN;
@property (nonatomic, assign) BOOL isStartB;
@property (nonatomic, assign) BOOL isRRRRR;
@property (nonatomic, copy) NSString *frequency;
@property (nonatomic, copy) NSString *shockMinute;
@end

@implementation MHRoleSetSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    self.view.backgroundColor = UIColor.clearColor;
    
    self.al_NN = 0;
    self.frequency = @"1";
    self.shockMinute = @"1";
    
    if(self.typN == 0) {
        
        UIScrollView *oneVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-50)];
        oneVV.backgroundColor = UIColor.clearColor;
        oneVV.showsVerticalScrollIndicator = NO;
        oneVV.showsHorizontalScrollIndicator = NO;
        oneVV.bounces = NO;
        [self.view addSubview:oneVV];
        
        NSArray *namsA = @[@"role_name25", @"role_name26"];
        int one_W1 = 36;
        int one_H1 = 24;
        int two_W1 = 26;
        
        CGFloat placF = ((_window_width/2)-(one_W1+two_W1)*3)/4;
        for (int i=0; i<namsA.count; i++) {
            UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentCenter];
            oneSLab.frame = CGRectMake(i*_window_width/2, 6, _window_width/2, 34);
            oneSLab.text = eLocalizedString(namsA[i]);
            [oneVV addSubview:oneSLab];
            
            UIView *MM_V = [[UIView alloc] initWithFrame:CGRectMake(i * _window_width/2, 24, _window_width/2, one_H1*3)];
            MM_V.backgroundColor = UIColor.clearColor;
            [oneVV addSubview:MM_V];
            
            
            NSArray *houA = @[@"role_name14", @"role_name14_h", @"role_name14_m"];
            for (int j=0; j<houA.count; j++) {
                
                MHGearSetView *gearV = [[MHGearSetView alloc] initWithFrame:CGRectMake(placF+j*(one_W1+two_W1+placF), 0, one_W1+5, one_H1*3)];
                gearV.minFont = 12;
                gearV.maxFont = 14;
                gearV.heihh_h = one_H1;
                gearV.tag = 8100+i*100+j;
                [MM_V addSubview:gearV];
                
                if(j==0) {
                    gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].dayArr];
                }else if (j==1) {
                    gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].hourArr];
                }else {
                    gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].mineArr];
                }
                gearV.block_ = ^(NSString * _Nonnull strLL) {
                    if(i==1) {
                        if(j==0) {
                            self.stopNNN = [strLL intValue]*24*60;
                        }else if (j==1) {
                            self.stopNNN2 = [strLL intValue]*60;
                        }else {
                            self.stopNNN3 = [strLL intValue];
                        }
                    }else {
                        if(j==0) {
                            self.starNNN = [strLL intValue]*24*60;
                        }else if (j==1) {
                            self.starNNN2 = [strLL intValue]*60;
                        }else {
                            self.starNNN3 = [strLL intValue];
                        }
                    }
                };
                
                UILabel *namLL = [HistoryRecordModel createLabLabTextColor:RGB(170, 170, 170) fontFloat:14 textAlignment:NSTextAlignmentCenter];
                namLL.frame = CGRectMake(placF+j*(one_W1+two_W1+placF)+one_W1, 0, two_W1, one_H1*3);
                namLL.text = eLocalizedString(houA[j]);
                namLL.numberOfLines = 0;
                [MM_V addSubview:namLL];
            }
        }
        
        UIButton *startBB = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-128)/2, 140, 128, 128)];
        [startBB setBackgroundImage:[UIImage imageNamed:@"role_imgs18"] forState:UIControlStateNormal];
        [startBB setTitle:eLocalizedString(@"role_name27") forState:UIControlStateNormal];
        [startBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        startBB.titleLabel.font = SYS_Font(26);
        [startBB addTarget:self action:@selector(startBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:startBB];
        
        UIButton *chatBtn = [HistoryRecordModel createImgBtn];
        UIButton *chatBtn_two = [HistoryRecordModel createImgBtn];
        if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
            
            UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startBB.frame)+42, 30, 30)];
            [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
            [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
            twoBtn.tag = 3400;
            [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:twoBtn];
            
            UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            oneSLab.frame = CGRectMake(30, CGRectGetMaxY(startBB.frame)+42-10, _window_width-60, 50);
            oneSLab.text = eLocalizedString(@"role_name28");
            oneSLab.numberOfLines = 0;
            [oneVV addSubview:oneSLab];
                
            chatBtn.frame = CGRectMake((_window_width-210)/2, CGRectGetMaxY(startBB.frame)+127+40, 210, 46);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setTitle:eLocalizedString(@"role_name31") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
        }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
            
            
            CGFloat lef_xx = (_window_width-300)/2;
            NSArray *houA = @[@"role_name14", @"role_name14_h", @"role_name14_m"];
            for (int j=0; j<houA.count; j++) {
                
                UIView *randomPlav = [[UIView alloc] initWithFrame:CGRectMake(lef_xx+j*100, CGRectGetMaxY(startBB.frame)+10, 100, 46)];
                randomPlav.backgroundColor = UIColor.clearColor;
                [oneVV addSubview:randomPlav];
                
                UIView *randomVV = [[UIView alloc] init];
                randomVV.backgroundColor = normalColors;
                [randomPlav addSubview:randomVV];
                [randomVV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(randomPlav.mas_right).offset(-45);
                    make.centerY.equalTo(randomPlav.mas_centerY);
                    make.height.offset(26);
                    make.width.mas_greaterThanOrEqualTo(40);
                }];
                UILabel *mmRandLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:20 textAlignment:NSTextAlignmentCenter];
                mmRandLab.tag = 970+j;
                mmRandLab.text = @"00";
                [randomVV addSubview:mmRandLab];
                [mmRandLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(randomVV);
                    make.left.equalTo(randomVV.mas_left).offset(5);
                    make.right.equalTo(randomVV.mas_right).offset(-5);
                }];
                
                UILabel *namLL = [HistoryRecordModel createLabLabTextColor:RGB(170, 170, 170) fontFloat:14 textAlignment:NSTextAlignmentLeft];
                namLL.text = eLocalizedString(houA[j]);
                namLL.numberOfLines = 0;
                [randomPlav addSubview:namLL];
                [namLL mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(randomPlav.mas_right).offset(-40);
                    make.centerY.equalTo(randomPlav);
                    make.right.equalTo(randomPlav.mas_right).offset(-5);
                }];
            }
            
            
            NSArray *namsA2 = @[@"role_name28"];
            for (int i=0; i<namsA2.count; i++) {
                
                UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startBB.frame)+42+i*36+46, 30, 30)];
                [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
                [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
                twoBtn.tag = 3400+i;
                [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:twoBtn];
                
                UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                oneSLab.frame = CGRectMake(30, CGRectGetMaxY(startBB.frame)+42+i*36-10+46, _window_width-60, 50);
                oneSLab.text = eLocalizedString(namsA2[i]);
                oneSLab.numberOfLines = 0;
                [oneVV addSubview:oneSLab];
            }
            
            UILabel *electSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            electSLab.frame = CGRectMake(12, CGRectGetMaxY(startBB.frame)+127-30+46, _window_width-24, 34);
            electSLab.text = eLocalizedString(@"role_name30");
            [oneVV addSubview:electSLab];
            
            self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(electSLab.frame)+14, _window_width-92, 24)];
            self.twoScrollV.delegate = self;
            self.twoScrollV.miniMumTIMg = @"role_imgs17";
            self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
            self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
            self.twoScrollV.value = 0.0;
            self.twoScrollV.bufferValue = 0.3;
            self.twoScrollV.sliderHeight = 12;
            self.twoScrollV.allowTapped = YES;
            self.twoScrollV.slidIMg = @"equipmentImgs3";
            self.twoScrollV.thumbSize = CGSizeMake(16, 16);
            [oneVV addSubview:self.twoScrollV];
            
            for (int i=0; i<2; i++) {
                UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                [oneVV addSubview:imgElec];
                if(i==0) {
                    imgElec.frame = CGRectMake(17, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs19"];
                }else {
                    imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs20"];
                }
            }
            
            CGFloat ww_ww = (_window_width-74*3-40)/2;
            NSArray *namsAr = @[@"role_name43", @"role_name44", @"role_name45"];
            NSArray *imgsAr = @[@"role_electImgs1", @"role_electImgs2", @"role_electImgs3"];
            for (int i=0; i<namsAr.count; i++) {
            
                UIButton *thrBtnBB = [[UIButton alloc] initWithFrame:CGRectMake(ww_ww + i*94, CGRectGetMaxY(electSLab.frame)+60, 74, 66)];
                [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgNor"] forState:UIControlStateNormal];
                [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgSel"] forState:UIControlStateSelected];
                thrBtnBB.tag = 5600+i;
                [thrBtnBB addTarget:self action:@selector(thrBtnMethodS:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:thrBtnBB];
                if(i==0) {
                    thrBtnBB.selected = YES;
                }
                
                UIImageView *imgThr = [HistoryRecordModel createImgImgView];
                imgThr.frame = CGRectMake(10, 14, 54, 18);
                imgThr.image = [UIImage imageNamed:imgsAr[i]];
                [thrBtnBB addSubview:imgThr];
                
                UILabel *namLLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
                namLLab.frame = CGRectMake(0, 34, 74, 30);
                namLLab.text = eLocalizedString(namsAr[i]);
                [thrBtnBB addSubview:namLLab];
                
            }
            
            UIButton *dj_timeBtn = [HistoryRecordModel createImgBtn];
            [dj_timeBtn setBackgroundImage:[UIImage imageNamed:@"play_allImgs9"] forState:UIControlStateNormal];
            [dj_timeBtn addTarget:self action:@selector(djTimeBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:dj_timeBtn];
            [dj_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(electSLab.mas_bottom).offset(146);
                make.centerX.equalTo(oneVV.mas_centerX);
                make.height.offset(40);
                make.width.mas_greaterThanOrEqualTo(238);
            }];
            UIView *smal_tim = [[UIView alloc] init];
            smal_tim.backgroundColor = UIColor.whiteColor;
            smal_tim.userInteractionEnabled = NO;
            [dj_timeBtn addSubview:smal_tim];
            [smal_tim mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dj_timeBtn.mas_centerX).offset(-2);
                make.centerY.equalTo(dj_timeBtn.mas_centerY);
                make.height.offset(20);
                make.width.mas_greaterThanOrEqualTo(38);
            }];
            UILabel *lef_djLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentRight];
            lef_djLab.text = eLocalizedString(@"two_nams28");
            [dj_timeBtn addSubview:lef_djLab];
            [lef_djLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dj_timeBtn.mas_left).offset(5);
                make.top.bottom.equalTo(dj_timeBtn);
                make.right.equalTo(smal_tim.mas_left).offset(-6);
            }];
            UILabel *smal_timLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
            smal_timLab.text = self.shockMinute;
            smal_timLab.tag = 5000;
            [smal_tim addSubview:smal_timLab];
            [smal_timLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(smal_tim.mas_left).offset(5);
                make.top.bottom.equalTo(smal_tim);
                make.right.equalTo(smal_tim.mas_right).offset(-5);
            }];
            UILabel *rig_djLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
            rig_djLab.text = eLocalizedString(@"role_name14_14");
            [dj_timeBtn addSubview:rig_djLab];
            [rig_djLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(dj_timeBtn.mas_right).offset(-5);
                make.top.bottom.equalTo(dj_timeBtn);
                make.left.equalTo(smal_tim.mas_right).offset(6);
            }];
            
            chatBtn.frame = CGRectMake((_window_width-244-34)/2, CGRectGetMaxY(electSLab.frame)+60+200, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setTitle:eLocalizedString(@"role_name31") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
            chatBtn_two.frame = CGRectMake((_window_width-244-34)/2 + 156, CGRectGetMaxY(electSLab.frame)+60+200, 122, 36);
            [chatBtn_two setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn_two setTitle:eLocalizedString(@"role_name32") forState:UIControlStateNormal];
            [chatBtn_two setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn_two.titleLabel.font = SYS_Font(14);
            [chatBtn_two addTarget:self action:@selector(chatBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn_two];
            
        }else {
            NSArray *namsA2 = @[@"role_name28", @"role_name29"];
            for (int i=0; i<namsA2.count; i++) {
                
                UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startBB.frame)+42+i*36, 30, 30)];
                [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
                [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
                twoBtn.tag = 3400+i;
                [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:twoBtn];
                
                UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                oneSLab.frame = CGRectMake(30, CGRectGetMaxY(startBB.frame)+42+i*36-10, _window_width-60, 50);
                oneSLab.text = eLocalizedString(namsA2[i]);
                oneSLab.numberOfLines = 0;
                [oneVV addSubview:oneSLab];
            }
            
            UILabel *electSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            electSLab.frame = CGRectMake(12, CGRectGetMaxY(startBB.frame)+127, _window_width-24, 34);
            electSLab.text = eLocalizedString(@"role_name30");
            [oneVV addSubview:electSLab];
            
            self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(electSLab.frame)+14, _window_width-92, 24)];
            self.twoScrollV.delegate = self;
            self.twoScrollV.miniMumTIMg = @"role_imgs17";
            self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
            self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
            self.twoScrollV.value = 0.0;
            self.twoScrollV.bufferValue = 0.3;
            self.twoScrollV.sliderHeight = 12;
            self.twoScrollV.allowTapped = YES;
            self.twoScrollV.slidIMg = @"equipmentImgs3";
            self.twoScrollV.thumbSize = CGSizeMake(16, 16);
            [oneVV addSubview:self.twoScrollV];
            
            for (int i=0; i<2; i++) {
                UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                [oneVV addSubview:imgElec];
                if(i==0) {
                    imgElec.frame = CGRectMake(17, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs19"];
                }else {
                    imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs20"];
                }
            }
            
            
            chatBtn.frame = CGRectMake((_window_width-210)/2, CGRectGetMaxY(electSLab.frame)+110, 210, 46);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setTitle:eLocalizedString(@"role_name31") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
        }

        oneVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(chatBtn.frame)+80);
        
    }else if (self.typN == 1) {
        
        UIView *oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-50)];
        oneVV.backgroundColor = UIColor.clearColor;
        [self.view addSubview:oneVV];
        
        
        int one_W1 = 60;
        int one_H1 = 26;
        int two_W1 = 36;
        CGFloat placF = (_window_width-(one_W1+two_W1)*3)/4;
        
        NSArray *houA = @[@"role_name14", @"role_name14_h", @"role_name14_m"];
        for (int j=0; j<houA.count; j++) {
            
            MHGearSetView *gearV = [[MHGearSetView alloc] initWithFrame:CGRectMake(placF+j*(one_W1+two_W1+placF), 38, one_W1, one_H1*3)];
            gearV.minFont = 20;
            gearV.maxFont = 24;
            gearV.heihh_h = one_H1;
            gearV.tag = 8100+j;
            [oneVV addSubview:gearV];
            
            if(j==0) {
                gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].dayArr];
            }else if (j==1) {
                gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].hourArr];
            }else {
                gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].mineArr];
            }
            gearV.block_ = ^(NSString * _Nonnull strLL) {
                
                if(j==0) {
                    self.starNNN = [strLL intValue]*24*60;
                }else if (j==1) {
                    self.starNNN2 = [strLL intValue]*60;
                }else {
                    self.starNNN3 = [strLL intValue];
                }
                
            };
            
            UILabel *namLL = [HistoryRecordModel createLabLabTextColor:RGB(170, 170, 170) fontFloat:14 textAlignment:NSTextAlignmentCenter];
            namLL.frame = CGRectMake(placF+j*(one_W1+two_W1+placF)+one_W1, 38, two_W1, one_H1*3);
            namLL.text = eLocalizedString(houA[j]);
            namLL.numberOfLines = 0;
            [oneVV addSubview:namLL];
        }
        
        if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
            
            UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 145, 30, 30)];
            [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
            [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
            twoBtn.tag = 3400;
            [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:twoBtn];
            
            UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            oneSLab.frame = CGRectMake(30, 145-10, _window_width-60, 50);
            oneSLab.text = eLocalizedString(@"role_name28");
            oneSLab.numberOfLines = 0;
            [oneVV addSubview:oneSLab];
            
                
            UIButton *chatBtn = [HistoryRecordModel createImgBtn];
            chatBtn.frame = CGRectMake((_window_width-244-34)/2, 145+2*36+20+110, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setTitle:eLocalizedString(@"role_name31") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
            UIButton *chatBtn2 = [HistoryRecordModel createImgBtn];
            chatBtn2.frame = CGRectMake((_window_width-244-34)/2 + 156, 145+2*36+20+110, 122, 36);
            [chatBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn2 setTitle:eLocalizedString(@"role_name32") forState:UIControlStateNormal];
            [chatBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn2.titleLabel.font = SYS_Font(14);
            [chatBtn2 addTarget:self action:@selector(chatBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn2];
            
        }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
            
            NSArray *namsA2 = @[@"role_name28"];
            for (int i=0; i<namsA2.count; i++) {
                
                UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 145+i*36, 30, 30)];
                [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
                [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
                twoBtn.tag = 3400+i;
                [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:twoBtn];
                
                UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                oneSLab.frame = CGRectMake(30, 145+i*36-10, _window_width-60, 50);
                oneSLab.text = eLocalizedString(namsA2[i]);
                oneSLab.numberOfLines = 0;
                [oneVV addSubview:oneSLab];
            }
            
            UILabel *electSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            electSLab.frame = CGRectMake(12, 145+2*36+20-30, _window_width-24, 34);
            electSLab.text = eLocalizedString(@"role_name30");
            [oneVV addSubview:electSLab];
            
            self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(electSLab.frame)+14, _window_width-92, 24)];
            self.twoScrollV.delegate = self;
            self.twoScrollV.miniMumTIMg = @"role_imgs17";
            self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
            self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
            self.twoScrollV.value = 0.0;
            self.twoScrollV.bufferValue = 0.3;
            self.twoScrollV.sliderHeight = 12;
            self.twoScrollV.allowTapped = YES;
            self.twoScrollV.slidIMg = @"equipmentImgs3";
            self.twoScrollV.thumbSize = CGSizeMake(16, 16);
            [oneVV addSubview:self.twoScrollV];
            
            for (int i=0; i<2; i++) {
                UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                [oneVV addSubview:imgElec];
                if(i==0) {
                    imgElec.frame = CGRectMake(17, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs19"];
                }else {
                    imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs20"];
                }
            }
            
            CGFloat ww_ww = (_window_width-74*3-40)/2;
            NSArray *namsAr = @[@"role_name43", @"role_name44", @"role_name45"];
            NSArray *imgsAr = @[@"role_electImgs1", @"role_electImgs2", @"role_electImgs3"];
            for (int i=0; i<namsAr.count; i++) {
            
                UIButton *thrBtnBB = [[UIButton alloc] initWithFrame:CGRectMake(ww_ww + i*94, CGRectGetMaxY(electSLab.frame)+60, 74, 66)];
                [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgNor"] forState:UIControlStateNormal];
                [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgSel"] forState:UIControlStateSelected];
                thrBtnBB.tag = 5600+i;
                [thrBtnBB addTarget:self action:@selector(thrBtnMethodS:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:thrBtnBB];
                if(i==0) {
                    thrBtnBB.selected = YES;
                }
                
                UIImageView *imgThr = [HistoryRecordModel createImgImgView];
                imgThr.frame = CGRectMake(10, 14, 54, 18);
                imgThr.image = [UIImage imageNamed:imgsAr[i]];
                [thrBtnBB addSubview:imgThr];
                
                UILabel *namLLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
                namLLab.frame = CGRectMake(0, 34, 74, 30);
                namLLab.text = eLocalizedString(namsAr[i]);
                [thrBtnBB addSubview:namLLab];
                
            }
            
            UIButton *dj_timeBtn = [HistoryRecordModel createImgBtn];
            [dj_timeBtn setBackgroundImage:[UIImage imageNamed:@"play_allImgs9"] forState:UIControlStateNormal];
            [dj_timeBtn addTarget:self action:@selector(djTimeBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:dj_timeBtn];
            [dj_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(electSLab.mas_bottom).offset(146);
                make.centerX.equalTo(oneVV.mas_centerX);
                make.height.offset(40);
                make.width.mas_greaterThanOrEqualTo(238);
            }];
            UIView *smal_tim = [[UIView alloc] init];
            smal_tim.backgroundColor = UIColor.whiteColor;
            smal_tim.userInteractionEnabled = NO;
            [dj_timeBtn addSubview:smal_tim];
            [smal_tim mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dj_timeBtn.mas_centerX).offset(-2);
                make.centerY.equalTo(dj_timeBtn.mas_centerY);
                make.height.offset(20);
                make.width.mas_greaterThanOrEqualTo(38);
            }];
            UILabel *lef_djLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentRight];
            lef_djLab.text = eLocalizedString(@"two_nams28");
            [dj_timeBtn addSubview:lef_djLab];
            [lef_djLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dj_timeBtn.mas_left).offset(5);
                make.top.bottom.equalTo(dj_timeBtn);
                make.right.equalTo(smal_tim.mas_left).offset(-6);
            }];
            UILabel *smal_timLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
            smal_timLab.text = self.shockMinute;
            smal_timLab.tag = 5000;
            [smal_tim addSubview:smal_timLab];
            [smal_timLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(smal_tim.mas_left).offset(5);
                make.top.bottom.equalTo(smal_tim);
                make.right.equalTo(smal_tim.mas_right).offset(-5);
            }];
            UILabel *rig_djLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
            rig_djLab.text = eLocalizedString(@"role_name14_14");
            [dj_timeBtn addSubview:rig_djLab];
            [rig_djLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(dj_timeBtn.mas_right).offset(-5);
                make.top.bottom.equalTo(dj_timeBtn);
                make.left.equalTo(smal_tim.mas_right).offset(6);
            }];
            
            UIButton *chatBtn = [HistoryRecordModel createImgBtn];
            chatBtn.frame = CGRectMake((_window_width-244-34)/2, CGRectGetMaxY(electSLab.frame)+110+100, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setTitle:eLocalizedString(@"role_name31") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
            UIButton *chatBtn2 = [HistoryRecordModel createImgBtn];
            chatBtn2.frame = CGRectMake((_window_width-244-34)/2 + 156, CGRectGetMaxY(electSLab.frame)+110+100, 122, 36);
            [chatBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn2 setTitle:eLocalizedString(@"role_name32") forState:UIControlStateNormal];
            [chatBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn2.titleLabel.font = SYS_Font(14);
            [chatBtn2 addTarget:self action:@selector(chatBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn2];
            
        }else {
            
            NSArray *namsA2 = @[@"role_name28", @"role_name29"];
            for (int i=0; i<namsA2.count; i++) {
                
                UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 145+i*36, 30, 30)];
                [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
                [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
                twoBtn.tag = 3400+i;
                [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:twoBtn];
                
                UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                oneSLab.frame = CGRectMake(30, 145+i*36-10, _window_width-60, 50);
                oneSLab.text = eLocalizedString(namsA2[i]);
                oneSLab.numberOfLines = 0;
                [oneVV addSubview:oneSLab];
            }
            
            UILabel *electSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            electSLab.frame = CGRectMake(12, 145+2*36+20, _window_width-24, 34);
            electSLab.text = eLocalizedString(@"role_name30");
            [oneVV addSubview:electSLab];
            
            self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(electSLab.frame)+14, _window_width-92, 24)];
            self.twoScrollV.delegate = self;
            self.twoScrollV.miniMumTIMg = @"role_imgs17";
            self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
            self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
            self.twoScrollV.value = 0.0;
            self.twoScrollV.bufferValue = 0.3;
            self.twoScrollV.sliderHeight = 12;
            self.twoScrollV.allowTapped = YES;
            self.twoScrollV.slidIMg = @"equipmentImgs3";
            self.twoScrollV.thumbSize = CGSizeMake(16, 16);
            [oneVV addSubview:self.twoScrollV];
            
            for (int i=0; i<2; i++) {
                UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                [oneVV addSubview:imgElec];
                if(i==0) {
                    imgElec.frame = CGRectMake(17, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs19"];
                }else {
                    imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs20"];
                }
            }
            
            UIButton *chatBtn = [HistoryRecordModel createImgBtn];
            chatBtn.frame = CGRectMake((_window_width-244-34)/2, CGRectGetMaxY(electSLab.frame)+110, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setTitle:eLocalizedString(@"role_name31") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
            UIButton *chatBtn2 = [HistoryRecordModel createImgBtn];
            chatBtn2.frame = CGRectMake((_window_width-244-34)/2 + 156, CGRectGetMaxY(electSLab.frame)+110, 122, 36);
            [chatBtn2 setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn2 setTitle:eLocalizedString(@"role_name32") forState:UIControlStateNormal];
            [chatBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn2.titleLabel.font = SYS_Font(14);
            [chatBtn2 addTarget:self action:@selector(chatBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn2];
        }
    }else {
        
        UIScrollView *oneVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-50)];
        oneVV.backgroundColor = UIColor.clearColor;
        oneVV.showsVerticalScrollIndicator = NO;
        oneVV.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:oneVV];
        
        NSArray *namsAr2 = @[@"role_name33", @"role_name34", @"role_name35"];
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
            namsAr2 = @[@"role_name33_33", @"role_name34", @"role_name35"];
        }
        for (int i=0; i<namsAr2.count; i++) {
            
            UILabel *adresLLlab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            adresLLlab.numberOfLines = 0;
            adresLLlab.text = eLocalizedString(namsAr2[i]);
            [oneVV addSubview:adresLLlab];
            
            UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
            nexImgv.image = [UIImage imageNamed:@"home_next2"];
            [oneVV addSubview:nexImgv];
            
            if(i==0){
                nexImgv.hidden = YES;
                adresLLlab.frame = CGRectMake(12, 15, 160, 34);
                nexImgv.frame = CGRectMake(oneVV.width-24, 25, 14, 14);
                
                CGFloat w_dd = [HistoryRecordModel jiSuanWith:eLocalizedString(@"role_name14_14") font:16];
                UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                msg_lab2.frame = CGRectMake(oneVV.width-10-w_dd, 15, w_dd, 34);
                msg_lab2.text = eLocalizedString(@"role_name14_14");
                [oneVV addSubview:msg_lab2];
                
                self.settingLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                [oneVV addSubview:self.settingLab];
                [self.settingLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(msg_lab2.mas_left).offset(-3);
                    make.centerY.equalTo(adresLLlab.mas_centerY);
                }];
                
                UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneVV.width/2, 0, oneVV.width/2, 50)];
                [towAlSelBtn addTarget:self action:@selector(settingMethodUI) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:towAlSelBtn];
                
                UIView *linVV = [HistoryRecordModel createLineViewUIUI];
                linVV.frame = CGRectMake(10, 15+33, oneVV.width-20, 1);
                [oneVV addSubview:linVV];
            }else if(i==1){
                
                adresLLlab.frame = CGRectMake(12, 15+34, 160, 34);
                nexImgv.frame = CGRectMake(oneVV.width-24, 15+34+10, 14, 14);
                
                self.settingLab2 = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                [oneVV addSubview:self.settingLab2];
                [self.settingLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(nexImgv.mas_left).offset(-3);
                    make.centerY.equalTo(adresLLlab.mas_centerY);
                }];
                
                UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneVV.width/2, 15+34, oneVV.width/2, 34)];
                [towAlSelBtn addTarget:self action:@selector(settingMethodUITwo) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:towAlSelBtn];
            }else {
                adresLLlab.frame = CGRectMake(10, 15+34*2, 160, 34);
                nexImgv.frame = CGRectMake(oneVV.width-24, 15+34*2+10, 14, 14);
                
                self.settingLab3 = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                [oneVV addSubview:self.settingLab3];
                [self.settingLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(nexImgv.mas_left).offset(-3);
                    make.centerY.equalTo(adresLLlab.mas_centerY);
                }];
                
                UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneVV.width/2, 15+34*2, oneVV.width/2, 34)];
                [towAlSelBtn addTarget:self action:@selector(settingMethodUIThr) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:towAlSelBtn];
            }
        }
        
        CGFloat ww_yy = 40+34*3+2*36+20+34;
        if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
            
            UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40+34*3, 30, 30)];
            [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
            [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
            twoBtn.tag = 3400;
            [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:twoBtn];
            
            UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            oneSLab.frame = CGRectMake(30, 145-10, _window_width-60, 50);
            oneSLab.text = eLocalizedString(@"role_name28");
            [oneVV addSubview:oneSLab];

            UIView *elecVV = [[UIView alloc] initWithFrame:CGRectMake(0, ww_yy+30, _window_width, 150)];
            elecVV.backgroundColor = UIColor.clearColor;
            [oneVV addSubview:elecVV];
            
            NSArray *elecAr = @[@"role_name36", @"role_name37", @"role_name38"];
            for (int i=0; i<elecAr.count; i++) {
                
                UIView *elOnV = [[UIView alloc] init];
                elOnV.backgroundColor = UIColor.clearColor;
                [elecVV addSubview:elOnV];
                
                UIView *elOnV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
                elOnV2.backgroundColor = RGBA(138, 0, 197, 0.15);
                [elOnV addSubview:elOnV2];
                
                UILabel *lefLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                lefLLab.frame = CGRectMake(12, 0, _window_width/2, 46);
                lefLLab.text = eLocalizedString(elecAr[i]);
                [elOnV addSubview:lefLLab];
                
                if(i==0) {
                    elOnV.frame = CGRectMake(0, 0, _window_width, 46);
                    UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
                    nexImgv.frame = CGRectMake(_window_width-26, 16, 14, 14);
                    nexImgv.image = [UIImage imageNamed:@"home_next2"];
                    [elOnV addSubview:nexImgv];
                    
                    UIButton *elSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
                    [elSelBtn addTarget:self action:@selector(elSelBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                    [elOnV addSubview:elSelBtn];
                }else if (i==1) {
                    elOnV.frame = CGRectMake(0, 58, _window_width, 46);
                    
                    UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                    msg_lab2.text = eLocalizedString(@"role_name14_14");
                    [elOnV addSubview:msg_lab2];
                    [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(elOnV.mas_right).offset(-12);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                    
                    UILabel *minLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    minLab.tag = 6700;
                    [elOnV addSubview:minLab];
                    [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(msg_lab2.mas_left).offset(-8);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                }else {
                    elOnV.frame = CGRectMake(0, 58+46, _window_width, 46);
                    
                    UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                    msg_lab2.text = eLocalizedString(@"role_name14_14");
                    [elOnV addSubview:msg_lab2];
                    [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(elOnV.mas_right).offset(-12);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                    
                    UILabel *minLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    minLab.tag = 6701;
                    [elOnV addSubview:minLab];
                    [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(msg_lab2.mas_left).offset(-8);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                }
            }
            
            UIButton *chatBtn = [HistoryRecordModel createImgBtn];
            chatBtn.frame = CGRectMake((_window_width-122)/2, CGRectGetMaxY(elecVV.frame)+60, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
            [chatBtn setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            chatBtn.tag = 6702;
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
            oneVV.contentSize = CGSizeMake(_window_width, ww_yy+60+80);
        }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
            
            NSArray *namsA2 = @[@"role_name28"];
            for (int i=0; i<namsA2.count; i++) {
                
                UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40+34*3+i*36, 30, 30)];
                [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
                [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
                twoBtn.tag = 3400+i;
                [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:twoBtn];
                
                UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                oneSLab.frame = CGRectMake(30, 142+i*36-10, _window_width-60, 50);
                oneSLab.text = eLocalizedString(namsA2[i]);
                oneSLab.numberOfLines = 2;
                [oneVV addSubview:oneSLab];
            }
            
            UILabel *electSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            electSLab.frame = CGRectMake(12, 40+34*3+2*36+20-30, _window_width-24, 34);
            electSLab.text = eLocalizedString(@"role_name30");
            [oneVV addSubview:electSLab];
            
            self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(electSLab.frame)+14, _window_width-92, 24)];
            self.twoScrollV.delegate = self;
            self.twoScrollV.miniMumTIMg = @"role_imgs17";
            self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
            self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
            self.twoScrollV.value = 0.0;
            self.twoScrollV.bufferValue = 0.3;
            self.twoScrollV.sliderHeight = 12;
            self.twoScrollV.allowTapped = YES;
            self.twoScrollV.slidIMg = @"equipmentImgs3";
            self.twoScrollV.thumbSize = CGSizeMake(16, 16);
            [oneVV addSubview:self.twoScrollV];
            
            for (int i=0; i<2; i++) {
                UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                [oneVV addSubview:imgElec];
                if(i==0) {
                    imgElec.frame = CGRectMake(17, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs19"];
                }else {
                    imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs20"];
                }
            }
            
            CGFloat ww_ww = (_window_width-74*3-40)/2;
            NSArray *namsAr = @[@"role_name43", @"role_name44", @"role_name45"];
            NSArray *imgsAr = @[@"role_electImgs1", @"role_electImgs2", @"role_electImgs3"];

            for (int i=0; i<namsAr.count; i++) {
            
                UIButton *thrBtnBB = [[UIButton alloc] initWithFrame:CGRectMake(ww_ww + i*94, CGRectGetMaxY(electSLab.frame)+60, 74, 66)];
                [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgNor"] forState:UIControlStateNormal];
                [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgSel"] forState:UIControlStateSelected];
                thrBtnBB.tag = 5600+i;
                [thrBtnBB addTarget:self action:@selector(thrBtnMethodS:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:thrBtnBB];
                if(i==0) {
                    thrBtnBB.selected = YES;
                }
                
                UIImageView *imgThr = [HistoryRecordModel createImgImgView];
                imgThr.frame = CGRectMake(10, 14, 54, 18);
                imgThr.image = [UIImage imageNamed:imgsAr[i]];
                [thrBtnBB addSubview:imgThr];
                
                UILabel *namLLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
                namLLab.frame = CGRectMake(0, 34, 74, 30);
                namLLab.text = eLocalizedString(namsAr[i]);
                [thrBtnBB addSubview:namLLab];
                
            }
            
            UIButton *dj_timeBtn = [HistoryRecordModel createImgBtn];
            [dj_timeBtn setBackgroundImage:[UIImage imageNamed:@"play_allImgs9"] forState:UIControlStateNormal];
            [dj_timeBtn addTarget:self action:@selector(djTimeBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:dj_timeBtn];
            [dj_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(electSLab.mas_bottom).offset(146);
                make.centerX.equalTo(oneVV.mas_centerX);
                make.height.offset(40);
                make.width.mas_greaterThanOrEqualTo(238);
            }];
            UIView *smal_tim = [[UIView alloc] init];
            smal_tim.backgroundColor = UIColor.whiteColor;
            smal_tim.userInteractionEnabled = NO;
            [dj_timeBtn addSubview:smal_tim];
            [smal_tim mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dj_timeBtn.mas_centerX).offset(-2);
                make.centerY.equalTo(dj_timeBtn.mas_centerY);
                make.height.offset(20);
                make.width.mas_greaterThanOrEqualTo(38);
            }];
            UILabel *lef_djLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentRight];
            lef_djLab.text = eLocalizedString(@"two_nams28");
            [dj_timeBtn addSubview:lef_djLab];
            [lef_djLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dj_timeBtn.mas_left).offset(5);
                make.top.bottom.equalTo(dj_timeBtn);
                make.right.equalTo(smal_tim.mas_left).offset(-6);
            }];
            UILabel *smal_timLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
            smal_timLab.text = self.shockMinute;
            smal_timLab.tag = 5000;
            [smal_tim addSubview:smal_timLab];
            [smal_timLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(smal_tim.mas_left).offset(5);
                make.top.bottom.equalTo(smal_tim);
                make.right.equalTo(smal_tim.mas_right).offset(-5);
            }];
            UILabel *rig_djLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
            rig_djLab.text = eLocalizedString(@"role_name14_14");
            [dj_timeBtn addSubview:rig_djLab];
            [rig_djLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(dj_timeBtn.mas_right).offset(-5);
                make.top.bottom.equalTo(dj_timeBtn);
                make.left.equalTo(smal_tim.mas_right).offset(6);
            }];
            
            UIView *elecVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(electSLab.frame)+110+100, _window_width, 150)];
            elecVV.backgroundColor = UIColor.clearColor;
            [oneVV addSubview:elecVV];
            
            NSArray *elecAr = @[@"role_name36", @"role_name37", @"role_name38"];
            for (int i=0; i<elecAr.count; i++) {
                
                UIView *elOnV = [[UIView alloc] init];
                elOnV.backgroundColor = UIColor.clearColor;
                [elecVV addSubview:elOnV];
                
                UIView *elOnV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
                elOnV2.backgroundColor = RGBA(138, 0, 197, 0.15);
                [elOnV addSubview:elOnV2];
                
                UILabel *lefLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                lefLLab.frame = CGRectMake(12, 0, _window_width/2, 46);
                lefLLab.text = eLocalizedString(elecAr[i]);
                [elOnV addSubview:lefLLab];
                
                if(i==0) {
                    elOnV.frame = CGRectMake(0, 0, _window_width, 46);
                    UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
                    nexImgv.frame = CGRectMake(_window_width-26, 16, 14, 14);
                    nexImgv.image = [UIImage imageNamed:@"home_next2"];
                    [elOnV addSubview:nexImgv];
                    
                    UIButton *elSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
                    [elSelBtn addTarget:self action:@selector(elSelBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                    [elOnV addSubview:elSelBtn];
                }else if (i==1) {
                    elOnV.frame = CGRectMake(0, 58, _window_width, 46);
                    
                    UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                    msg_lab2.text = eLocalizedString(@"role_name14_14");
                    [elOnV addSubview:msg_lab2];
                    [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(elOnV.mas_right).offset(-12);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                    
                    UILabel *minLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    minLab.tag = 6700;
                    [elOnV addSubview:minLab];
                    [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(msg_lab2.mas_left).offset(-8);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                }else {
                    elOnV.frame = CGRectMake(0, 58+46, _window_width, 46);
                    
                    UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                    msg_lab2.text = eLocalizedString(@"role_name14_14");
                    [elOnV addSubview:msg_lab2];
                    [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(elOnV.mas_right).offset(-12);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                    
                    UILabel *minLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    minLab.tag = 6701;
                    [elOnV addSubview:minLab];
                    [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(msg_lab2.mas_left).offset(-8);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                }
            }
            
            
            
            UIButton *chatBtn = [HistoryRecordModel createImgBtn];
            chatBtn.frame = CGRectMake((_window_width-122)/2, CGRectGetMaxY(elecVV.frame)+60, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
            [chatBtn setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            chatBtn.tag = 6702;
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
            oneVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(chatBtn.frame)+80);
            
        }else {
            
            NSArray *namsA2 = @[@"role_name28", @"role_name29"];
            for (int i=0; i<namsA2.count; i++) {
                
                UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40+34*3+i*36, 30, 30)];
                [twoBtn setImage:[UIImage imageNamed:@"role_normalImg"] forState:UIControlStateNormal];
                [twoBtn setImage:[UIImage imageNamed:@"role_selImg"] forState:UIControlStateSelected];
                twoBtn.tag = 3400+i;
                [twoBtn addTarget:self action:@selector(twoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [oneVV addSubview:twoBtn];
                
                UILabel *oneSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                oneSLab.frame = CGRectMake(30, 142+i*36-10, _window_width-60, 50);
                oneSLab.text = eLocalizedString(namsA2[i]);
                oneSLab.numberOfLines = 2;
                [oneVV addSubview:oneSLab];
            }
            
            UILabel *electSLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            electSLab.frame = CGRectMake(12, 40+34*3+2*36+20, _window_width-24, 34);
            electSLab.text = eLocalizedString(@"role_name30");
            [oneVV addSubview:electSLab];
            
            self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(electSLab.frame)+14, _window_width-92, 24)];
            self.twoScrollV.delegate = self;
            self.twoScrollV.miniMumTIMg = @"role_imgs17";
            self.twoScrollV.minimumTrackTintColor = RGB(202, 76, 255);
            self.twoScrollV.maximumTrackTintColor = RGBA(130, 66, 158, 0.49);
            self.twoScrollV.value = 0.0;
            self.twoScrollV.bufferValue = 0.3;
            self.twoScrollV.sliderHeight = 12;
            self.twoScrollV.allowTapped = YES;
            self.twoScrollV.slidIMg = @"equipmentImgs3";
            self.twoScrollV.thumbSize = CGSizeMake(16, 16);
            [oneVV addSubview:self.twoScrollV];
            
            for (int i=0; i<2; i++) {
                UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                [oneVV addSubview:imgElec];
                if(i==0) {
                    imgElec.frame = CGRectMake(17, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs19"];
                }else {
                    imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(electSLab.frame)+6, 17, 24);
                    imgElec.image = [UIImage imageNamed:@"role_imgs20"];
                }
            }
            
            UIView *elecVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(electSLab.frame)+110, _window_width, 150)];
            elecVV.backgroundColor = UIColor.clearColor;
            [oneVV addSubview:elecVV];
            
            NSArray *elecAr = @[@"role_name36", @"role_name37", @"role_name38"];
            for (int i=0; i<elecAr.count; i++) {
                
                UIView *elOnV = [[UIView alloc] init];
                elOnV.backgroundColor = UIColor.clearColor;
                [elecVV addSubview:elOnV];
                
                UIView *elOnV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
                elOnV2.backgroundColor = RGBA(138, 0, 197, 0.15);
                [elOnV addSubview:elOnV2];
                
                UILabel *lefLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                lefLLab.frame = CGRectMake(12, 0, _window_width/2, 46);
                lefLLab.text = eLocalizedString(elecAr[i]);
                [elOnV addSubview:lefLLab];
                
                if(i==0) {
                    elOnV.frame = CGRectMake(0, 0, _window_width, 46);
                    UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
                    nexImgv.frame = CGRectMake(_window_width-26, 16, 14, 14);
                    nexImgv.image = [UIImage imageNamed:@"home_next2"];
                    [elOnV addSubview:nexImgv];
                    
                    UIButton *elSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, 46)];
                    [elSelBtn addTarget:self action:@selector(elSelBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                    [elOnV addSubview:elSelBtn];
                }else if (i==1) {
                    elOnV.frame = CGRectMake(0, 58, _window_width, 46);
                    
                    UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                    msg_lab2.text = eLocalizedString(@"role_name14_14");
                    [elOnV addSubview:msg_lab2];
                    [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(elOnV.mas_right).offset(-12);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                    
                    UILabel *minLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    minLab.tag = 6700;
                    [elOnV addSubview:minLab];
                    [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(msg_lab2.mas_left).offset(-8);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                }else {
                    elOnV.frame = CGRectMake(0, 58+46, _window_width, 46);
                    
                    UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
                    msg_lab2.text = eLocalizedString(@"role_name14_14");
                    [elOnV addSubview:msg_lab2];
                    [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(elOnV.mas_right).offset(-12);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                    
                    UILabel *minLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    minLab.tag = 6701;
                    [elOnV addSubview:minLab];
                    [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(msg_lab2.mas_left).offset(-8);
                        make.centerY.equalTo(elOnV.mas_centerY);
                    }];
                }
            }
            
            UIButton *chatBtn = [HistoryRecordModel createImgBtn];
            chatBtn.frame = CGRectMake((_window_width-122)/2, CGRectGetMaxY(elecVV.frame)+60, 122, 36);
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
            [chatBtn setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
            [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            chatBtn.titleLabel.font = SYS_Font(14);
            chatBtn.tag = 6702;
            [chatBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:chatBtn];
            
//            oneVV.contentSize = CGSizeMake(_window_width, ww_yy+60+80);
            oneVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(chatBtn.frame)+80);
        }
        
        self.cytjArr = @[@"1", @"18", @"70", @"", @"", @"", @"0", @""];
        
        [requestToolClass getNetworkWithUrl:request_voteRecord_getInProgressVoteRecord andParameter:@{@"deviceId":self.devicId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            if([info isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dicUser = info;
                UILabel *time_Lab = [oneVV viewWithTag:6700];
                UILabel *time_Lab2 = [oneVV viewWithTag:6701];
                if([minStr(dicUser[@"cumulativeTotalDuration"]) intValue] > 0) {
                    time_Lab.text = minStr(dicUser[@"cumulativeTotalDuration"]);
                }
                if([minStr(dicUser[@"pendingExecutionDuration"]) intValue] > 0) {
                    time_Lab2.text = minStr(dicUser[@"pendingExecutionDuration"]);
                }
            }
        } fail:^(NSString * _Nonnull msg) {
            
        }];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadRoleTimelockMethod:) name:@"uploadRoleTimelock" object:nil];
}


//MARK: 二期电鳗贞操锁  选择 震动、震颤、针刺
- (void)thrBtnMethodS:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        
        UIButton *strB = [self.view viewWithTag:5600+i];
        if(btn == strB) {
            self.frequency = minIntStr(i+1);
            strB.selected = YES;
        }else {
            strB.selected = NO;
        }
    }
}

//选择时间
- (void)djTimeBtnMethod
{
    CXDatePickerView *datePick = [[CXDatePickerView alloc] initWithZeroDayCompleteBlock:^(NSInteger days, NSInteger hours, NSInteger minutes) {
        
        NSInteger all_num = days*24*60 + hours*60 + minutes;
        if ((all_num>0) && (all_num<999)) {
            self.shockMinute = [NSString stringWithFormat:@"%ld", (long)(days*24*60 + hours*60 + minutes)];
            UILabel *smal_timLab = [self.view viewWithTag:5000];
            smal_timLab.text = self.shockMinute;
        }else {
         
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"two_nams30")];
        }
    }];
    [datePick show];
}


- (void)uploadRoleTimelockMethod:(NSNotification *)notiF
{
    if([minStr(notiF.object) isEqualToString:@"1"]) {
        self.isStartB = YES;
    }else {
        self.isStartB = NO;
    }
}

//MARK: 公投记录
- (void)elSelBtnMethod
{
    MHRoleSetSubRecordsController *vc = [[MHRoleSetSubRecordsController alloc] init];
    vc.devicId = self.devicId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chatBtnMethod
{
    if(self.typN == 0) {
        
        MHGearSetView *gearV = [self.view viewWithTag:8100];
        MHGearSetView *gearV2 = [self.view viewWithTag:8101];
        MHGearSetView *gearV3 = [self.view viewWithTag:8102];
        
        MHGearSetView *gearVT = [self.view viewWithTag:8200];
        MHGearSetView *gearVT2 = [self.view viewWithTag:8201];
        MHGearSetView *gearVT3 = [self.view viewWithTag:8202];

        gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].dayArr];
        gearV2.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].hourArr];
        gearV3.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].mineArr];
        
        gearVT.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].dayArr];
        gearVT2.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].hourArr];
        gearVT3.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].mineArr];

        self.stopNNN = 0;
        self.stopNNN2 = 0;
        self.stopNNN3 = 0;
        self.starNNN = 0;
        self.starNNN2 = 0;
        self.starNNN3 = 0;
        self.al_NN = 0;
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
            self.randomNNN = 0;
            self.randomNNN2 = 0;
            self.randomNNN3 = 0;
            
            for (int i=0; i<3; i++) {
                UILabel *mmRandLab = [self.view viewWithTag:970+i];
                mmRandLab.text = @"00";
            }
        }
        
        UIButton *twoBtn = [self.view viewWithTag:3400];
        UIButton *twoBtn2 = [self.view viewWithTag:3401];
        twoBtn.selected = NO;
        twoBtn2.selected = NO;
        
        self.twoScrollV.value = 0.0;
        
    }else if (self.typN == 1) {
        
        MHGearSetView *gearV = [self.view viewWithTag:8100];
        MHGearSetView *gearV2 = [self.view viewWithTag:8101];
        MHGearSetView *gearV3 = [self.view viewWithTag:8102];

        gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].dayArr];
        gearV2.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].hourArr];
        gearV3.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].mineArr];

        self.stopNNN = 0;
        self.starNNN = 0;
        self.starNNN2 = 0;
        self.starNNN3 = 0;
        self.al_NN = 0;
        
        UIButton *twoBtn = [self.view viewWithTag:3400];
        UIButton *twoBtn2 = [self.view viewWithTag:3401];
        twoBtn.selected = NO;
        twoBtn2.selected = NO;
        
        self.twoScrollV.value = 0.0;
        
    }else {
        
        if((self.settingLab.text.length>0)&&(self.settingLab2.text.length > 0)&&[self.settingLab3.text isEqualToString:eLocalizedString(@"role_name15")]) {
            
            if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
                
                UIButton *oneBtn = [self.view viewWithTag:3400];
                NSString *btn_sel = oneBtn.selected==YES ? @"true":@"false";
                NSString *btn_sel2 = @"false";
                NSString *kai_dy = @"0";
                
                MHPostSquareController *vc = [[MHPostSquareController alloc] init];
                vc.isRoleGongTouBoo = YES;
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                    vc.frequency = self.frequency;
                    vc.shockMinute = self.shockMinute;
                }
                vc.selfUpVC = self.selfUpVC;
                vc.reqestDicAr = @[self.devicId, minStr(self.settingLab.text), minStr(self.settingLab2.text), @{@"ageRangeStart":self.cytjArr[1], @"ageRangeEnd":self.cytjArr[2], @"genderRange":self.cytjArr[3], @"genderPreferenceRange":self.cytjArr[4], @"rolePreferenceRange":self.cytjArr[5], @"locationId":self.cytjArr[6]}, btn_sel, btn_sel2, kai_dy];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                UIButton *oneBtn = [self.view viewWithTag:3400];
                UIButton *oneBtn2 = [self.view viewWithTag:3401];
                NSString *btn_sel = oneBtn.selected==YES ? @"true":@"false";
                NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                
                MHPostSquareController *vc = [[MHPostSquareController alloc] init];
                vc.isRoleGongTouBoo = YES;
                if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                    vc.frequency = self.frequency;
                    vc.shockMinute = self.shockMinute;
                }
                vc.selfUpVC = self.selfUpVC;
                vc.reqestDicAr = @[self.devicId, minStr(self.settingLab.text), minStr(self.settingLab2.text), @{@"ageRangeStart":self.cytjArr[1], @"ageRangeEnd":self.cytjArr[2], @"genderRange":self.cytjArr[3], @"genderPreferenceRange":self.cytjArr[4], @"rolePreferenceRange":self.cytjArr[5], @"locationId":self.cytjArr[6]}, btn_sel, btn_sel2, kai_dy];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else {
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_3")];
        }
    }
}

//MARK: 开启接口
- (void)chatBtnMethodTwo
{
    if(self.typN == 0) {
        
        if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
            if((self.randomNNN+self.randomNNN2+self.randomNNN3) > 0) {
                UIButton *oneBtn = [self.view viewWithTag:3400];
                NSString *btn_sel = oneBtn.selected==YES ? @"true":@"false";
                if(self.isStartB && (oneBtn.selected==YES)) {
                    
                    [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"login_err9") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                        if (index == 1) {
    
                            NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                            NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":@"true", @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.randomNNN+self.randomNNN2+self.randomNNN3)), @"maxSeconds":minIntStr((self.randomNNN+self.randomNNN2+self.randomNNN3)), @"frequency":self.frequency, @"shockMinute":self.shockMinute};
                            [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                                self.isRRRRR = NO;
                               
                                if(self.block_) {
                                    self.block_(oneBtn.selected);
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            } fail:^(NSString * _Nonnull msg) {
                                self.isRRRRR = NO;
                            }];
                        }
                    }];
                }else {
                    
                    if(self.isRRRRR) {
                        return;
                    }
                    self.isRRRRR = YES;
                    
                    [SVProgressHUD show];

                    NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                    NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":@"true", @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.randomNNN+self.randomNNN2+self.randomNNN3)), @"maxSeconds":minIntStr((self.randomNNN+self.randomNNN2+self.randomNNN3)), @"frequency":self.frequency, @"shockMinute":self.shockMinute};
                    [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                        self.isRRRRR = NO;
                       
                        if(self.block_) {
                            self.block_(oneBtn.selected);
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                    }];
                }
            }
        }
    }else if (self.typN == 1) {
        
        if((self.starNNN+self.starNNN2+self.starNNN3) > 0) {
            UIButton *oneBtn = [self.view viewWithTag:3400];
            NSString *btn_sel = oneBtn.selected==YES ? @"true":@"false";
            if(self.isStartB && (oneBtn.selected==YES)) {
                
                [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"login_err9") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
                            
                            
                            NSString *btn_sel2 = @"false";
                            
                            NSString *kai_dy = @"0";
                            
                            NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"maxSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60)};
                            [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                                self.isRRRRR = NO;
                               
                                if(self.block_) {
                                    self.block_(oneBtn.selected);
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            } fail:^(NSString * _Nonnull msg) {
                                self.isRRRRR = NO;
                            }];
                        }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                            
                            NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                            
                            NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":@"true", @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"maxSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"frequency":self.frequency, @"shockMinute":self.shockMinute};
                            [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                                self.isRRRRR = NO;
                              
                                if(self.block_) {
                                    self.block_(oneBtn.selected);
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            } fail:^(NSString * _Nonnull msg) {
                                self.isRRRRR = NO;
                            }];
                        }else {

                            UIButton *oneBtn2 = [self.view viewWithTag:3401];
                            NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                            
                            NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                            
                            NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"maxSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60)};
                            [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                
                                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                                self.isRRRRR = NO;
                              
                                if(self.block_) {
                                    self.block_(oneBtn.selected);
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            } fail:^(NSString * _Nonnull msg) {
                                self.isRRRRR = NO;
                            }];
                        }
                    }
                }];
            }else {
                
                if(self.isRRRRR) {
                    return;
                }
                self.isRRRRR = YES;
                
                [SVProgressHUD show];
                if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
                    
          
                    NSString *btn_sel2 = @"false";
                    
                    NSString *kai_dy = @"0";
                    
                    NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"maxSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60)};
                    [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                        self.isRRRRR = NO;
                       
                        if(self.block_) {
                            self.block_(oneBtn.selected);
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                    }];
                }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                    
                    NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                    
                    NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":@"true", @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"maxSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"frequency":self.frequency, @"shockMinute":self.shockMinute};
                    [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                        self.isRRRRR = NO;
                       
                        if(self.block_) {
                            self.block_(oneBtn.selected);
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                    }];
                }else {

                    UIButton *oneBtn2 = [self.view viewWithTag:3401];
                    NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                    
                    NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                    
                    NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60), @"maxSeconds":minIntStr((self.starNNN+self.starNNN2+self.starNNN3)*60)};
                    [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                        self.isRRRRR = NO;
                       
                        if(self.block_) {
                            self.block_(oneBtn.selected);
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    } fail:^(NSString * _Nonnull msg) {
                        self.isRRRRR = NO;
                    }];
                }
            }
        }
    }else {
        
    }
}

//MARK:  是否即时生效
- (void)twoBtnMethod:(UIButton *)btn
{
    UIButton *oneBtn = [self.view viewWithTag:3400];
    UIButton *oneBtn2 = [self.view viewWithTag:3401];
    if(btn == oneBtn) {
        if(!self.isStartB) {
            oneBtn.selected = !oneBtn.selected;
        }else {
            oneBtn.selected = !oneBtn.selected;
        }
    }else {
        oneBtn2.selected = !oneBtn2.selected;
    }
}

//MARK: 获取随机数
- (void)startBtnMethod
{
    
    if(self.al_NN <= 0) {
        
        int one_fff = self.starNNN+self.starNNN2+self.starNNN3;
        int two_fff = self.stopNNN+self.stopNNN2+self.stopNNN3;
        if(two_fff > one_fff) {
            
     
            if (one_fff <= 0) {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"two_nams33")];
                return;
            }
            
            if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                
                UILabel *mmRandLab = [self.view viewWithTag:970];
                UILabel *mmRandLab2 = [self.view viewWithTag:971];
                UILabel *mmRandLab3 = [self.view viewWithTag:972];
                int www_sj = [self getRandomNumber:one_fff to:two_fff];
                NSString *sj_str = [HistoryRecordModel minDayToDayHourMinutes:www_sj];
                NSArray *arr_sj = [sj_str componentsSeparatedByString:@":"];
                
                mmRandLab.text = arr_sj[0];
                mmRandLab2.text = arr_sj[1];
                mmRandLab3.text = arr_sj[2];
                
                self.randomNNN = [minStr(arr_sj[0]) intValue]*24*60;
                self.randomNNN2 = [minStr(arr_sj[1]) intValue]*60;
                self.randomNNN3 = [minStr(arr_sj[2]) intValue];
                
            }else {
                
                UIButton *oneBtn = [self.view viewWithTag:3400];
                NSString *btn_sel = oneBtn.selected==YES ? @"true":@"false";
                if(self.isStartB && (oneBtn.selected==YES)) {
                    [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"login_err9") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                        if (index == 1) {
                            if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
                                
                                NSString *btn_sel2 = @"false";
                                
                                NSString *kai_dy = @"0";
                                
                                NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr(one_fff*60), @"maxSeconds":minIntStr(two_fff*60)};
                                [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                    
                                    if([info isKindOfClass:[NSDictionary class]]) {
                                        self.al_NN = [minStr(info[@"days"]) intValue]*24*60 + [minStr(info[@"hours"]) intValue]*60 + [minStr(info[@"minutes"]) intValue];
                                        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                                        vc.startNum = self.al_NN;
                                        [self.tabBarController.view addSubview:vc];
                                        [vc addLimitsAuthorityUIUI:1];
                                        vc.block_ = ^{
                                            if(self.block_) {
                                                self.block_(oneBtn.selected);
                                            }
                                            [self.navigationController popViewControllerAnimated:YES];
                                        };
                                    }
                                    self.isRRRRR = NO;
                                } fail:^(NSString * _Nonnull msg) {
                                    self.isRRRRR = NO;
                                }];
                            }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                                
                                UIButton *oneBtn2 = [self.view viewWithTag:3401];
//                                NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                                
                                NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                                
                                NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":@"true", @"unlockVoltage":kai_dy, @"minSeconds":minIntStr(one_fff*60), @"maxSeconds":minIntStr(two_fff*60), @"frequency":self.frequency, @"shockMinute":self.shockMinute};
                                [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                    
                                    if([info isKindOfClass:[NSDictionary class]]) {
                                        self.al_NN = [minStr(info[@"days"]) intValue]*24*60 + [minStr(info[@"hours"]) intValue]*60 + [minStr(info[@"minutes"]) intValue];
                                        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                                        vc.startNum = self.al_NN;
                                        [self.tabBarController.view addSubview:vc];
                                        [vc addLimitsAuthorityUIUI:1];
                                        vc.block_ = ^{
                                            if(self.block_) {
                                                self.block_(oneBtn.selected);
                                            }
                                            [self.navigationController popViewControllerAnimated:YES];
                                        };
                                    }
                                    self.isRRRRR = NO;
                                } fail:^(NSString * _Nonnull msg) {
                                    self.isRRRRR = NO;
                                }];
                            }else {
                                
                                UIButton *oneBtn2 = [self.view viewWithTag:3401];
                                NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                                
                                NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                                
                                NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr(one_fff*60), @"maxSeconds":minIntStr(two_fff*60)};
                                [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                                    
                                    if([info isKindOfClass:[NSDictionary class]]) {
                                        self.al_NN = [minStr(info[@"days"]) intValue]*24*60 + [minStr(info[@"hours"]) intValue]*60 + [minStr(info[@"minutes"]) intValue];
                                        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                                        vc.startNum = self.al_NN;
                                        [self.tabBarController.view addSubview:vc];
                                        [vc addLimitsAuthorityUIUI:1];
                                        vc.block_ = ^{
                                            if(self.block_) {
                                                self.block_(oneBtn.selected);
                                            }
                                            [self.navigationController popViewControllerAnimated:YES];
                                        };
                                    }
                                    self.isRRRRR = NO;
                                } fail:^(NSString * _Nonnull msg) {
                                    self.isRRRRR = NO;
                                }];
                            }
                        }
                    }];
                }else {
                    
                    if(self.isRRRRR) {
                        return;
                    }
                    self.isRRRRR = YES;
                    [SVProgressHUD show];
                    
                    if([self.devicTyy isEqualToString:kCharactName2] || [self.devicTyy isEqualToString:kCharactName12] || [self.devicTyy isEqualToString:kCharactName15]) {
                        
                        NSString *btn_sel2 = @"false";
                        
                        NSString *kai_dy = @"0";
                        
                        NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr(one_fff*60), @"maxSeconds":minIntStr(two_fff*60)};
                        [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if([info isKindOfClass:[NSDictionary class]]) {
                                self.al_NN = [minStr(info[@"days"]) intValue]*24*60 + [minStr(info[@"hours"]) intValue]*60 + [minStr(info[@"minutes"]) intValue];
                                MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                                vc.startNum = self.al_NN;
                                [self.tabBarController.view addSubview:vc];
                                [vc addLimitsAuthorityUIUI:1];
                                vc.block_ = ^{
                                    if(self.block_) {
                                        self.block_(oneBtn.selected);
                                    }
                                    [self.navigationController popViewControllerAnimated:YES];
                                };
                            }
                            self.isRRRRR = NO;
                        } fail:^(NSString * _Nonnull msg) {
                            self.isRRRRR = NO;
                        }];
                    }else if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:self.devicTyy]) {
                        
                        UIButton *oneBtn2 = [self.view viewWithTag:3401];
                        
//                        NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                        
                        NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                        
                        NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":@"true", @"unlockVoltage":kai_dy, @"minSeconds":minIntStr(one_fff*60), @"maxSeconds":minIntStr(two_fff*60), @"frequency":self.frequency, @"shockMinute":self.shockMinute};
                        [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if([info isKindOfClass:[NSDictionary class]]) {
                                self.al_NN = [minStr(info[@"days"]) intValue]*24*60 + [minStr(info[@"hours"]) intValue]*60 + [minStr(info[@"minutes"]) intValue];
                                MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                                vc.startNum = self.al_NN;
                                [self.tabBarController.view addSubview:vc];
                                [vc addLimitsAuthorityUIUI:1];
                                vc.block_ = ^{
                                    if(self.block_) {
                                        self.block_(oneBtn.selected);
                                    }
                                    [self.navigationController popViewControllerAnimated:YES];
                                };
                            }
                            self.isRRRRR = NO;
                        } fail:^(NSString * _Nonnull msg) {
                            self.isRRRRR = NO;
                        }];
                    }else {
                        
                        UIButton *oneBtn2 = [self.view viewWithTag:3401];
                        NSString *btn_sel2 = oneBtn2.selected==YES ? @"true":@"false";
                        
                        NSString *kai_dy = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
                        
                        NSDictionary *dicMM = @{@"deviceId":self.devicId, @"executeImmediately":btn_sel, @"unlockReminderEnabled":btn_sel2, @"unlockVoltage":kai_dy, @"minSeconds":minIntStr(one_fff*60), @"maxSeconds":minIntStr(two_fff*60)};
                        [requestToolClass postNetworkWithUrl:request_device_generateTimeVoucher andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            if([info isKindOfClass:[NSDictionary class]]) {
                                self.al_NN = [minStr(info[@"days"]) intValue]*24*60 + [minStr(info[@"hours"]) intValue]*60 + [minStr(info[@"minutes"]) intValue];
                                MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                                vc.startNum = self.al_NN;
                                [self.tabBarController.view addSubview:vc];
                                [vc addLimitsAuthorityUIUI:1];
                                vc.block_ = ^{
                                    if(self.block_) {
                                        self.block_(oneBtn.selected);
                                    }
                                    [self.navigationController popViewControllerAnimated:YES];
                                };
                            }
                            self.isRRRRR = NO;
                        } fail:^(NSString * _Nonnull msg) {
                            self.isRRRRR = NO;
                        }];
                    }
                }
            }
        }
    }
}

//MARK: 获取区间随机数
-(int)getRandomNumber:(int)from to:(int)to
{
    if (from < 0 || to < 0 || from >= to) {
        return 0;
    }
    if (from == to+1) {
        return  from;
    } else {
        return  (arc4random() % (to-from)) + from;
    }
}

- (void)sliderVVView:(sliderVVView *)sliderVV sliderTouchEnded:(float)value
{
    
}

//MARK: 设置
- (void)settingMethodUI
{
    PopModifyView *modify = [[PopModifyView alloc]init];
    modify.titleString = eLocalizedString(@"role_name33");
    modify.isSingleCommit = YES;
    modify.textfield.keyboardType = UIKeyboardTypeNumberPad;
    modify.blockTextToModify = ^(NSString *name, NSString *phone) {
        
        self.settingLab.text = name;
    };
    [modify show];
}
- (void)settingMethodUITwo
{
    NSString *mmm = [HistoryRecordModel getCurrentTimeMethod:@""];
    NSArray *ar_MM = [mmm componentsSeparatedByString:@" "];
    
    NSArray *ar_MM2 = [minStr(ar_MM[0]) componentsSeparatedByString:@"-"];
    NSArray *ar_MM3 = [minStr(ar_MM[1]) componentsSeparatedByString:@":"];
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    // 2.设置属性
    datePickerView.pickerMode = BRDatePickerModeYMDHM;
    datePickerView.title = eLocalizedString(@"role_name34");
    datePickerView.selectDate = [NSDate br_setYear:[ar_MM2[0] intValue] month:[ar_MM2[1] intValue] day:[ar_MM2[2] intValue] hour:[ar_MM3[0] intValue] minute:[ar_MM3[1] intValue]];
    datePickerView.minDate = [NSDate br_setYear:[ar_MM2[0] intValue] month:[ar_MM2[1] intValue] day:[ar_MM2[2] intValue] hour:[ar_MM3[0] intValue] minute:[ar_MM3[1] intValue]];
//    datePickerView.maxDate = [NSDate br_setYear:[l_s integerValue]-17 month:1 day:1];
    datePickerView.isAutoSelect = YES;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
        self.settingLab2.text = selectValue;
    };
    [datePickerView show];
}

- (void)settingMethodUIThr
{
    MHPostConditionsController *vc = [[MHPostConditionsController alloc] init];
    vc.arrFind = self.cytjArr;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^(NSArray * _Nonnull arr) {
        self.settingLab3.text = eLocalizedString(@"role_name15");
        self.cytjArr = arr;
    };
}

@end
