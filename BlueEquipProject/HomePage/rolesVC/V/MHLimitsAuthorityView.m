//
//  MHLimitsAuthorityView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "MHLimitsAuthorityView.h"

@implementation MHLimitsAuthorityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deleBBB.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBBB];
        
        UIView *placVV = [HistoryRecordModel createViewUIUI];
        placVV.backgroundColor = UIColor.clearColor;
        [self addSubview:placVV];
        [placVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.offset(180);
            make.height.offset(126);
        }];
        
        UIImageView *plaImg = [HistoryRecordModel createImgImgView];
        plaImg.image = [UIImage imageNamed:@"toysAllImg3"];
        [placVV addSubview:plaImg];
        [plaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(placVV);
        }];
        
        UILabel *titLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLab.text = eLocalizedString(@"my_about4");
        [placVV addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(placVV);
            make.top.equalTo(placVV.mas_top).offset(15);
            make.height.offset(30);
        }];
        
        UILabel *titLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLab2.text = eLocalizedString(@"my_about20");
        [placVV addSubview:titLab2];
        [titLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(placVV);
            make.top.equalTo(titLab.mas_bottom);
            make.height.offset(28);
        }];
        
        UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
        lefBBtn2.backgroundColor = RGB(117, 34, 169);
        lefBBtn2.layer.cornerRadius = 4;
        [lefBBtn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        lefBBtn2.titleLabel.font = SYS_Font(14);
        [lefBBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [lefBBtn2 addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [placVV addSubview:lefBBtn2];
        [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(placVV.mas_centerX);
            make.top.equalTo(titLab2.mas_bottom).offset(7);
            make.height.offset(28);
            make.width.offset(76);
        }];
    }
    return self;
}

- (void)addTwoLimitsAuthorityUIUI:(NSInteger)tyepMM
{
    [self removeAllSubviews];
    UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    deleBBB.backgroundColor = RGBA(0, 0, 0, 0.4);
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
    plaImg.image = [UIImage imageNamed:@"toysAllImg3"];
    [placVV addSubview:plaImg];
    [plaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(placVV);
    }];
    
    UILabel *titLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    titLab.text = eLocalizedString(@"my_about4");
    [placVV addSubview:titLab];
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(placVV);
        make.top.equalTo(placVV.mas_top).offset(15);
        make.height.offset(30);
    }];
    
    UILabel *titLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:15 textAlignment:NSTextAlignmentCenter];
    titLab2.text = eLocalizedString(@"msg_UIUIStr1");
    titLab2.numberOfLines = 0;
    [placVV addSubview:titLab2];
    [titLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(placVV.mas_left).offset(25);
        make.right.equalTo(placVV.mas_right).offset(-25);
        make.top.equalTo(titLab.mas_bottom);
        make.height.offset(68);
    }];
    
    UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
    lefBBtn2.backgroundColor = UIColor.clearColor;
    lefBBtn2.layer.cornerRadius = 4;
    lefBBtn2.layer.borderColor = UIColor.whiteColor.CGColor;
    lefBBtn2.layer.borderWidth = 1;
    [lefBBtn2 setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
    lefBBtn2.titleLabel.font = SYS_Font(12);
    [lefBBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [lefBBtn2 addTarget:self action:@selector(cancelMUIBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:lefBBtn2];
    [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(placVV.mas_centerX).offset(-10);
        make.top.equalTo(titLab2.mas_bottom).offset(7);
        make.height.offset(34);
        make.width.offset(96);
    }];
    
    UIButton *rigBBtn2 = [HistoryRecordModel createImgBtn];
    rigBBtn2.backgroundColor = RGB(117, 34, 169);
    rigBBtn2.layer.cornerRadius = 4;
    [rigBBtn2 setTitle:eLocalizedString(@"msg_UIUIStr2") forState:UIControlStateNormal];
    rigBBtn2.titleLabel.font = SYS_Font(12);
    rigBBtn2.titleLabel.numberOfLines = 2;
    [rigBBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [rigBBtn2 addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:rigBBtn2];
    [rigBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(placVV.mas_centerX).offset(10);
        make.top.equalTo(titLab2.mas_bottom).offset(7);
        make.height.offset(34);
        make.width.offset(96);
    }];
}

- (void)addLimitsAuthorityUIUI:(NSInteger)tyepMM
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
        make.width.offset(240);
        make.height.offset(132+46);
    }];
    
    UIImageView *plaImg = [HistoryRecordModel createImgImgView];
    plaImg.image = [UIImage imageNamed:@"toysAllImg3"];
    [placVV addSubview:plaImg];
    [plaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(placVV);
    }];
    
    UILabel *titLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    titLab.text = eLocalizedString(@"my_about4");
    [placVV addSubview:titLab];
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(placVV);
        make.top.equalTo(placVV.mas_top).offset(15);
        make.height.offset(46);
    }];
    
    int second = 0;
    int minn = 0;
    int hour = 0;

    second = self.startNum%60;
    minn = self.startNum/60;

    if(minn >= 24) {
        hour = minn/24;
        minn = minn%24;
    }

    NSString *oneStr = [NSString stringWithFormat:@"%d", second];
    if(second<10) {
        oneStr = [NSString stringWithFormat:@"0%d", second];
    }
    NSString *twoStr = [NSString stringWithFormat:@"%d", minn];
    if(minn<10) {
        twoStr = [NSString stringWithFormat:@"0%d", minn];
    }
    NSString *thrStr = [NSString stringWithFormat:@"%d", hour];
    if(hour<10) {
        thrStr = [NSString stringWithFormat:@"0%d", hour];
    }
    
    NSArray *hourAr = @[thrStr, twoStr, oneStr];
    
    CGFloat w_xx = (240-160)/2;
    for (int i=0; i<hourAr.count; i++) {
        
        UIButton *delBBB = [[UIButton alloc] initWithFrame:CGRectMake(w_xx + i*60, 60, 40, 40)];
        [delBBB setBackgroundImage:[UIImage imageNamed:@"LimitsAu_img1"] forState:UIControlStateNormal];
        [delBBB setTitle:hourAr[i] forState:UIControlStateNormal];
        [delBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        delBBB.titleLabel.font = SYS_Font(14);
        [placVV addSubview:delBBB];
        
        if(i<hourAr.count-1) {
            UILabel *wXLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
            wXLab.frame = CGRectMake(w_xx+40 + i*60, 60, 20, 40);
            wXLab.text = @":";
            [placVV addSubview:wXLab];
        }
    }
    
    UIButton *deleBBB2 = [[UIButton alloc] init];
    deleBBB2.backgroundColor = normalColors;
    deleBBB2.layer.cornerRadius = 3;
    [deleBBB2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
    [deleBBB2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    deleBBB2.titleLabel.font = SYS_Font(13);
    [deleBBB2 addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [placVV addSubview:deleBBB2];
    [deleBBB2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(placVV.mas_bottom).offset(-15);
        make.centerX.equalTo(placVV.mas_centerX);
        make.height.offset(30);
        make.width.offset(70);
    }];
}

- (void)deleBtnMethod
{
    if(self.block_) {
        self.block_();
    }
    [self removeFromSuperview];
}

- (void)cancelMUIBtnMethod
{
    if (self.wwwhhhBoo) {
        if (self.twoblock_) {
            self.twoblock_();
        }
    }
    [self removeFromSuperview];
}

@end
