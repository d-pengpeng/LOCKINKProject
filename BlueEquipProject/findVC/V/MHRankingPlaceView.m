//
//  MHRankingPlaceView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/13.
//

#import "MHRankingPlaceView.h"

@interface MHRankingPlaceView ()

@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *twoLab;
@end

@implementation MHRankingPlaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deleBBB.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBBB];
        
        UIView *placVV = [HistoryRecordModel createViewUIUI];
        placVV.backgroundColor = UIColor.clearColor;
        [self addSubview:placVV];
        [placVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.offset(280);
            make.height.mas_greaterThanOrEqualTo(200);
        }];
        
        UIImageView *plaImg = [HistoryRecordModel createImgImgView];
        plaImg.image = [UIImage imageNamed:@"toysAllImg3"];
        [placVV addSubview:plaImg];
        [plaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(placVV);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        [placVV addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(placVV);
            make.top.equalTo(placVV.mas_top).offset(30);
            make.height.offset(42);
        }];
        
        self.twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.twoLab.numberOfLines = 0;
        [placVV addSubview:self.twoLab];
        [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(placVV.mas_left).offset(24);
            make.right.equalTo(placVV.mas_right).offset(-24);
            make.top.equalTo(self.oneLab.mas_bottom).offset(4);
            make.height.mas_greaterThanOrEqualTo(42);
        }];
        
        UIButton *lefBBtn = [HistoryRecordModel createImgBtn];
        lefBBtn.backgroundColor = UIColor.clearColor;
        lefBBtn.layer.cornerRadius = 4;
        lefBBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        lefBBtn.layer.borderWidth = 1;
        [lefBBtn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        lefBBtn.titleLabel.font = SYS_Font(14);
        [lefBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [lefBBtn addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [placVV addSubview:lefBBtn];
        [lefBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(placVV.mas_left).offset(38);
            make.bottom.equalTo(placVV.mas_bottom).offset(-28);
            make.top.equalTo(self.twoLab.mas_bottom).offset(20);
            make.height.offset(36);
            make.width.offset(92);
        }];
        
        UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
        lefBBtn2.backgroundColor = RGB(117, 34, 169);
        lefBBtn2.layer.cornerRadius = 4;
        [lefBBtn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        lefBBtn2.titleLabel.font = SYS_Font(14);
        [lefBBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [lefBBtn2 addTarget:self action:@selector(leftBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [placVV addSubview:lefBBtn2];
        [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(placVV.mas_right).offset(-38);
            make.bottom.equalTo(placVV.mas_bottom).offset(-28);
            make.top.equalTo(self.twoLab.mas_bottom).offset(20);
            make.height.offset(36);
            make.width.offset(92);
        }];
        
    }
    return self;
}

- (void)addIMMsgDataToTag:(NSInteger)Typ
{
    switch (Typ) {
        case 1:
        {
            [self removeAllSubviews];
            
            UIView *oneVV = [HistoryRecordModel createViewUIUI];
            oneVV.frame = CGRectMake(_window_width/2-150, _window_height/2-90, 300, 180);
            oneVV.backgroundColor = UIColor.clearColor;
            [self addSubview:oneVV];

            UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, oneVV.width, oneVV.height)];
            bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
            [oneVV addSubview:bacImg];

            UILabel *tex_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
            tex_lab.text = eLocalizedString(@"role_name56");
            tex_lab.numberOfLines = 0;
            [oneVV addSubview:tex_lab];
            [tex_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(oneVV.mas_left).offset(30);
                make.right.equalTo(oneVV.mas_right).offset(-30);
                make.top.equalTo(oneVV.mas_top).offset(24);
                make.height.offset(68);
            }];

            CGFloat ww_hhw = (oneVV.width-220)/2.f;

            UIButton *btn_btn = [HistoryRecordModel createImgBtn];
            btn_btn.frame = CGRectMake(ww_hhw, oneVV.height-76, 100, 36);
            [btn_btn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
            [btn_btn setTitleColor:normalColors forState:UIControlStateNormal];
            [btn_btn setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
            btn_btn.titleLabel.font = SYS_Font(14);
            [btn_btn addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:btn_btn];

            UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
            btn_btn2.frame = CGRectMake(ww_hhw+120, oneVV.height-76, 100, 36);
            [btn_btn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
            [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn_btn2 setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateNormal];
            btn_btn2.titleLabel.font = SYS_Font(14);
            btn_btn2.titleLabel.numberOfLines = 2;
            [btn_btn2 addTarget:self action:@selector(leftBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:btn_btn2];
            
        }
            break;
            
        default:
            break;
    }
}


- (void)addFourthDataToDicTypeNum:(NSInteger)Typ
{
    [self removeAllSubviews];
    
    UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    deleBBB.backgroundColor = RGBA(0, 0, 0, 0.4);
    [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleBBB];
    
    UIView *placVV = [HistoryRecordModel createViewUIUI];
    placVV.backgroundColor = UIColor.clearColor;
    [self addSubview:placVV];
    [placVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.offset(300);
        make.height.offset(166);
    }];
    
    UIImageView *plaImg = [HistoryRecordModel createImgImgView];
    plaImg.image = [UIImage imageNamed:@"fourth_tipsb_img"];
    [placVV addSubview:plaImg];
    [plaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(placVV);
    }];
    
    UILabel *tips_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    [placVV addSubview:tips_lab];
    [tips_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(placVV);
        make.top.equalTo(placVV.mas_top);
        make.height.offset(42);
    }];
    
    UILabel *tipsMsg_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    tipsMsg_lab.numberOfLines = 0;
    [placVV addSubview:tipsMsg_lab];
    [tipsMsg_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(placVV.mas_left).offset(24);
        make.right.equalTo(placVV.mas_right).offset(-24);
        make.top.equalTo(tips_lab.mas_bottom).offset(4);
        make.height.mas_greaterThanOrEqualTo(42);
    }];
    
    UIButton *lefBBtn = [HistoryRecordModel createImgBtn];
    lefBBtn.backgroundColor = UIColor.clearColor;
    [lefBBtn setBackgroundImage:[UIImage imageNamed:@"fourth_tipsCancel_img"] forState:UIControlStateNormal];
    [lefBBtn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
    lefBBtn.titleLabel.font = SYS_Font(14);
    [lefBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [lefBBtn addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:lefBBtn];
    [lefBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(placVV.mas_bottom).offset(-15);
        make.right.equalTo(placVV.mas_centerX).offset(-10);
        make.height.offset(36);
        make.width.offset(107);
    }];
    
    UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
    [lefBBtn2 setBackgroundImage:[UIImage imageNamed:@"fourth_tipsSure_img"] forState:UIControlStateNormal];
    [lefBBtn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
    lefBBtn2.titleLabel.font = SYS_Font(14);
    [lefBBtn2 setTitleColor:normalColors forState:UIControlStateNormal];
    [lefBBtn2 addTarget:self action:@selector(leftBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:lefBBtn2];
    [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(placVV.mas_bottom).offset(-15);
        make.left.equalTo(placVV.mas_centerX).offset(10);
        make.height.offset(36);
        make.width.offset(107);
    }];
    if (Typ==1) {

        tips_lab.text = eLocalizedString(@"my_about4");
        tipsMsg_lab.text = eLocalizedString(@"role_setting13");
    }else {
        tips_lab.text = eLocalizedString(@"my_about4");
        tipsMsg_lab.text = eLocalizedString(@"thr_nams13");
    }
}


- (void)addFourthDataToDic:(NSInteger)Typ
{
    [self removeAllSubviews];
    
    UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    deleBBB.backgroundColor = RGBA(0, 0, 0, 0.4);
    [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleBBB];
    
    UIView *placVV = [HistoryRecordModel createViewUIUI];
    placVV.backgroundColor = UIColor.clearColor;
    [self addSubview:placVV];
    [placVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.offset(300);
        make.height.offset(166);
    }];
    
    UIImageView *plaImg = [HistoryRecordModel createImgImgView];
    plaImg.image = [UIImage imageNamed:@"fourth_tipsb_img"];
    [placVV addSubview:plaImg];
    [plaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(placVV);
    }];
    
    UILabel *tips_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    [placVV addSubview:tips_lab];
    [tips_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(placVV);
        make.top.equalTo(placVV.mas_top);
        make.height.offset(42);
    }];
    
    UILabel *tipsMsg_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    tipsMsg_lab.numberOfLines = 0;
    [placVV addSubview:tipsMsg_lab];
    [tipsMsg_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(placVV.mas_left).offset(24);
        make.right.equalTo(placVV.mas_right).offset(-24);
        make.top.equalTo(tips_lab.mas_bottom).offset(4);
        make.height.mas_greaterThanOrEqualTo(42);
    }];
    
    UIButton *lefBBtn = [HistoryRecordModel createImgBtn];
    lefBBtn.backgroundColor = UIColor.clearColor;
    [lefBBtn setBackgroundImage:[UIImage imageNamed:@"fourth_tipsCancel_img"] forState:UIControlStateNormal];
    [lefBBtn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
    lefBBtn.titleLabel.font = SYS_Font(14);
    [lefBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [lefBBtn addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:lefBBtn];
    [lefBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(placVV.mas_bottom).offset(-15);
        make.right.equalTo(placVV.mas_centerX).offset(-10);
        make.height.offset(36);
        make.width.offset(107);
    }];
    
    UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
    [lefBBtn2 setBackgroundImage:[UIImage imageNamed:@"fourth_tipsSure_img"] forState:UIControlStateNormal];
    [lefBBtn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
    lefBBtn2.titleLabel.font = SYS_Font(14);
    [lefBBtn2 setTitleColor:normalColors forState:UIControlStateNormal];
    [lefBBtn2 addTarget:self action:@selector(leftBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:lefBBtn2];
    [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(placVV.mas_bottom).offset(-15);
        make.left.equalTo(placVV.mas_centerX).offset(10);
        make.height.offset(36);
        make.width.offset(107);
    }];
    if (Typ==1) {

        tips_lab.text = eLocalizedString(@"my_about4");
        tipsMsg_lab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"my_about6_6") All:eLocalizedString(@"my_about6") nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    }else {
        tips_lab.text = eLocalizedString(@"my_about4");
        tipsMsg_lab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"my_about7_7") All:eLocalizedString(@"my_about7") nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    }
}

- (void)addDataToDic:(NSInteger)Typ
{
    if(Typ == 1) {
        
        self.oneLab.text = eLocalizedString(@"plaza_all25");
        self.twoLab.text = eLocalizedString(@"plaza_all25");
    }else if(Typ == 3) {
        
        self.oneLab.text = eLocalizedString(@"my_about4");
        self.twoLab.text = eLocalizedString(@"my_about5");
        self.twoLab.textAlignment = NSTextAlignmentCenter;
    }else if(Typ == 4) {
        
        self.twoLab.textAlignment = NSTextAlignmentCenter;
        self.oneLab.text = eLocalizedString(@"my_about4");
        self.twoLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"my_about6_6") All:eLocalizedString(@"my_about6") nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    }else if(Typ == 5) {
        
        self.twoLab.textAlignment = NSTextAlignmentCenter;
        self.oneLab.text = eLocalizedString(@"my_about4");
        self.twoLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"my_about7_7") All:eLocalizedString(@"my_about7") nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    }else if(Typ == 6) {
        
        self.oneLab.text = eLocalizedString(@"my_about4");
        NSString *MM = [NSString stringWithFormat:@"%@ %@ %@?", eLocalizedString(@"role_name8"), self.nickNam, eLocalizedString(@"role_name10")];
        self.twoLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:self.nickNam All:MM nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    }else if(Typ == 7) {
        
        self.oneLab.text = eLocalizedString(@"my_about4");
        NSString *MM = [NSString stringWithFormat:@"%@ %@ %@?", eLocalizedString(@"role_name8"), self.nickNam, eLocalizedString(@"role_name9")];
        self.twoLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:self.nickNam All:MM nameFont:SYS_Font(14) allFont:SYS_Font(14) nameColor:normalColors allColor:UIColor.whiteColor];
    }else if(Typ == 8) {
        
        self.oneLab.text = eLocalizedString(@"my_about4");
        self.twoLab.text = eLocalizedString(@"my_about16");
    }else if(Typ == 9) {
        
        self.oneLab.text = eLocalizedString(@"my_about4");
        self.twoLab.text = eLocalizedString(@"my_about17");
    }else if(Typ == 10) {
        
        self.twoLab.textAlignment = NSTextAlignmentCenter;
        self.oneLab.text = eLocalizedString(@"my_about18");
        self.twoLab.text = eLocalizedString(@"my_about19");
    }else if(Typ == 11) {
        
        self.twoLab.textAlignment = NSTextAlignmentCenter;
        self.oneLab.text = eLocalizedString(@"role_setting25");
        self.twoLab.text = eLocalizedString(@"role_name54");
    }else {
        self.oneLab.text = eLocalizedString(@"plaza_all27");
        self.twoLab.text = eLocalizedString(@"plaza_all28");
    }
    
}

- (void)leftBtnMethodTwo
{
    if(self.block_) {
        self.block_(YES);
    }
    [self removeFromSuperview];
}

- (void)deleBtnMethod
{
    if(self.block_) {
        self.block_(NO);
    }
    [self removeFromSuperview];
}

@end
