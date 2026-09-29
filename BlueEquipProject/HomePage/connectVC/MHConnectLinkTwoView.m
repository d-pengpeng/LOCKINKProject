//
//  MHConnectLinkTwoView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/4.
//

#import "MHConnectLinkTwoView.h"

@interface MHConnectLinkTwoView ()

@property (nonatomic, strong) NSMutableArray *oneMut;
@property (nonatomic, strong) NSMutableArray *twoMut;
@property (nonatomic, strong) NSMutableArray *thrMut;
@property (nonatomic, strong) NSMutableArray *fouMut;
@property (nonatomic, strong) UIView *tankuVV;

@property (nonatomic, assign) NSInteger numTyp;
@end
@implementation MHConnectLinkTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIButton *deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [deleBtn addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn];
        
        UIButton *deleBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-38-TARBARHEIGHT, self.width, 38+TARBARHEIGHT)];
        deleBtn2.backgroundColor = UIColor.blackColor;
        [deleBtn2 addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn2];
    }
    return self;
}

- (void)addConnectMethodUIUI:(NSInteger)typeM
{
    self.numTyp = typeM;
    
    self.oneMut = [NSMutableArray array];
    self.twoMut = [NSMutableArray array];
    self.thrMut = [NSMutableArray array];
    self.fouMut = [NSMutableArray array];

    
    CGFloat al_yyy = _window_height-(38+TARBARHEIGHT+TIMESTATUSHEIGHT+100);
    
    UIScrollView *contVV = [[UIScrollView alloc] init];
    contVV.bounces = NO;
    if(al_yyy>=550) {
        contVV.frame = CGRectMake(0, _window_height-38-TARBARHEIGHT-550, self.width, 550);
    }else {
        contVV.frame = CGRectMake(0, TIMESTATUSHEIGHT+100, self.width, al_yyy);
    }
    contVV.backgroundColor = UIColor.blackColor;
    contVV.showsHorizontalScrollIndicator = NO;
    contVV.showsVerticalScrollIndicator = NO;
    contVV.clipsToBounds = YES;
    [self addSubview:contVV];
    
    if(typeM == 1) {
        
        NSArray *oneAr = @[eLocalizedString(@"center_all12"), eLocalizedString(@"center_all13"), eLocalizedString(@"center_all14")];
        NSArray *oneAr2 = @[eLocalizedString(@"center_all12"), @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
        NSArray *oneAr3 = @[eLocalizedString(@"center_all12"), @"BIS", @"HETERO", @"GAY", @"LES"];
        NSArray *oneAr4 = @[eLocalizedString(@"center_all12"), @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
        
        NSArray *al_arNN = @[[NSString stringWithFormat:@"#%@", eLocalizedString(@"tabbar_tit1")], [NSString stringWithFormat:@"#%@", eLocalizedString(@"center_all18")], eLocalizedString(@"center_all19"), eLocalizedString(@"center_all20")];
        
        CGFloat hh_h = 142;
        
        contVV.contentSize = CGSizeMake(_window_width, 20+96+hh_h*3+62);
        
        for (int i=0; i<al_arNN.count; i++) {
            
            UILabel *fouLMM = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:16 textAlignment:NSTextAlignmentLeft];
            if(i==0) {
                fouLMM.frame = CGRectMake(16, 20+96*i, self.width-32, 24);
            }else {
                fouLMM.frame = CGRectMake(16, 20+96+hh_h*(i-1), self.width-32, 24);
            }
            fouLMM.text = al_arNN[i];
            [contVV addSubview:fouLMM];
            
            UIView *placVV = [[UIView alloc] init];
            placVV.backgroundColor = UIColor.clearColor;
            [contVV addSubview:placVV];
            
            switch (i) {
                case 0:
                {
                    placVV.frame = CGRectMake(0, 20+24, self.width, 72);
                    CGFloat w_ww = (self.width-64)/3;
                    for (int j=0; j<oneAr.count; j++) {
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+16)*j, 10, w_ww, 36);
                        [btn_btn setTitle:oneAr[j] forState:UIControlStateNormal];
                        [btn_btn setTitle:oneAr[j] forState:UIControlStateSelected];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.layer.cornerRadius = 6;
//                        btn_btn.layer.borderColor = normalColors.CGColor;
//                        btn_btn.layer.borderWidth = 1;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAlls:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.oneMut addObject:btn_btn];
                        if(self.has_str1.length > 0) {
                            if([self.has_str1 intValue] == 1) {
                                if(j==1) {
                                    btn_btn.selected = YES;
                                    btn_btn.backgroundColor = RGB(89, 26, 115);
                                }
                            }else {
                                if(j==2) {
                                    btn_btn.selected = YES;
                                    btn_btn.backgroundColor = RGB(89, 26, 115);
                                }
                            }
                        }else {
                            if(j==0) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }
                    }
                }
                    break;
                case 1:
                {
                    placVV.frame = CGRectMake(0, 20+96+hh_h*(i-1)+24, self.width, 118);
                    CGFloat w_ww = (self.width-62)/4;
                    for (int j=0; j<oneAr2.count; j++) {
                        
                        int x_w = j%4;
                        int y_w = j/4;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+10)*x_w, 10+y_w*46, w_ww, 36);
                        [btn_btn setTitle:oneAr2[j] forState:UIControlStateNormal];
                        [btn_btn setTitle:oneAr2[j] forState:UIControlStateSelected];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.layer.cornerRadius = 18;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAllsTwo:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.twoMut addObject:btn_btn];
                        if(self.has_str2.length > 0) {
                            
                            if([self.has_str2 isEqualToString:oneAr2[j]]) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }else {
                            if(j==0) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }
                    }
                }
                    break;
                case 2:
                {
                    placVV.frame = CGRectMake(0, 20+96+hh_h*(i-1)+24, self.width, 118);
                    fouLMM.textColor = UIColor.whiteColor;
                    CGFloat w_ww = (self.width-62)/4;
                    for (int j=0; j<oneAr3.count; j++) {
                        
                        int x_w = j%4;
                        int y_w = j/4;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+10)*x_w, 10+y_w*46, w_ww, 36);
                        [btn_btn setTitle:oneAr3[j] forState:UIControlStateNormal];
                        [btn_btn setTitle:oneAr3[j] forState:UIControlStateSelected];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.layer.cornerRadius = 18;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAllsThr:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.thrMut addObject:btn_btn];
                        if(self.has_str3.length > 0) {
                            
                            if([self.has_str3 isEqualToString:oneAr3[j]]) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }else {
                            if(j==0) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }
                    }
                }
                    break;
                case 3:
                {
                    placVV.frame = CGRectMake(0, 20+96+hh_h*(i-1)+24, self.width, 118);
                    fouLMM.textColor = UIColor.whiteColor;
                    CGFloat w_ww = (self.width-62)/4;
                    for (int j=0; j<oneAr4.count; j++) {
                        
                        int x_w = j%4;
                        int y_w = j/4;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+10)*x_w, 10+y_w*46, w_ww, 36);
                        [btn_btn setTitle:oneAr4[j] forState:UIControlStateNormal];
                        [btn_btn setTitle:oneAr4[j] forState:UIControlStateSelected];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.layer.cornerRadius = 18;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAllsFou:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.fouMut addObject:btn_btn];
                        
                        if(self.has_str4.length > 0) {
                            NSArray *ar_lis = [self.has_str4 componentsSeparatedByString:@","];
                            if([ar_lis containsObject:oneAr4[j]]) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }else {
                                btn_btn.selected = NO;
                                btn_btn.backgroundColor = RGB(43, 12, 56);
                            }
                        }else {
                            if(j==0) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        UIButton *sureBBB = [HistoryRecordModel createImgBtn];
        sureBBB.frame = CGRectMake((self.width-124)/2, 20+96+hh_h*3+10, 124, 42);
        [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [sureBBB setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sureBBB.titleLabel.font = SYS_Font(14);
        [sureBBB addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [contVV addSubview:sureBBB];
        
    }else {
        
        self.has_str1 = @"true";
        self.has_str2 = @"";
        self.has_str3 = @"";
        self.has_str4 = @"";
        
        if(al_yyy>=480) {
            contVV.frame = CGRectMake(0, _window_height-38-TARBARHEIGHT-480, self.width, 480);
        }else {
            contVV.frame = CGRectMake(0, TIMESTATUSHEIGHT+100, self.width, al_yyy);
        }
        contVV.contentSize = CGSizeMake(_window_width, 480);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNewAction)];
        [contVV addGestureRecognizer:tapGesture];
        
        NSArray *oneAr = @[eLocalizedString(@"center_all13"), eLocalizedString(@"center_all14")];
        NSArray *oneAr3 = @[eLocalizedString(@"center_all12"), @"BIS", @"HETERO", @"GAY", @"LES"];
        NSArray *oneAr4 = @[eLocalizedString(@"center_all12"), @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
        
        
        NSArray *al_arNN = @[[NSString stringWithFormat:@"#%@", eLocalizedString(@"center_all9")], [NSString stringWithFormat:@"#%@", eLocalizedString(@"center_all9_9")], eLocalizedString(@"center_all20")];
        
        for (int i=0; i<al_arNN.count; i++) {
            
            UILabel *fouLMM = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:16 textAlignment:NSTextAlignmentLeft];
            if(i==0) {
                fouLMM.frame = CGRectMake(16, 20, self.width-32, 24);
            }else if (i==1) {
                fouLMM.frame = CGRectMake(16, 20+96, self.width-32, 24);
            }else {
                fouLMM.frame = CGRectMake(16, 20+96+132, self.width-32, 24);
            }
            fouLMM.text = al_arNN[i];
            [contVV addSubview:fouLMM];
            
            
            UIView *placVV = [[UIView alloc] init];
            placVV.backgroundColor = UIColor.clearColor;
            [contVV addSubview:placVV];
            
            switch (i) {
                case 0:
                {
                    placVV.frame = CGRectMake(0, 44, self.width, 72);
                    CGFloat w_ww = (self.width-64)/2;
                    for (int j=0; j<oneAr.count; j++) {
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+32)*j, 10, w_ww, 36);
                        [btn_btn setTitle:oneAr[j] forState:UIControlStateNormal];
                        [btn_btn setTitle:oneAr[j] forState:UIControlStateSelected];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.layer.cornerRadius = 6;
//                        btn_btn.layer.borderColor = normalColors.CGColor;
//                        btn_btn.layer.borderWidth = 1;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAlls:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.oneMut addObject:btn_btn];
                        if(j==0) {
                            btn_btn.selected = YES;
                            btn_btn.backgroundColor = RGB(89, 26, 115);
                        }
                    }
                }
                    break;
                case 1:
                {
                    CGFloat w_ww = (self.width-62)/2;
                    placVV.frame = CGRectMake(0, 20+96+24, self.width, 108);
                    
                    NSArray *ar_ml = @[eLocalizedString(@"center_all18"), eLocalizedString(@"center_all19")];
                    for (int j=0; j<2; j++) {
                        
                        UILabel *sub_llab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
                        sub_llab.frame = CGRectMake(j*self.width/2, 0, self.width/2, 36);
                        sub_llab.text = ar_ml[j];
                        [placVV addSubview:sub_llab];
                        
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+32)*j, 40, w_ww, 36);
                        [btn_btn setTitle:oneAr3[0] forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        btn_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        btn_btn.backgroundColor = RGB(89, 26, 115);
                        btn_btn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 10);
                        btn_btn.layer.cornerRadius = 6;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAllsThrPPP:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.thrMut addObject:btn_btn];
                        
                        UIImageView *nexV = [HistoryRecordModel createImgImgView];
                        nexV.frame = CGRectMake(w_ww-28, 9, 18, 18);
                        nexV.image = [UIImage imageNamed:@"dissm_nexImg4"];
                        [btn_btn addSubview:nexV];
                    }
                }
                    break;
                case 2:
                {
                    placVV.frame = CGRectMake(0, 20+96+132+24, self.width, 118);
                    fouLMM.textColor = UIColor.whiteColor;
                    CGFloat w_ww = (self.width-62)/4;
                    for (int j=0; j<oneAr4.count; j++) {
                        
                        int x_w = j%4;
                        int y_w = j/4;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(16+(w_ww+10)*x_w, 10+y_w*46, w_ww, 36);
                        [btn_btn setTitle:oneAr4[j] forState:UIControlStateNormal];
                        [btn_btn setTitle:oneAr4[j] forState:UIControlStateSelected];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.layer.cornerRadius = 18;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        [btn_btn addTarget:self action:@selector(btnMethodAllsFou:) forControlEvents:UIControlEventTouchUpInside];
                        [placVV addSubview:btn_btn];
                        [self.fouMut addObject:btn_btn];
                        
                        if(self.has_str4.length > 0) {
                            NSArray *ar_lis = [self.has_str4 componentsSeparatedByString:@","];
                            if([ar_lis containsObject:oneAr4[j]]) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }else {
                            if(j==0) {
                                btn_btn.selected = YES;
                                btn_btn.backgroundColor = RGB(89, 26, 115);
                            }
                        }
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        UIImageView *imgV_two = [[UIImageView alloc] initWithFrame:CGRectMake(16, 385, 16, 16)];
        imgV_two.image = [UIImage imageNamed:@"center_img14"];
        [contVV addSubview:imgV_two];
        
        UILabel *msg_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        msg_lab.numberOfLines = 0;
        msg_lab.text = eLocalizedString(@"center_all25");
        [contVV addSubview:msg_lab];
        [msg_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgV_two.mas_right).offset(6);
            make.top.equalTo(imgV_two.mas_top);
            make.width.offset(_window_width-50);
            make.height.mas_greaterThanOrEqualTo(16);
        }];
        
        UIButton *sureBBB = [HistoryRecordModel createImgBtn];
//        sureBBB.frame = CGRectMake((self.width-124)/2, 600-45, 124, 42);
        [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [sureBBB setImage:[UIImage imageNamed:@"center_img13"] forState:UIControlStateNormal];
        [sureBBB setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
        [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sureBBB.titleLabel.font = SYS_Font(14);
        [sureBBB addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [contVV addSubview:sureBBB];
        [sureBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contVV.mas_centerX);
            make.top.equalTo(msg_lab.mas_bottom).offset(14);
            make.width.offset(124);
            make.height.offset(42);
        }];
        
        self.tankuVV = [HistoryRecordModel createViewUIUI];
        self.tankuVV.frame = CGRectMake(16, _window_height, (_window_width-64)/2, 36*6);
        [contVV addSubview:self.tankuVV];
        
    }
}

- (void)btnMethodAlls:(UIButton *)btn
{
    self.tankuVV.y = _window_height;
    
    NSArray *oneAr2 = @[@"", @"true", @"false"];
    if(self.numTyp == 2) {
        oneAr2 = @[@"true", @"false"];
    }
    for (int i=0; i<self.oneMut.count; i++) {
        UIButton *bMM = self.oneMut[i];
        if(bMM == btn) {
            
            self.has_str1 = oneAr2[i];
            bMM.selected = YES;
            bMM.backgroundColor = RGB(89, 26, 115);
        }else {
            bMM.selected = NO;
            bMM.backgroundColor = RGB(43, 12, 56);

            
        }
    }
        
}

- (void)btnMethodAllsTwo:(UIButton *)btn
{
    NSArray *oneAr2 = @[@"", @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];

    for (int i=0; i<self.twoMut.count; i++) {
        UIButton *bMM = self.twoMut[i];
        if(bMM == btn) {
            
            bMM.selected = YES;
            bMM.backgroundColor = RGB(89, 26, 115);
            self.has_str2 = oneAr2[i];
        }else {
            bMM.selected = NO;
            bMM.backgroundColor = RGB(43, 12, 56);

        }
    }
}

- (void)btnMethodAllsThr:(UIButton *)btn
{
    
    NSArray *oneAr2 = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
    for (int i=0; i<self.thrMut.count; i++) {
        UIButton *bMM = self.thrMut[i];
        if(bMM == btn) {
            
            bMM.selected = YES;
            bMM.backgroundColor = RGB(89, 26, 115);
            self.has_str3 = oneAr2[i];
        }else {
            bMM.selected = NO;
            bMM.backgroundColor = RGB(43, 12, 56);

        }
    }
}

- (void)btnMethodAllsFou:(UIButton *)btn
{
    self.tankuVV.y = _window_height;
    NSArray *oneAr4 = @[@"", @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
    self.has_str4 = @"";
    
    BOOL boo_boo = NO;
    BOOL boo_two = NO;
    for (int i=0; i<self.fouMut.count; i++) {
        UIButton *bMM = self.fouMut[i];
        
        if(bMM == btn) {
            bMM.selected = !bMM.selected;
            if(bMM.selected == YES) {
                if(i==0) {
                    boo_boo = YES;
                }
            }
        }
        if(i>0) {
            if(bMM.selected == YES) {
                boo_two = YES;
            }
        }
    }
    
    if(boo_boo) {
        for (int i=0; i<self.fouMut.count; i++) {
            UIButton *bMM = self.fouMut[i];
            
            if(i==0) {
                bMM.selected = YES;
                bMM.backgroundColor = RGB(89, 26, 115);
            }else {
                bMM.selected = NO;
                bMM.backgroundColor = RGB(43, 12, 56);
            }
        }
    }else {
        if(boo_two) {
            
            for (int i=0; i<self.fouMut.count; i++) {
                UIButton *bMM = self.fouMut[i];
                
                if(i==0) {
                    bMM.selected = NO;
                    bMM.backgroundColor = RGB(43, 12, 56);
                }else {
                    if(bMM.selected == YES) {
                        if(self.has_str4.length>0) {
                            
                            self.has_str4 = [NSString stringWithFormat:@"%@,%@", self.has_str4, oneAr4[i]];
                        }else {
                            self.has_str4 = oneAr4[i];
                        }
                        bMM.backgroundColor = RGB(89, 26, 115);
                    }else {
                        bMM.backgroundColor = RGB(43, 12, 56);
                    }
                }
            }
        }else {
            for (int i=0; i<self.fouMut.count; i++) {
                UIButton *bMM = self.fouMut[i];
                
                if(i==0) {
                    bMM.selected = YES;
                    bMM.backgroundColor = RGB(89, 26, 115);
                }else {
                    bMM.selected = NO;
                    bMM.backgroundColor = RGB(43, 12, 56);
                }
            }
        }
    }
}

- (void)sureBtnMethod
{
    if(self.block_) {
        self.block_(self.has_str1, self.has_str2, self.has_str3, self.has_str4);
    }
    
    [self removeFromSuperview];
}

- (void)btnMethodAllsThrPPP:(UIButton *)btn
{
    NSArray *oneAr2 = @[eLocalizedString(@"center_all12"), @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    NSArray *oneAr3 = @[eLocalizedString(@"center_all12"), @"BIS", @"HETERO", @"GAY", @"LES"];
    
    if(self.tankuVV.y >= _window_height) {
    
        [self.tankuVV removeAllSubviews];
        for (int i=0; i<self.thrMut.count; i++) {
            UIButton *btnMM = self.thrMut[i];
            if(btn == btnMM) {
                if(i==0) {
                    self.tankuVV.frame = CGRectMake(16, 20+96+102, (_window_width-64)/2, 36*oneAr2.count);
                    for (int j=0; j<oneAr2.count; j++) {
                        UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, j*36, (_window_width-64)/2, 36)];
                        [selBBtn setTitle:oneAr2[j] forState:UIControlStateNormal];
                        [selBBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                        [selBBtn setTitleColor:normalColors forState:UIControlStateSelected];
                        selBBtn.titleLabel.font = SYS_Font(14);
                        selBBtn.tag = 6500+j;
                        [selBBtn addTarget:self action:@selector(selBtnAllsMehtod:) forControlEvents:UIControlEventTouchUpInside];
                        [self.tankuVV addSubview:selBBtn];
                        if(self.has_str2.length>0) {
                            if([self.has_str2 isEqualToString:oneAr2[j]]) {
                                selBBtn.selected = YES;
                            }
                        }else {
                            if(j==0) {
                                selBBtn.selected = YES;
                            }
                        }
                    }
                }else {
                    self.tankuVV.frame = CGRectMake(16+i*(_window_width)/2, 20+96+102, (_window_width-64)/2, 36*oneAr3.count);
                    for (int j=0; j<oneAr3.count; j++) {
                        UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, j*36, (_window_width-64)/2, 36)];
                        [selBBtn setTitle:oneAr3[j] forState:UIControlStateNormal];
                        [selBBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                        [selBBtn setTitleColor:normalColors forState:UIControlStateSelected];
                        selBBtn.titleLabel.font = SYS_Font(14);
                        selBBtn.tag = 6500+j;
                        [selBBtn addTarget:self action:@selector(selBtnAllsMehtodTwo:) forControlEvents:UIControlEventTouchUpInside];
                        [self.tankuVV addSubview:selBBtn];
                        if(self.has_str3.length>0) {
                            if([self.has_str3 isEqualToString:oneAr3[j]]) {
                                selBBtn.selected = YES;
                            }
                        }else {
                            if(j==0) {
                                selBBtn.selected = YES;
                            }
                        }
                    }
                }
            }
        }
    }else {
        self.tankuVV.y = _window_height;
    }
}

- (void)selBtnAllsMehtod:(UIButton *)btn
{
    NSArray *oneAr2 = @[eLocalizedString(@"center_all12"), @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    NSArray *oneAr22 = @[@"", @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    UIButton *btn_btn = self.thrMut[0];
    [btn_btn setTitle:oneAr2[btn.tag-6500] forState:UIControlStateNormal];
    
    self.has_str2 = oneAr22[btn.tag-6500];
    
    self.tankuVV.y = _window_height;
}

- (void)selBtnAllsMehtodTwo:(UIButton *)btn
{
    NSArray *oneAr3 = @[eLocalizedString(@"center_all12"), @"BIS", @"HETERO", @"GAY", @"LES"];
    NSArray *oneAr33 = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
    UIButton *btn_btn = self.thrMut[1];
    [btn_btn setTitle:oneAr3[btn.tag-6500] forState:UIControlStateNormal];
    
    self.has_str3 = oneAr33[btn.tag-6500];
    self.tankuVV.y = _window_height;
}

- (void)deleBtnMethod
{
    [self removeFromSuperview];
}

- (void)tapNewAction
{
    self.tankuVV.y = _window_height;
}

@end
