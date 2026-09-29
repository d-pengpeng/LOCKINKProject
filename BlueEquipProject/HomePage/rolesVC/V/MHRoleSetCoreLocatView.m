//
//  MHRoleSetCoreLocatView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/19.
//

#import "MHRoleSetCoreLocatView.h"
#import "sliderVVView.h"

@interface MHRoleSetCoreLocatView ()<UITextFieldDelegate, TPVerticalVideoSliderViewDelegate>

@property (nonatomic, strong) sliderVVView *twoScrollV;
@property (nonatomic, strong) UILabel *addreslab;
@property (nonatomic, strong) UITextField *textFFF;
@property (nonatomic, copy) NSString *oneStr1;
@property (nonatomic, copy) NSString *oneStr2;
@property (nonatomic, copy) NSString *oneStr3;
@property (nonatomic, assign) CGFloat oneStr4;
@property (nonatomic, copy) NSString *day_str;
@property (nonatomic, copy) NSString *ruu_str;
@end
@implementation MHRoleSetCoreLocatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.oneStr1 = @"";
        self.oneStr2 = @"";
        self.oneStr3 = @"true";
        self.oneStr4 = 0;
        self.ruu_str = @"";
        
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deletbn addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-260, 330, 420);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 420)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(35, 39, oneVV.width-70, oneVV.height-78)];
        scrolVV.showsVerticalScrollIndicator = NO;
        scrolVV.showsHorizontalScrollIndicator = NO;
        scrolVV.backgroundColor = UIColor.clearColor;
        scrolVV.bounces = NO;
        [oneVV addSubview:scrolVV];
        
        UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab.frame = CGRectMake(0, 0, scrolVV.width, 44);
        titLlab.text = eLocalizedString(@"my_settings");
        [scrolVV addSubview:titLlab];
        
        NSArray *listAr = @[@"role_setting1", @"role_setting2", @"role_setting3", @"role_setting4"];
        NSArray *listAr2 = @[@"44", @"102", @"179", @"211"];
        
        for (int i=0; i<listAr.count; i++) {
            
            UILabel *allLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
            allLab.frame = CGRectMake(0, [listAr2[i] intValue], scrolVV.width, 22);
            allLab.text = eLocalizedString(listAr[i]);
            [scrolVV addSubview:allLab];
            
            switch (i) {
                case 0:
                {
                    self.addreslab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                    self.addreslab.frame = CGRectMake(0, CGRectGetMaxY(allLab.frame), scrolVV.width, 30);
                    [scrolVV addSubview:self.addreslab];
                }
                    break;
                case 1:
                {
                    self.textFFF = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(allLab.frame), scrolVV.width-46, 32)];
                    self.textFFF.backgroundColor = UIColor.clearColor;
                    self.textFFF.textColor = UIColor.whiteColor;
                    self.textFFF.font = SYS_Font(14);
                    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"role_setting5") attributes:
                        @{NSForegroundColorAttributeName:RGB(198, 164, 214), NSFontAttributeName:self.textFFF.font}];
                    self.textFFF.attributedPlaceholder = attrString3;
                    self.textFFF.clipsToBounds = YES;
                    self.textFFF.layer.borderColor = RGB(198, 164, 214).CGColor;
                    self.textFFF.layer.borderWidth = 1;
                    self.textFFF.layer.cornerRadius = 4;
                    self.textFFF.delegate = self;
                    self.textFFF.keyboardType = UIKeyboardTypeNumberPad;
                    [scrolVV addSubview:self.textFFF];
                    
                    UIView *lefVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 32)];
                    lefVV.backgroundColor = UIColor.clearColor;
                    self.textFFF.leftView = lefVV;
                    self.textFFF.leftViewMode = UITextFieldViewModeAlways;
                    
                    UILabel *fff = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
                    fff.frame = CGRectMake(self.textFFF.width, self.textFFF.y, 46, 32);
                    fff.text = @"KM";
                    [scrolVV addSubview:fff];
                }
                    break;
                case 2:
                {
                    CGFloat ww_XX = [HistoryRecordModel jiSuanWith:eLocalizedString(listAr[i]) font:16];
                    
                    NSArray *oneMM = @[eLocalizedString(@"role_setting6"), eLocalizedString(@"role_setting7")];
                    CGFloat w_ww = (scrolVV.width-ww_XX)/2;
                    for (int j=0; j<oneMM.count; j++) {
                        
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(ww_XX + j*w_ww, allLab.y, w_ww, 22);
                        [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setImage:[UIImage imageNamed:@"role_normalImg2"] forState:UIControlStateNormal];
                        [btn_btn setImage:[UIImage imageNamed:@"role_selImg 1"] forState:UIControlStateSelected];
                        btn_btn.backgroundColor = UIColor.clearColor;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        btn_btn.tag = 8200+j;
                        [btn_btn layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleLeft imageTitleSpace:4];
//                        btn_btn.imageEdgeInsets = UIEdgeInsetsMake(3, 10, 3, w_ww-26);
//                        btn_btn.titleEdgeInsets = UIEdgeInsetsMake(3, 34, 3, 0);
                        [btn_btn addTarget:self action:@selector(btnMethodAllsTwo:) forControlEvents:UIControlEventTouchUpInside];
                        [scrolVV addSubview:btn_btn];
                        if(j==0) {
                            btn_btn.selected = YES;
                        }
                    }
                }
                    break;
                case 3:
                {
                    self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(allLab.frame)+14, scrolVV.width-54, 24)];
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
                    [scrolVV addSubview:self.twoScrollV];
                    
                    for (int i=0; i<2; i++) {
                        UIImageView *imgElec = [HistoryRecordModel createImgImgView];
                        [scrolVV addSubview:imgElec];
                        if(i==0) {
                            imgElec.frame = CGRectMake(0, CGRectGetMaxY(allLab.frame)+12, 17, 24);
                            imgElec.image = [UIImage imageNamed:@"role_imgs19_1"];
                        }else {
                            imgElec.frame = CGRectMake(scrolVV.width-17, CGRectGetMaxY(allLab.frame)+12, 17, 24);
                            imgElec.image = [UIImage imageNamed:@"role_imgs20_1"];
                        }
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }

        CGFloat w_two = (scrolVV.width-92*2)/4;
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(w_two, scrolVV.height-60, 92, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn.backgroundColor = UIColor.clearColor;
        btn_btn.layer.cornerRadius = 6;
        btn_btn.titleLabel.font = SYS_Font(14);
        btn_btn.layer.borderColor = RGB(198, 164, 214).CGColor;
        btn_btn.layer.borderWidth = 1;
        [btn_btn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [scrolVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(w_two*3+92, scrolVV.height-60, 92, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = normalColors;
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [scrolVV addSubview:btn_btn2];
        
    }
    return self;
}

//MARK: 记录感受命名
- (void)addTwoNewTextfUIUIMethod:(int)typeML
{
    [self removeAllSubviews];
    
    UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
//    [deletbn addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deletbn];
    
    if (typeML == 1) {
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-140, _window_height/2-110, 280, 220);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 220)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        self.textFFF = [[UITextField alloc] initWithFrame:CGRectMake(29, 60, oneVV.width-58, 38)];
        self.textFFF.backgroundColor = UIColor.clearColor;
        self.textFFF.textColor = UIColor.whiteColor;
        self.textFFF.font = SYS_Font(14);
        NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"two_nams12") attributes:
            @{NSForegroundColorAttributeName:GrayText, NSFontAttributeName:self.textFFF.font}];
        self.textFFF.attributedPlaceholder = attrString3;
        self.textFFF.clipsToBounds = YES;
        self.textFFF.layer.borderColor = UIColor.whiteColor.CGColor;
        self.textFFF.layer.borderWidth = 1;
        self.textFFF.layer.cornerRadius = 4;
        self.textFFF.delegate = self;
//        self.textFFF.keyboardType = UIKeyboardTypeNumberPad;
        [oneVV addSubview:self.textFFF];
        
        UIView *lefVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 32)];
        lefVV.backgroundColor = UIColor.clearColor;
        self.textFFF.leftView = lefVV;
        self.textFFF.leftViewMode = UITextFieldViewModeAlways;
        
        CGFloat ww_hhw = (oneVV.width-220)/2.f;
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-86, 100, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
        [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(sureBtnMethodTwoNewDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-86, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeML == 2) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-163, _window_height/2-110, 326, 334);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326, 334)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *tit_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        tit_lab.text = eLocalizedString(@"two_nams13");
        tit_lab.numberOfLines = 0;
        [oneVV addSubview:tit_lab];
        [tit_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(20);
            make.right.equalTo(oneVV.mas_right).offset(-20);
            make.top.equalTo(oneVV.mas_top).offset(60);
            make.height.offset(75);
        }];
        
        UILabel *tex_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        if (self.bx_sstr) {
            tex_lab.text = self.bx_sstr;
        }else {
            tex_lab.text = eLocalizedString(@"two_nams14");
        }
        tex_lab.numberOfLines = 0;
        [oneVV addSubview:tex_lab];
        [tex_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(30);
            make.right.equalTo(oneVV.mas_right).offset(-30);
            make.top.equalTo(tit_lab.mas_bottom).offset(5);
            make.height.mas_greaterThanOrEqualTo(40);
        }];
        
        CGFloat ww_hhw = (oneVV.width-220)/2.f;
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-86, 100, 36);
        [btn_btn setTitle:eLocalizedString(@"two_nams15") forState:UIControlStateNormal];
        [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
        [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(sureBtnMethodTwoNewDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-86, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"two_nams16") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew2) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeML == 3) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-140, _window_height/2-110, 280, 220);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 220)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *tit_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        tit_lab.text = eLocalizedString(@"two_nams26");
        tit_lab.numberOfLines = 0;
        [oneVV addSubview:tit_lab];
        [tit_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(30);
            make.right.equalTo(oneVV.mas_right).offset(-30);
            make.top.equalTo(oneVV.mas_top).offset(60);
            make.height.offset(38);
        }];
        
        CGFloat ww_hhw = (oneVV.width-220)/2.f;
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-86, 100, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
        [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(sureBtnMethodTwoNewDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-86, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew2) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeML == 4) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-163, _window_height/2-110, 326, 334);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326, 334)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *tit_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        tit_lab.text = eLocalizedString(@"my_about4");
        tit_lab.numberOfLines = 0;
        [oneVV addSubview:tit_lab];
        [tit_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(20);
            make.right.equalTo(oneVV.mas_right).offset(-20);
            make.top.equalTo(oneVV.mas_top).offset(60);
            make.height.offset(75);
        }];
        
        UILabel *tex_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        tex_lab.text = eLocalizedString(@"two_nams31");
        tex_lab.numberOfLines = 0;
        [oneVV addSubview:tex_lab];
        [tex_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(30);
            make.right.equalTo(oneVV.mas_right).offset(-30);
            make.top.equalTo(tit_lab.mas_bottom).offset(5);
            make.height.mas_greaterThanOrEqualTo(40);
        }];
        
        CGFloat ww_hhw = (oneVV.width-220)/2.f;
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-86, 100, 36);
        [btn_btn setTitle:eLocalizedString(@"two_nams15") forState:UIControlStateNormal];
        [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
        [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(sureBtnMethodTwoNewDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-86, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"two_nams17") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        btn_btn2.titleLabel.numberOfLines = 2;
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew2) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeML == 5) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-163, _window_height/2-110, 326, 218);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326, 218)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *tex_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        tex_lab.text = eLocalizedString(@"thr_nams12");
        tex_lab.numberOfLines = 0;
        [oneVV addSubview:tex_lab];
        [tex_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(30);
            make.right.equalTo(oneVV.mas_right).offset(-30);
            make.top.equalTo(oneVV.mas_top).offset(44);
            make.height.offset(88);
        }];
        
        CGFloat ww_hhw = (oneVV.width-220)/2.f;
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-86, 100, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
        [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(sureBtnMethodTwoNewDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-86, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        btn_btn2.titleLabel.numberOfLines = 2;
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew2) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeML == 6) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-163, _window_height/2-110, 326, 218);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326, 218)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *tex_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        tex_lab.text = eLocalizedString(@"thr_nams13");
        tex_lab.numberOfLines = 0;
        [oneVV addSubview:tex_lab];
        [tex_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(30);
            make.right.equalTo(oneVV.mas_right).offset(-30);
            make.top.equalTo(oneVV.mas_top).offset(44);
            make.height.offset(88);
        }];
        
        CGFloat ww_hhw = (oneVV.width-220)/2.f;
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-86, 100, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
        [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(sureBtnMethodTwoNewDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-86, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        btn_btn2.titleLabel.numberOfLines = 2;
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew2) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeML == 7) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-163, _window_height/2-110, 326, 218);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326, 218)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *tex_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        tex_lab.text = eLocalizedString(@"two_tips123");
        tex_lab.numberOfLines = 0;
        [oneVV addSubview:tex_lab];
        [tex_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(30);
            make.right.equalTo(oneVV.mas_right).offset(-30);
            make.top.equalTo(oneVV.mas_top).offset(24);
            make.height.offset(88+30);
        }];
        
        CGFloat ww_hhw = (oneVV.width-100)/2.f;
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(ww_hhw, oneVV.height-86+10, 100, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
        btn_btn2.titleLabel.font = SYS_Font(14);
        btn_btn2.titleLabel.numberOfLines = 2;
        [btn_btn2 addTarget:self action:@selector(sureBtnMethodTwoNew2) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }
    
}

//记录感受命名
- (void)sureBtnMethodTwoNew
{
    if (self.textFFF.text.length>0) {
        
        if(self.block_) {
            self.block_(@[minStr(self.textFFF.text)]);
        }
        [self removeFromSuperview];
    }
}
- (void)sureBtnMethodTwoNew2
{
    if(self.block_) {
        self.block_(@[@""]);
    }
    [self removeFromSuperview];
}

- (void)sureBtnMethodTwoNewDelete
{
    if(self.block_) {
        self.block_(@[]);
    }
    [self removeFromSuperview];
}



- (void)addUIUIUTwo
{
    [self removeAllSubviews];
    
    self.oneStr1 = @"";
    self.oneStr2 = @"";
    self.oneStr3 = @"true";
    self.oneStr4 = 0;
    self.ruu_str = @"";
    
    UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
    [deletbn addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deletbn];
    
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-260, 330, 420);
    oneVV.backgroundColor = UIColor.clearColor;
    [self addSubview:oneVV];
    
    UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 420)];
    bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
    [oneVV addSubview:bacImg];
    
    UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(35, 39, oneVV.width-70, oneVV.height-78)];
    scrolVV.showsVerticalScrollIndicator = NO;
    scrolVV.showsHorizontalScrollIndicator = NO;
    scrolVV.backgroundColor = UIColor.clearColor;
    scrolVV.bounces = NO;
    [oneVV addSubview:scrolVV];
    
    UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    titLlab.frame = CGRectMake(0, 0, scrolVV.width, 44);
    titLlab.text = eLocalizedString(@"my_settings");
    [scrolVV addSubview:titLlab];
    
    NSArray *listAr = @[@"role_setting1", @"role_setting2"];
    NSArray *listAr2 = @[@"64", @"162"];
    
    for (int i=0; i<listAr.count; i++) {
        
        UILabel *allLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
        allLab.frame = CGRectMake(0, [listAr2[i] intValue], scrolVV.width, 22);
        allLab.text = eLocalizedString(listAr[i]);
        [scrolVV addSubview:allLab];
        
        switch (i) {
            case 0:
            {
                self.addreslab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                self.addreslab.frame = CGRectMake(0, CGRectGetMaxY(allLab.frame), scrolVV.width, 50);
                [scrolVV addSubview:self.addreslab];
            }
                break;
            case 1:
            {
                self.textFFF = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(allLab.frame)+12, scrolVV.width-46, 32)];
                self.textFFF.backgroundColor = UIColor.clearColor;
                self.textFFF.textColor = UIColor.whiteColor;
                self.textFFF.font = SYS_Font(14);
                NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"role_setting5") attributes:
                    @{NSForegroundColorAttributeName:RGB(198, 164, 214), NSFontAttributeName:self.textFFF.font}];
                self.textFFF.attributedPlaceholder = attrString3;
                self.textFFF.clipsToBounds = YES;
                self.textFFF.layer.borderColor = RGB(198, 164, 214).CGColor;
                self.textFFF.layer.borderWidth = 1;
                self.textFFF.layer.cornerRadius = 4;
                self.textFFF.delegate = self;
                self.textFFF.keyboardType = UIKeyboardTypeNumberPad;
                [scrolVV addSubview:self.textFFF];
                
                UIView *lefVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 32)];
                lefVV.backgroundColor = UIColor.clearColor;
                self.textFFF.leftView = lefVV;
                self.textFFF.leftViewMode = UITextFieldViewModeAlways;
                
                UILabel *fff = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
                fff.frame = CGRectMake(self.textFFF.width, self.textFFF.y, 46, 32);
                fff.text = @"KM";
                [scrolVV addSubview:fff];
            }
                break;
                
            default:
                break;
        }
    }

    CGFloat w_two = (scrolVV.width-92*2)/4;
    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
    btn_btn.frame = CGRectMake(w_two, scrolVV.height-60, 92, 36);
    [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn_btn.backgroundColor = UIColor.clearColor;
    btn_btn.layer.cornerRadius = 6;
    btn_btn.titleLabel.font = SYS_Font(14);
    btn_btn.layer.borderColor = RGB(198, 164, 214).CGColor;
    btn_btn.layer.borderWidth = 1;
    [btn_btn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [scrolVV addSubview:btn_btn];
    
    UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
    btn_btn2.frame = CGRectMake(w_two*3+92, scrolVV.height-60, 92, 36);
    [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
    [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn_btn2.backgroundColor = normalColors;
    btn_btn2.layer.cornerRadius = 6;
    btn_btn2.titleLabel.font = SYS_Font(14);
    [btn_btn2 addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [scrolVV addSubview:btn_btn2];
    
    
    self.oneStr1 = self.arrFind[0];
    self.oneStr2 = self.arrFind[1];
    self.oneStr3 = self.arrFind[2];
    self.oneStr4 = [self.arrFind[3] floatValue];
    
    self.addreslab.text = self.oneStr1;
    self.textFFF.text = self.oneStr2;
    
}

- (void)addUIUIU
{
    self.oneStr1 = self.arrFind[0];
    self.oneStr2 = self.arrFind[1];
    self.oneStr3 = self.arrFind[2];
    self.oneStr4 = [self.arrFind[3] floatValue];
    
    self.addreslab.text = self.oneStr1;
    self.textFFF.text = self.oneStr2;
    
    for (int i=0; i<2; i++) {
        UIButton *btnAll = [self viewWithTag:8200+i];
        if(i==0) {
            
            if([self.oneStr3 isEqualToString:@"true"]) {
                
                btnAll.selected = YES;
            }else {
                btnAll.selected = NO;
            }
        }else {
            if([self.oneStr3 isEqualToString:@"false"]) {
                
                btnAll.selected = YES;
            }else {
                btnAll.selected = NO;
            }
        }
    }
    self.twoScrollV.value = self.oneStr4;
}

- (void)retoreBtnMethod
{
    [self removeFromSuperview];
}

- (void)sureBtnMethod
{
    if([self.readName isEqualToString:kCharactName2] || [self.readName isEqualToString:kCharactName12] || [self.readName isEqualToString:kCharactName15]) {
        self.oneStr2 = self.textFFF.text;
        if(self.block_) {
            self.block_(@[self.oneStr1, self.oneStr2, @"false", @"0"]);
        }
    }else {
        self.oneStr2 = self.textFFF.text;
        self.oneStr4 = self.twoScrollV.value;
        if(self.block_) {
            self.block_(@[self.oneStr1, self.oneStr2, self.oneStr3, [NSString stringWithFormat:@"%.2f", self.oneStr4]]);
        }
    }
    [self removeFromSuperview];
}

- (void)btnMethodAllsTwo:(UIButton *)btn
{
    for (int i=0; i<2; i++) {
        UIButton *btnAll = [self viewWithTag:8200+i];
        if(btnAll == btn) {
            if(i==0) {
                self.oneStr3 = @"true";
            }else {
                self.oneStr3 = @"false";
            }
            btnAll.selected = YES;
        }else {
            btnAll.selected = NO;
        }
    }
}

- (void)sliderTouchEnded:(float)value
{
    self.oneStr4 = value;
}

- (void)deleBtnMehtod
{
    if(self.twoBlock_) {
        self.twoBlock_(@[]);
    }
    [self removeFromSuperview];
}

- (void)addUnlockingMethod:(BOOL)boo
{
    [self removeAllSubviews];
    
    UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
    [deletbn addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deletbn];
    
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-200, 330, 400);
    oneVV.backgroundColor = UIColor.clearColor;
    [self addSubview:oneVV];
    
    UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 350)];
    bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
    [oneVV addSubview:bacImg];
    
    UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(35, 39, oneVV.width-70, oneVV.height-78)];
    scrolVV.showsVerticalScrollIndicator = NO;
    scrolVV.showsHorizontalScrollIndicator = NO;
    scrolVV.backgroundColor = UIColor.clearColor;
    scrolVV.bounces = NO;
    [oneVV addSubview:scrolVV];
    
    //MARK: boo 是否处于开锁惩罚中
    if(!boo) {
        oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-235, 330, 470);
        bacImg.frame = CGRectMake(0, 0, 330, 420);
        scrolVV.frame = CGRectMake(35, 39, oneVV.width-70, oneVV.height-78-50);
        
        CGFloat w_two = (oneVV.width-92*2-20)/2;
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(w_two, scrolVV.height+10, 92, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn.backgroundColor = UIColor.clearColor;
        btn_btn.layer.cornerRadius = 6;
        btn_btn.titleLabel.font = SYS_Font(14);
        btn_btn.layer.borderColor = RGB(198, 164, 214).CGColor;
        btn_btn.layer.borderWidth = 1;
        [btn_btn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(w_two+112, scrolVV.height+10, 92, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = normalColors;
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureTwoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else {
        UIButton *deleBBB = [HistoryRecordModel createImgBtn];
        deleBBB.frame = CGRectMake(oneVV.width-26-36, 38, 36, 36);
        [deleBBB setImage:[UIImage imageNamed:@"delete_img1"] forState:UIControlStateNormal];
        [deleBBB addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:deleBBB];
    }
    
    scrolVV.contentSize = CGSizeMake(oneVV.width-70, (self.roleOneModel.forcedUnlockPenaltyList.count+2)*24+80);
    
    for (int i=0; i<self.roleOneModel.forcedUnlockPenaltyList.count+2; i++) {
        
        if(i<self.roleOneModel.forcedUnlockPenaltyList.count) {
            NSDictionary *dimmsub = self.roleOneModel.forcedUnlockPenaltyList[i];
            UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
            subLLLab.frame = CGRectMake(0, 90+i*24, scrolVV.width, 24);
            subLLLab.text = [NSString stringWithFormat:@"%@%@%@, %@%@%@", eLocalizedString(@"role_setting54"), dimmsub[@"times"], eLocalizedString(@"me_allNames21"), eLocalizedString(@"role_setting55"), dimmsub[@"penaltyDays"], eLocalizedString(@"role_name14")];
            [scrolVV addSubview:subLLLab];
        }else {
            if(i == self.roleOneModel.forcedUnlockPenaltyList.count) {
                UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                subLLLab.frame = CGRectMake(0, 90+i*24, scrolVV.width, 24);
                subLLLab.text = eLocalizedString(@"role_setting52");
                [scrolVV addSubview:subLLLab];
            }else {
                UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                subLLLab.frame = CGRectMake(0, 90+i*24, scrolVV.width, 24);
                subLLLab.text = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"role_setting53"), self.roleOneModel.monthlyForcedUnlockTimes, eLocalizedString(@"me_allNames21")];
                [scrolVV addSubview:subLLLab];
            }
        }
    }
    
    UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    titLlab.frame = CGRectMake(0, 0, scrolVV.width, 32);
    titLlab.text = eLocalizedString(@"my_about4");
    [scrolVV addSubview:titLlab];
    
    if(!boo) {
        
        UILabel *cccccLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        cccccLlab.frame = CGRectMake(0, 40, scrolVV.width, 42);
        cccccLlab.numberOfLines = 2;
        cccccLlab.text = eLocalizedString(@"my_about4_lock");
        [scrolVV addSubview:cccccLlab];
        
    }else {
        UILabel *cccccLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        cccccLlab.numberOfLines = 2;
        cccccLlab.frame = CGRectMake(0, 40, scrolVV.width, 42);
        cccccLlab.text = [NSString stringWithFormat:eLocalizedString(@"my_about4_lock2"), self.roleOneModel.penaltyReleaseTime];
        [scrolVV addSubview:cccccLlab];
    }
}

- (void)addUIUIUIUMethodType:(NSInteger)typeMM
{
    if((typeMM == 1) || (typeMM == 2)) {
        [self removeAllSubviews];
        
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deletbn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-175, 330, 350);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 350)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(35, 39, oneVV.width-70, oneVV.height-78)];
        scrolVV.showsVerticalScrollIndicator = NO;
        scrolVV.showsHorizontalScrollIndicator = NO;
        scrolVV.backgroundColor = UIColor.clearColor;
        scrolVV.bounces = NO;
        [oneVV addSubview:scrolVV];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake((oneVV.width-178)/2, scrolVV.height+10, 178, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = normalColors;
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureTwoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
        
        
        UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab.frame = CGRectMake(0, 0, scrolVV.width, 32);
        if(typeMM == 2) {
            titLlab.text = eLocalizedString(@"role_setting21");
        }else {
            titLlab.text = eLocalizedString(@"role_setting16");
        }
        [scrolVV addSubview:titLlab];
        
        if(typeMM == 2) {
            scrolVV.contentSize = CGSizeMake(oneVV.width-70, 40+(self.roleOneModel.deleteLockRecordPenaltyList.count+2)*24+20);
            
            for (int i=0; i<self.roleOneModel.deleteLockRecordPenaltyList.count+2; i++) {
                
                if(i<self.roleOneModel.deleteLockRecordPenaltyList.count) {
                    NSDictionary *dimmsub = self.roleOneModel.deleteLockRecordPenaltyList[i];
                    UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                    subLLLab.frame = CGRectMake(0, 50+i*24, scrolVV.width, 24);
                    subLLLab.text = [NSString stringWithFormat:@"%@%@%@, %@%@%@", eLocalizedString(@"role_setting54"), dimmsub[@"times"], eLocalizedString(@"me_allNames21"), eLocalizedString(@"role_setting55"), dimmsub[@"penaltyDays"], eLocalizedString(@"role_name14")];
                    [scrolVV addSubview:subLLLab];
                }else {
                    if(i == self.roleOneModel.deleteLockRecordPenaltyList.count) {
                        UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                        subLLLab.frame = CGRectMake(0, 50+i*24, scrolVV.width, 24);
                        subLLLab.text = eLocalizedString(@"role_setting52");
                        [scrolVV addSubview:subLLLab];
                    }else {
                        UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                        subLLLab.frame = CGRectMake(0, 50+i*24, scrolVV.width, 24);
                        subLLLab.text = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"role_setting53"), self.roleOneModel.monthlyDeleteLockRecordTimes, eLocalizedString(@"me_allNames21")];
                        [scrolVV addSubview:subLLLab];
                    }
                }
            }
        }else {
            scrolVV.contentSize = CGSizeMake(oneVV.width-70, 40+(self.roleOneModel.forcedUnbindPenaltyList.count+2)*24+20);
            
            for (int i=0; i<self.roleOneModel.forcedUnbindPenaltyList.count+2; i++) {
                
                if(i<self.roleOneModel.forcedUnbindPenaltyList.count) {
                    NSDictionary *dimmsub = self.roleOneModel.forcedUnbindPenaltyList[i];
                    UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                    subLLLab.frame = CGRectMake(0, 50+i*24, scrolVV.width, 24);
                    subLLLab.text = [NSString stringWithFormat:@"%@%@%@, %@%@%@", eLocalizedString(@"role_setting54"), dimmsub[@"times"], eLocalizedString(@"me_allNames21"), eLocalizedString(@"role_setting55"), dimmsub[@"penaltyDays"], eLocalizedString(@"role_name14")];
                    [scrolVV addSubview:subLLLab];
                }else {
                    if(i == self.roleOneModel.forcedUnbindPenaltyList.count) {
                        UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                        subLLLab.frame = CGRectMake(0, 50+i*24, scrolVV.width, 24);
                        subLLLab.text = eLocalizedString(@"role_setting52");
                        [scrolVV addSubview:subLLLab];
                    }else {
                        UILabel *subLLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                        subLLLab.frame = CGRectMake(0, 50+i*24, scrolVV.width, 24);
                        subLLLab.text = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"role_setting53"), self.roleOneModel.monthlyForcedUnbindTimes, eLocalizedString(@"me_allNames21")];
                        [scrolVV addSubview:subLLLab];
                    }
                }
            }
        }
        UIButton *deleBBB = [HistoryRecordModel createImgBtn];
        deleBBB.frame = CGRectMake(oneVV.width-26-36, 30, 36, 36);
        [deleBBB setImage:[UIImage imageNamed:@"delete_img1"] forState:UIControlStateNormal];
        [deleBBB addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:deleBBB];
        
        
        
    }else if (typeMM == 3) {
        [self removeAllSubviews];
        
        self.ruu_str = @"1";
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deletbn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-140, _window_height/2-109, 280, 218);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 218)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab.frame = CGRectMake(0, 24, oneVV.width, 34);
        titLlab.text = eLocalizedString(@"role_setting25");
        [oneVV addSubview:titLlab];
        
        UILabel *titLlab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab2.frame = CGRectMake(0, CGRectGetMaxY(titLlab.frame), oneVV.width, 26);
        titLlab2.text = eLocalizedString(@"role_setting25_25");
        [oneVV addSubview:titLlab2];
        
        NSArray *imgsAr = @[@"role_unlinkImg1", @"role_unlinkImg2"];
        NSArray *namsAr = @[@"my_about6_6", @"my_about7_7"];
        for (int i=0; i<imgsAr.count; i++) {
            
            UIButton *twoBBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneVV.width/2-88+i*108, CGRectGetMaxY(titLlab2.frame)+10, 68, 42)];
            [twoBBtn setBackgroundImage:[UIImage imageNamed:@"role_unlinkImg2"] forState:UIControlStateNormal];
            [twoBBtn setBackgroundImage:[UIImage imageNamed:@"role_unlinkImg1"] forState:UIControlStateSelected];
            [twoBBtn setTitle:eLocalizedString(namsAr[i]) forState:UIControlStateNormal];
            [twoBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            twoBBtn.titleLabel.font = SYS_Font(14);
            twoBBtn.tag = 4300+i;
            [twoBBtn addTarget:self action:@selector(twoRuleMMMethod:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:twoBBtn];
            if(i==0) {
                twoBBtn.selected = YES;
            }
        }
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake((oneVV.width-178)/2, CGRectGetMaxY(titLlab2.frame)+68, 178, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = RGB(117, 34, 169);
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureTwoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeMM == 4) {
        [self removeAllSubviews];
        
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
//        [deletbn addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-200, 330, 400);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 400)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab.frame = CGRectMake(0, 40, oneVV.width, 32);
        titLlab.text = eLocalizedString(@"role_setting26");
        [oneVV addSubview:titLlab];
        
        UILabel *titLlab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        titLlab2.frame = CGRectMake(37, CGRectGetMaxY(titLlab.frame), oneVV.width-74, 30);
        titLlab2.text = eLocalizedString(@"role_setting37");
        [oneVV addSubview:titLlab2];
        
        NSArray *namsAr = @[@"7", @"30", eLocalizedString(@"role_setting38")];
        for (int i=0; i<namsAr.count; i++) {
            
            UIButton *twoBBtn = [[UIButton alloc] initWithFrame:CGRectMake(37+i*88, CGRectGetMaxY(titLlab2.frame)+7, 76, 30)];
            [twoBBtn setTitle:namsAr[i] forState:UIControlStateNormal];
            [twoBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            twoBBtn.titleLabel.font = SYS_Font(14);
            twoBBtn.layer.cornerRadius = 4;
            twoBBtn.tag = 880+i;
            twoBBtn.layer.borderColor = UIColor.whiteColor.CGColor;
            twoBBtn.layer.borderWidth = 1;
            [twoBBtn addTarget:self action:@selector(twoBtnMethodUIUI:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:twoBBtn];
            if(i==0) {
                twoBBtn.backgroundColor = normalColors;
                twoBBtn.layer.borderColor = normalColors.CGColor;
            }else {
                twoBBtn.layer.borderColor = UIColor.whiteColor.CGColor;
                twoBBtn.backgroundColor = UIColor.clearColor;
            }
        }
        self.day_str = @"7";
        
        self.customLab = [[UIButton alloc] initWithFrame:CGRectMake(37, CGRectGetMaxY(titLlab2.frame)+57, oneVV.width-74, 32)];
        [self.customLab setBackgroundImage:[UIImage imageNamed:@"roleCustomImg1"] forState:UIControlStateNormal];
        [self.customLab setTitle:eLocalizedString(@"role_setting39") forState:UIControlStateNormal];
        [self.customLab setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.customLab.titleLabel.font = SYS_Font(14);
        [self.customLab addTarget:self action:@selector(customeBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:self.customLab];
        
        UILabel *titLlab3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        titLlab3.frame = CGRectMake(37, CGRectGetMaxY(self.customLab.frame)+10, oneVV.width-74, 36);
        titLlab3.text = eLocalizedString(@"role_setting40");
        [oneVV addSubview:titLlab3];
        
        self.avatorBtn = [[UIButton alloc] initWithFrame:CGRectMake(145, CGRectGetMaxY(titLlab3.frame)+12, 40, 40)];
        [self.avatorBtn setBackgroundImage:[UIImage imageNamed:@"roleCustomImg2"] forState:UIControlStateNormal];
        [self.avatorBtn addTarget:self action:@selector(avatorBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:self.avatorBtn];
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(63, CGRectGetMaxY(self.avatorBtn.frame)+28, 92, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn.backgroundColor = UIColor.clearColor;
        btn_btn.layer.cornerRadius = 6;
        btn_btn.layer.borderColor = UIColor.whiteColor.CGColor;
        btn_btn.layer.borderWidth = 1;
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(cacelTwoBtnMethodDelete) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(oneVV.width/2+10, btn_btn.y, 92, 36);
        [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = RGB(117, 34, 169);
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureTwoBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeMM == 5) {
        
        [self removeAllSubviews];
        
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deletbn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-140, _window_height/2-200, 280, 285);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 285)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab.frame = CGRectMake(0, 30, oneVV.width, 38);
        titLlab.text = eLocalizedString(@"role_setting17");
        [oneVV addSubview:titLlab];
        
        UILabel *titLlab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        titLlab2.text = eLocalizedString(@"role_setting41");
        titLlab2.numberOfLines = 0;
        [oneVV addSubview:titLlab2];
        [titLlab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(37);
            make.top.equalTo(titLlab.mas_bottom).offset(10);
            make.right.equalTo(oneVV.mas_right).offset(-37);
            
        }];
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake((oneVV.width-92*2-20)/2, oneVV.height-66, 92, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn.backgroundColor = UIColor.clearColor;
        btn_btn.layer.cornerRadius = 6;
        btn_btn.layer.borderColor = UIColor.whiteColor.CGColor;
        btn_btn.layer.borderWidth = 1;
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(oneVV.width/2+10, btn_btn.y, 92, 36);
        [btn_btn2 setTitle:eLocalizedString(@"role_setting42") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = RGB(117, 34, 169);
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureTwoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }else if (typeMM == 6) {
        
        [self removeAllSubviews];
        
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deletbn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-140, _window_height/2-150, 280, 285);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 285)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UILabel *titLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLlab.frame = CGRectMake(0, 30, oneVV.width, 38);
        titLlab.text = eLocalizedString(@"role_setting17");
        titLlab.numberOfLines = 0;
        [oneVV addSubview:titLlab];
        
        UILabel *titLlab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        titLlab2.text = eLocalizedString(@"role_setting41_41");
        titLlab2.numberOfLines = 0;
        [oneVV addSubview:titLlab2];
        [titLlab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(37);
            make.top.equalTo(titLlab.mas_bottom).offset(10);
            make.right.equalTo(oneVV.mas_right).offset(-37);
            
        }];
        
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake((oneVV.width-92*2-20)/2, oneVV.height-66, 92, 36);
        [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn.backgroundColor = UIColor.clearColor;
        btn_btn.layer.cornerRadius = 6;
        btn_btn.layer.borderColor = UIColor.whiteColor.CGColor;
        btn_btn.layer.borderWidth = 1;
        btn_btn.titleLabel.font = SYS_Font(14);
        [btn_btn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn];
        
        UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
        btn_btn2.frame = CGRectMake(oneVV.width/2+10, btn_btn.y, 92, 36);
        [btn_btn2 setTitle:eLocalizedString(@"role_setting42") forState:UIControlStateNormal];
        [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn_btn2.backgroundColor = RGB(117, 34, 169);
        btn_btn2.layer.cornerRadius = 6;
        btn_btn2.titleLabel.font = SYS_Font(14);
        [btn_btn2 addTarget:self action:@selector(sureTwoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:btn_btn2];
    }
    
}

- (void)avatorBtnMethod
{
    if(self.twoBlock_) {
        self.twoBlock_(@[@"", @"", @""]);
    }
}

- (void)customeBtnMethod
{
    if(self.twoBlock_) {
        self.twoBlock_(@[@"", @""]);
    }
}

- (void)customeUIUIUIU:(NSString *)strM
{
    self.day_str = strM;
    for (int i=0; i<3; i++) {
        UIButton *twoBBtn = [self viewWithTag:880+i];
        
        twoBBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        twoBBtn.backgroundColor = UIColor.clearColor;
    }
}

- (void)twoBtnMethodUIUI:(UIButton *)btn
{
    [self.customLab setTitle:eLocalizedString(@"role_setting39") forState:UIControlStateNormal];
    
    for (int i=0; i<3; i++) {
        UIButton *twoBBtn = [self viewWithTag:880+i];
        if(btn == twoBBtn) {
            twoBBtn.backgroundColor = normalColors;
            twoBBtn.layer.borderColor = normalColors.CGColor;
            if(i==0) {
                self.day_str = @"7";
            }else if (i==1) {
                self.day_str = @"30";
            }else {
                self.day_str = @"-1";
            }
        }else {
            twoBBtn.layer.borderColor = UIColor.whiteColor.CGColor;
            twoBBtn.backgroundColor = UIColor.clearColor;
        }
    }
}

- (void)twoRuleMMMethod:(UIButton *)btn
{
    UIButton *oneBBB = [self viewWithTag:4300];
    UIButton *oneBBB2 = [self viewWithTag:4301];
    if(btn.tag == 4300) {
        oneBBB.selected = YES;
        oneBBB2.selected = NO;
        self.ruu_str = @"1";
    }else {
        oneBBB.selected = NO;
        oneBBB2.selected = YES;
        self.ruu_str = @"2";
    }
}

- (void)sureTwoBtnMethod
{
    if(self.block_) {
        self.block_(@[self.ruu_str]);
    }
    [self removeFromSuperview];
}

- (void)sureTwoBtnMethodTwo
{
    if(self.twoBlock_) {
        self.twoBlock_(@[self.day_str]);
    }
}

- (void)cacelTwoBtnMethodDelete
{
    if(self.twoBlock_) {
        self.twoBlock_(@[]);
    }
}

@end
