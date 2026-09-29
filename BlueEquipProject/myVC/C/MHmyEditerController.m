//
//  MHmyEditerController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/31.
//

#import "MHmyEditerController.h"
#import "PopBottomView.h"
#import "MHsettingPasswordController.h"
#import "MHUserModel.h"
#import <BRPickerView/BRStringPickerView.h>

@interface MHmyEditerController ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *namLab;
@property (nonatomic, strong) UILabel *cityLab;
@property (nonatomic, strong) UILabel *ageLab;
@property (nonatomic, strong) UIImageView *sexImgV;
@property (nonatomic, strong) UILabel *emilAccLab;

@property (nonatomic, assign) int sexNum;
@property (nonatomic, assign) int ageNum;
@property (nonatomic, strong) NSMutableArray *oneMut;
@property (nonatomic, strong) NSMutableArray *oneMut2;
@property (nonatomic, strong) NSMutableArray *oneMut3;
@property (nonatomic, assign) BOOL isRqestBo;
@property (nonatomic, strong) MHUserModel *model;
@property (nonatomic, copy) NSString *countStr;
@end

@implementation MHmyEditerController

- (void)viewWillAppear:(BOOL)animated {
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
    self.backImgV.image = [UIImage imageNamed:@"backNormalImg"];
    
    self.oneMut = [NSMutableArray array];
    self.oneMut2 = [NSMutableArray array];
    self.oneMut3 = [NSMutableArray array];
    self.countStr = @"";
    
    self.model = [MHUserModel mj_objectWithKeyValues:self.userDic];
    
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    linVV.frame = CGRectMake(0, NAVHEIGHT-1, _window_width, 1);
    linVV.backgroundColor = RGB(121, 121, 121);
    [self.navView addSubview:linVV];
    
    self.titleName.text = eLocalizedString(@"me_allNames5_5");
    
    UIButton *svaeBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    svaeBnt.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    svaeBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    svaeBnt.titleLabel.font = [UIFont systemFontOfSize:14];
    [svaeBnt setTitle:eLocalizedString(@"home_edit_save") forState:0];
    [svaeBnt setTitleColor:normalColors forState:0];
    [svaeBnt addTarget:self action:@selector(svaeBntTitleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:svaeBnt];
    
    UIScrollView *scrolVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    scrolVV.showsVerticalScrollIndicator = NO;
    scrolVV.showsHorizontalScrollIndicator = NO;
    scrolVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:scrolVV];
    
    NSArray *listAr = @[@"me_allNames3", @"login_all31", @"login_all32", @"login_all33", @"login_all34", @"login_all35", @"login_all36"];
    
    NSArray *listAr2 = @[@"4", @"98", @"181", @"277", @"407", @"537", @"667"];
    
    for (int i=0; i<listAr.count; i++) {
        
        UILabel *allLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        allLab.frame = CGRectMake(12, [listAr2[i] intValue], _window_width-24, 40);
        allLab.text = eLocalizedString(listAr[i]);
        [scrolVV addSubview:allLab];
        
        switch (i) {
            case 0:
            {
                UIButton *oneBB = [HistoryRecordModel createImgBtn];
                oneBB.frame = CGRectMake(12, CGRectGetMaxY(allLab.frame), _window_width-24, 42);
                oneBB.backgroundColor = RGB(89, 26, 115);
                oneBB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                oneBB.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                [oneBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                oneBB.titleLabel.font = SYS_Font(14);
                [oneBB setTitle:self.model.nickName forState:UIControlStateNormal];
                oneBB.tag = 6400;
                [oneBB addTarget:self action:@selector(oneAllBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [scrolVV addSubview:oneBB];
            }
                break;
            case 1:
            {
                UIButton *oneBB = [HistoryRecordModel createImgBtn];
                oneBB.frame = CGRectMake(12, CGRectGetMaxY(allLab.frame), _window_width-24, 42);
                oneBB.backgroundColor = RGB(89, 26, 115);
                oneBB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                oneBB.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                [oneBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                oneBB.titleLabel.font = SYS_Font(14);
                [oneBB setTitle:minIntStr(self.model.age) forState:UIControlStateNormal];
                oneBB.tag = 6401;
                [oneBB addTarget:self action:@selector(oneAllBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [scrolVV addSubview:oneBB];
                
                UIView *swithVVVV = [self createSaveMiTag:6402];
                [scrolVV addSubview:swithVVVV];
                [swithVVVV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(oneBB.mas_right);
                    make.centerY.equalTo(allLab.mas_centerY);
                    make.height.offset(40);
                }];
                
                UIButton *swiBB = [scrolVV viewWithTag:6402];
                swiBB.selected = self.model.agePrivate;
                
            }
                break;
            case 2:
            {
                UILabel *baomiLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                baomiLab2.frame = CGRectMake(_window_width/2+10, allLab.y, 100, 40);
                baomiLab2.text = eLocalizedString(@"me_allNames25");
                [scrolVV addSubview:baomiLab2];
                
                CGFloat w_ww = (_window_width-44)/2;
                UIButton *oneBB = [HistoryRecordModel createImgBtn];
                oneBB.frame = CGRectMake(12, CGRectGetMaxY(allLab.frame), w_ww, 42);
                oneBB.backgroundColor = RGB(89, 26, 115);
                oneBB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                oneBB.titleEdgeInsets = UIEdgeInsetsMake(0, 42, 0, 10);
                [oneBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [oneBB setImage:[UIImage imageNamed:@"edit_meImgs1"] forState:UIControlStateNormal];
                oneBB.imageEdgeInsets = UIEdgeInsetsMake(11, 10, 11, w_ww-30);
                oneBB.imageView.clipsToBounds = YES;
                [oneBB setTitle:minIntStr(self.model.weight) forState:UIControlStateNormal];
                oneBB.titleLabel.font = SYS_Font(14);
                oneBB.tag = 6403;
                [oneBB addTarget:self action:@selector(oneAllBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [scrolVV addSubview:oneBB];
                
                UILabel *danWLab = [HistoryRecordModel createLabLabTextColor:RGB(217, 217, 217) fontFloat:14 textAlignment:NSTextAlignmentCenter];
                danWLab.frame = CGRectMake(w_ww-40, 0, 40, 42);
                danWLab.text = @"KG";
                [oneBB addSubview:danWLab];
                
                UIView *swithVVVV = [self createSaveMiTag:6404];//体重
                [scrolVV addSubview:swithVVVV];
                [swithVVVV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(oneBB.mas_right);
                    make.centerY.equalTo(allLab.mas_centerY);
                    make.height.offset(40);
                }];
                
                UIButton *swiBB = [scrolVV viewWithTag:6404];
                swiBB.selected = self.model.weightPrivate;
                
                
                UIButton *oneBB2 = [HistoryRecordModel createImgBtn];
                oneBB2.frame = CGRectMake(32+w_ww, CGRectGetMaxY(allLab.frame), w_ww, 42);
                oneBB2.backgroundColor = RGB(89, 26, 115);
                oneBB2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                oneBB2.titleEdgeInsets = UIEdgeInsetsMake(0, 42, 0, 10);
                [oneBB2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [oneBB2 setImage:[UIImage imageNamed:@"edit_meImgs2"] forState:UIControlStateNormal];
                oneBB2.imageEdgeInsets = UIEdgeInsetsMake(11, 10, 11, w_ww-30);
                oneBB2.imageView.clipsToBounds = YES;
                [oneBB2 setTitle:minIntStr(self.model.height) forState:UIControlStateNormal];
                oneBB2.titleLabel.font = SYS_Font(14);
                oneBB2.tag = 6405;
                [oneBB2 addTarget:self action:@selector(oneAllBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [scrolVV addSubview:oneBB2];
                
                UILabel *danWLab2 = [HistoryRecordModel createLabLabTextColor:RGB(217, 217, 217) fontFloat:14 textAlignment:NSTextAlignmentCenter];
                danWLab2.frame = CGRectMake(w_ww-40, 0, 40, 42);
                danWLab2.text = @"CM";
                [oneBB2 addSubview:danWLab2];
                
                UIView *swithVVVV2 = [self createSaveMiTag:6406]; //身高
                [scrolVV addSubview:swithVVVV2];
                [swithVVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(oneBB2.mas_right);
                    make.centerY.equalTo(allLab.mas_centerY);
                    make.height.offset(40);
                }];
                
                UIButton *swiBB2 = [scrolVV viewWithTag:6406];
                swiBB2.selected = self.model.heightPrivate;
            }
                break;
            case 3:
            {
                NSArray *oneMM = @[@"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
                CGFloat w_ww = _window_width/3;
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(12+w_ww*x_w, CGRectGetMaxY(allLab.frame)+y_w*46, w_ww-24, 34);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 18;
                    btn_btn.titleLabel.font = SYS_Font(14);
                    [btn_btn addTarget:self action:@selector(btnMethodAllsTwo:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    [self.oneMut addObject:btn_btn];
                    if(self.model.gender.length > 0) {
                        
                        if([self.model.gender isEqualToString:oneMM[j]]) {
                            btn_btn.selected = YES;
                            btn_btn.backgroundColor = RGB(89, 26, 115);
                        }
                    }
                    
                    if(j==2) {
                        UIView *swithVVVV2 = [self createSaveMiTag:6407]; //性别
                        [scrolVV addSubview:swithVVVV2];
                        [swithVVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(btn_btn.mas_right);
                            make.centerY.equalTo(allLab.mas_centerY);
                            make.height.offset(40);
                        }];
                        
                        UIButton *swiBB = [scrolVV viewWithTag:6407];
                        swiBB.selected = self.model.genderPrivate;
                    }
                }
                
            }
                break;
            case 4:
            {
                NSArray *oneMM = @[@"BIS", @"HETERO", @"GAY", @"LES"];
                CGFloat w_ww = _window_width/3;
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(12+w_ww*x_w, CGRectGetMaxY(allLab.frame)+y_w*46, w_ww-24, 34);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 18;
                    btn_btn.titleLabel.font = SYS_Font(14);
                    [btn_btn addTarget:self action:@selector(btnMethodAllsThr:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    [self.oneMut2 addObject:btn_btn];
                    if(self.model.genderPreference.length > 0) {
                        
                        if([self.model.genderPreference isEqualToString:oneMM[j]]) {
                            btn_btn.selected = YES;
                            btn_btn.backgroundColor = RGB(89, 26, 115);
                        }
                    }
                    
                    if(j==2) {
                        UIView *swithVVVV2 = [self createSaveMiTag:6408]; //性取向
                        [scrolVV addSubview:swithVVVV2];
                        [swithVVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(btn_btn.mas_right);
                            make.centerY.equalTo(allLab.mas_centerY);
                            make.height.offset(40);
                        }];
                        
                        UIButton *swiBB = [scrolVV viewWithTag:6408];
                        swiBB.selected = self.model.genderPreferencePrivate;
                    }
                }
            }
                break;
            case 5:
            {
                NSArray *oneMM = @[@"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
                CGFloat w_ww = _window_width/3;
                for (int j=0; j<oneMM.count; j++) {
                    
                    int x_w = j%3;
                    int y_w = j/3;
                    UIButton *btn_btn = [HistoryRecordModel createImgBtn];
                    btn_btn.frame = CGRectMake(12+w_ww*x_w, CGRectGetMaxY(allLab.frame)+y_w*46, w_ww-24, 34);
                    [btn_btn setTitle:oneMM[j] forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                    [btn_btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
                    btn_btn.backgroundColor = RGB(43, 12, 56);
                    btn_btn.layer.cornerRadius = 18;
                    btn_btn.titleLabel.font = SYS_Font(14);
                    [btn_btn addTarget:self action:@selector(btnMethodAllsFou:) forControlEvents:UIControlEventTouchUpInside];
                    [scrolVV addSubview:btn_btn];
                    [self.oneMut3 addObject:btn_btn];
                    if(self.model.rolePreference.length > 0) {
                        
                        NSArray *ar_sub = [self.model.rolePreference componentsSeparatedByString:@","];
                        if([ar_sub containsObject:oneMM[j]]) {
                            btn_btn.selected = YES;
                            btn_btn.backgroundColor = RGB(89, 26, 115);
                        }
                    }
                    if(j == 2) {
                        UIView *swithVVVV2 = [self createSaveMiTag:6409]; //属性
                        [scrolVV addSubview:swithVVVV2];
                        [swithVVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(btn_btn.mas_right);
                            make.centerY.equalTo(allLab.mas_centerY);
                            make.height.offset(40);
                        }];
                        
                        UIButton *swiBB = [scrolVV viewWithTag:6409];
                        swiBB.selected = self.model.rolePreferencePrivate;
                    }
                }
                
            }
                break;
            case 6:
            {
                UIButton *oneBB = [HistoryRecordModel createImgBtn];
                oneBB.frame = CGRectMake(12, CGRectGetMaxY(allLab.frame), _window_width-24, 42);
                oneBB.backgroundColor = RGB(89, 26, 115);
                oneBB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                oneBB.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                [oneBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                oneBB.titleLabel.font = SYS_Font(14);
                [oneBB setTitle:eLocalizedString(@"center_all12") forState:UIControlStateNormal];
                [oneBB setImage:[UIImage imageNamed:@"home_next2"] forState:UIControlStateNormal];
                oneBB.imageEdgeInsets = UIEdgeInsetsMake(13, _window_width-24-26, 13, 10);
                oneBB.imageView.clipsToBounds = YES;
                oneBB.tag = 6411;
                [oneBB addTarget:self action:@selector(oneAllBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                [scrolVV addSubview:oneBB];
                
                if(self.model.location.length > 0) {
                    [oneBB setTitle:self.model.location forState:UIControlStateNormal];
                }
                
                UIView *swithVVVV2 = [self createSaveMiTag:6410]; //国家
                [scrolVV addSubview:swithVVVV2];
                [swithVVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(oneBB.mas_right);
                    make.centerY.equalTo(allLab.mas_centerY);
                    make.height.offset(40);
                }];
                
                UIButton *swiBB = [scrolVV viewWithTag:6410];
                swiBB.selected = self.model.locationPrivate;
            }
                break;
                
            default:
                break;
        }
    }
    
    scrolVV.contentSize = CGSizeMake(_window_width, 770);
    if([LYUserDefault userDefault].countries_Arr.count <= 0) {
        [self requCountries];
    }
}

//MARK: 保存
- (void)svaeBntTitleAction
{
    if(self.isRqestBo) {
        return;
    }
    self.isRqestBo = YES;
    [SVProgressHUD show];
    
    NSDictionary *saveDic = @{@"nickName":self.model.nickName, @"agePrivate":self.model.agePrivate?@"true":@"false", @"age":minIntStr(self.model.age), @"weightPrivate":self.model.weightPrivate?@"true":@"false", @"weight":minIntStr(self.model.weight), @"heightPrivate":self.model.heightPrivate?@"true":@"false", @"height":minIntStr(self.model.height), @"genderPrivate":self.model.genderPrivate?@"true":@"false", @"gender":self.model.gender, @"genderPreferencePrivate":self.model.genderPreferencePrivate?@"true":@"false", @"genderPreference":self.model.genderPreference, @"rolePreferencePrivate":self.model.rolePreferencePrivate?@"true":@"false", @"rolePreference":self.model.rolePreference, @"locationPrivate":self.model.locationPrivate?@"true":@"false"};
    if(self.countStr.length>0) {
        saveDic = @{@"nickName":self.model.nickName, @"agePrivate":self.model.agePrivate?@"true":@"false", @"age":minIntStr(self.model.age), @"weightPrivate":self.model.weightPrivate?@"true":@"false", @"weight":minIntStr(self.model.weight), @"heightPrivate":self.model.heightPrivate?@"true":@"false", @"height":minIntStr(self.model.height), @"genderPrivate":self.model.genderPrivate?@"true":@"false", @"gender":self.model.gender, @"genderPreferencePrivate":self.model.genderPreferencePrivate?@"true":@"false", @"genderPreference":self.model.genderPreference, @"rolePreferencePrivate":self.model.rolePreferencePrivate?@"true":@"false", @"rolePreference":self.model.rolePreference, @"locationPrivate":self.model.locationPrivate?@"true":@"false", @"locationId":self.countStr};
    }
    [requestToolClass postNetworkWithUrl:request_user_updateInfo andParameter:saveDic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.isRqestBo = NO;
        
        V2TIMUserFullInfo *infoIM = [[V2TIMUserFullInfo alloc] init];
        infoIM.nickName = self.model.nickName;
        infoIM.allowType = V2TIM_FRIEND_NEED_CONFIRM;
        [[V2TIMManager sharedInstance] setSelfInfo:infoIM succ:^{
            NSLog(@"更新 IM昵称 成功");
            
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(int code, NSString *desc) {
            NSLog(@"更新 IM昵称 失败");
            
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } fail:^(NSString * _Nonnull msg) {
        self.isRqestBo = NO;
    }];
}


- (void)btnMethodAllsTwo:(UIButton *)btn
{
    NSArray *oneAr2 = @[@"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];

    for (int i=0; i<self.oneMut.count; i++) {
        UIButton *bMM = self.oneMut[i];
        if(bMM == btn) {
            bMM.selected = YES;
            bMM.backgroundColor = RGB(89, 26, 115);
            self.model.gender = oneAr2[i];
        }else {
            bMM.selected = NO;
            bMM.backgroundColor = RGB(43, 12, 56);

        }
    }
}

- (void)btnMethodAllsThr:(UIButton *)btn
{
    NSArray *oneAr2 = @[@"BIS", @"HETERO", @"GAY", @"LES"];
    for (int i=0; i<self.oneMut2.count; i++) {
        UIButton *bMM = self.oneMut2[i];
        if(bMM == btn) {
            
            bMM.selected = YES;
            bMM.backgroundColor = RGB(89, 26, 115);
            self.model.genderPreference = oneAr2[i];
        }else {
            bMM.selected = NO;
            bMM.backgroundColor = RGB(43, 12, 56);

        }
    }
}

- (void)btnMethodAllsFou:(UIButton *)btn
{
    NSArray *oneAr4 = @[@"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
//    self.model.rolePreference = @"";
    
    for (int i=0; i<self.oneMut3.count; i++) {
        UIButton *bMM = self.oneMut3[i];
        
        if(bMM == btn) {
            bMM.selected = !bMM.selected;
            if(bMM.selected == YES) {
                bMM.backgroundColor = RGB(89, 26, 115);
                if(self.model.rolePreference.length > 0) {
                    NSArray *speAr = [self.model.rolePreference componentsSeparatedByString:@","];
                    BOOL isJJJ = NO;
                    for (NSString *nnn in speAr) {
                        if([nnn isEqualToString:oneAr4[i]]) {
                            isJJJ = YES;
                        }
                    }
                    if(!isJJJ) {
                        self.model.rolePreference = [NSString stringWithFormat:@"%@,%@", self.model.rolePreference, oneAr4[i]];
                    }
                }else {
                    self.model.rolePreference = oneAr4[i];
                }
            }else {
                NSArray *speAr = [self.model.rolePreference componentsSeparatedByString:@","];
                NSString *nam_s2 = @"";
                for (NSString *nnn in speAr) {
                    if(![nnn isEqualToString:oneAr4[i]]) {
                        if(nam_s2.length > 0) {
                            nam_s2 = [NSString stringWithFormat:@"%@,%@", nam_s2, nnn];
                        }else {
                            nam_s2 = nnn;
                        }
                    }
                }
                self.model.rolePreference = nam_s2;
                bMM.backgroundColor = RGB(43, 12, 56);
            }
        }
    }
    
}

- (void)oneAllBtnMethod:(UIButton *)btn
{
//    0- 6400、1- 6401 、 2- 6403 、 2- 6405 、 6- 6411
    switch (btn.tag) {
        case 6400:
        {
            PopModifyView *modify = [[PopModifyView alloc]init];
            modify.titleString = eLocalizedString(@"me_allNames3");
            modify.isSingleCommit = YES;
            modify.blockTextToModify = ^(NSString *name, NSString *phone) {
                
                self.model.nickName = name;
                [btn setTitle:self.model.nickName forState:UIControlStateNormal];
            };
            [modify show];
        }
            break;
        case 6401:
        {
            PopModifyView *modify = [[PopModifyView alloc]init];
            modify.titleString = eLocalizedString(@"login_all31");
            modify.isSingleCommit = YES;
            modify.blockTextToModify = ^(NSString *name, NSString *phone) {
                
                self.model.age = [name intValue];
                [btn setTitle:name forState:UIControlStateNormal];
            };
            [modify show];
        }
            break;
        case 6403:
        {
            PopModifyView *modify = [[PopModifyView alloc]init];
            modify.titleString = eLocalizedString(@"login_all32");
            modify.isSingleCommit = YES;
            modify.blockTextToModify = ^(NSString *name, NSString *phone) {
                
                self.model.weight = [name intValue];
                [btn setTitle:name forState:UIControlStateNormal];
            };
            [modify show];
        }
            break;
        case 6405:
        {
            PopModifyView *modify = [[PopModifyView alloc]init];
            modify.titleString = eLocalizedString(@"me_allNames25");
            modify.isSingleCommit = YES;
            modify.blockTextToModify = ^(NSString *name, NSString *phone) {
                
                self.model.height = [name intValue];
                [btn setTitle:name forState:UIControlStateNormal];
            };
            [modify show];
        }
            break;
        case 6411:
        {
            if([LYUserDefault userDefault].countries_Arr.count > 0) {
                
                NSMutableArray *namsArr = [NSMutableArray array];
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
                    self.model.location = resultModel.value;
                    NSDictionary *dicM = [LYUserDefault userDefault].countries_Arr[resultModel.index];
                    self.countStr = minStr(dicM[@"id"]);
                };
                [stringPickerView show];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)requCountries
{
    if(self.isRqestBo) {
        return;
    }
    self.isRqestBo = YES;
    [requestToolClass getNetworkWithUrl:request_login_countries andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        self.isRqestBo = NO;
        [LYUserDefault saveCountiesArr:info];
    } fail:^(NSString * _Nonnull msg) {
        self.isRqestBo = NO;
    }];
}

- (void)switBtnMethod:(UIButton *)btn
{
    //1- 6402 、 2- 6404、 2- 6406 、 3- 6407 、 4- 6408 、 5- 6409 、 6- 6410
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 6402:
        {
            self.model.agePrivate = btn.selected==YES ? YES:NO;
        }
            break;
        case 6404:
        {
            self.model.weightPrivate = btn.selected==YES ? YES:NO;
        }
            break;
        case 6406:
        {
            self.model.heightPrivate = btn.selected==YES ? YES:NO;
        }
            break;
        case 6407:
        {
            self.model.genderPrivate = btn.selected==YES ? YES:NO;
        }
            break;
        case 6408:
        {
            self.model.genderPreferencePrivate = btn.selected==YES ? YES:NO;
        }
            break;
        case 6409:
        {
            self.model.rolePreferencePrivate = btn.selected==YES ? YES:NO;
        }
            break;
        case 6410:
        {
            self.model.locationPrivate = btn.selected==YES ? YES:NO;
        }
            break;
            
        default:
            break;
    }
}


- (UIView *)createSaveMiTag:(NSInteger)tagLL
{
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.backgroundColor = UIColor.clearColor;
    
    UILabel *baomiLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
    baomiLab.text = eLocalizedString(@"me_allNames24");
    [oneVV addSubview:baomiLab];
    [baomiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV.mas_right);
        make.centerY.equalTo(oneVV.mas_centerY);
    }];
    
    UIButton *swithbtn = [HistoryRecordModel createImgBtn];
    [swithbtn setBackgroundImage:[UIImage imageNamed:@"switch_norlImg"] forState:UIControlStateNormal];
    [swithbtn setBackgroundImage:[UIImage imageNamed:@"switch_selImg"] forState:UIControlStateSelected];
    swithbtn.tag = tagLL;
    [swithbtn addTarget:self action:@selector(switBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [oneVV addSubview:swithbtn];
    [swithbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baomiLab.mas_left).offset(-8);
        make.centerY.equalTo(oneVV.mas_centerY);
        make.left.equalTo(oneVV.mas_left).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];
    
    return oneVV;
}

@end
