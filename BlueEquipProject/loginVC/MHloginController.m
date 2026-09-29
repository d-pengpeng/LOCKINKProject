//
//  MHloginController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "MHloginController.h"
#import <BRPickerView/BRPickerView.h>
#import <BRPickerView/BRStringPickerView.h>
#import "MHNexLoginController.h"

@interface MHloginController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *ymdLab;
@property (nonatomic, strong) UITextField *ymdLab2;
@property (nonatomic, strong) UITextField *ymdLab3;
@property (nonatomic, strong) UILabel *choseLab;
@property (nonatomic, strong) NSArray *countrAr;
@property (nonatomic, copy) NSString *countStr;
@end

@implementation MHloginController

- (void)viewWillAppear:(BOOL)animated
{
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
    UIImageView *backIMgV = [HistoryRecordModel createImgImgView];
    backIMgV.image = [UIImage imageNamed:@"backNormalImg"];
    [self.view addSubview:backIMgV];
    [backIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    self.redNavView = YES;
    [self.view addSubview:self.navView];
    self.countStr = @"";
    
    UILabel *onelab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:18 textAlignment:NSTextAlignmentLeft];
    onelab.frame = CGRectMake(30, NAVHEIGHT+10, _window_width-60, 38);
    onelab.text = eLocalizedString(@"login_all19");
    [self.view addSubview:onelab];
    
    UILabel *onelab2 = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab2.frame = CGRectMake(30, CGRectGetMaxY(onelab.frame), _window_width-60, 36);
    onelab2.text = eLocalizedString(@"login_all20");
    [self.view addSubview:onelab2];
    
    NSString *mmm = [HistoryRecordModel getCurrentTimeMethod:@"YYYY-MM-dd"];
    NSArray *ar_MM = [mmm componentsSeparatedByString:@"-"];
    NSString *l_s = minStr(ar_MM[0]);
    
    self.ymdLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:24 textAlignment:NSTextAlignmentLeft];
    self.ymdLab.frame = CGRectMake(30, CGRectGetMaxY(onelab2.frame)+20, _window_width-60, 38);
    self.ymdLab.text = [NSString stringWithFormat:@"%d-%@-%@", [l_s intValue]-17, ar_MM[1], ar_MM[2]];
    [self.view addSubview:self.ymdLab];
    
    UIButton *yymBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(onelab2.frame)+20, _window_width-60, 38)];
    [yymBtn addTarget:self action:@selector(selectMMMMMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yymBtn];
    
    UILabel *onelab3 = [HistoryRecordModel createLabLabTextColor:RGB(199, 199, 199) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab3.frame = CGRectMake(30, CGRectGetMaxY(self.ymdLab.frame)+4, _window_width-60, 36);
    onelab3.text = eLocalizedString(@"login_all21");
    [self.view addSubview:onelab3];
    
    self.ymdLab2 = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(onelab3.frame)+7, _window_width-60, 24)];
    self.ymdLab2.textColor = normalColors;
    self.ymdLab2.font = SYS_Font(14);
    self.ymdLab2.keyboardType= UIKeyboardTypeNumberPad;
    self.ymdLab2.text = @"";
    self.ymdLab2.textAlignment = NSTextAlignmentCenter;
    self.ymdLab2.delegate = self;
    self.ymdLab2.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.ymdLab2];
    
    UILabel *cmLLab = [HistoryRecordModel createLabLabTextColor:RGB(199, 199, 199) fontFloat:14 textAlignment:NSTextAlignmentRight];
    cmLLab.text = @"cm";
    [self.view addSubview:cmLLab];
    [cmLLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.centerY.equalTo(self.ymdLab2.mas_centerY);
    }];
    
    
    UIImageView *linVV = [HistoryRecordModel createImgImgView];
    linVV.frame = CGRectMake(30, self.ymdLab2.y+24, _window_width-60, 3);
    linVV.backgroundColor = RGB(186, 80, 191);
    [self.view addSubview:linVV];
    
    
    UILabel *onelab4 = [HistoryRecordModel createLabLabTextColor:RGB(199, 199, 199) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab4.frame = CGRectMake(30, CGRectGetMaxY(linVV.frame)+7, _window_width-60, 36);
    onelab4.text = eLocalizedString(@"login_all22");
    [self.view addSubview:onelab4];
    
    self.ymdLab3 = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(onelab4.frame)+7, _window_width-60, 24)];
    self.ymdLab3.textColor = normalColors;
    self.ymdLab3.font = SYS_Font(14);
    self.ymdLab3.keyboardType= UIKeyboardTypeNumberPad;
    self.ymdLab3.text = @"";
    self.ymdLab3.delegate = self;
    self.ymdLab3.textAlignment = NSTextAlignmentCenter;
    self.ymdLab3.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.ymdLab3];
    
    UILabel *cmLLab2 = [HistoryRecordModel createLabLabTextColor:RGB(199, 199, 199) fontFloat:14 textAlignment:NSTextAlignmentRight];
    cmLLab2.text = @"KG";
    [self.view addSubview:cmLLab2];
    [cmLLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.centerY.equalTo(self.ymdLab3.mas_centerY);
    }];
    
   
    
    UIImageView *linVV2 = [HistoryRecordModel createImgImgView];
    linVV2.frame = CGRectMake(30, self.ymdLab3.y+24, _window_width-60, 3);
    linVV2.backgroundColor = RGB(186, 80, 191);
    [self.view addSubview:linVV2];
    
    UILabel *onelab5 = [HistoryRecordModel createLabLabTextColor:RGB(199, 199, 199) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    onelab5.frame = CGRectMake(30, CGRectGetMaxY(linVV2.frame)+20, _window_width-60, 36);
    onelab5.text = eLocalizedString(@"login_all23");
    [self.view addSubview:onelab5];
    
    UIButton *choseBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(onelab5.frame)+10, 164, 40)];
    [choseBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [choseBtn addTarget:self action:@selector(choseBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choseBtn];
    
    self.choseLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    self.choseLab.frame = CGRectMake(16, 0, 132, 40);
    self.choseLab.text = eLocalizedString(@"login_all30");
    self.choseLab.numberOfLines = 2;
    [choseBtn addSubview:self.choseLab];
    self.countStr = @"";
    
    UILabel *nexLL = [HistoryRecordModel createLabLabTextColor:RGB(200, 200, 200) fontFloat:16 textAlignment:NSTextAlignmentCenter];
    nexLL.frame = CGRectMake(30, _window_height-32-TARBARHEIGHT, _window_width-60, 28);
    nexLL.text = eLocalizedString(@"login_all25");
    [self.view addSubview:nexLL];
    
    UIImageView *nexImg = [[UIImageView alloc] initWithFrame:CGRectMake((_window_width-14)/2, _window_height-41-TARBARHEIGHT, 14, 9)];
    nexImg.image = [UIImage imageNamed:@"dissm_nexImg_black"];
    nexImg.clipsToBounds = YES;
    [self.view addSubview:nexImg];
    
    UIButton *nexBtn = [[UIButton alloc] initWithFrame:CGRectMake((_window_width-100)/2, _window_height-41-TARBARHEIGHT, 100, 40)];
    [nexBtn addTarget:self action:@selector(nextBtnmethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nexBtn];
    
    [requestToolClass getNetworkWithUrl:request_login_countries andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.countrAr = info;
        [LYUserDefault saveCountiesArr:self.countrAr];
        if(self.countrAr.count > 0) {
            NSDictionary *dMM = self.countrAr[0];
            self.choseLab.text = minStr(dMM[@"name"]);
            self.countStr = minStr(dMM[@"id"]);
        }
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)selectMMMMMethod
{
    [self.view endEditing:YES];
    NSString *mmm = [HistoryRecordModel getCurrentTimeMethod:@"YYYY-MM-dd"];
    NSArray *ar_MM = [mmm componentsSeparatedByString:@"-"];
    NSString *l_s = minStr(ar_MM[0]);
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    // 2.设置属性
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = eLocalizedString(@"login_all24");
    // datePickerView.selectValue = @"2019-10-30";
    datePickerView.selectDate = [NSDate br_setYear:2017 month:1 day:1];
    datePickerView.minDate = [NSDate br_setYear:1949 month:10 day:12];
    datePickerView.maxDate = [NSDate br_setYear:[l_s integerValue]-17 month:1 day:1];//[NSDate date];
    datePickerView.isAutoSelect = YES;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
        self.ymdLab.text = selectValue;
    };
    [datePickerView show];
}

- (void)choseBtnMethod
{
    [self.view endEditing:YES];
    if(self.countrAr.count > 0) {
        
        NSMutableArray *namsArr = [NSMutableArray array];
        for (NSDictionary *dicM in self.countrAr) {
            [namsArr addObject:minStr(dicM[@"name"])];
        }
        
        BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
        stringPickerView.pickerMode = BRStringPickerComponentSingle;
        stringPickerView.title = eLocalizedString(@"login_all30");
        stringPickerView.dataSourceArr = namsArr;
        stringPickerView.selectIndex = 0;
        stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
            NSLog(@"选择的值：%@", resultModel.value);
            self.choseLab.text = resultModel.value;
            NSDictionary *dicM = self.countrAr[resultModel.index];
            self.countStr = minStr(dicM[@"id"]);
        };
        [stringPickerView show];
    }
}

- (void)nextBtnmethod
{
    if((self.ymdLab2.text.length>0)&&((self.ymdLab3.text.length>0))) {
        NSLog(@"%@", self.ymdLab.text);
        MHNexLoginController *vc = [[MHNexLoginController alloc] init];
        vc.ymdStr = self.ymdLab.text;
        vc.ymdStr2 = self.ymdLab2.text.length>0 ? self.ymdLab2.text : @"";
        vc.ymdStr3 = self.ymdLab3.text.length>0 ? self.ymdLab3.text : @"";
        vc.ymdStr4 = self.countStr;
        vc.phoneStr = self.phoneStr;
        vc.passworStr = self.passworStr;
        vc.codeStr = self.codeStr;
        vc.isEmilBoo = self.isEmilBoo;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
//        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_all30")];
    }
}

@end
