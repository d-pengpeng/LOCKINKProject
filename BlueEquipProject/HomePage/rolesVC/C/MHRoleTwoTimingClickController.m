//
//  MHRoleTwoTimingClickController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/19.
//

#import "MHRoleTwoTimingClickController.h"
#import "MHGearSetView.h"
#import "sliderVVView.h"
#import <BRStringPickerView.h>

@interface MHRoleTwoTimingClickController ()<TPVerticalVideoSliderViewDelegate>

@property (nonatomic, strong) sliderVVView *twoScrollV;
@property (nonatomic, strong) UILabel *secondLLab;
@property (nonatomic, copy) NSString *day_str;
@property (nonatomic, copy) NSString *hour_str;
@property (nonatomic, copy) NSString *min_str;
@property (nonatomic, copy) NSString *frequency;
@end

@implementation MHRoleTwoTimingClickController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.titleName.textColor = UIColor.blackColor;
    self.titleName.text = eLocalizedString(@"role_name39_39");
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    UIImageView *lockImgV = [HistoryRecordModel createImgImgView];
    lockImgV.frame = CGRectMake(12, NAVHEIGHT+10, 20, 20);
    lockImgV.image = [UIImage imageNamed:@"role_imgs22"];
    [self.view addSubview:lockImgV];
    
    UILabel *timingLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timingLab.frame = CGRectMake(38, lockImgV.y, _window_width/2, 20);
    timingLab.text = eLocalizedString(@"role_name47");
    [self.view addSubview:timingLab];
    
    
    int one_W1 = 60;
    int one_H1 = 34;
    int two_W1 = 36;
    CGFloat placF = (_window_width-(one_W1+two_W1)*3)/4;
    
    UIView *oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lockImgV.frame)+8, _window_width, one_H1*3)];
    oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:oneVV];
    
    self.day_str = @"0";
    self.hour_str = @"0";
    self.min_str = @"0";
    NSArray *houA = @[@"role_name14", @"role_name14_h", @"role_name14_m"];
    for (int j=0; j<houA.count; j++) {
        
        MHGearSetView *gearV = [[MHGearSetView alloc] initWithFrame:CGRectMake(placF+j*(one_W1+two_W1+placF), 0, one_W1, one_H1*3)];
        gearV.minFont = 20;
        gearV.maxFont = 24;
        gearV.heihh_h = one_H1;
        [oneVV addSubview:gearV];
        
        if(j==0) {
            gearV.block_ = ^(NSString * _Nonnull strLL) {
                self.day_str = strLL;
            };
            gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].dayArr];
        }else if (j==1) {
            gearV.block_ = ^(NSString * _Nonnull strLL) {
                self.hour_str = strLL;
            };
            gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].hourArr];
        }else {
            gearV.block_ = ^(NSString * _Nonnull strLL) {
                self.min_str = strLL;
            };
            gearV.imgArr = [NSMutableArray arrayWithArray:[LYUserDefault userDefault].mineArr];
        }
        
        UILabel *namLL = [HistoryRecordModel createLabLabTextColor:RGB(170, 170, 170) fontFloat:14 textAlignment:NSTextAlignmentCenter];
        namLL.frame = CGRectMake(placF+j*(one_W1+two_W1+placF)+one_W1, 0, two_W1, one_H1*3);
        namLL.text = eLocalizedString(houA[j]);
        [oneVV addSubview:namLL];
    }
    
    UILabel *timeLLLL = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentCenter];
    timeLLLL.frame = CGRectMake(12, CGRectGetMaxY(oneVV.frame)+6, _window_width-24, 36);
    timeLLLL.text = eLocalizedString(@"role_name48");
    [self.view addSubview:timeLLLL];
    
    UIView *linVP = [HistoryRecordModel createLineViewUIUI];
    linVP.frame = CGRectMake(0, CGRectGetMaxY(timeLLLL.frame), _window_width, 10);
    linVP.backgroundColor = RGB(243, 224, 251);
    [self.view addSubview:linVP];
    
    UIImageView *lockImgV2 = [HistoryRecordModel createImgImgView];
    lockImgV2.frame = CGRectMake(12, CGRectGetMaxY(linVP.frame), 20, 20);
    lockImgV2.image = [UIImage imageNamed:@"role_imgs23"];
    [self.view addSubview:lockImgV2];
    
    UILabel *timingLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timingLab2.frame = CGRectMake(38, lockImgV2.y, _window_width/2, 20);
    timingLab2.text = eLocalizedString(@"role_name49");
    [self.view addSubview:timingLab2];
    
    UILabel *timingLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timingLab3.frame = CGRectMake(12, CGRectGetMaxY(lockImgV2.frame)+4, _window_width-24, 38);
    timingLab3.text = eLocalizedString(@"role_name50");
    [self.view addSubview:timingLab3];
    
    self.frequency = @"1";
    NSArray *namsAr = @[@"role_name43", @"role_name44", @"role_name45"];
    NSArray *imgsAr = @[@"role_electImgs1", @"role_electImgs2", @"role_electImgs3"];
    CGFloat w_xx = (_window_width-88*3)/3;
    for (int i=0; i<namsAr.count; i++) {
    
        UIButton *thrBtnBB = [[UIButton alloc] initWithFrame:CGRectMake(w_xx/2 + i*(w_xx+88), CGRectGetMaxY(timingLab3.frame), 88, 64)];
        [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgNor"] forState:UIControlStateNormal];
        [thrBtnBB setBackgroundImage:[UIImage imageNamed:@"role_electImgSel"] forState:UIControlStateSelected];
        thrBtnBB.tag = 5600+i;
        [thrBtnBB addTarget:self action:@selector(thrBtnMethodS:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:thrBtnBB];
        if(i==0) {
            thrBtnBB.selected = YES;
        }
        
        UIImageView *imgThr = [HistoryRecordModel createImgImgView];
        imgThr.frame = CGRectMake(11, 12, 66, 22);
        imgThr.image = [UIImage imageNamed:imgsAr[i]];
        [thrBtnBB addSubview:imgThr];
        
        UILabel *namLLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
        namLLab.frame = CGRectMake(0, 34, 88, 26);
        namLLab.text = eLocalizedString(namsAr[i]);
        [thrBtnBB addSubview:namLLab];
        
    }
    
    UILabel *timingLab4 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timingLab4.frame = CGRectMake(12, CGRectGetMaxY(timingLab3.frame)+84, _window_width-24, 34);
    timingLab4.text = eLocalizedString(@"role_name30");
    [self.view addSubview:timingLab4];
    
    self.twoScrollV = [[sliderVVView alloc] initWithFrame:CGRectMake(46, CGRectGetMaxY(timingLab4.frame)+10, _window_width-92, 24)];
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
    [self.view addSubview:self.twoScrollV];
    
    for (int i=0; i<2; i++) {
        UIImageView *imgElec = [HistoryRecordModel createImgImgView];
        [self.view addSubview:imgElec];
        if(i==0) {
            imgElec.frame = CGRectMake(17, CGRectGetMaxY(timingLab4.frame)+6, 17, 24);
            imgElec.image = [UIImage imageNamed:@"role_imgs19"];
        }else {
            imgElec.frame = CGRectMake(_window_width-34, CGRectGetMaxY(timingLab4.frame)+6, 17, 24);
            imgElec.image = [UIImage imageNamed:@"role_imgs20"];
        }
    }
    
    UILabel *timingLab5 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    timingLab5.frame = CGRectMake(12, CGRectGetMaxY(timingLab4.frame)+44, _window_width-24, 34);
    timingLab5.text = eLocalizedString(@"role_name51");
    [self.view addSubview:timingLab5];
    
    UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
    nexImgv.frame = CGRectMake(_window_width-26, timingLab5.y+10, 14, 14);
    nexImgv.image = [UIImage imageNamed:@"home_next2"];
    [self.view addSubview:nexImgv];
    

    self.secondLLab = [HistoryRecordModel createLabLabTextColor:RGB(138, 0, 197) fontFloat:14 textAlignment:NSTextAlignmentRight];
    self.secondLLab.frame = CGRectMake(100, timingLab5.y, _window_width-34-100, 34);
    self.secondLLab.text = @"10s";
    [self.view addSubview:self.secondLLab];
    
    UIButton *clickBBBB = [[UIButton alloc] initWithFrame:CGRectMake(100, timingLab5.y-10, _window_width-100, 54)];
    [clickBBBB addTarget:self action:@selector(secondClickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBBBB];
    
    UIButton *chatBtn = [HistoryRecordModel createImgBtn];
    chatBtn.frame = CGRectMake((_window_width-122)/2, CGRectGetMaxY(clickBBBB.frame)+60, 122, 36);
    [chatBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [chatBtn setTitle:eLocalizedString(@"home_edit_save") forState:UIControlStateNormal];
    [chatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    chatBtn.titleLabel.font = SYS_Font(14);
    [chatBtn addTarget:self action:@selector(chatBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatBtn];
    
}

- (void)chatBtnMethod:(UIButton *)btn
{
    NSString *valta = [NSString stringWithFormat:@"%.f", self.twoScrollV.value*100];
    NSArray *durAr = [self.secondLLab.text componentsSeparatedByString:@"s"];
    [SVProgressHUD show];
    NSDictionary *dic = @{@"deviceId":self.devicId, @"days":self.day_str, @"hours":self.hour_str, @"minutes":self.min_str, @"frequency":self.frequency, @"voltage":minIntStr([valta intValue]), @"duration":minStr(durAr[0])};
    [requestToolClass postNetworkWithUrl:request_device_addScheduledElectricShock andParameter:dic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        btn.userInteractionEnabled = YES;
        if(self.block_) {
            self.block_();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSString * _Nonnull msg) {
        btn.userInteractionEnabled = YES;
    }];
    
    btn.userInteractionEnabled = NO;
}

//MARK: 选择电压时长
- (void)secondClickBtnMethod
{
    int num_num = 9;
    NSString *st_l = minStr(self.secondLLab.text);
    NSMutableArray *namsArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        NSString *ssL_st = [NSString stringWithFormat:@"%d%@", i+1, @"s"];
        if([ssL_st isEqualToString:st_l]) {
            num_num = i;
        }
        [namsArr addObject:ssL_st];
    }
    
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
    stringPickerView.pickerMode = BRStringPickerComponentSingle;
    stringPickerView.title = eLocalizedString(@"role_name51");
    stringPickerView.dataSourceArr = namsArr;
    stringPickerView.selectIndex = num_num;
    stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
        NSLog(@"选择的值：%@", resultModel.value);
        self.secondLLab.text = resultModel.value;
    };
    [stringPickerView show];
}

//MARK: 电击频率
- (void)thrBtnMethodS:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        
        UIButton *strB = [self.view viewWithTag:5600+i];
        if(btn == strB) {
            self.frequency = minIntStr(i+1);
            strB.selected = YES;
        }else {
            strB.selected = NO;
        }
    }
}

@end
