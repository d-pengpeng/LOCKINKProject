//
//  MHPostConditionsController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "MHPostConditionsController.h"
#import "MHfindChooseSliderView.h"
#import <BRStringPickerView.h>

@interface MHPostConditionsController ()

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
@end

@implementation MHPostConditionsController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.showImgVV = YES;
    self.titleName.text = eLocalizedString(@"role_name12");
 
    self.oneStr1 = self.arrFind[0];
    self.oneStr2 = [self.arrFind[1] intValue];
    self.oneStr3 = [self.arrFind[2] intValue];
    self.oneStr4 = self.arrFind[3];
    self.oneStr5 = self.arrFind[4];
    self.oneStr6 = self.arrFind[5];
    self.oneStr7 = self.arrFind[6];
    self.oneStr8 = self.arrFind[7];
    
    self.fouMut = [NSMutableArray array];
    
    UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(12, NAVHEIGHT, _window_width-24, _window_height-NAVHEIGHT)];
    scrolVV.showsVerticalScrollIndicator = NO;
    scrolVV.showsHorizontalScrollIndicator = NO;
    scrolVV.backgroundColor = UIColor.clearColor;
    scrolVV.bounces = NO;
    [self.view addSubview:scrolVV];
    
    scrolVV.contentSize = CGSizeMake(_window_width-24, 562+176);
    
    NSArray *listAr = @[@"", @"login_all31", @"find_detail1", @"login_all34", @"login_all35", @"login_all36"];
    
//    NSArray *listAr2 = @[@"0", @"72", @"150", @"262", @"374", @"486", @"562"];
    NSArray *listAr2 = @[@"0", @"0", @"78", @"190", @"302", @"414", @"490"];
    CGFloat w_ww = (_window_width-24*3)/3+24;
    for (int i=0; i<listAr.count; i++) {
        
        UILabel *allLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        allLab.frame = CGRectMake(0, [listAr2[i] intValue], scrolVV.width, 36);
        allLab.text = eLocalizedString(listAr[i]);
        [scrolVV addSubview:allLab];
        
        switch (i) {
            case 0:
            {
//                NSArray *one_ar1 = @[@"center_all12", @"find_choose2", @"find_choose3"];
//                for (int j=0; j<one_ar1.count; j++) {
//
//                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
//                    btn_btn.frame = CGRectMake(j*(76+13), CGRectGetMaxY(allLab.frame)+2, 76, 30);
//                    [btn_btn setTitle:eLocalizedString(one_ar1[j]) forState:UIControlStateNormal];
//                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
//                    btn_btn.backgroundColor = UIColor.clearColor;
//                    btn_btn.layer.cornerRadius = 4;
//                    btn_btn.titleLabel.font = SYS_Font(14);
//                    btn_btn.layer.borderColor = normalColors.CGColor;
//                    btn_btn.layer.borderWidth = 1;
//                    btn_btn.tag = 8100+j;
//                    [btn_btn addTarget:self action:@selector(btnMethodAllsOne:) forControlEvents:UIControlEventTouchUpInside];
//                    [scrolVV addSubview:btn_btn];
//                    if(i == [self.oneStr1 intValue]-1) {
//                        btn_btn.backgroundColor = normalColors;
//                        btn_btn.selected = YES;
//                    }else {
//                        btn_btn.backgroundColor = UIColor.clearColor;
//                        btn_btn.selected = NO;
//                    }
//                }
            }
                break;
            case 1:
            {
                self.findChooseSliderV = [[MHfindChooseSliderView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(allLab.frame)+12, scrolVV.width-60, 30)];
                [scrolVV addSubview:self.findChooseSliderV];
                
            }
                break;
            case 2:
            {
                NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
                
                
                NSArray *oneMM2 = @[@"", @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-24, 30);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 4;
                    btn_btn.titleLabel.font = SYS_Font(14);
                    btn_btn.tag = 8200+j;
                    [btn_btn addTarget:self action:@selector(btnMethodAllsTwo:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    if([self.oneStr4 isEqualToString:oneMM2[j]]) {
                        btn_btn.backgroundColor = RGB(89, 26, 115);
                        btn_btn.selected = YES;
                    }else {
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.selected = NO;
                    }
                }
            }
                break;
            case 3:
            {
                NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"BIS", @"HETERO", @"GAY", @"LES"];
                
                NSArray *oneMM3 = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-24, 30);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 4;
                    btn_btn.titleLabel.font = SYS_Font(14);
                    btn_btn.tag = 8300+j;
                    [btn_btn addTarget:self action:@selector(btnMethodAllsThr:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    if([self.oneStr5 isEqualToString:oneMM3[j]]) {
                        btn_btn.backgroundColor = RGB(89, 26, 115);
                        btn_btn.selected = YES;
                    }else {
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.selected = NO;
                    }
                }
            }
                break;
            case 4:
            {
                NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
                NSArray *oneAr4 = @[@"", @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-24, 30);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 4;
                    btn_btn.titleLabel.font = SYS_Font(14);
                    btn_btn.tag = 8400+j;
                    [btn_btn addTarget:self action:@selector(btnMethodAllsFou:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    [self.fouMut addObject:btn_btn];
                    
                    
                    NSArray *sub_arr = [self.oneStr6 componentsSeparatedByString:@","];
                    if([sub_arr containsObject:oneAr4[j]]) {
                        btn_btn.backgroundColor = RGB(89, 26, 115);
                        btn_btn.selected = YES;
                    }else {
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.selected = NO;
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
                
                if([self.oneStr7 intValue] > 0) {
                    
                    for (NSDictionary *dicM in [LYUserDefault userDefault].countries_Arr) {
                        if([minStr(dicM[@"id"]) isEqualToString:self.oneStr7]) {
                            [oneBB setTitle:minStr(dicM[@"name"]) forState:UIControlStateNormal];
                        }
                    }
                }else {
                    [oneBB setTitle:eLocalizedString(@"center_all12") forState:UIControlStateNormal];
                }
                
            }
                break;
            case 6:
            {
                NSArray *oneMM = @[eLocalizedString(@"center_all12"), @"CELL MATE", @"PEAR FLPWER", @"KEYPOD", @"BEAT PAT"];
                CGFloat w_ww = 76+13;
                
                NSArray *oneMM6 = @[@"", @"CELL MATE", @"PEAR FLPWER", @"KEYPOD", @"BEAT PAT"];
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(w_ww*x_w, CGRectGetMaxY(allLab.frame)+2+y_w*38, w_ww-13, 30);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 4;
                    btn_btn.titleLabel.font = SYS_Font(12);
                    btn_btn.titleLabel.numberOfLines = 2;
                    btn_btn.tag = 8600+j;
                    [btn_btn addTarget:self action:@selector(btnMethodAllsSix:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    if([self.oneStr8 isEqualToString:oneMM6[i]]) {
                        btn_btn.backgroundColor = RGB(89, 26, 115);
                        btn_btn.selected = YES;
                    }else {
                        btn_btn.backgroundColor = RGB(43, 12, 56);
                        btn_btn.selected = NO;
                    }
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    [self.findChooseSliderV addLeftStr:self.oneStr2-18 righStr:self.oneStr3-18];
    
    UIButton *btn_btn2 = [HistoryRecordModel createImgBtn];
    btn_btn2.frame = CGRectMake(50, 414+80+30, scrolVV.width-100, 36);
    [btn_btn2 setTitle:eLocalizedString(@"home_ok") forState:UIControlStateNormal];
    [btn_btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn_btn2.backgroundColor = normalColors;
    btn_btn2.layer.cornerRadius = 6;
    btn_btn2.titleLabel.font = SYS_Font(14);
    [btn_btn2 addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [scrolVV addSubview:btn_btn2];
    
}


- (void)sureBtnMethod
{
    NSArray *arLis = [self.findChooseSliderV getStartToEnd];
    
    self.oneStr2 = [arLis[0] intValue];
    self.oneStr3 = [arLis[1] intValue];
    if(self.block_) {
        self.block_(@[self.oneStr1, minStr(arLis[0]), minStr(arLis[1]), self.oneStr4, self.oneStr5, self.oneStr6, self.oneStr7, self.oneStr8]);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
                NSDictionary *dicM = [LYUserDefault userDefault].countries_Arr[resultModel.index-1];
                self.oneStr7 = minStr(dicM[@"id"]);
            }
        };
        [stringPickerView show];
    }
}

- (void)btnMethodAllsOne:(UIButton *)btn
{
//    8100
    for (int i=0; i<3; i++) {
        UIButton *btnAll = [self.view viewWithTag:8100+i];
        if(btnAll == btn) {
            self.oneStr1 = minIntStr(i+1);
            btnAll.backgroundColor = RGB(89, 26, 115);
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = RGB(43, 12, 56);
            btnAll.selected = NO;
        }
    }
}

- (void)btnMethodAllsTwo:(UIButton *)btn
{
//    8200
    NSArray *oneMM = @[@"", @"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    for (int i=0; i<6; i++) {
        UIButton *btnAll = [self.view viewWithTag:8200+i];
        if(btnAll == btn) {
            self.oneStr4 = oneMM[i];
            btnAll.backgroundColor = RGB(89, 26, 115);
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = RGB(43, 12, 56);
            btnAll.selected = NO;
        }
    }
}

- (void)btnMethodAllsSix:(UIButton *)btn
{
//    8600
    NSArray *oneMM = @[@"", @"CELL MATE", @"PEAR FLPWER", @"KEYPOD", @"BEAT PAT"];
    for (int i=0; i<oneMM.count; i++) {
        UIButton *btnAll = [self.view viewWithTag:8600+i];
        if(btnAll == btn) {
            self.oneStr8 = oneMM[i];
            btnAll.backgroundColor = RGB(89, 26, 115);
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = RGB(43, 12, 56);
            btnAll.selected = NO;
        }
    }
}

- (void)btnMethodAllsThr:(UIButton *)btn
{
//    8300
    NSArray *oneMM = @[@"", @"BIS", @"HETERO", @"GAY", @"LES"];
    for (int i=0; i<oneMM.count; i++) {
        UIButton *btnAll = [self.view viewWithTag:8300+i];
        if(btnAll == btn) {
            self.oneStr5 = oneMM[i];
            btnAll.backgroundColor = RGB(89, 26, 115);
            btnAll.selected = YES;
        }else {
            btnAll.backgroundColor = RGB(43, 12, 56);
            btnAll.selected = NO;
        }
    }
}

- (void)btnMethodAllsFou:(UIButton *)btn
{
    NSArray *oneAr4 = @[@"", @"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
    self.oneStr6 = @"";
    
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
                        if(self.oneStr6.length>0) {
                            
                            self.oneStr6 = [NSString stringWithFormat:@"%@,%@", self.oneStr6, oneAr4[i]];
                        }else {
                            self.oneStr6 = oneAr4[i];
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

@end
