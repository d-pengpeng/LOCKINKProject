//
//  MHfindChooseView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import "MHfindChooseView.h"
#import "MHfindChooseSliderView.h"
#import <BRStringPickerView.h>

@interface MHfindChooseView ()

@property (nonatomic, strong) MHfindChooseSliderView *findChooseSliderV;
@property (nonatomic, copy) NSString *oneStr1;
@property (nonatomic, assign) int oneStr2;
@property (nonatomic, assign) int oneStr3;
@property (nonatomic, copy) NSString *oneStr4;
@property (nonatomic, copy) NSString *oneStr5;
@property (nonatomic, copy) NSString *oneStr6;
@property (nonatomic, copy) NSString *oneStr7;
@property (nonatomic, copy) NSString *oneStr8;
@property (nonatomic, strong) NSMutableArray *fouMut;
@property (nonatomic, strong) UIScrollView *scrolVVTwo;
@property (nonatomic, strong) UIButton *btn_btn;
@property (nonatomic, strong) UIButton *btn_btn2;
@end
@implementation MHfindChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.oneStr1 = @"1";
        self.oneStr2 = 18;
        self.oneStr3 = 70;
        self.oneStr4 = @"";
        self.oneStr5 = @"";
        self.oneStr6 = @"";
        self.oneStr7 = @"0";
        self.oneStr8 = @"";
        
        self.fouMut = [NSMutableArray array];
        
        UIButton *deletbn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deletbn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deletbn addTarget:self action:@selector(deleBtnMehtod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletbn];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(_window_width/2-165, _window_height/2-210, 330, 420);
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
        self.scrolVVTwo = scrolVV;
        
        scrolVV.contentSize = CGSizeMake(330-75, 562+176);
        
        NSArray *listAr = @[@"find_choose1", @"login_all31", @"find_detail1", @"login_all34", @"login_all35", @"login_all36", @"tabbar_tit1"];
        
        NSArray *listAr2 = @[@"0", @"72", @"150", @"262", @"374", @"486", @"562"];
        
        for (int i=0; i<listAr.count; i++) {
            
            UILabel *allLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
            allLab.frame = CGRectMake(0, [listAr2[i] intValue], scrolVV.width, 36);
            allLab.text = eLocalizedString(listAr[i]);
            [scrolVV addSubview:allLab];
            
            switch (i) {
                case 0:
                {
                    NSArray *one_ar1 = @[@"center_all12", @"find_choose2", @"find_choose3"];
                    for (int j=0; j<one_ar1.count; j++) {
                        
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(j*(76+13), CGRectGetMaxY(allLab.frame)+2, 76, 30);
                        [btn_btn setTitle:eLocalizedString(one_ar1[j]) forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = UIColor.clearColor;
                        btn_btn.layer.cornerRadius = 4;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        btn_btn.layer.borderColor = normalColors.CGColor;
                        btn_btn.layer.borderWidth = 1;
                        btn_btn.tag = 8100+j;
                        [btn_btn addTarget:self action:@selector(btnMethodAllsOne:) forControlEvents:UIControlEventTouchUpInside];
                        [scrolVV addSubview:btn_btn];
                        if(j==0) {
                            btn_btn.backgroundColor = normalColors;
                        }
                    }
                }
                    break;
                case 1:
                {
                    self.findChooseSliderV = [[MHfindChooseSliderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(allLab.frame)+12, scrolVV.width, 30)];
                    [scrolVV addSubview:self.findChooseSliderV];
                    
                }
                    break;
                case 2:
                {
                    NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
                    CGFloat w_ww = 76+13;
                    for (int j=0; j<oneMM.count; j++) {
                        
                        int x_w = j%3;
                        int y_w = j/3;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-13, 30);
                        [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = UIColor.clearColor;
                        btn_btn.layer.cornerRadius = 4;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        btn_btn.layer.borderColor = normalColors.CGColor;
                        btn_btn.layer.borderWidth = 1;
                        btn_btn.tag = 8200+j;
                        [btn_btn addTarget:self action:@selector(btnMethodAllsTwo:) forControlEvents:UIControlEventTouchUpInside];
                        [scrolVV addSubview:btn_btn];
                        if(j==0) {
                            btn_btn.backgroundColor = normalColors;
                        }
                    }
                }
                    break;
                case 3:
                {
                    NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"BIS", @"HETERO", @"GAY", @"LES"];
                    CGFloat w_ww = 76+13;
                    for (int j=0; j<oneMM.count; j++) {
                        
                        int x_w = j%3;
                        int y_w = j/3;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-13, 30);
                        [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = UIColor.clearColor;
                        btn_btn.layer.cornerRadius = 4;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        btn_btn.layer.borderColor = normalColors.CGColor;
                        btn_btn.layer.borderWidth = 1;
                        btn_btn.tag = 8300+j;
                        [btn_btn addTarget:self action:@selector(btnMethodAllsThr:) forControlEvents:UIControlEventTouchUpInside];
                        [scrolVV addSubview:btn_btn];
                        if(j==0) {
                            btn_btn.backgroundColor = normalColors;
                        }
                    }
                }
                    break;
                case 4:
                {
                    NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
                    CGFloat w_ww = 76+13;
                    for (int j=0; j<oneMM.count; j++) {
                        
                        int x_w = j%3;
                        int y_w = j/3;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-13, 30);
                        [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = UIColor.clearColor;
                        btn_btn.layer.cornerRadius = 4;
                        btn_btn.titleLabel.font = SYS_Font(14);
                        btn_btn.layer.borderColor = normalColors.CGColor;
                        btn_btn.layer.borderWidth = 1;
                        btn_btn.tag = 8400+j;
                        [btn_btn addTarget:self action:@selector(btnMethodAllsFou:) forControlEvents:UIControlEventTouchUpInside];
                        [scrolVV addSubview:btn_btn];
//                        [self.fouMut addObject:btn_btn];
                        if(j==0) {
                            btn_btn.backgroundColor = normalColors;
                        }
                    }
                }
                    break;
                case 5:
                {
                    
                    UIImageView *mmm = [[UIImageView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(allLab.frame)+2, scrolVV.width, 32)];
                    mmm.backgroundColor = RGBA(176, 51, 228, 0.50);
                    mmm.layer.cornerRadius = 4;
                    mmm.clipsToBounds = YES;
                    [scrolVV addSubview:mmm];
                    
                    UIButton *oneBB = [HistoryRecordModel createImgBtn];
                    oneBB.frame = CGRectMake(0, CGRectGetMaxY(allLab.frame)+2, scrolVV.width, 32);
                    oneBB.backgroundColor = UIColor.clearColor;
                    oneBB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    oneBB.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                    [oneBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    oneBB.titleLabel.font = SYS_Font(14);
                    [oneBB setTitle:eLocalizedString(@"center_all12") forState:UIControlStateNormal];
                    [oneBB setImage:[UIImage imageNamed:@"home_next2"] forState:UIControlStateNormal];
                    oneBB.imageEdgeInsets = UIEdgeInsetsMake(9, scrolVV.width-24, 9, 10);
                    oneBB.imageView.clipsToBounds = YES;
                    oneBB.tag = 8500;
                    [oneBB addTarget:self action:@selector(chooseCountriesMehtod:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:oneBB];
                }
                    break;
                case 6:
                {
                    NSArray *oneMM = @[eLocalizedString(@"center_all12")];
                    CGFloat w_ww = 76+13;
                    for (int j=0; j<oneMM.count; j++) {
                        
                        int x_w = j%3;
                        int y_w = j/3;
                        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                        btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-13, 30);
                        [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                        btn_btn.backgroundColor = UIColor.clearColor;
                        btn_btn.layer.cornerRadius = 4;
                        btn_btn.titleLabel.font = SYS_Font(12);
                        btn_btn.layer.borderColor = normalColors.CGColor;
                        btn_btn.layer.borderWidth = 1;
                        btn_btn.titleLabel.numberOfLines = 2;
                        btn_btn.tag = 8600+j;
                        [btn_btn addTarget:self action:@selector(btnMethodAllsSix:) forControlEvents:UIControlEventTouchUpInside];
                        [scrolVV addSubview:btn_btn];
                        if(j==0) {
                            btn_btn.backgroundColor = normalColors;
                        }
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        _btn_btn = [HistoryRecordModel createImgBtn];
        _btn_btn.frame = CGRectMake(26, 684, 92, 36);
        [_btn_btn setTitle:eLocalizedString(@"home_reset") forState:UIControlStateNormal];
        [_btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btn_btn.backgroundColor = UIColor.clearColor;
        _btn_btn.layer.cornerRadius = 6;
        _btn_btn.titleLabel.font = SYS_Font(14);
        _btn_btn.layer.borderColor = normalColors.CGColor;
        _btn_btn.layer.borderWidth = 1;
        [_btn_btn addTarget:self action:@selector(retoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [scrolVV addSubview:_btn_btn];
        
        _btn_btn2 = [HistoryRecordModel createImgBtn];
        _btn_btn2.frame = CGRectMake(26+112, 684, 92, 36);
        [_btn_btn2 setTitle:eLocalizedString(@"home_ok") forState:UIControlStateNormal];
        [_btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btn_btn2.backgroundColor = normalColors;
        _btn_btn2.layer.cornerRadius = 6;
        _btn_btn2.titleLabel.font = SYS_Font(14);
        [_btn_btn2 addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [scrolVV addSubview:_btn_btn2];
        
    }
    return self;
}

- (void)addUIUIU
{
    self.oneStr1 = self.arrFind[0];
    self.oneStr2 = [self.arrFind[1] intValue];
    self.oneStr3 = [self.arrFind[2] intValue];
    self.oneStr4 = self.arrFind[3];
    self.oneStr5 = self.arrFind[4];
    self.oneStr6 = self.arrFind[5];
    self.oneStr7 = self.arrFind[6];
    self.oneStr8 = self.arrFind[7];
    
    UIButton *oneBB = [self viewWithTag:8500];
    if([self.oneStr7 intValue] > 0) {
        
        for (NSDictionary *dicM in [LYUserDefault userDefault].countries_Arr) {
            if([minStr(dicM[@"id"]) isEqualToString:self.oneStr7]) {
                [oneBB setTitle:minStr(dicM[@"name"]) forState:UIControlStateNormal];
            }
        }
    }else {
        [oneBB setTitle:eLocalizedString(@"center_all12") forState:UIControlStateNormal];
    }
    
    
    for (int i=0; i<3; i++) {
        UIButton *btnAll = [self viewWithTag:8100+i];
        if(i == [self.oneStr1 intValue]-1) {
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    NSArray *oneMM = @[@"", @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    NSArray *onemm_ar = [self.oneStr4 componentsSeparatedByString:@","];
    for (int i=0; i<6; i++) {
        UIButton *btnAll = [self viewWithTag:8200+i];
        if([onemm_ar containsObject:oneMM[i]]) {
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    NSArray *oneMM3 = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
    NSArray *oneMM3_ar = [self.oneStr5 componentsSeparatedByString:@","];
    for (int i=0; i<oneMM3.count; i++) {
        UIButton *btnAll = [self viewWithTag:8300+i];
        if([oneMM3_ar containsObject:oneMM3[i]]) {
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    NSArray *oneAr4 = @[@"", @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
    NSArray *sub_arr = [self.oneStr6 componentsSeparatedByString:@","];
    for (int i=0; i<self.fouMut.count; i++) {
        UIButton *btnAll = self.fouMut[i];
        
        if([sub_arr containsObject:oneAr4[i]]) {
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    if(self.arrFind2.count > 5) {
        
        int num_num = (int)self.arrFind2.count-5;
        int x_w = num_num%3;
        int y_w = num_num/3;
        
        int num_num2 = 1;
        if(x_w > 0) {
            num_num2 = y_w+1;
        }else {
            num_num2 = y_w;
        }
        self.scrolVVTwo.contentSize = CGSizeMake(330-75, 562+176+num_num2*38);
        
        _btn_btn.frame = CGRectMake(26, 684+num_num2*38, 92, 36);
        
        _btn_btn2.frame = CGRectMake(26+112, 684+num_num2*38, 92, 36);
    }
    
    CGFloat w_ww = 76+13;
    NSArray *lis_Ar8 = [self.oneStr8 componentsSeparatedByString:@","];
    if(![self.oneStr8 isEqualToString:@""]) {
        UIButton *btn_btn8 = [self.scrolVVTwo viewWithTag:8600];
        btn_btn8.backgroundColor = UIColor.clearColor;
    }
    for (int j=0; j<self.arrFind2.count; j++) {
        
        NSDictionary *dicMM = self.arrFind2[j];
        int x_w = (j+1)%3;
        int y_w = (j+1)/3;
        UIButton *btn_btn = [HistoryRecordModel createImgBtn];
        btn_btn.frame = CGRectMake(w_ww*x_w, 562+36+2+y_w*38, w_ww-13, 30);
        [btn_btn setTitle:minStr(dicMM[@"model"]) forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        btn_btn.backgroundColor = UIColor.clearColor;
        btn_btn.layer.cornerRadius = 4;
        btn_btn.titleLabel.font = SYS_Font(12);
        btn_btn.layer.borderColor = normalColors.CGColor;
        btn_btn.layer.borderWidth = 1;
        btn_btn.titleLabel.numberOfLines = 2;
        btn_btn.tag = 8600+j+1;
        [btn_btn addTarget:self action:@selector(btnMethodAllsSix:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrolVVTwo addSubview:btn_btn];
        if([lis_Ar8 containsObject:minStr(dicMM[@"id"])]) {
            btn_btn.backgroundColor = normalColors;
        }
    }
    
    [self.findChooseSliderV addLeftStr:self.oneStr2-18 righStr:self.oneStr3-18];
    
}

//MARK: 重置
- (void)retoreBtnMethod
{
    UIButton *oneBB = [self viewWithTag:8500];
    [oneBB setTitle:eLocalizedString(@"center_all12") forState:UIControlStateNormal];
    self.oneStr7 = @"0";
    
    for (int i=0; i<3; i++) {
        UIButton *btnAll = [self viewWithTag:8100+i];
        if(i == 0) {
            self.oneStr1 = minIntStr(i+1);
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    for (int i=0; i<6; i++) {
        UIButton *btnAll = [self viewWithTag:8200+i];
        if(i == 0) {
            self.oneStr4 = @"";
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    for (int i=0; i<self.arrFind2.count+1; i++) {
        UIButton *btnAll = [self viewWithTag:8600+i];
        if(i == 0) {
            self.oneStr8 = @"";
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    NSArray *oneMM3 = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
    for (int i=0; i<oneMM3.count; i++) {
        UIButton *btnAll = [self viewWithTag:8300+i];
        if(i == 0) {
            self.oneStr5 = @"";
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
    
    NSArray *oneAr4 = @[@"", @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
    for (int i=0; i<oneAr4.count; i++) {
        UIButton *btnAll = [self viewWithTag:8400+i];
        
        if(i == 0) {
            self.oneStr6 = oneAr4[i];
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
}

- (void)sureBtnMethod
{
    NSArray *arLis = [self.findChooseSliderV getStartToEnd];
    
    self.oneStr2 = [arLis[0] intValue];
    self.oneStr3 = [arLis[1] intValue];
    if(self.block_) {
        self.block_(@[self.oneStr1, minStr(arLis[0]), minStr(arLis[1]), self.oneStr4, self.oneStr5, self.oneStr6, self.oneStr7, self.oneStr8]);
    }
    [self removeFromSuperview];
}

- (void)chooseCountriesMehtod:(UIButton *)btn
{
    if([LYUserDefault userDefault].countries_Arr.count>0) {
        
        NSMutableArray *namsArr = [NSMutableArray array];
        [namsArr addObject:eLocalizedString(@"center_all12")];
        for (NSDictionary *dicM in [LYUserDefault userDefault].countries_Arr) {
            [namsArr addObject:minStr(dicM[@"name"])];
        }
        
        BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
        stringPickerView.pickerMode = BRStringPickerComponentSingle;
        stringPickerView.title = eLocalizedString(@"login_all36");
        stringPickerView.dataSourceArr = namsArr;
        stringPickerView.selectIndex = 0;
        stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
            NSLog(@"选择的值：%@", resultModel.value);
            [btn setTitle:resultModel.value forState:UIControlStateNormal];
            if(resultModel.index == 0) {
                self.oneStr7 = @"0";
            }else {
                NSDictionary *dicM = [LYUserDefault userDefault].countries_Arr[resultModel.index];
                self.oneStr7 = minStr(dicM[@"id"]);
            }
        };
        [stringPickerView show];
    }else {
        
    }
}

- (void)btnMethodAllsOne:(UIButton *)btn
{
//    8100
    for (int i=0; i<3; i++) {
        UIButton *btnAll = [self viewWithTag:8100+i];
        if(btnAll == btn) {
            self.oneStr1 = minIntStr(i+1);
            btnAll.backgroundColor = normalColors;
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = UIColor.clearColor;
            btnAll.selected = NO;
        }
    }
}

- (void)btnMethodAllsTwo:(UIButton *)btn
{
//    8200
    NSArray *oneMM = @[@"", @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];

    BOOL isBB = NO;
    for (int i=0; i<oneMM.count; i++) {
        if(i==0) {
            UIButton *btnAll = [self.scrolVVTwo viewWithTag:8200+i];
            if(btnAll == btn) {
                NSLog(@"----%ld--%ld", btnAll.tag, (long)btn.tag);
                self.oneStr4 = oneMM[i];
                btnAll.backgroundColor = normalColors;
                btnAll.selected = YES;
                isBB = YES;
            }else {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }
        }else {
            UIButton *btnAll = [self.scrolVVTwo viewWithTag:8200+i];
            if(isBB) {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }else {
                NSArray *dic_list = [self.oneStr4 componentsSeparatedByString:@","];
                NSString *dic_dic = oneMM[i];
                if(btnAll == btn) {

                    NSString *str_len8 = @"";
                    
                    btnAll.selected = !btnAll.selected;
                    if(btnAll.selected) {
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
       
                        str_len8 = self.oneStr4.length>0 ? [NSString stringWithFormat:@"%@,%@", self.oneStr4, dic_dic]:minStr(dic_dic);
                    }else {
                        btnAll.backgroundColor = UIColor.clearColor;
                        btnAll.selected = NO;
                        for (int j=0; j<dic_list.count; j++) {
                            if(![minStr(dic_list[j]) isEqualToString:dic_dic]) {
                                if(str_len8.length>0) {
                                    
                                    str_len8 = [NSString stringWithFormat:@"%@,%@", str_len8, minStr(dic_list[j])];
                                }else {
                                    str_len8 = minStr(dic_list[j]);
                                }
                            }
                        }
                    }
                    self.oneStr4 = str_len8;
                    
                    if(self.oneStr4.length<=0) {
                        UIButton *btnAll = [self viewWithTag:8200];
                        self.oneStr4 = @"";
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                    }
                }
            }
        }
    }
}

- (void)btnMethodAllsSix:(UIButton *)btn
{
    BOOL isBB = NO;
    for (int i=0; i<self.arrFind2.count+1; i++) {
        UIButton *btnAll = [self viewWithTag:8600+i];
        if(i==0) {
            if(btnAll == btn) {
                self.oneStr8 = @"";
                btnAll.backgroundColor = normalColors;
                btnAll.selected = YES;
                isBB = YES;
            }else {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }
        }else {
            if(isBB) {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }else {
                NSArray *dic_list = [self.oneStr8 componentsSeparatedByString:@","];
                NSDictionary *dic_dic = self.arrFind2[i-1];
                if(btnAll == btn) {
                    NSString *str_len8 = @"";
                    
                    btnAll.selected = !btnAll.selected;
                    if(btnAll.selected) {
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                        
                        str_len8 = self.oneStr8.length>0 ? [NSString stringWithFormat:@"%@,%@", self.oneStr8, minStr(dic_dic[@"id"])]:minStr(minStr(dic_dic[@"id"]));
                    }else {
                        btnAll.backgroundColor = UIColor.clearColor;
                        btnAll.selected = NO;
                        for (int j=0; j<dic_list.count; j++) {
                            if(![minStr(dic_list[j]) isEqualToString:minStr(dic_dic[@"id"])]) {
                                if(str_len8.length>0) {
                                    
                                    str_len8 = [NSString stringWithFormat:@"%@,%@", str_len8, minStr(dic_list[j])];
                                }else {
                                    str_len8 = minStr(dic_list[j]);
                                }
                            }
                        }
                    }
                    self.oneStr8 = str_len8;
                    
                    if(self.oneStr8.length<=0) {
                        UIButton *btnAll = [self viewWithTag:8600];
                        self.oneStr8 = @"";
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                    }
                }
            }
        }
    }
}

- (void)btnMethodAllsThr:(UIButton *)btn
{
//    8300
    NSArray *oneMM = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
    
    BOOL isBB = NO;
    for (int i=0; i<oneMM.count; i++) {
        UIButton *btnAll = [self viewWithTag:8300+i];
        
        if(i==0) {
            if(btnAll == btn) {
                self.oneStr5 = oneMM[i];
                btnAll.backgroundColor = normalColors;
                btnAll.selected = YES;
                isBB = YES;
            }else {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }
        }else {
            if(isBB) {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }else {
                NSArray *dic_list = [self.oneStr5 componentsSeparatedByString:@","];
                NSString *dic_dic = oneMM[i];
                if(btnAll == btn) {
                    NSString *str_len8 = @"";
                    
                    btnAll.selected = !btnAll.selected;
                    if(btnAll.selected) {
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                        
                        str_len8 = self.oneStr5.length>0 ? [NSString stringWithFormat:@"%@,%@", self.oneStr5, dic_dic]:minStr(dic_dic);
                    }else {
                        btnAll.backgroundColor = UIColor.clearColor;
                        btnAll.selected = NO;
                        for (int j=0; j<dic_list.count; j++) {
                            if(![minStr(dic_list[j]) isEqualToString:dic_dic]) {
                                if(str_len8.length>0) {
                                    
                                    str_len8 = [NSString stringWithFormat:@"%@,%@", str_len8, minStr(dic_list[j])];
                                }else {
                                    str_len8 = minStr(dic_list[j]);
                                }
                            }
                        }
                    }
                    self.oneStr5 = str_len8;
                    if(self.oneStr5.length<=0) {
                        UIButton *btnAll = [self viewWithTag:8300];
                        self.oneStr5 = @"";
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                    }
                }
            }
        }
    }
}

- (void)btnMethodAllsFou:(UIButton *)btn
{
    NSArray *oneAr4 = @[@"", @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
    
    BOOL isBB = NO;
    for (int i=0; i<oneAr4.count; i++) {
        UIButton *btnAll = [self viewWithTag:8400+i];
        if(i==0) {
            if(btnAll == btn) {
                self.oneStr6 = oneAr4[i];
                btnAll.backgroundColor = normalColors;
                btnAll.selected = YES;
                isBB = YES;
            }else {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }
        }else {
            if(isBB) {
                btnAll.backgroundColor = UIColor.clearColor;
                btnAll.selected = NO;
            }else {
                NSArray *dic_list = [self.oneStr6 componentsSeparatedByString:@","];
                NSString *dic_dic = oneAr4[i];
                if(btnAll == btn) {
                    NSString *str_len8 = @"";
                    
                    btnAll.selected = !btnAll.selected;
                    if(btnAll.selected) {
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                        
                        str_len8 = self.oneStr6.length>0 ? [NSString stringWithFormat:@"%@,%@", self.oneStr6, dic_dic]:minStr(dic_dic);
                    }else {
                        btnAll.backgroundColor = UIColor.clearColor;
                        btnAll.selected = NO;
                        for (int j=0; j<dic_list.count; j++) {
                            if(![minStr(dic_list[j]) isEqualToString:dic_dic]) {
                                if(str_len8.length>0) {
                                    
                                    str_len8 = [NSString stringWithFormat:@"%@,%@", str_len8, minStr(dic_list[j])];
                                }else {
                                    str_len8 = minStr(dic_list[j]);
                                }
                            }
                        }
                    }
                    self.oneStr6 = str_len8;
                    if(self.oneStr6.length<=0) {
                        UIButton *btnAll = [self viewWithTag:8400];
                        self.oneStr6 = @"";
                        btnAll.backgroundColor = normalColors;
                        btnAll.selected = YES;
                    }
                }
            }
        }
    }
}

- (void)deleBtnMehtod
{
    [self removeFromSuperview];
}

@end
