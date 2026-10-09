//
//  MHRoleThrJDMSController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/11.
//

#import "MHRoleThrJDMSController.h"
#import "MHThrSDMSSliderView.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHLimitsAuthorityView.h"

@interface MHRoleThrJDMSController ()

@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) UIScrollView *scrollVVV;
@property (nonatomic, strong) MHThrSDMSSliderView *thrSDMSSliderV;
@property (nonatomic, strong) MHThrSDMSSliderView_one *thrSDMSSliderV_one;
@property (nonatomic, strong) MHThrSDMSSliderView_one *thrSDMSSliderV_two;

@property (nonatomic, strong) UIView *suijiVV;

@property (nonatomic, copy) NSString *val_one1;//旋转强度
@property (nonatomic, copy) NSString *val_one2;//旋转模式1-10
@property (nonatomic, copy) NSString *val_one3;//电击强度
@property (nonatomic, copy) NSString *val_one4;//电击模式1-10
@property (nonatomic, copy) NSString *val_one5;//狂暴模式
@property (nonatomic, copy) NSString *val_one6;//顺时针、逆时针
@property (nonatomic, copy) NSString *val_one7;//随机
@property (nonatomic, copy) NSString *val_one8;//随机范围 1
@property (nonatomic, copy) NSString *val_one9;//随机范围 2
@property (nonatomic, assign) BOOL isSuijiBoo;

@property (nonatomic, assign) BOOL controling_boo; //是否是 被控制设备
@end

@implementation MHRoleThrJDMSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.val_one1 = @"0";
    self.val_one2 = @"0";
    self.val_one3 = @"0";
    self.val_one4 = @"0";
    self.val_one5 = @"false";
    self.val_one6 = @"0";
    self.val_one7 = @"false";
    self.val_one8 = @"0";
    self.val_one9 = @"100";
    
    _oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    _oneVV.layer.cornerRadius = 0;
    _oneVV.clipsToBounds = YES;
    _oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_oneVV];
    
    UIView *plaVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    plaVV.layer.cornerRadius = 0;
    plaVV.clipsToBounds = YES;
    plaVV.backgroundColor = RGBA(130, 54, 231, 0.76);
    [self.oneVV addSubview:plaVV];
    
    self.scrollVVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.oneVV.height)];
    self.scrollVVV.showsVerticalScrollIndicator = NO;
    self.scrollVVV.showsHorizontalScrollIndicator = NO;
    self.scrollVVV.bounces = NO;
    self.scrollVVV.backgroundColor = UIColor.clearColor;
    [self.oneVV addSubview:self.scrollVVV];
    
    if ([self.devicTyp isEqualToString:kCharactName12]) {
        
        //MARK: 电击模式UI
        UILabel *tit_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        tit_lab2.frame = CGRectMake(20, 0, _window_width-40, 48);
        tit_lab2.text = [NSString stringWithFormat:@"%@:", eLocalizedString(@"thr_nams7")];
        [self.scrollVVV addSubview:tit_lab2];
        
        UIButton *lefNumBtn2 = [HistoryRecordModel createImgBtn];
        lefNumBtn2.frame = CGRectMake(6, CGRectGetMaxY(tit_lab2.frame), 52, 40);
        lefNumBtn2.tag = 1002;
        [lefNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollVVV addSubview:lefNumBtn2];
        UIImageView *lef_subIII_2 = [HistoryRecordModel createImgImgView];
        lef_subIII_2.frame = CGRectMake(14, 8, 24, 24);
        lef_subIII_2.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
        [lefNumBtn2 addSubview:lef_subIII_2];
        UIImageView *lef_subIII22 = [HistoryRecordModel createImgImgView];
        lef_subIII22.frame = CGRectMake(38, 22, 10, 10);
        lef_subIII22.image = [UIImage imageNamed:@"threeAdMut_imgs2"];
        [lefNumBtn2 addSubview:lef_subIII22];
        
        UIButton *rigNumBtn2 = [HistoryRecordModel createImgBtn];
        rigNumBtn2.frame = CGRectMake(_window_width-58, CGRectGetMaxY(tit_lab2.frame), 52, 40);
        rigNumBtn2.tag = 1003;
        [rigNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollVVV addSubview:rigNumBtn2];
        UIImageView *rig_subIII_2 = [HistoryRecordModel createImgImgView];
        rig_subIII_2.frame = CGRectMake(14, 8, 24, 24);
        rig_subIII_2.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
        [rigNumBtn2 addSubview:rig_subIII_2];
        UIImageView *rig_subIII22 = [HistoryRecordModel createImgImgView];
        rig_subIII22.frame = CGRectMake(38, 22, 10, 10);
        rig_subIII22.image = [UIImage imageNamed:@"threeAdMut_imgs3"];
        [rigNumBtn2 addSubview:rig_subIII22];
        
        self.thrSDMSSliderV_two = [[MHThrSDMSSliderView_one alloc] initWithFrame:CGRectMake(lefNumBtn2.x+lefNumBtn2.width, CGRectGetMaxY(tit_lab2.frame), _window_width-116, 40)];
        [self.scrollVVV addSubview:self.thrSDMSSliderV_two];
        WEAKSELF
        self.thrSDMSSliderV_two.block_ = ^(NSString * _Nonnull oneNum, NSString * _Nonnull twoNum) {
            weakSelf.val_one3 = oneNum;
            
            [weakSelf sendSocketThreeDataMethod];
        };
        self.thrSDMSSliderV_two.twoBlock_ = ^(BOOL isBoo) {
          
            __strong __typeof(self)self = weakSelf;
            
            self.scrollVVV.scrollEnabled = isBoo;
        };
        
        UIView *sub_oneVV2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lefNumBtn2.frame)+28, _window_width-20, 96*2)];
        sub_oneVV2.backgroundColor = UIColor.clearColor;
        [self.scrollVVV addSubview:sub_oneVV2];
        
        CGFloat one_fivFF = (_window_width-20)/5.f;
        for (int i=0; i<10; i++) {
            UIButton *ten_BBtn = [HistoryRecordModel createImgBtn];
            if (i>4) {
                ten_BBtn.frame = CGRectMake(10+(i-5)*one_fivFF, 96, 52, 96);
            }else {
                ten_BBtn.frame = CGRectMake(10+i*one_fivFF, 0, 52, 96);
            }
            ten_BBtn.tag = 2300+i;
            [ten_BBtn addTarget:self action:@selector(tenBtnMethodUIUIUIUTag:) forControlEvents:UIControlEventTouchUpInside];
            [sub_oneVV2 addSubview:ten_BBtn];
            
            UIImageView *teImgVV = [HistoryRecordModel createImgImgView];
            teImgVV.frame = CGRectMake(0, 0, 52, 52);
            teImgVV.image = [UIImage imageNamed:[NSString stringWithFormat:@"threeModel2_imgs%d", i+1]];
            teImgVV.tag = 2400+i;
            [ten_BBtn addSubview:teImgVV];
            
            NSString *nam_sttt = [NSString stringWithFormat:@"thrModel2_nams%d", i+1];
            UILabel *nam_LLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
            nam_LLab.frame = CGRectMake(3, 52, ten_BBtn.width-6, 34);
            nam_LLab.tag = 2500+i;
            nam_LLab.numberOfLines = 3;
            nam_LLab.text = eLocalizedString(nam_sttt);
            [ten_BBtn addSubview:nam_LLab];
            [nam_LLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ten_BBtn.mas_left).offset(3);
                make.top.equalTo(ten_BBtn.mas_top).offset(52);
                make.right.equalTo(ten_BBtn.mas_right).offset(-3);
                make.height.mas_greaterThanOrEqualTo(34);
            }];
        }
        
        //MARK: 狂暴、旋转、随机
        CGFloat ww_lef = _window_width/2.f;
        NSArray *imgsA = @[@"three_imgs10", @"three_imgs11"];
        NSArray *namsA = @[@"thr_nams9", @"thr_nams11"];
        NSArray *tagsA = @[@"0", @"2"];
        for (int i=0; i<namsA.count; i++) {
            
            UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*ww_lef, CGRectGetMaxY(sub_oneVV2.frame)+15, ww_lef, 120)];
            selBBtn.tag = 2600+[minStr(tagsA[i]) intValue];
            [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollVVV addSubview:selBBtn];
            
            UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
            hhhImgV.frame = CGRectMake((selBBtn.width-64)/2, 0, 64, 67);
            hhhImgV.image = [UIImage imageNamed:imgsA[i]];
            hhhImgV.tag = 2700+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:hhhImgV];
            
            UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
            nam_LLL.frame = CGRectMake(3, 67, ww_lef-6, 24);
            nam_LLL.text = eLocalizedString(namsA[i]);
            nam_LLL.tag = 2800+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:nam_LLL];
            
            UIImageView *switImgV = [HistoryRecordModel createImgImgView];
            switImgV.frame = CGRectMake((ww_lef-34)/2, 107, 34, 12);
            switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
            switImgV.tag = 2900+[minStr(tagsA[i]) intValue];
            [selBBtn addSubview:switImgV];
        }
       
        //MARK: 设置随机模式 区间
        
        self.suijiVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sub_oneVV2.frame)+150, _window_width, 106)];
        self.suijiVV.backgroundColor = UIColor.clearColor;
        [self.scrollVVV addSubview:self.suijiVV];
        
        UIButton *lefNumBtn3 = [HistoryRecordModel createImgBtn];
        lefNumBtn3.frame = CGRectMake(6, 0, 52, 40);
        lefNumBtn3.tag = 1004;
        [lefNumBtn3 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.suijiVV addSubview:lefNumBtn3];
        UIImageView *lef_subIII_3 = [HistoryRecordModel createImgImgView];
        lef_subIII_3.frame = CGRectMake(14, 8, 24, 24);
        lef_subIII_3.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
        [lefNumBtn3 addSubview:lef_subIII_3];
        UIImageView *lef_subIII23 = [HistoryRecordModel createImgImgView];
        lef_subIII23.frame = CGRectMake(38, 22, 10, 10);
        lef_subIII23.image = [UIImage imageNamed:@"threeAdMut_imgs2"];
        [lefNumBtn3 addSubview:lef_subIII23];
        
        UIButton *rigNumBtn3 = [HistoryRecordModel createImgBtn];
        rigNumBtn3.frame = CGRectMake(_window_width-58, 0, 52, 40);
        rigNumBtn3.tag = 1005;
        [rigNumBtn3 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.suijiVV addSubview:rigNumBtn3];
        UIImageView *rig_subIII_3 = [HistoryRecordModel createImgImgView];
        rig_subIII_3.frame = CGRectMake(14, 8, 24, 24);
        rig_subIII_3.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
        [rigNumBtn3 addSubview:rig_subIII_3];
        UIImageView *rig_subIII23 = [HistoryRecordModel createImgImgView];
        rig_subIII23.frame = CGRectMake(38, 22, 10, 10);
        rig_subIII23.image = [UIImage imageNamed:@"threeAdMut_imgs3"];
        [rigNumBtn3 addSubview:rig_subIII23];
        
        self.thrSDMSSliderV = [[MHThrSDMSSliderView alloc] initWithFrame:CGRectMake(58, 5, _window_width-116, 30)];
        self.thrSDMSSliderV.typeN = 0;
        [self.suijiVV addSubview:self.thrSDMSSliderV];
        [self.thrSDMSSliderV addLeftStr:0 righStr:100];
        self.thrSDMSSliderV.block_ = ^(NSString * _Nonnull oneNum, NSString * _Nonnull twoNum) {
            
            weakSelf.val_one8 = oneNum;
            weakSelf.val_one9 = twoNum;
        };
        
        UIButton *sureBBB = [HistoryRecordModel createImgBtn];
        sureBBB.frame = CGRectMake((self.oneVV.width-124)/2, CGRectGetMaxY(lefNumBtn3.frame)+30, 124, 36);
        [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [sureBBB setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sureBBB.titleLabel.font = SYS_Font(14);
        [sureBBB addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.suijiVV addSubview:sureBBB];
        
        self.suijiVV.hidden = YES;
        
        
        self.scrollVVV.contentSize = CGSizeMake(_window_width, self.suijiVV.y+self.suijiVV.height+50);
        
    }else {
        //MARK: 旋转模式UI
        UILabel *tit_lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        tit_lab.frame = CGRectMake(20, 0, _window_width-40, 48);
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp]) {
            if ([self.devicTyp isEqualToString:kCharactName7]) {
                tit_lab.text = [NSString stringWithFormat:@"%@:", eLocalizedString(@"thr_nams8_3")];
            }else {
                tit_lab.text = [NSString stringWithFormat:@"%@:", eLocalizedString(@"thr_nams8_2")];
            }
        }else {
            if ([self.devicTyp isEqualToString:kCharactName15]) {
                tit_lab.text = [NSString stringWithFormat:@"%@:", eLocalizedString(@"thr_nams8_2")];
            }else {
                tit_lab.text = [NSString stringWithFormat:@"%@:", eLocalizedString(@"thr_nams8")];
            }
        }
        [self.scrollVVV addSubview:tit_lab];
        
        UIButton *lefNumBtn = [HistoryRecordModel createImgBtn];
        lefNumBtn.frame = CGRectMake(6, CGRectGetMaxY(tit_lab.frame), 52, 40);
        lefNumBtn.tag = 1000;
        [lefNumBtn addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollVVV addSubview:lefNumBtn];
//        if ([self.devicTyp isEqualToString:kCharactName15]) {
//            
//            UIImageView *lef_subIII = [HistoryRecordModel createImgImgView];
//            lef_subIII.frame = CGRectMake(14, 8, 34, 24);
//            lef_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs2_15"];
//            [lefNumBtn addSubview:lef_subIII];
//        }else {
            
            UIImageView *lef_subIII = [HistoryRecordModel createImgImgView];
            lef_subIII.frame = CGRectMake(14, 8, 24, 24);
            if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp]) {
                lef_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs1_2"];
            }else {
                if ([self.devicTyp isEqualToString:kCharactName15]) {
                    lef_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs1_2"];
                }else {
                    lef_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs1"];
                }
            }
            [lefNumBtn addSubview:lef_subIII];
            UIImageView *lef_subIII2 = [HistoryRecordModel createImgImgView];
            lef_subIII2.frame = CGRectMake(38, 22, 10, 10);
            lef_subIII2.image = [UIImage imageNamed:@"threeAdMut_imgs2"];
            [lefNumBtn addSubview:lef_subIII2];
//        }
        
        
        UIButton *rigNumBtn = [HistoryRecordModel createImgBtn];
        rigNumBtn.frame = CGRectMake(_window_width-58, CGRectGetMaxY(tit_lab.frame), 52, 40);
        rigNumBtn.tag = 1001;
        [rigNumBtn addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollVVV addSubview:rigNumBtn];
//        if ([self.devicTyp isEqualToString:kCharactName15]) {
//            
//            UIImageView *rig_subIII = [HistoryRecordModel createImgImgView];
//            rig_subIII.frame = CGRectMake(4, 8, 34, 24);
//            rig_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs3_15"];
//            [rigNumBtn addSubview:rig_subIII];
//        }else {
            UIImageView *rig_subIII = [HistoryRecordModel createImgImgView];
            rig_subIII.frame = CGRectMake(4, 8, 24, 24);
            if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp]) {
                rig_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs1_2"];
            }else {
                if ([self.devicTyp isEqualToString:kCharactName15]) {
                    rig_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs1_2"];
                }else {
                    rig_subIII.image = [UIImage imageNamed:@"threeAdMut_imgs1"];
                }
            }
            
            [rigNumBtn addSubview:rig_subIII];
            UIImageView *rig_subIII2 = [HistoryRecordModel createImgImgView];
            rig_subIII2.frame = CGRectMake(28, 22, 10, 10);
            rig_subIII2.image = [UIImage imageNamed:@"threeAdMut_imgs3"];
            [rigNumBtn addSubview:rig_subIII2];
//        }
        self.thrSDMSSliderV_one = [[MHThrSDMSSliderView_one alloc] initWithFrame:CGRectMake(lefNumBtn.x+lefNumBtn.width, CGRectGetMaxY(tit_lab.frame), _window_width-116, 40)];
        [self.scrollVVV addSubview:self.thrSDMSSliderV_one];
        WEAKSELF
        self.thrSDMSSliderV_one.block_ = ^(NSString * _Nonnull oneNum, NSString * _Nonnull twoNum) {
            
            weakSelf.val_one1 = oneNum;
            if (weakSelf.controling_boo) [FloatingWindowModel shareInstance].JingDian_one_strong = [oneNum intValue];
            
            [weakSelf sendSocketThreeDataMethod];
        };
        self.thrSDMSSliderV_one.twoBlock_ = ^(BOOL isBoo) {
            
            __strong __typeof(self)self = weakSelf;
            
            self.scrollVVV.scrollEnabled = isBoo;
        };
        
        UIView *sub_oneVV = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lefNumBtn.frame)+28, _window_width-20, 96*2)];
        sub_oneVV.backgroundColor = UIColor.clearColor;
        [self.scrollVVV addSubview:sub_oneVV];
        
        CGFloat one_fivFF = (_window_width-20)/5.f;
        for (int i=0; i<10; i++) {
            UIButton *ten_BBtn = [HistoryRecordModel createImgBtn];
            if (i>4) {
                ten_BBtn.frame = CGRectMake(10+(i-5)*one_fivFF, 96, 52, 96);
            }else {
                ten_BBtn.frame = CGRectMake(10+i*one_fivFF, 0, 52, 96);
            }
            ten_BBtn.tag = 2000+i;
            [ten_BBtn addTarget:self action:@selector(tenBtnMethodUIUIUIUTag:) forControlEvents:UIControlEventTouchUpInside];
            [sub_oneVV addSubview:ten_BBtn];
            
            UIImageView *teImgVV = [HistoryRecordModel createImgImgView];
            teImgVV.frame = CGRectMake(0, 0, 52, 52);
            teImgVV.image = [UIImage imageNamed:[NSString stringWithFormat:@"threeModel_imgs%d", i+1]];
            teImgVV.tag = 2100+i;
            [ten_BBtn addSubview:teImgVV];
            
            NSString *nam_sttt = [NSString stringWithFormat:@"thrModel_nams%d", i+1];
            if ([self.devicTyp isEqualToString:kCharactName15]) {
                nam_sttt = [NSString stringWithFormat:@"thrModel_nams%d_15", i+1];
                teImgVV.image = [UIImage imageNamed:[NSString stringWithFormat:@"threeModel_imgs%d_15", i+1]];
            }
            UILabel *nam_LLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
            nam_LLab.frame = CGRectMake(3, 52, ten_BBtn.width-6, 34);
            nam_LLab.tag = 2200+i;
            nam_LLab.numberOfLines = 3;
            nam_LLab.text = eLocalizedString(nam_sttt);
            [ten_BBtn addSubview:nam_LLab];
            [nam_LLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ten_BBtn.mas_left).offset(3);
                make.top.equalTo(ten_BBtn.mas_top).offset(52);
                make.right.equalTo(ten_BBtn.mas_right).offset(-3);
                make.height.mas_greaterThanOrEqualTo(34);
            }];
        }
        
        if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] && ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11]|| [self.devicTyp isEqualToString:kCharactName16]|| [self.devicTyp isEqualToString:kCharactName17])) {
            
            
            CGFloat ww_lef = _window_width/2.f;
            NSArray *imgsA = @[@"three_imgs10", @"three_imgs11"];
            NSArray *namsA = @[@"thr_nams9", @"thr_nams11"];
            NSArray *tagsA = @[@"0", @"2"];
            for (int i=0; i<namsA.count; i++) {
                
                UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*ww_lef, CGRectGetMaxY(sub_oneVV.frame)+15, ww_lef, 120)];
                selBBtn.tag = 2600+[minStr(tagsA[i]) intValue];
                [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollVVV addSubview:selBBtn];
                
                UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
                hhhImgV.frame = CGRectMake((selBBtn.width-64)/2, 0, 64, 67);
                hhhImgV.image = [UIImage imageNamed:imgsA[i]];
                hhhImgV.tag = 2700+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:hhhImgV];
                
                UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
                nam_LLL.frame = CGRectMake(3, 67, ww_lef-6, 24);
                nam_LLL.text = eLocalizedString(namsA[i]);
                nam_LLL.tag = 2800+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:nam_LLL];
                
                UIImageView *switImgV = [HistoryRecordModel createImgImgView];
                switImgV.frame = CGRectMake((ww_lef-34)/2, 107, 34, 12);
                switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                switImgV.tag = 2900+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:switImgV];
            }
            
            self.scrollVVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(sub_oneVV.frame)+150+50);
            
            
        }else {
            
            //MARK: 电击模式UI
            UILabel *tit_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
            tit_lab2.frame = CGRectMake(20, CGRectGetMaxY(sub_oneVV.frame), _window_width-40, 48);
            tit_lab2.text = [NSString stringWithFormat:@"%@:", eLocalizedString(@"thr_nams7")];
            [self.scrollVVV addSubview:tit_lab2];
            
            UIButton *lefNumBtn2 = [HistoryRecordModel createImgBtn];
            lefNumBtn2.frame = CGRectMake(6, CGRectGetMaxY(tit_lab2.frame), 52, 40);
            lefNumBtn2.tag = 1002;
            [lefNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollVVV addSubview:lefNumBtn2];
            UIImageView *lef_subIII_2 = [HistoryRecordModel createImgImgView];
            lef_subIII_2.frame = CGRectMake(14, 8, 24, 24);
            lef_subIII_2.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
            [lefNumBtn2 addSubview:lef_subIII_2];
            UIImageView *lef_subIII22 = [HistoryRecordModel createImgImgView];
            lef_subIII22.frame = CGRectMake(38, 22, 10, 10);
            lef_subIII22.image = [UIImage imageNamed:@"threeAdMut_imgs2"];
            [lefNumBtn2 addSubview:lef_subIII22];
            
            UIButton *rigNumBtn2 = [HistoryRecordModel createImgBtn];
            rigNumBtn2.frame = CGRectMake(_window_width-58, CGRectGetMaxY(tit_lab2.frame), 52, 40);
            rigNumBtn2.tag = 1003;
            [rigNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollVVV addSubview:rigNumBtn2];
            UIImageView *rig_subIII_2 = [HistoryRecordModel createImgImgView];
            rig_subIII_2.frame = CGRectMake(4, 8, 24, 24);
            rig_subIII_2.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
            [rigNumBtn2 addSubview:rig_subIII_2];
            UIImageView *rig_subIII22 = [HistoryRecordModel createImgImgView];
            rig_subIII22.frame = CGRectMake(28, 22, 10, 10);
            rig_subIII22.image = [UIImage imageNamed:@"threeAdMut_imgs3"];
            [rigNumBtn2 addSubview:rig_subIII22];
            
            self.thrSDMSSliderV_two = [[MHThrSDMSSliderView_one alloc] initWithFrame:CGRectMake(lefNumBtn2.x+lefNumBtn2.width, CGRectGetMaxY(tit_lab2.frame), _window_width-116, 40)];
            [self.scrollVVV addSubview:self.thrSDMSSliderV_two];
            self.thrSDMSSliderV_two.block_ = ^(NSString * _Nonnull oneNum, NSString * _Nonnull twoNum) {
                weakSelf.val_one3 = oneNum;
                
                if (weakSelf.controling_boo) [FloatingWindowModel shareInstance].JingDian_two_strong = [oneNum intValue];
                [weakSelf sendSocketThreeDataMethod];
            };
            self.thrSDMSSliderV_two.twoBlock_ = ^(BOOL isBoo) {
              
                __strong __typeof(self)self = weakSelf;
                
                self.scrollVVV.scrollEnabled = isBoo;
            };
            
            UIView *sub_oneVV2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lefNumBtn2.frame)+28, _window_width-20, 96*2)];
            sub_oneVV2.backgroundColor = UIColor.clearColor;
            [self.scrollVVV addSubview:sub_oneVV2];
            
            for (int i=0; i<10; i++) {
                UIButton *ten_BBtn = [HistoryRecordModel createImgBtn];
                if (i>4) {
                    ten_BBtn.frame = CGRectMake(10+(i-5)*one_fivFF, 96, 52, 96);
                }else {
                    ten_BBtn.frame = CGRectMake(10+i*one_fivFF, 0, 52, 96);
                }
                ten_BBtn.tag = 2300+i;
                [ten_BBtn addTarget:self action:@selector(tenBtnMethodUIUIUIUTag:) forControlEvents:UIControlEventTouchUpInside];
                [sub_oneVV2 addSubview:ten_BBtn];
                
                UIImageView *teImgVV = [HistoryRecordModel createImgImgView];
                teImgVV.frame = CGRectMake(0, 0, 52, 52);
                teImgVV.image = [UIImage imageNamed:[NSString stringWithFormat:@"threeModel2_imgs%d", i+1]];
                teImgVV.tag = 2400+i;
                [ten_BBtn addSubview:teImgVV];
                
                NSString *nam_sttt = [NSString stringWithFormat:@"thrModel2_nams%d", i+1];
                if ([self.devicTyp isEqualToString:kCharactName15]) {
                    teImgVV.image = [UIImage imageNamed:[NSString stringWithFormat:@"threeModel2_imgs%d_15", i+1]];
                }
                UILabel *nam_LLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
                nam_LLab.frame = CGRectMake(3, 52, ten_BBtn.width-6, 34);
                nam_LLab.tag = 2500+i;
                nam_LLab.numberOfLines = 3;
                nam_LLab.text = eLocalizedString(nam_sttt);
                [ten_BBtn addSubview:nam_LLab];
                [nam_LLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ten_BBtn.mas_left).offset(3);
                    make.top.equalTo(ten_BBtn.mas_top).offset(52);
                    make.right.equalTo(ten_BBtn.mas_right).offset(-3);
                    make.height.mas_greaterThanOrEqualTo(34);
                }];
            }
            
            //MARK: 狂暴、旋转、随机
            CGFloat ww_lef = _window_width/2.f;
            NSArray *imgsA = @[@"three_imgs10", @"three_imgs11"];
            NSArray *namsA = @[@"thr_nams9", @"thr_nams11"];
            NSArray *tagsA = @[@"0", @"2"];
            for (int i=0; i<namsA.count; i++) {
                
                UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*ww_lef, CGRectGetMaxY(sub_oneVV2.frame)+15, ww_lef, 120)];
                selBBtn.tag = 2600+[minStr(tagsA[i]) intValue];
                [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollVVV addSubview:selBBtn];
                
                UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
                hhhImgV.frame = CGRectMake((selBBtn.width-64)/2, 0, 64, 67);
                hhhImgV.image = [UIImage imageNamed:imgsA[i]];
                hhhImgV.tag = 2700+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:hhhImgV];
                
                UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
                nam_LLL.frame = CGRectMake(3, 67, ww_lef-6, 24);
                nam_LLL.text = eLocalizedString(namsA[i]);
                nam_LLL.tag = 2800+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:nam_LLL];
                
                UIImageView *switImgV = [HistoryRecordModel createImgImgView];
                switImgV.frame = CGRectMake((ww_lef-34)/2, 107, 34, 12);
                switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                switImgV.tag = 2900+[minStr(tagsA[i]) intValue];
                [selBBtn addSubview:switImgV];
            }
            //    }else {
            //        CGFloat ww_lef = _window_width/3.f;
            //        NSArray *imgsA = @[@"three_imgs10", @"three_imgs7_sel", @"three_imgs11"];
            //        NSArray *namsA = @[@"thr_nams9", @"thr_nams10", @"thr_nams11"];
            //
            //        for (int i=0; i<namsA.count; i++) {
            //
            //            UIButton *selBBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*ww_lef, CGRectGetMaxY(sub_oneVV2.frame)+15, ww_lef, 120)];
            //            selBBtn.tag = 2600+i;
            //            [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            //            [self.scrollVVV addSubview:selBBtn];
            //
            //            UIImageView *hhhImgV = [HistoryRecordModel createImgImgView];
            //            hhhImgV.frame = CGRectMake((selBBtn.width-64)/2, 0, 64, 67);
            //            hhhImgV.image = [UIImage imageNamed:imgsA[i]];
            //            hhhImgV.tag = 2700+i;
            //            [selBBtn addSubview:hhhImgV];
            //
            //            UILabel *nam_LLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
            //            nam_LLL.frame = CGRectMake(3, 67, ww_lef-6, 24);
            //            nam_LLL.text = eLocalizedString(namsA[i]);
            //            nam_LLL.tag = 2800+i;
            //            [selBBtn addSubview:nam_LLL];
            //
            //            UIImageView *switImgV = [HistoryRecordModel createImgImgView];
            //            switImgV.frame = CGRectMake((ww_lef-34)/2, 107, 34, 12);
            //            switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
            //            switImgV.tag = 2900+i;
            //            [selBBtn addSubview:switImgV];
            //        }
            //    }
            
            
            //MARK: 设置随机模式 区间
            
            self.suijiVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sub_oneVV2.frame)+150, _window_width, 106)];
            self.suijiVV.backgroundColor = UIColor.clearColor;
            [self.scrollVVV addSubview:self.suijiVV];
            
            UIButton *lefNumBtn3 = [HistoryRecordModel createImgBtn];
            lefNumBtn3.frame = CGRectMake(6, 0, 52, 40);
            lefNumBtn3.tag = 1004;
            [lefNumBtn3 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.suijiVV addSubview:lefNumBtn3];
            UIImageView *lef_subIII_3 = [HistoryRecordModel createImgImgView];
            lef_subIII_3.frame = CGRectMake(14, 8, 24, 24);
            lef_subIII_3.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
            [lefNumBtn3 addSubview:lef_subIII_3];
            UIImageView *lef_subIII23 = [HistoryRecordModel createImgImgView];
            lef_subIII23.frame = CGRectMake(38, 22, 10, 10);
            lef_subIII23.image = [UIImage imageNamed:@"threeAdMut_imgs2"];
            [lefNumBtn3 addSubview:lef_subIII23];
            
            UIButton *rigNumBtn3 = [HistoryRecordModel createImgBtn];
            rigNumBtn3.frame = CGRectMake(_window_width-58, 0, 52, 40);
            rigNumBtn3.tag = 1005;
            [rigNumBtn3 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.suijiVV addSubview:rigNumBtn3];
            UIImageView *rig_subIII_3 = [HistoryRecordModel createImgImgView];
            rig_subIII_3.frame = CGRectMake(14, 8, 24, 24);
            rig_subIII_3.image = [UIImage imageNamed:@"threeAdMut_imgs4"];
            [rigNumBtn3 addSubview:rig_subIII_3];
            UIImageView *rig_subIII23 = [HistoryRecordModel createImgImgView];
            rig_subIII23.frame = CGRectMake(38, 22, 10, 10);
            rig_subIII23.image = [UIImage imageNamed:@"threeAdMut_imgs3"];
            [rigNumBtn3 addSubview:rig_subIII23];
            
            self.thrSDMSSliderV = [[MHThrSDMSSliderView alloc] initWithFrame:CGRectMake(58, 5, _window_width-116, 30)];
            self.thrSDMSSliderV.typeN = 0;
            [self.suijiVV addSubview:self.thrSDMSSliderV];
            [self.thrSDMSSliderV addLeftStr:0 righStr:100];
            self.thrSDMSSliderV.block_ = ^(NSString * _Nonnull oneNum, NSString * _Nonnull twoNum) {
                __strong __typeof(self)self = weakSelf;
                
                self.val_one8 = oneNum;
                self.val_one9 = twoNum;
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].JingDian_thr_strong = [self.val_one8 intValue];
                    [FloatingWindowModel shareInstance].JingDian_thr_strong2 = [self.val_one9 intValue];
                }
            };
            
            UIButton *sureBBB = [HistoryRecordModel createImgBtn];
            sureBBB.frame = CGRectMake((self.oneVV.width-124)/2, CGRectGetMaxY(lefNumBtn3.frame)+30, 124, 36);
            [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
            [sureBBB setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
            [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            sureBBB.titleLabel.font = SYS_Font(14);
            [sureBBB addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [self.suijiVV addSubview:sureBBB];
            
            self.suijiVV.hidden = YES;
            
            
            self.scrollVVV.contentSize = CGSizeMake(_window_width, self.suijiVV.y+self.suijiVV.height+50);
        }
    }
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq && ([self.devicTyp isEqualToString:kCharactName5]||[self.devicTyp isEqualToString:kCharactName7])) {
        self.controling_boo = YES;
        
        [self selBBtnMethodRecovery];
        [self btnAllBtnMethodTagRecovery];
        [self tenBtnMethodUIUIUIUTag_Recovery];
    }
    
}

- (BOOL)getBooMEthod
{
    if ([minStr(self.val_one2) intValue]>0 || [minStr(self.val_one4) intValue]>0) {
        return YES;
    }else {
        return NO;
    }
}

- (void)uploadUIUIUI
{
    if (!self.val_one1) {
        return;
    }
    if (self.time_Boo2) {
        if (self.time_Boo2_old) {
            
            if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
                return;
            }
            if ([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
                return;
            }
            
            BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            if(isEEEqq) {
                
                
//                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0", @"spinDirection":self.val_one6, @"voltage":@"0", @"electricFrequency":@"0", @"inBerserkMode":@"false", @"inRandomMode":@"false", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0", @"spinDirection":self.val_one6, @"voltage":@"0", @"electricFrequency":@"0", @"inBerserkMode":@"", @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
            }else {
                if(self.isConnDevic) {
                    
//                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0", @"spinDirection":self.val_one6, @"voltage":@"0", @"electricFrequency":@"0", @"inBerserkMode":@"false", @"inRandomMode":@"false", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":@"0", @"shakeFrequency":@"0", @"spinDirection":self.val_one6, @"voltage":@"0", @"electricFrequency":@"0", @"inBerserkMode":@"", @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                }else {
                    if(self.twoBBlock_) {
                        self.twoBBlock_(1);
                    }
                }
            }
        }
    }else {
        
        [self sendSocketThreeDataMethod];
    }
}

- (void)stopMethodUIUIUI
{
    
}

- (void)sendSocketThreeDataMethod
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        return;
    }
    
    if ([self.val_one8 intValue]<=0) {
        self.val_one8 = @"1";
    }
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
//        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":self.val_one5, @"inRandomMode":self.val_one7, @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
        if ([self.val_one5 isEqualToString:@"true"]) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":self.val_one1, @"spinFrequency":self.val_one2, @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":self.val_one5, @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
        }else {
            if ([self.val_one7 isEqualToString:@"true"]) {
                
//                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":self.val_one5, @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":self.val_one1, @"spinFrequency":self.val_one2, @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":@"", @"inRandomMode":self.val_one7, @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
            }else {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":self.val_one1, @"spinFrequency":self.val_one2, @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":@"", @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
            }
        }
    }else {
        if(self.isConnDevic) {
            
//            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":self.val_one5, @"inRandomMode":self.val_one7, @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
            
            if ([self.val_one5 isEqualToString:@"true"]) {
                
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":self.val_one1, @"spinFrequency":self.val_one2, @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":self.val_one5, @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
            }else {
                if ([self.val_one7 isEqualToString:@"true"]) {
                    
    //                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":@"0", @"spinFrequency":@"0", @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":self.val_one5, @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":self.val_one1, @"spinFrequency":self.val_one2, @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":@"", @"inRandomMode":self.val_one7, @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                }else {
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-CLASSIC-MODE-UPLOAD", @"deviceId":self.devicId, @"spinIntensity":self.val_one1, @"spinFrequency":self.val_one2, @"shakeIntensity":self.val_one1, @"shakeFrequency":self.val_one2, @"spinDirection":self.val_one6, @"voltage":self.val_one3, @"electricFrequency":self.val_one4, @"inBerserkMode":@"", @"inRandomMode":@"", @"minVoltage":self.val_one8, @"maxVoltage":self.val_one9}];
                }
            }
            
        }else {
            if(self.twoBBlock_) {
                self.twoBBlock_(1);
            }
        }
    }
    
}


//MARK: 确定随机区间
- (void)sureBtnMethod
{
    if (self.isSuijiBoo) {
        MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vcLocat];
        [vcLocat addTwoNewTextfUIUIMethod:5];
        vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
          
            if (arrList.count>0) {
                
                self.val_one7 = @"true";
                self.thrSDMSSliderV.isboo_boo = YES;
                [self.thrSDMSSliderV uploadMethodtagboo];
                
                self.thrSDMSSliderV_one.isboo_boo = YES;
                [self.thrSDMSSliderV_one uploadMethodtagboo];
                
                self.thrSDMSSliderV_two.isboo_boo = YES;
                [self.thrSDMSSliderV_two uploadMethodtagboo];
                
                if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr = 3;
                
                [self sendSocketThreeDataMethod];
            }
        };
    }else {
        
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_8")];
    }
    
}

//MARK: 狂暴、旋转、随机
- (void)selBBtnMethod:(UIButton *)btn
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    UIButton *selBBtn = [self.scrollVVV viewWithTag:2600];
    UIButton *selBBtn2 = [self.scrollVVV viewWithTag:2601];
    UIButton *selBBtn3 = [self.scrollVVV viewWithTag:2602];
    
    UIImageView *logImgV2 = [selBBtn2 viewWithTag:2701];
    
    UILabel *nam_LLL2 = [selBBtn2 viewWithTag:2801];
    
    UIImageView *switImgV = [selBBtn viewWithTag:2900];
    UIImageView *switImgV2 = [selBBtn2 viewWithTag:2901];
    UIImageView *switImgV3 = [selBBtn3 viewWithTag:2902];
    
    switch (btn.tag) {
        case 2600:
        {
            if (selBBtn3.selected == YES) {
                
               
            }else {
                selBBtn.selected = !selBBtn.selected;
                if (selBBtn.selected == YES) {
                    
                    switImgV.image = [UIImage imageNamed:@"switch_selImg2"];
                    self.val_one5 = @"true";
                    
                    self.thrSDMSSliderV_one.isboo_boo = YES;
                    [self.thrSDMSSliderV_one uploadMethodtagboo];
                    
                    self.thrSDMSSliderV_two.isboo_boo = YES;
                    [self.thrSDMSSliderV_two uploadMethodtagboo];
                    
                    if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr = 1;
                    
                }else {
                    switImgV.image = [UIImage imageNamed:@"switch_norlImg2"];
                    self.val_one5 = @"false";
                    
                    self.thrSDMSSliderV_one.isboo_boo = NO;
                    [self.thrSDMSSliderV_one uploadMethodtagboo];
                    
                    self.thrSDMSSliderV_two.isboo_boo = NO;
                    [self.thrSDMSSliderV_two uploadMethodtagboo];
                    
                    if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr = 0;
                }
            }
        }
            break;
        case 2601:
        {
            btn.selected = !btn.selected;
            
            if (btn.selected == YES) {
                
                logImgV2.image = [UIImage imageNamed:@"three_imgs7_nor"];
                nam_LLL2.text = eLocalizedString(@"thr_nams10_10");
                switImgV2.image = [UIImage imageNamed:@"switch_selImg2"];
                self.val_one6 = @"1";
            }else {
                logImgV2.image = [UIImage imageNamed:@"three_imgs7_sel"];
                nam_LLL2.text = eLocalizedString(@"thr_nams10");
                switImgV2.image = [UIImage imageNamed:@"switch_norlImg2"];
                self.val_one6 = @"2";
            }
        }
            break;
        case 2602:
        {
            if (selBBtn.selected == YES) {
                
                if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr = 1;
            }else {
                selBBtn3.selected = !selBBtn3.selected;
                
                if ([[FloatingWindowModel shareInstance].devicNameArr3 containsObject:self.devicTyp] && ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11]|| [self.devicTyp isEqualToString:kCharactName16]|| [self.devicTyp isEqualToString:kCharactName17])) {
                    
                    if (selBBtn3.selected == YES) {
                        
                        switImgV3.image = [UIImage imageNamed:@"switch_selImg2"];
                        
                        self.val_one7 = @"true";
                        self.thrSDMSSliderV.isboo_boo = YES;
                        [self.thrSDMSSliderV uploadMethodtagboo];
                        
                        self.thrSDMSSliderV_one.isboo_boo = YES;
                        [self.thrSDMSSliderV_one uploadMethodtagboo];
                        
                        self.thrSDMSSliderV_two.isboo_boo = YES;
                        [self.thrSDMSSliderV_two uploadMethodtagboo];
                        
                    }else {
                        switImgV3.image = [UIImage imageNamed:@"switch_norlImg2"];
                        self.val_one7 = @"false";
                        
                        self.thrSDMSSliderV.isboo_boo = NO;
                        [self.thrSDMSSliderV uploadMethodtagboo];
                        
                        self.thrSDMSSliderV_one.isboo_boo = NO;
                        [self.thrSDMSSliderV_one uploadMethodtagboo];
                        
                        self.thrSDMSSliderV_two.isboo_boo = NO;
                        [self.thrSDMSSliderV_two uploadMethodtagboo];
                    }
                    
                    
                }else {
                    
                    if (selBBtn3.selected == YES) {
                        
                        switImgV3.image = [UIImage imageNamed:@"switch_selImg2"];
                    }else {
                        switImgV3.image = [UIImage imageNamed:@"switch_norlImg2"];
                        self.val_one7 = @"false";
                        
                        self.thrSDMSSliderV.isboo_boo = NO;
                        [self.thrSDMSSliderV uploadMethodtagboo];
                        
                        self.thrSDMSSliderV_one.isboo_boo = NO;
                        [self.thrSDMSSliderV_one uploadMethodtagboo];
                        
                        self.thrSDMSSliderV_two.isboo_boo = NO;
                        [self.thrSDMSSliderV_two uploadMethodtagboo];
                        
                        if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr = 0;
                    }
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    if ([self.devicTyp isEqualToString:kCharactName8]||[self.devicTyp isEqualToString:kCharactName9] || [self.devicTyp isEqualToString:kCharactName10] || [self.devicTyp isEqualToString:kCharactName11]|| [self.devicTyp isEqualToString:kCharactName16]|| [self.devicTyp isEqualToString:kCharactName17]) {
        
    }else {
        self.isSuijiBoo = selBBtn3.selected;
        self.suijiVV.hidden = !selBBtn3.selected;
    }
    
    if (self.controling_boo && ([self.devicTyp isEqualToString:kCharactName5]||[self.devicTyp isEqualToString:kCharactName7])) {
        if (self.device7Block_) {
            self.device7Block_(1);
        }
    }
    
    [self sendSocketThreeDataMethod];
}

//MARK: 强度 加 减
- (void)btnAllBtnMethodTag:(UIButton *)btn
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    if (self.thrSDMSSliderV.isboo_boo || self.thrSDMSSliderV_one.isboo_boo) {
        return;
    }
    switch (btn.tag) {
        case 1000:
        {
            if (self.thrSDMSSliderV_one.isboo_boo) {
                return;
            }
            int www = [self.val_one1 intValue];
            if (www <= 10) {
                www = 0;
            }else {
                www = www-10;
            }
            [self.thrSDMSSliderV_one addLeftStr:www];
            self.val_one1 = minIntStr(www);
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_one_strong = www;
        }
            break;
        case 1001:
        {
            if (self.thrSDMSSliderV_one.isboo_boo) {
                return;
            }
            int www = [self.val_one1 intValue];
            if (www >= 90) {
                www = 100;
            }else {
                www = www+10;
            }
            [self.thrSDMSSliderV_one addLeftStr:www];
            self.val_one1 = minIntStr(www);
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_one_strong = www;
        }
            break;
        case 1002:
        {
            if (self.thrSDMSSliderV_two.isboo_boo) {
                return;
            }
            int www = [self.val_one3 intValue];
            if (www <= 10) {
                www = 0;
            }else {
                www = www-10;
            }
            [self.thrSDMSSliderV_two addLeftStr:www];
            self.val_one3 = minIntStr(www);
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_two_strong = www;
        }
            break;
        case 1003:
        {
            if (self.thrSDMSSliderV_two.isboo_boo) {
                return;
            }
            int www = [self.val_one3 intValue];
            if (www >= 90) {
                www = 100;
            }else {
                www = www+10;
            }
            [self.thrSDMSSliderV_two addLeftStr:www];
            self.val_one3 = minIntStr(www);
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_two_strong = www;
        }
            break;
        case 1004:
        {
            if (self.thrSDMSSliderV.isboo_boo) {
                return;
            }
            int www = [self.val_one8 intValue];
            if (www <= 10) {
                www = 0;
            }else {
                www = www-10;
            }
            [self.thrSDMSSliderV addLeftStr:www righStr:[self.val_one9 intValue]];
            self.val_one8 = minIntStr(www);
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr_strong = www;
        }
            break;
        case 1005:
        {
//            if (self.thrSDMSSliderV.isboo_boo) {
//                return;
//            }
            int www = [self.val_one9 intValue];
            if (www >= 90) {
                www = 100;
            }else {
                www = www+10;
            }
            [self.thrSDMSSliderV addLeftStr:[self.val_one8 intValue] righStr:www];
            self.val_one9 = minIntStr(www);
            
            if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_thr_strong2 = www;
        }
            break;
            
        default:
            break;
    }
    
    [self sendSocketThreeDataMethod];
}

//MARK: 模式-选择
- (void)tenBtnMethodUIUIUIUTag:(UIButton *)btn
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    if (self.thrSDMSSliderV_one.isboo_boo || self.thrSDMSSliderV.isboo_boo) {
        return;
    }
    if (btn.tag < 2100) {

        for (int i=0; i<10; i++) {
            
            UIButton *ten_BBtn = [self.scrollVVV viewWithTag:2000+i];
            UILabel *nam_LLab = [self.scrollVVV viewWithTag:2200+i];
            
            if (ten_BBtn == btn) {
                ten_BBtn.selected = !ten_BBtn.selected;
                if (ten_BBtn.selected == YES) {
       
                    nam_LLab.textColor = normalColors;
                    self.val_one2 = minIntStr(i+1);
                    if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_one_model = i+1;
                }else {
                    nam_LLab.textColor = UIColor.whiteColor;
                    self.val_one2 = @"0";
                    
                    if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_one_model = 0;
                }
            }else {
                ten_BBtn.selected = NO;
                nam_LLab.textColor = UIColor.whiteColor;
            }
        }
    }else {

        for (int i=0; i<10; i++) {
            
            UIButton *ten_BBtn = [self.scrollVVV viewWithTag:2300+i];
            UILabel *nam_LLab = [self.scrollVVV viewWithTag:2500+i];
            
            if (ten_BBtn == btn) {
                ten_BBtn.selected = !ten_BBtn.selected;
                if (ten_BBtn.selected == YES) {
 
                    nam_LLab.textColor = normalColors;
                    self.val_one4 = minIntStr(i+1);
                    
                    if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_two_model = i+1;
                }else {
                    nam_LLab.textColor = UIColor.whiteColor;
                    self.val_one4 = @"0";
                    
                    if (self.controling_boo) [FloatingWindowModel shareInstance].JingDian_two_model = 0;
                }
            }else {
                ten_BBtn.selected = NO;
                nam_LLab.textColor = UIColor.whiteColor;
            }
        }
    }
    
    if (self.controling_boo && ([self.devicTyp isEqualToString:kCharactName5]||[self.devicTyp isEqualToString:kCharactName7])) {
        if (self.device7Block_) {
            self.device7Block_(1);
        }
    }
    
    [self sendSocketThreeDataMethod];
    
}

//MARK: 设备5、7  恢复控制 - UI
- (void)tenBtnMethodUIUIUIUTag_Recovery
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
//        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        return;
    }
    
    if (self.thrSDMSSliderV_one.isboo_boo || self.thrSDMSSliderV.isboo_boo) {
        return;
    }
    
    if ([FloatingWindowModel shareInstance].JingDian_one_model > 0) {
        UIButton *ten_BBtn = [self.scrollVVV viewWithTag:2000+[FloatingWindowModel shareInstance].JingDian_one_model-1];
        UILabel *nam_LLab = [self.scrollVVV viewWithTag:2200+[FloatingWindowModel shareInstance].JingDian_one_model-1];
        ten_BBtn.selected = YES;
        nam_LLab.textColor = normalColors;
        self.val_one2 = minIntStr([FloatingWindowModel shareInstance].JingDian_one_model);
    }
    
    if ([FloatingWindowModel shareInstance].JingDian_two_model > 0) {
        UIButton *ten_BBtn = [self.scrollVVV viewWithTag:2300+[FloatingWindowModel shareInstance].JingDian_two_model-1];
        UILabel *nam_LLab = [self.scrollVVV viewWithTag:2500+[FloatingWindowModel shareInstance].JingDian_two_model-1];
        ten_BBtn.selected = YES;
        nam_LLab.textColor = normalColors;
        self.val_one4 = minIntStr([FloatingWindowModel shareInstance].JingDian_one_model);
    }
    
    if (self.controling_boo && ([self.devicTyp isEqualToString:kCharactName5]||[self.devicTyp isEqualToString:kCharactName7])) {
        if (self.device7Block_) {
            self.device7Block_(1);
        }
    }
    
}


- (void)btnAllBtnMethodTagRecovery
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
//        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        return;
    }
    
    if (self.thrSDMSSliderV.isboo_boo || self.thrSDMSSliderV_one.isboo_boo) {
        return;
    }
    
    if ([FloatingWindowModel shareInstance].JingDian_one_strong>0) {
        
        [self.thrSDMSSliderV_one addLeftStr:[FloatingWindowModel shareInstance].JingDian_one_strong];
        self.val_one1 = minIntStr([FloatingWindowModel shareInstance].JingDian_one_strong);
    }
    
    if ([FloatingWindowModel shareInstance].JingDian_two_strong>0) {
        
        [self.thrSDMSSliderV_two addLeftStr:[FloatingWindowModel shareInstance].JingDian_two_strong];
        self.val_one3 = minIntStr([FloatingWindowModel shareInstance].JingDian_two_strong);
    }
    
    if ([FloatingWindowModel shareInstance].JingDian_thr_strong2>0) {
        
        self.val_one8 = minIntStr([FloatingWindowModel shareInstance].JingDian_thr_strong);
        self.val_one9 = minIntStr([FloatingWindowModel shareInstance].JingDian_thr_strong2);
        [self.thrSDMSSliderV addLeftStr:[self.val_one8 intValue] righStr:[self.val_one9 intValue]];
    }
    
  
}

- (void)selBBtnMethodRecovery
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
//        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        return;
    }
    
    UIButton *selBBtn = [self.scrollVVV viewWithTag:2600];
//    UIButton *selBBtn2 = [self.scrollVVV viewWithTag:2601];
    UIButton *selBBtn3 = [self.scrollVVV viewWithTag:2602];
    
    UIImageView *switImgV = [selBBtn viewWithTag:2900];
    UIImageView *switImgV3 = [selBBtn3 viewWithTag:2902];
    
    if ([FloatingWindowModel shareInstance].JingDian_thr>0) {
        
        switch ([FloatingWindowModel shareInstance].JingDian_thr) {
            case 1:
            {
                selBBtn.selected = YES;
                    
                switImgV.image = [UIImage imageNamed:@"switch_selImg2"];
                self.val_one5 = @"true";
                
                self.thrSDMSSliderV_one.isboo_boo = YES;
                [self.thrSDMSSliderV_one uploadMethodtagboo];
                
                self.thrSDMSSliderV_two.isboo_boo = YES;
                [self.thrSDMSSliderV_two uploadMethodtagboo];
                    
            }
                break;
            case 3:
            {
                selBBtn3.selected = YES;
                switImgV3.image = [UIImage imageNamed:@"switch_selImg2"];
                
                self.isSuijiBoo = selBBtn3.selected;
                self.suijiVV.hidden = !selBBtn3.selected;
                
                self.val_one7 = @"true";
                self.thrSDMSSliderV.isboo_boo = YES;
                [self.thrSDMSSliderV uploadMethodtagboo];

                self.thrSDMSSliderV_one.isboo_boo = YES;
                [self.thrSDMSSliderV_one uploadMethodtagboo];

                self.thrSDMSSliderV_two.isboo_boo = YES;
                [self.thrSDMSSliderV_two uploadMethodtagboo];
            }
                break;
                
            default:
                break;
        }
    }
    
}



/***
 
 恢复原有指令
 */
- (void)recoveryControlMethodZL
{
    [self sendSocketThreeDataMethod];
    
}


@end
