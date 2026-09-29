//
//  MHNexLoginController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/5.
//

#import "MHNexLoginController.h"

@interface MHNexLoginController ()

@property (nonatomic, copy) NSString *oneSt;
@property (nonatomic, copy) NSString *oneSt2;
@property (nonatomic, copy) NSString *oneSt3;
@property (nonatomic, assign) BOOL isRequBoo;
@end

@implementation MHNexLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backIMgV = [HistoryRecordModel createImgImgView];
    backIMgV.image = [UIImage imageNamed:@"backNormalImg"];
    [self.view addSubview:backIMgV];
    [backIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    self.oneSt = @"";
    self.oneSt2 = @"";
    self.oneSt3 = @"";
    self.redNavView = YES;
    [self.view addSubview:self.navView];
    
    UILabel *onelab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:18 textAlignment:NSTextAlignmentLeft];
    onelab.frame = CGRectMake(30, NAVHEIGHT+10, _window_width-60, 38);
    onelab.text = eLocalizedString(@"login_all26");
    [self.view addSubview:onelab];
    
    
    UIScrollView *oneVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(onelab.frame), _window_width, _window_height-10-TARBARHEIGHT-30-(CGRectGetMaxY(onelab.frame)))];
    oneVV.backgroundColor = UIColor.clearColor;
    oneVV.showsVerticalScrollIndicator = NO;
    oneVV.showsHorizontalScrollIndicator = NO;
    oneVV.bounces = NO;
    [self.view addSubview:oneVV];
    
    UILabel *onelab2 = [HistoryRecordModel createLabLabTextColor:RGB(200, 200, 200) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab2.frame = CGRectMake(30, 0, _window_width-60, 36);
    onelab2.text = eLocalizedString(@"login_all27");
    [oneVV addSubview:onelab2];
    
    CGFloat ww_one = (_window_width-64*3-60)/2;
    UIView *subOneV = [[UIView alloc] initWithFrame:CGRectMake(ww_one, 46, 64*3+60, 134)];
    subOneV.backgroundColor = UIColor.clearColor;
    [oneVV addSubview:subOneV];
    
    NSArray *oneMM = @[@"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    NSArray *oneMMImg = @[@"sex_imgs1", @"sex_imgs2", @"sex_imgs3", @"sex_imgs4", @"sex_imgs5"];
    NSArray *oneMMImgsel = @[@"sex_imgs6", @"sex_imgs7", @"sex_imgs8", @"sex_imgs9", @"sex_imgs10"];
    
    for (int i=0; i<oneMM.count; i++) {
        
        UIButton *oneBtns = [[UIButton alloc] init];
        [oneBtns setBackgroundImage:[UIImage imageNamed:oneMMImg[i]] forState:UIControlStateNormal];
        [oneBtns setBackgroundImage:[UIImage imageNamed:oneMMImgsel[i]] forState:UIControlStateSelected];
        oneBtns.titleLabel.font = SYS_Font(14);
        [oneBtns setTitle:oneMM[i] forState:UIControlStateNormal];
        oneBtns.tag = 230+i;
        [oneBtns addTarget:self action:@selector(oneBtnsMethod:) forControlEvents:UIControlEventTouchUpInside];
        [subOneV addSubview:oneBtns];
        switch (i) {
            case 0:
            {
                [oneBtns setTitleColor:RGB(80, 198, 254) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(0, 0, 64, 64);
            }
                break;
            case 1:
            {
                [oneBtns setTitleColor:RGB(232, 62, 120) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(94*i, 0, 64, 64);
            }
                break;
            case 2:
            {
                [oneBtns setTitleColor:RGB(116, 114, 206) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(94*i, 0, 64, 64);
            }
                break;
            case 3:
            {
                [oneBtns setTitleColor:RGB(255, 168, 83) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(47, 70, 64, 64);
            }
                break;
            case 4:
            {
                [oneBtns setTitleColor:RGB(125, 194, 172) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(47+94, 70, 64, 64);
            }
                break;
                
            default:
                break;
        }
    }
    
    UILabel *onelab3 = [HistoryRecordModel createLabLabTextColor:RGB(200, 200, 200) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab3.frame = CGRectMake(30, CGRectGetMaxY(subOneV.frame)+20, _window_width-60, 36);
    onelab3.text = eLocalizedString(@"login_all28");
    [oneVV addSubview:onelab3];
    
    CGFloat ww_one2 = (_window_width-64*2-77)/2;
    UIView *subOneV2 = [[UIView alloc] initWithFrame:CGRectMake(ww_one2, CGRectGetMaxY(onelab3.frame)+10, 64*2+77, 134)];
    subOneV2.backgroundColor = UIColor.clearColor;
    [oneVV addSubview:subOneV2];
    
    NSArray *oneMM2 = @[@"BIS", @"HETERO", @"GAY", @"LES"];
    NSArray *oneMMImg2 = @[@"sex_imgs2", @"sex_imgs3", @"sex_imgs1", @"sex_imgs5"];
    NSArray *oneMMImgsel2 = @[@"sex_imgs7", @"sex_imgs8", @"sex_imgs6", @"sex_imgs10"];
    
    for (int i=0; i<oneMM2.count; i++) {
        
        UIButton *oneBtns = [[UIButton alloc] init];
        [oneBtns setBackgroundImage:[UIImage imageNamed:oneMMImg2[i]] forState:UIControlStateNormal];
        [oneBtns setBackgroundImage:[UIImage imageNamed:oneMMImgsel2[i]] forState:UIControlStateSelected];
        oneBtns.titleLabel.font = SYS_Font(14);
        [oneBtns setTitle:oneMM2[i] forState:UIControlStateNormal];
        oneBtns.tag = 240+i;
        [oneBtns addTarget:self action:@selector(oneBtnsMethodTwo:) forControlEvents:UIControlEventTouchUpInside];
        [subOneV2 addSubview:oneBtns];
        switch (i) {
            case 0:
            {
                [oneBtns setTitleColor:RGB(232, 62, 120) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(94*i, 0, 64, 64);
            }
                break;
            case 1:
            {
                [oneBtns setTitleColor:RGB(116, 114, 206) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(94*i, 0, 64, 64);
            }
                break;
            case 2:
            {
                [oneBtns setTitleColor:RGB(80, 198, 254) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(47, 70, 64, 64);
            }
                break;
            case 3:
            {
                [oneBtns setTitleColor:RGB(125, 194, 172) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(47+94, 70, 64, 64);
            }
                break;
                
            default:
                break;
        }
    }
    
    
    UILabel *onelab4 = [HistoryRecordModel createLabLabTextColor:RGB(200, 200, 200) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab4.frame = CGRectMake(30, CGRectGetMaxY(subOneV2.frame)+20, _window_width-60, 36);
    onelab4.text = eLocalizedString(@"login_all29");
    [oneVV addSubview:onelab4];
    
    CGFloat ww_one3 = (_window_width-64*3-60)/2;
    UIView *subOneV3 = [[UIView alloc] initWithFrame:CGRectMake(ww_one3, CGRectGetMaxY(onelab4.frame)+10, 64*3+60, 134)];
    subOneV3.backgroundColor = UIColor.clearColor;
    [oneVV addSubview:subOneV3];
    
    oneVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(subOneV3.frame)+50);
    
    NSArray *oneMM3 = @[@"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
    NSArray *oneMMImg3 = @[@"sex_imgs1", @"sex_imgs2", @"sex_imgs3", @"sex_imgs4", @"sex_imgs5"];
    NSArray *oneMMImgsel3 = @[@"sex_imgs6", @"sex_imgs7", @"sex_imgs8", @"sex_imgs9", @"sex_imgs10"];
    
    for (int i=0; i<oneMM3.count; i++) {
        
        UIButton *oneBtns = [[UIButton alloc] init];
        [oneBtns setBackgroundImage:[UIImage imageNamed:oneMMImg3[i]] forState:UIControlStateNormal];
        [oneBtns setBackgroundImage:[UIImage imageNamed:oneMMImgsel3[i]] forState:UIControlStateSelected];
        oneBtns.titleLabel.font = SYS_Font(14);
        [oneBtns setTitle:oneMM3[i] forState:UIControlStateNormal];
        oneBtns.tag = 250+i;
        [oneBtns addTarget:self action:@selector(oneBtnsMethodThr:) forControlEvents:UIControlEventTouchUpInside];
        [subOneV3 addSubview:oneBtns];
        switch (i) {
            case 0:
            {
                [oneBtns setTitleColor:RGB(80, 198, 254) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(0, 0, 64, 64);
            }
                break;
            case 1:
            {
                [oneBtns setTitleColor:RGB(232, 62, 120) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(94*i, 0, 64, 64);
            }
                break;
            case 2:
            {
                [oneBtns setTitleColor:RGB(116, 114, 206) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(94*i, 0, 64, 64);
            }
                break;
            case 3:
            {
                [oneBtns setTitleColor:RGB(255, 168, 83) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(47, 70, 64, 64);
            }
                break;
            case 4:
            {
                [oneBtns setTitleColor:RGB(125, 194, 172) forState:UIControlStateNormal];
                oneBtns.frame = CGRectMake(47+94, 70, 64, 64);
            }
                break;
                
            default:
                break;
        }
    }
    
    UILabel *nexLL = [HistoryRecordModel createLabLabTextColor:RGB(200, 200, 200) fontFloat:16 textAlignment:NSTextAlignmentCenter];
    nexLL.frame = CGRectMake(30, _window_height-10-TARBARHEIGHT-30, _window_width-60, 28);
    nexLL.text = eLocalizedString(@"home_ok");
    [self.view addSubview:nexLL];
    
    UIImageView *nexImg = [[UIImageView alloc] initWithFrame:CGRectMake((_window_width-14)/2, _window_height-10-TARBARHEIGHT, 14, 9)];
    nexImg.image = [UIImage imageNamed:@"dissm_nexImg_black"];
    nexImg.clipsToBounds = YES;
    [self.view addSubview:nexImg];
    
    UIButton *nexBtn = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-100)/2, _window_height-10-TARBARHEIGHT-30, 100, 40)];
    [nexBtn addTarget:self action:@selector(nextBtnmethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nexBtn];
    
}

- (void)nextBtnmethod
{
    if(self.oneSt.length > 0) {
        if(self.isRequBoo) {
            return;
        }
        self.isRequBoo = YES;
        [SVProgressHUD show];
        NSDictionary *dicMM = @{@"contact":self.phoneStr, @"password":self.passworStr, @"code":self.codeStr, @"birthday":self.ymdStr, @"height":self.ymdStr2, @"weight":self.ymdStr3, @"locationId":self.ymdStr4, @"gender":self.oneSt, @"genderPreference":self.oneSt2, @"rolePreference":self.oneSt3, @"channel":@"IOS"};
        [requestToolClass postRegisterLogNetworkWithUrl:request_login_register andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            [self loginMethodUIUIU];
        } fail:^(NSString * _Nonnull msg) {
            self.isRequBoo = NO;
        }];
    }else {
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err3")];
    }
}

- (void)loginMethodUIUIU
{
    NSDictionary *dicMM = @{@"contact":self.phoneStr, @"verificationMethod":@"1", @"password":self.passworStr, @"code":self.codeStr};
    [requestToolClass postNetworkWithUrl:request_login_login andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        self.isRequBoo = NO;
        [LYUserDefault saveEmailAuccount:self.phoneStr];
        if([info isKindOfClass:[NSDictionary class]]) {
            [LYUserDefault saveUserLoginDefault:info];
        }
        [LYUserDefault saveIsEmailBoo:self.isEmilBoo];
        [LYUserDefault saveIsLoginBoo:YES];
        
        if([LYUserDefault userDefault].sealing) {
            
            [LYUserDefault saveIsSealing:NO];
            
            NSArray *ar_list = [HistoryRecordModel requestAccountAllDataPlist];
            NSString *main_id = @"";
            BOOL isMMainBoo = NO;
            for (NSDictionary *dicSub in ar_list) {
                if([minStr(dicSub[@"uid"]) isEqualToString:minStr(info[@"userId"])]) {

                    isMMainBoo = YES;
                }
                if([minStr(dicSub[@"recordId"]) intValue] == 0) {
                    main_id = minStr(dicSub[@"uid"]);
                }
            }
            if(isMMainBoo) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                });
            }else {
                [requestToolClass postNetworkWithUrl:request_config_establishLink andParameter:@{@"mainId":main_id, @"subId":minStr(info[@"userId"]), @"subToken":minStr(info[@"token"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                } fail:^(NSString * _Nonnull msg) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                }];
            }
            
        }else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
            });
        }
        
    } fail:^(NSString * _Nonnull msg) {
        self.isRequBoo = NO;
    }];
}

- (void)oneBtnsMethod:(UIButton *)btn
{
    NSArray *oneMM = @[@"MALE", @"FEMALE", @"SISSY", @"MTF", @"FTM"];
    self.oneSt = oneMM[btn.tag-230];
    for (int i=0; i<5; i++) {
        UIButton *bbb = [self.view viewWithTag:230+i];
        if(i==btn.tag-230) {
            bbb.selected = YES;
        }else {
            bbb.selected = NO;
        }
    }
    
    
}

- (void)oneBtnsMethodTwo:(UIButton *)btn
{
    NSArray *oneMM2 = @[@"BIS", @"HETERO", @"GAY", @"LES"];
    self.oneSt2 = oneMM2[btn.tag-240];
    for (int i=0; i<4; i++) {
        UIButton *bbb = [self.view viewWithTag:240+i];
        if(i==btn.tag-240) {
            bbb.selected = YES;
        }else {
            bbb.selected = NO;
        }
    }
    
}

- (void)oneBtnsMethodThr:(UIButton *)btn
{
    NSArray *oneMM3 = @[@"SADO", @"MASO", @"DOM", @"SUB", @"SWITCH"];
//    self.oneSt3 = oneMM3[btn.tag-250];
//    for (int i=0; i<4; i++) {
//        UIButton *bbb = [self.view viewWithTag:250+i];
//        if(i==btn.tag-250) {
//            bbb.selected = YES;
//        }else {
//            bbb.selected = NO;
//        }
//    }
    
    for (int i=0; i<oneMM3.count; i++) {
        UIButton *bMM = [self.view viewWithTag:250+i];
        
        if(bMM == btn) {
            NSString *nam_st = oneMM3[i];
            bMM.selected = !bMM.selected;
            if(bMM.selected == YES) {
                if(self.oneSt3.length > 0) {
                    NSArray *speAr = [self.oneSt3 componentsSeparatedByString:@","];
                    BOOL isJJJ = NO;
                    for (NSString *nnn in speAr) {
                        if([nnn isEqualToString:oneMM3[i]]) {
                            isJJJ = YES;
                        }
                    }
                    if(!isJJJ) {
                        self.oneSt3 = [NSString stringWithFormat:@"%@,%@", self.oneSt3, oneMM3[i]];
                    }
                }else {
                    self.oneSt3 = oneMM3[i];
                }
            }else {
                NSArray *speAr = [self.oneSt3 componentsSeparatedByString:@","];
                NSString *nam_s2 = @"";
                for (NSString *nnn in speAr) {
                    if(![nnn isEqualToString:nam_st]) {
                        if(nam_s2.length > 0) {
                            nam_s2 = [NSString stringWithFormat:@"%@,%@", nam_s2, nnn];
                        }else {
                            nam_s2 = nnn;
                        }
                    }
                }
                self.oneSt3 = nam_s2;
            }
        }
    }
}

@end
