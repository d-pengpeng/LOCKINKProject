//
//  MHPostRoleController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "MHPostRoleController.h"
#import "LFImagePickerController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PopBottomView.h"
#import <CoreLocation/CoreLocation.h>
#import "MHVioceRecordView.h"
#import "TUIDefine.h"
#import <BRDatePickerView.h>
#import "MHPostConditionsController.h"
#import "MHSearchLocationController.h"

@interface MHPostRoleController ()<UITextViewDelegate, LFImagePickerControllerDelegate, CLLocationManagerDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, copy) NSString *wavPath;

@property (nonatomic, strong) UIImage *voiceImage;
@property (nonatomic, strong) NSArray *voiceAnimationImages;
@property (nonatomic, strong) UIImageView *voice;
@property (nonatomic, strong) UILabel *duration;
@property (nonatomic, copy) NSString *pathOne;
@property (nonatomic, assign) BOOL isPPlayb;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) UIView *one_VV;
@property (nonatomic, strong) UIView *two_VV;
@property (nonatomic, strong) UIView *thr_VV;
@property (nonatomic, strong) UIView *fou_VV;
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UILabel *placeLab;
@property (nonatomic, strong) UILabel *numberLab;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *Videos;

@property (nonatomic, copy) NSString *imgUrlStr;

@property (nonatomic, strong) UILabel *addresLab;
@property (nonatomic, strong) UILabel *addresLab2;
@property (nonatomic, copy) NSString *adresMsg;

@property (nonatomic, strong) UILabel *settingLab;
@property (nonatomic, strong) UILabel *settingLab2;
@property (nonatomic, strong) UILabel *settingLab3;
@property (nonatomic, strong) UIScrollView *oneScrollVV;
@property (nonatomic, copy) NSString *thrTyp;
@property (nonatomic, strong) NSArray *cytjArr; //参与条件
@end

@implementation MHPostRoleController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
}

-(CLGeocoder *)geocoder{
    if (_geocoder==nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDelegate:self];
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.redNavView = YES;
    self.titleName.text = eLocalizedString(@"plaza_all12");
    self.showImgVV = YES;
    
    UIButton *rightImgBtn = [[UIButton alloc] init];
    rightImgBtn.frame = CGRectMake(_window_width-12-42, TIMESTATUSHEIGHT+12, 42, 20);
    [rightImgBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_Imgs2"] forState:UIControlStateNormal];
    [rightImgBtn setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
    [rightImgBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightImgBtn.titleLabel.font = SYS_Font(12);
    [rightImgBtn addTarget:self action:@selector(pulishImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightImgBtn];
    
    self.imgUrlStr = @"";
    self.thrTyp = @"";
    self.cytjArr = @[@"1", @"18", @"70", @"", @"", @"", @"", @""];
    self.photos = [NSMutableArray array];
    self.Videos = [NSMutableArray array];
    
    UIScrollView *scrollVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    scrollVV.backgroundColor = UIColor.clearColor;
    scrollVV.showsVerticalScrollIndicator = NO;
    scrollVV.showsHorizontalScrollIndicator = NO;
    scrollVV.bounces = NO;
    [self.view addSubview:scrollVV];
    self.oneScrollVV = scrollVV;
    
    UITapGestureRecognizer *tapGestureL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVVAction:)];
    [scrollVV addGestureRecognizer:tapGestureL];
    
    self.fou_VV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, _window_width, 244)];
    self.fou_VV.backgroundColor = UIColor.clearColor;
    [scrollVV addSubview:self.fou_VV];
    
    self.one_VV = [HistoryRecordModel createViewUIUI];
    self.one_VV.frame = CGRectMake(12, CGRectGetMaxY(self.fou_VV.frame), _window_width-24, 162);
    self.one_VV.backgroundColor = UIColor.clearColor;
    self.one_VV.layer.cornerRadius = 0;
    [scrollVV addSubview:self.one_VV];
    
    UIImageView *placeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 152)];
    placeImgV.image = [UIImage imageNamed:@"sqarePost_Imgs1_1"];
    [self.one_VV addSubview:placeImgV];
    
    self.two_VV = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92)];
    [scrollVV addSubview:self.two_VV];
    
    self.thr_VV = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101)];
    self.thr_VV.clipsToBounds = YES;
    self.thr_VV.layer.cornerRadius = 8;
    self.thr_VV.backgroundColor = UIColor.clearColor;
    [scrollVV addSubview:self.thr_VV];
    
    scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
    
    UILabel *fou_lab1 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    fou_lab1.frame = CGRectMake(12, 0, _window_width-24, 28);
    fou_lab1.text = eLocalizedString(@"my_settings");
    [self.fou_VV addSubview:fou_lab1];
    
    UILabel *fou_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    fou_lab2.frame = CGRectMake(12, 210, _window_width-24, 28);
    fou_lab2.text = eLocalizedString(@"role_name11");
    [self.fou_VV addSubview:fou_lab2];
    
    UIView *fouVVV = [HistoryRecordModel createViewUIUI];
    fouVVV.frame = CGRectMake(12, 34, _window_width-24, 162);
    fouVVV.backgroundColor = RGB(89, 26, 115);
    [self.fou_VV addSubview:fouVVV];
    
    NSArray *namsAr2 = @[@"find_detail2", @"find_detail3", @"role_name12"];
    for (int i=0; i<namsAr2.count; i++) {
        
        UILabel *adresLLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        
        adresLLlab.numberOfLines = 0;
        adresLLlab.text = eLocalizedString(namsAr2[i]);
        [fouVVV addSubview:adresLLlab];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        
        nexImgv.image = [UIImage imageNamed:@"home_next2_2"];
        [fouVVV addSubview:nexImgv];
        
        if(i==0){
            nexImgv.hidden = YES;
            adresLLlab.frame = CGRectMake(10, 15, 160, 24);
            nexImgv.frame = CGRectMake(fouVVV.width-24, 20, 14, 14);
            
            UIImageView *imgV_two = [[UIImageView alloc] initWithFrame:CGRectMake(12, 44, 10, 10)];
            imgV_two.image = [UIImage imageNamed:@"center_img14"];
            imgV_two.clipsToBounds = YES;
            [fouVVV addSubview:imgV_two];
            
            UILabel *msg_lab = [HistoryRecordModel createLabLabTextColor:RGB(217, 217, 217) fontFloat:10 textAlignment:NSTextAlignmentLeft];
            msg_lab.frame = CGRectMake(26, 39, 300, 20);
            msg_lab.text = eLocalizedString(@"role_name13");
            [fouVVV addSubview:msg_lab];
            
            UILabel *msg_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            msg_lab2.text = eLocalizedString(@"role_name14");
            [fouVVV addSubview:msg_lab2];
            [msg_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(fouVVV.mas_right).offset(-10);
                make.centerY.equalTo(adresLLlab.mas_centerY);
            }];
            
            self.settingLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            [fouVVV addSubview:self.settingLab];
            [self.settingLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(msg_lab2.mas_left).offset(-3);
                make.centerY.equalTo(adresLLlab.mas_centerY);
            }];
            
            UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(fouVVV.width/2, 0, fouVVV.width/2-32, 50)];
            [towAlSelBtn addTarget:self action:@selector(settingMethodUI) forControlEvents:UIControlEventTouchUpInside];
            [fouVVV addSubview:towAlSelBtn];
            
            UIView *linVV = [HistoryRecordModel createLineViewUIUI];
            linVV.frame = CGRectMake(10, 63, fouVVV.width-20, 1);
            linVV.backgroundColor = RGB(114, 44, 142);
            [fouVVV addSubview:linVV];
        }else if(i==1){
            
            adresLLlab.frame = CGRectMake(10, 64, 160, 46);
            nexImgv.frame = CGRectMake(fouVVV.width-24, 64+16, 14, 14);
            
            self.settingLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            self.settingLab2.frame = CGRectMake(fouVVV.width/2, 64, fouVVV.width/2-32, 46);
            [fouVVV addSubview:self.settingLab2];
            
            UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(fouVVV.width/2, 64, fouVVV.width/2-32, 46)];
            [towAlSelBtn addTarget:self action:@selector(settingMethodUITwo) forControlEvents:UIControlEventTouchUpInside];
            [fouVVV addSubview:towAlSelBtn];
            
            UIView *linVV = [HistoryRecordModel createLineViewUIUI];
            linVV.frame = CGRectMake(10, 64+45, fouVVV.width-20, 1);
            linVV.backgroundColor = RGB(114, 44, 142);
            [fouVVV addSubview:linVV];
        }else {
            adresLLlab.frame = CGRectMake(10, 64+44, 160, 46);
            nexImgv.frame = CGRectMake(fouVVV.width-24, 64+44+16, 14, 14);
            
            self.settingLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            self.settingLab3.frame = CGRectMake(fouVVV.width/2, 64+46, fouVVV.width/2-32, 46);
            [fouVVV addSubview:self.settingLab3];
            
            UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(fouVVV.width/2, 64+46, fouVVV.width/2-32, 46)];
            [towAlSelBtn addTarget:self action:@selector(settingMethodUIThr) forControlEvents:UIControlEventTouchUpInside];
            [fouVVV addSubview:towAlSelBtn];
        }
    }
    
    
    
    UIImageView *placeImgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 101)];
    placeImgV2.image = [UIImage imageNamed:@"sqarePost_Imgs1"];
    [self.thr_VV addSubview:placeImgV2];
    
    self.placeLab = [HistoryRecordModel createLabLabTextColor:RGB(169, 169, 169) fontFloat:14 textAlignment:NSTextAlignmentLeft];
    self.placeLab.text = eLocalizedString(@"postPlaza_placeText");
    [self.one_VV addSubview:self.placeLab];
    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.one_VV.mas_left).offset(12);
        make.top.equalTo(self.one_VV.mas_top).offset(18);
    }];
    
    self.numberLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentRight];
    self.numberLab.text = @"0/1000";
    [self.one_VV addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.one_VV.mas_right).offset(-12);
        make.bottom.equalTo(self.one_VV.mas_bottom).offset(-22);
    }];
    
    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(12, 12, self.one_VV.width-24, self.one_VV.height-24)];
    self.textV.font = SYS_Font(14);
    self.textV.textColor = UIColor.whiteColor;
    self.textV.backgroundColor = UIColor.clearColor;
    self.textV.delegate = self;
    self.textV.returnKeyType = UIReturnKeyDone;
    [self.one_VV addSubview:self.textV];
    
    NSArray *imgsAr = @[@"sqarePost_Imgs3_3", @"sqarePost_Imgs4_4"];
    NSArray *namsAr = @[@"plaza_all15", @"plaza_all16"];
    for (int i=0; i<imgsAr.count; i++) {
        
        UIImageView *adresImg = [HistoryRecordModel createImgImgView];
        adresImg.frame = CGRectMake(10, 17+i*51, 16, 16);
        adresImg.image = [UIImage imageNamed:imgsAr[i]];
        [self.thr_VV addSubview:adresImg];
        
        UILabel *adresLLlab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        adresLLlab.frame = CGRectMake(34, i*51, 100, 50);
        adresLLlab.numberOfLines = 0;
        adresLLlab.text = eLocalizedString(namsAr[i]);
        [self.thr_VV addSubview:adresLLlab];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        nexImgv.frame = CGRectMake(self.thr_VV.width-24, 18+i*51, 14, 14);
        nexImgv.image = [UIImage imageNamed:@"home_next2_2"];
        [self.thr_VV addSubview:nexImgv];
        
        if(i==0){
            self.addresLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            self.addresLab.frame = CGRectMake(self.thr_VV.width/2, 0, self.thr_VV.width/2-32, 50);
            
            [self.thr_VV addSubview:self.addresLab];
            
            UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.thr_VV.width/2, i*51, self.thr_VV.width/2, 50)];
            [towAlSelBtn addTarget:self action:@selector(twoMethodUIUIOne) forControlEvents:UIControlEventTouchUpInside];
            [self.thr_VV addSubview:towAlSelBtn];
            
        }else {
            self.addresLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            self.addresLab2.frame = CGRectMake(self.thr_VV.width/2, 51, self.thr_VV.width/2-32, 50);
            [self.thr_VV addSubview:self.addresLab2];
            
            UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.thr_VV.width/2, i*51, self.thr_VV.width/2, 50)];
            [towAlSelBtn addTarget:self action:@selector(twoMethodUIUI) forControlEvents:UIControlEventTouchUpInside];
            [self.thr_VV addSubview:towAlSelBtn];
        }
    }
    UIView *linV = [HistoryRecordModel createLineViewUIUI];
    linV.frame = CGRectMake(12, 50, self.thr_VV.width-24, 1);
    linV.backgroundColor = UIColor.whiteColor;
    [self.thr_VV addSubview:linV];
    
    UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
    addFilBtn.frame = CGRectMake(0, 0, 92, 92);
    [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
    [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.two_VV addSubview:addFilBtn];
    
    self.addresLab2.text = eLocalizedString(@"plaza_all17");
    self.adresMsg = @"PUBLIC";
    
}

- (void)rigLabBtnMethod
{
    [self.view endEditing:YES];
}

- (void)tapVVAction:(UITapGestureRecognizer *)tapGesture{
    
    [self.view endEditing:YES];
}

//MARK: 设置
- (void)settingMethodUI
{
    [self.view endEditing:YES];
    PopModifyView *modify = [[PopModifyView alloc]init];
    modify.titleString = eLocalizedString(@"find_detail2");
    modify.isSingleCommit = YES;
    modify.textfield.keyboardType = UIKeyboardTypeNumberPad;
    modify.blockTextToModify = ^(NSString *name, NSString *phone) {
        
        self.settingLab.text = name;
    };
    [modify show];
}
- (void)settingMethodUITwo
{
    [self.view endEditing:YES];
    NSString *mmm = [HistoryRecordModel getCurrentTimeMethod:@""];
    NSArray *ar_MM = [mmm componentsSeparatedByString:@" "];
    
    NSArray *ar_MM2 = [minStr(ar_MM[0]) componentsSeparatedByString:@"-"];
    NSArray *ar_MM3 = [minStr(ar_MM[1]) componentsSeparatedByString:@":"];
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    // 2.设置属性
    datePickerView.pickerMode = BRDatePickerModeYMDHM;
    datePickerView.title = eLocalizedString(@"find_detail3");
    datePickerView.selectDate = [NSDate br_setYear:[ar_MM2[0] intValue] month:[ar_MM2[1] intValue] day:[ar_MM2[2] intValue] hour:[ar_MM3[0] intValue] minute:[ar_MM3[1] intValue]];
    datePickerView.minDate = [NSDate br_setYear:[ar_MM2[0] intValue] month:[ar_MM2[1] intValue] day:[ar_MM2[2] intValue] hour:[ar_MM3[0] intValue] minute:[ar_MM3[1] intValue]];
//    datePickerView.maxDate = [NSDate br_setYear:[l_s integerValue]-17 month:1 day:1];
    datePickerView.isAutoSelect = YES;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
        self.settingLab2.text = selectValue;
    };
    [datePickerView show];
}
- (void)settingMethodUIThr
{
    [self.view endEditing:YES];
    MHPostConditionsController *vc = [[MHPostConditionsController alloc] init];
    vc.arrFind = self.cytjArr;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^(NSArray * _Nonnull arr) {
        self.settingLab3.text = eLocalizedString(@"role_name15");
        self.cytjArr = arr;
    };
}

- (void)pulishImageAction
{
    [self.view endEditing:YES];
//    if((self.textV.text.length>0) && ((self.photos.count>0) || (self.pathOne.length>0))) {
    if(self.settingLab2.text.length>0) {
        NSInteger num_ty = 1;
        NSMutableArray *arMut = [NSMutableArray array];
        if(self.pathOne.length>0) {
            
            NSURL *url = [NSURL fileURLWithPath:self.pathOne];
            NSData *dataVideo = [NSData dataWithContentsOfURL:url];
            [arMut addObject:dataVideo];
            
            num_ty = 2;
            [SVProgressHUD show];
            if(num_ty == 3) {
                
                [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    [LYUserDefault saveQCloudDic:info];
                    
                    [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:num_ty andImageData:@[arMut[0]] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        NSArray *oneAr = info;
                        self.imgUrlStr = oneAr.count>0 ? minStr(oneAr[0]):@"";
                        [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:@[arMut[1]] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                            NSArray *oneArTwo = info;
                            self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, oneArTwo.count>0 ? minStr(oneArTwo[0]):@""];
                            [self uploadRequestMMM];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD dismiss];
                        }];
                    } fail:^(NSString * _Nonnull msg) {
                        [SVProgressHUD dismiss];
                    }];
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD dismiss];
                }];
                
            }else {

                [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    [LYUserDefault saveQCloudDic:info];
                    
                    [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:num_ty andImageData:arMut success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        NSArray *oneAr = info;
                        for (NSString *liUrl in oneAr) {
                            if(self.imgUrlStr.length > 0) {
                                self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, liUrl];
                            }else {
                                self.imgUrlStr = liUrl;
                            }
                        }
                        [self uploadRequestMMM];
                    } fail:^(NSString * _Nonnull msg) {
                        [SVProgressHUD dismiss];
                    }];
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD dismiss];
                }];
            }
        }else if(self.photos.count>0) {
            if(self.Videos.count > 0) {
                
                LFResultVideo *resultVideo = self.photos[0];
                NSData *dataImg = UIImageJPEGRepresentation(resultVideo.smallImage, 0.9);
                
                NSURL *outfileUrl = [NSURL fileURLWithPath:self.Videos[0]];
                NSData *dataVideo = [NSData dataWithContentsOfURL:outfileUrl];
                
                [arMut addObject:dataVideo];
                [arMut addObject:dataImg];
                num_ty = 3;
            }else {
                for (int i=0; i<self.photos.count; i++) {
                    LFResultVideo *resultVideo = self.photos[i];
                    NSData *dataImg = UIImageJPEGRepresentation(resultVideo.smallImage, 0.9);
                    [arMut addObject:dataImg];
                }
            }
            [SVProgressHUD show];
            if(num_ty == 3) {
                
                [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    [LYUserDefault saveQCloudDic:info];
                    
                    [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:num_ty andImageData:@[arMut[0]] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        NSArray *oneAr = info;
                        self.imgUrlStr = oneAr.count>0 ? minStr(oneAr[0]):@"";
                        [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:@[arMut[1]] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                            NSArray *oneArTwo = info;
                            self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, oneArTwo.count>0 ? minStr(oneArTwo[0]):@""];
                            [self uploadRequestMMM];
                        } fail:^(NSString * _Nonnull msg) {
                            [SVProgressHUD dismiss];
                        }];
                    } fail:^(NSString * _Nonnull msg) {
                        [SVProgressHUD dismiss];
                    }];
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD dismiss];
                }];
                
            }else {

                [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    [LYUserDefault saveQCloudDic:info];
                    
                    [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:num_ty andImageData:arMut success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        NSArray *oneAr = info;
                        for (NSString *liUrl in oneAr) {
                            if(self.imgUrlStr.length > 0) {
                                self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, liUrl];
                            }else {
                                self.imgUrlStr = liUrl;
                            }
                        }
                        [self uploadRequestMMM];
                    } fail:^(NSString * _Nonnull msg) {
                        [SVProgressHUD dismiss];
                    }];
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD dismiss];
                }];
            }
        }else {
            [self uploadRequestMMM];
        }
    }else {
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err7")];
    }
//        NSInteger num_ty = 1;
//        NSMutableArray *arMut = [NSMutableArray array];
//        if(self.pathOne.length>0) {
//            
//            NSURL *url = [NSURL fileURLWithPath:self.pathOne];
//            NSData *dataVideo = [NSData dataWithContentsOfURL:url];
//            [arMut addObject:dataVideo];
//            
//            num_ty = 2;
//        }else {
//            if(self.Videos.count > 0) {
//                
//                LFResultVideo *resultVideo = self.photos[0];
//                NSData *dataImg = UIImageJPEGRepresentation(resultVideo.smallImage, 0.9);
//                
//                NSURL *outfileUrl = [NSURL fileURLWithPath:self.Videos[0]];
//                NSData *dataVideo = [NSData dataWithContentsOfURL:outfileUrl];
//                
//                [arMut addObject:dataVideo];
//                [arMut addObject:dataImg];
//                num_ty = 3;
//            }else {
//                for (int i=0; i<self.photos.count; i++) {
//                    LFResultVideo *resultVideo = self.photos[i];
//                    NSData *dataImg = UIImageJPEGRepresentation(resultVideo.smallImage, 0.9);
//                    [arMut addObject:dataImg];
//                }
//            }
//        }
//        [SVProgressHUD show];
//        if(num_ty == 3) {
//            
//            [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                [LYUserDefault saveQCloudDic:info];
//                
//                [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:num_ty andImageData:@[arMut[0]] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                    
//                    NSArray *oneAr = info;
//                    self.imgUrlStr = oneAr.count>0 ? minStr(oneAr[0]):@"";
//                    [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:@[arMut[1]] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                        NSArray *oneArTwo = info;
//                        self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, oneArTwo.count>0 ? minStr(oneArTwo[0]):@""];
//                        [self uploadRequestMMM];
//                    } fail:^(NSString * _Nonnull msg) {
//                        [SVProgressHUD dismiss];
//                    }];
//                } fail:^(NSString * _Nonnull msg) {
//                    [SVProgressHUD dismiss];
//                }];
//            } fail:^(NSString * _Nonnull msg) {
//                [SVProgressHUD dismiss];
//            }];
//            
//        }else {
//
//            [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                [LYUserDefault saveQCloudDic:info];
//                
//                [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:num_ty andImageData:arMut success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                    
//                    NSArray *oneAr = info;
//                    for (NSString *liUrl in oneAr) {
//                        if(self.imgUrlStr.length > 0) {
//                            self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, liUrl];
//                        }else {
//                            self.imgUrlStr = liUrl;
//                        }
//                    }
//                    [self uploadRequestMMM];
//                } fail:^(NSString * _Nonnull msg) {
//                    [SVProgressHUD dismiss];
//                }];
//            } fail:^(NSString * _Nonnull msg) {
//                [SVProgressHUD dismiss];
//            }];
//        }
//    }
}

- (void)uploadRequestMMM
{
    NSString *locat_str = @"";
    if(self.addresLab.text.length > 0) {
        locat_str = self.addresLab.text;
    }
    NSDictionary *dicMMM = @{@"deviceId":minIntStr(self.modelM.id), @"transferDays":@"-1", @"deadline":minStr(self.settingLab2.text), @"conditions":@{@"ageRangeStart":self.cytjArr[1], @"ageRangeEnd":self.cytjArr[2], @"genderRange":self.cytjArr[3], @"genderPreferenceRange":self.cytjArr[4], @"rolePreferenceRange":self.cytjArr[5], @"locationId":self.cytjArr[6]}, @"text":minStr(self.textV.text), @"mediaUrls":self.imgUrlStr, @"mediaType":self.thrTyp, @"location":locat_str, @"visibility":self.adresMsg};
    if([minStr(self.settingLab.text) intValue] > 0) {
        dicMMM = @{@"deviceId":minIntStr(self.modelM.id), @"transferDays":minStr(self.settingLab.text), @"deadline":minStr(self.settingLab2.text), @"conditions":@{@"ageRangeStart":self.cytjArr[1], @"ageRangeEnd":self.cytjArr[2], @"genderRange":self.cytjArr[3], @"genderPreferenceRange":self.cytjArr[4], @"rolePreferenceRange":self.cytjArr[5], @"locationId":self.cytjArr[6]}, @"text":minStr(self.textV.text), @"mediaUrls":self.imgUrlStr, @"mediaType":self.thrTyp, @"location":locat_str, @"visibility":self.adresMsg};
    }
    [requestToolClass postNetworkWithUrl:request_seekingMasterRecord_post andParameter:dicMMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)twoMethodUIUIOne
{
    MHSearchLocationController *vc = [[MHSearchLocationController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^(NSString * _Nonnull strLLL) {
        self.addresLab.text = strLLL;
    };
    
//    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    [self.locationManager startUpdatingLocation];

}
//MARK: 定位
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
 
    if(locations.count > 0) {
        
        CLLocation * location1 = [locations lastObject];
        
        [self.locationManager stopUpdatingLocation];
        
        [self.geocoder reverseGeocodeLocation:location1 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error == nil)
            {
                CLPlacemark *pl = [placemarks firstObject];
                //获得的定位信息
                NSString * str = pl.name;
        
                NSString * str2 = pl.thoroughfare;
                //获得所在的位置(某市)
                NSString * str3 = pl.locality;
                //获得所在市的某区
                NSString * str4 = pl.subLocality;
                //获得省份(形成区域)
                NSString * str5 = pl.administrativeArea;
                if(str4) {
                    self.addresLab.text = [NSString stringWithFormat:@"%@%@%@%@", str5, str3, str4, str];
                }else {
                    self.addresLab.text = [NSString stringWithFormat:@"%@%@%@%@", str5, str3, str2, str];
                }
            }else {
                NSLog(@"错误");
            }
        }];
    }
}

//MARK: 范围
- (void)twoMethodUIUI
{
    NSArray *array = @[@{@"name":eLocalizedString(@"plaza_all17"),@"id":@"PUBLIC"},@{@"name":eLocalizedString(@"plaza_all18"),@"id":@"FRIENDS"},@{@"name":eLocalizedString(@"plaza_all19"),@"id":@"PRIVATE"}];
    PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
    pop.cancelColor = GrayTextColor;
    pop.data = array;
    pop.blockCallBackIndex = ^(NSDictionary *dictionary){
        
        self.addresLab2.text = minStr(dictionary[@"name"]);
        self.adresMsg = minStr(dictionary[@"id"]);
    };
    [pop viewShow];
}


- (void)addFileBtnMethod
{
    [self.view endEditing:YES];
    
    NSArray *array = @[@{@"name":eLocalizedString(@"plaza_all20"),@"id":@"3"},@{@"name":eLocalizedString(@"plaza_all21"),@"id":@"2"},@{@"name":eLocalizedString(@"plaza_all22"),@"id":@"1"},@{@"name":eLocalizedString(@"home_Cancel")}];
    PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
    pop.cancelColor = GrayTextColor;
    pop.data = array;
    pop.blockCallBackIndex = ^(NSDictionary *dictionary){
        NSLog(@"index = %@",dictionary);
        
        if ([dictionary[@"id"] intValue] == 3) {
           
            [self choosePhotosMethod];
        }else if ([dictionary[@"id"] intValue] == 2) {
            
            [self chooseVideoMethod];
        }else if ([dictionary[@"id"] intValue] == 1) {
            [self voiceMMMMet];
        }
    };
    [pop viewShow];
}

//MARK: 语音
- (void)voiceMMMMet
{
    MHVioceRecordView *vc = [[MHVioceRecordView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    vc.block_ = ^(NSString * _Nonnull pathUrl, int oneIn, int twoIn) {
      
        [self.photos removeAllObjects];
        [self.Videos removeAllObjects];
        self.pathOne = pathUrl;
        
        self.thrTyp = @"AUDIO";
        [self.two_VV removeAllSubviews];
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
        self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        self.oneScrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
        
        UIButton *imgBtn = [HistoryRecordModel createImgBtn];
        imgBtn.frame = CGRectMake(0, 30, 174, 32);
        imgBtn.backgroundColor = normalPurpleColors;
        imgBtn.layer.cornerRadius = 16;
        [imgBtn addTarget:self action:@selector(voiceMMMMMM:) forControlEvents:UIControlEventTouchUpInside];
        [self.two_VV addSubview:imgBtn];
        
        UIImageView *logPlayImgv = [HistoryRecordModel createImgImgView];
        logPlayImgv.frame = CGRectMake(10, 5, 22, 22);
        logPlayImgv.image = [UIImage imageNamed:@"playVoice_img"];
        logPlayImgv.tag = 8300;
        [imgBtn addSubview:logPlayImgv];
        
        UIImageView *logPlayImgv2 = [HistoryRecordModel createImgImgView];
        logPlayImgv2.frame = CGRectMake(44, 6, 66, 20);
        logPlayImgv2.image = [UIImage imageNamed:@"playVoice_img2"];
        [imgBtn addSubview:logPlayImgv2];
        
        self.duration = [[UILabel alloc] initWithFrame:CGRectMake(110, 3, 52, 26)];
        self.duration.textAlignment = NSTextAlignmentRight;
        self.duration.font = [UIFont systemFontOfSize:10];
        self.duration.textColor = [UIColor whiteColor];
        [imgBtn addSubview:self.duration];
        self.duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:oneIn]];
        
        UIButton *deleteBtn = [HistoryRecordModel createImgBtn];
        deleteBtn.frame = CGRectMake(imgBtn.width, 20, 20, 20);
        [deleteBtn setImage:[UIImage imageNamed:@"startL_vipbtnDelet"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleVoiceMMmethod) forControlEvents:UIControlEventTouchUpInside];
        [self.two_VV addSubview:deleteBtn];
        
        
//        CGFloat w_max = 80+oneIn*1;
//        if(w_max>240) {
//            w_max = 240;
//        }
//        UIButton *imgBtn = [HistoryRecordModel createImgBtn];
//        imgBtn.frame = CGRectMake(0, 26, w_max, 40);
//        imgBtn.backgroundColor = normalColors;
//        imgBtn.layer.cornerRadius = 5;
//        [imgBtn addTarget:self action:@selector(voiceMMMMMM:) forControlEvents:UIControlEventTouchUpInside];
//        [self.two_VV addSubview:imgBtn];
//
//        UIButton *deleteBtn = [HistoryRecordModel createImgBtn];
//        deleteBtn.frame = CGRectMake(imgBtn.width, 20, 20, 20);
//        [deleteBtn setImage:[UIImage imageNamed:@"startL_vipbtnDelet"] forState:UIControlStateNormal];
//        [deleteBtn addTarget:self action:@selector(deleVoiceMMmethod) forControlEvents:UIControlEventTouchUpInside];
//        [self.two_VV addSubview:deleteBtn];
//
//        [self.voice removeFromSuperview];
//        self.voice = nil;
//        [self.duration removeFromSuperview];
//        self.duration = nil;
//
//        self.voice = [[UIImageView alloc] initWithFrame:CGRectMake(imgBtn.width-40, 5, 30, 30)];
//        self.voice.animationDuration = 1;
//        [imgBtn addSubview:self.voice];
//
//        self.duration = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, imgBtn.width-45, 30)];
//        self.duration.textAlignment = NSTextAlignmentRight;
//        self.duration.font = [UIFont systemFontOfSize:10];
//        self.duration.textColor = [UIColor whiteColor];
//        [imgBtn addSubview:self.duration];
//
//        self.duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:oneIn]];
//
//        self.voice.image = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_normal")];
//        self.voice.animationImages = [NSArray arrayWithObjects:
//                                  [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_1")],
//                                  [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_2")],
//                                  [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_3")], nil];
    };
}

//MARK: 播放语音
- (void)voiceMMMMMM:(UIButton *)btnVoic
{
    if(self.pathOne.length > 0) {
        
        if(self.isPPlayb) {
            return;
        }
        self.isPPlayb = YES;
        
        btnVoic.selected = !btnVoic.selected;
        
        UIImageView *logPlayImgv = [btnVoic viewWithTag:8300];
        if(!btnVoic.selected) {
            logPlayImgv.image = [UIImage imageNamed:@"playVoice_img"];
            [self stopVoiceMessage];
        }else {
            
            logPlayImgv.image = [UIImage imageNamed:@"playVoice_imgsel"];
            
            
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            NSURL *url = [NSURL fileURLWithPath:self.pathOne];
            
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            self.audioPlayer.delegate = self;
            bool result = [self.audioPlayer play];
            if (!result) {
                self.wavPath = [[self.pathOne stringByDeletingPathExtension] stringByAppendingString:@".wav"];
                NSURL *url = [NSURL fileURLWithPath:self.wavPath];
                [self.audioPlayer stop];
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                self.audioPlayer.delegate = self;
                [self.audioPlayer play];
            }
        }
        
    }
 
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    self.isPPlayb = NO;
//    [self.voice stopAnimating];
    [[NSFileManager defaultManager] removeItemAtPath:self.wavPath error:nil];
    [self stopVoiceMessage];
}

- (void)stopVoiceMessage
{
    UIImageView *logPlayImgv = [self.view viewWithTag:8300];
    logPlayImgv.image = [UIImage imageNamed:@"playVoice_img"];
    self.isPPlayb = NO;
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
        self.audioPlayer = nil;
    }
}

- (void)deleVoiceMMmethod
{
    self.thrTyp = @"";
    [self.photos removeAllObjects];
    [self.Videos removeAllObjects];
    [self.two_VV removeAllSubviews];
    
    self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
    self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
    self.oneScrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
    UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
    addFilBtn.frame = CGRectMake(0, 0, 92, 92);
    [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
    [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.two_VV addSubview:addFilBtn];
}


- (void)choosePhotosMethod {
    [self.view endEditing:YES];
    NSInteger numImg = 6;
    
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:numImg delegate:self];
    //根据需求设置
    imagePicker.allowTakePicture = NO;
    imagePicker.maxVideosCount = 0; /** 解除混合选择- 要么1个视频，要么9个图片 */
    imagePicker.supportAutorotate = NO; /** 适配横屏 */
    imagePicker.allowPickingType = LFPickingMediaTypePhoto;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        imagePicker.syncAlbum = YES; /** 实时同步相册 */
    }
    imagePicker.doneBtnTitleStr = eLocalizedString(@"home_ok"); //最终确定按钮名称
    imagePicker.cancelBtnTitleStr = eLocalizedString(@"home_Cancel");
    imagePicker.previewBtnTitleStr = eLocalizedString(@"home_preview");
    imagePicker.fullImageBtnTitleStr = eLocalizedString(@"home_MasterDrawing");
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)chooseVideoMethod {
    
    [self.view endEditing:YES];
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    //根据需求设置
    imagePicker.allowTakePicture = NO;
    imagePicker.maxVideosCount = 1; /** 解除混合选择- 要么1个视频，要么9个图片 */
    imagePicker.supportAutorotate = NO; /** 适配横屏 */
    imagePicker.allowPickingType = LFPickingMediaTypeVideo;
    imagePicker.maxVideoDuration = 30; /** 30秒视频 */
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        imagePicker.syncAlbum = YES; /** 实时同步相册 */
    }
    imagePicker.doneBtnTitleStr = eLocalizedString(@"home_ok"); //最终确定按钮名称
    imagePicker.cancelBtnTitleStr = eLocalizedString(@"home_Cancel");
    imagePicker.previewBtnTitleStr = eLocalizedString(@"home_preview");
    imagePicker.fullImageBtnTitleStr = eLocalizedString(@"home_MasterDrawing");
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingResult:(NSArray<LFResultObject *> *)results {
    
    [self.photos removeAllObjects];
    [self.Videos removeAllObjects];
    self.pathOne = @"";
    [self.two_VV removeAllSubviews];
    
    for (NSInteger i = 0; i < results.count; i++) {
        LFResultObject *result = results[i];
        if ([result isKindOfClass:[LFResultImage class]]) {
           
            LFResultImage *resultImage = (LFResultImage *)result;

            LFResultVideo *resultVideo = [[LFResultVideo alloc] init];
            resultVideo.smallImage = resultImage.originalImage;
            resultVideo.typeModel = 2;
            [self.photos addObject:resultVideo];
            
        } else {
            
            LFResultVideo *resultVideo = (LFResultVideo *)result;
            if (resultVideo.data.length/1024/1024 > 50) {

                [SVProgressHUD showInfoWithStatus:@"视频过大,请重新选择"];
                return;
            }
            resultVideo.smallImage = resultVideo.coverImage;
            resultVideo.typeModel = 1;

            [self.photos addObject:resultVideo];

            NSString *defultPath = [self getVideoCompressionPathCache];
            NSString *outputFielPath= [defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mp4"]];
            NSURL *outfileUrl = [NSURL fileURLWithPath:outputFielPath];
            [self.Videos addObject:outputFielPath];

            [HistoryRecordModel convertVideoQuailtyWithInputURL:resultVideo.url outputURL:outfileUrl];
        }
    }
    if (self.Videos.count > 0) {
        
        self.thrTyp = @"VIDEO";
        
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
        self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        self.oneScrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
        CGFloat ww_wX = (_window_width-24-20)/3+10;
        for (int i=0; i<self.photos.count; i++) {
            LFResultVideo *resultVideo = self.photos[i];
            
            NSInteger num = i%3;
            NSInteger numT = i/3;
            UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
            [self.two_VV addSubview:cont_VV];
            [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:YES];
        }
    }else {
        
        if(self.photos.count > 0) {
            self.thrTyp = @"IMAGE";
        }
        
        if(self.photos.count > 2) {
            self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 194);
            self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        }else {
            self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
            self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        }
        self.oneScrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
        CGFloat ww_wX = (_window_width-24-20)/3+10;
        
        if(self.photos.count > 5) {
   
            for (int i=0; i<self.photos.count; i++) {
                LFResultVideo *resultVideo = self.photos[i];
                
                NSInteger num = i%3;
                NSInteger numT = i/3;
                UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
                [self.two_VV addSubview:cont_VV];
                [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
            }
        }else {

            for (int i=0; i<self.photos.count+1; i++) {
                
                NSInteger num = i%3;
                NSInteger numT = i/3;
                if(i==self.photos.count) {
                    UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
                    addFilBtn.frame = CGRectMake(0, 0, 92, 92);
                    [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
                    [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                    [self.two_VV addSubview:addFilBtn];
                    addFilBtn.frame = CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92);
                }else {
                    LFResultVideo *resultVideo = self.photos[i];
                    UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
                    [self.two_VV addSubview:cont_VV];
                    [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
                }
            }
        }
    }
}

- (void)createUIUI:(UIView *)botVV tag:(NSInteger)tagN model:(LFResultVideo *)model isVideo:(BOOL)isVideo
{
    
    UIImageView *bigImgV = [HistoryRecordModel createImgImgView];
    bigImgV.frame = CGRectMake(0, 0, botVV.width-10, botVV.height);
    bigImgV.tag = tagN+200;
    bigImgV.image = model.smallImage;
    [botVV addSubview:bigImgV];
    
    UIButton *imgBtn = [HistoryRecordModel createImgBtn];
    imgBtn.frame = CGRectMake(0, 0, botVV.width-10, botVV.height);
    imgBtn.tag = tagN;
    [botVV addSubview:imgBtn];
    
    UIButton *deleteBtn = [HistoryRecordModel createImgBtn];
    deleteBtn.frame = CGRectMake(botVV.width-20, 0, 20, 20);
    deleteBtn.tag = tagN+100;
    [deleteBtn setImage:[UIImage imageNamed:@"startL_vipbtnDelet"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnsMethod:) forControlEvents:UIControlEventTouchUpInside];
    [botVV addSubview:deleteBtn];
    
    if (isVideo) {
        UIImageView *vide_img = [HistoryRecordModel createImgImgView];
        vide_img.image = [UIImage imageNamed:@"topic_postTopic_video2"];
        [bigImgV addSubview:vide_img];
        [vide_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bigImgV);
            make.width.height.offset(30);
        }];
    }else {
        [imgBtn addTarget:self action:@selector(showImgSBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)showImgSBtn:(UIButton *)btn
{
    NSMutableArray *arrImgss = [NSMutableArray array];
    for (int i=0; i<self.photos.count; i++) {
        LFResultVideo *resultVideo = self.photos[i];
        
        UIImageView *btnImgs = [self.two_VV viewWithTag:i+2300];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.index = i;
        photo.image = resultVideo.smallImage; // 图片路径
        photo.srcImageView = btnImgs; // 来源于哪个UIImageView
        [arrImgss addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = arrImgss; // 设置所有的图片
    browser.currentPhotoIndex = btn.tag-2100; // 弹出相册时显示的第一张图片是？
    [browser show];
}

- (void)deleteBtnsMethod:(UIButton *)btn
{
    if (self.Videos.count > 0) {
        
        [self.photos removeAllObjects];
        [self.Videos removeAllObjects];
        [self.two_VV removeAllSubviews];
        
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
        self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        self.oneScrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
        
        UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
        addFilBtn.frame = CGRectMake(0, 0, 92, 92);
        [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
        [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.two_VV addSubview:addFilBtn];
        
        self.thrTyp = @"";
        
    }else {
        
        [self.photos removeObjectAtIndex:btn.tag-2200];
        [self.two_VV removeAllSubviews];
        
        if(self.photos.count > 2) {
            self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 194);
            self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        }else {
            self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
            self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        }
        
        self.oneScrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(self.thr_VV.frame)+80);
        if(self.photos.count <= 0) {
            self.thrTyp = @"";
        }
        
        CGFloat ww_wX = (_window_width-24-20)/3+10;
        
        if(self.photos.count > 5) {

            for (int i=0; i<self.photos.count; i++) {
                LFResultVideo *resultVideo = self.photos[i];
                
                NSInteger num = i%3;
                NSInteger numT = i/3;
                UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
                [self.two_VV addSubview:cont_VV];
                [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
            }
        }else {
            
            for (int i=0; i<self.photos.count+1; i++) {
                
                NSInteger num = i%3;
                NSInteger numT = i/3;
                if(i==self.photos.count) {
                    UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
                    addFilBtn.frame = CGRectMake(0, 0, 92, 92);
                    [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
                    [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                    [self.two_VV addSubview:addFilBtn];
                    addFilBtn.frame = CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92);
                }else {
                    LFResultVideo *resultVideo = self.photos[i];
                    UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
                    [self.two_VV addSubview:cont_VV];
                    [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
                }
            }
        }
    }
}

- (NSString *)getVideoNameWithType:(NSString *)fileType
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"video_%@.%@",timeStr,fileType];
    return fileName;
}

- (NSString *)getVideoCompressionPathCache
{
    NSString *videoCache = [NSTemporaryDirectory() stringByAppendingPathComponent:@"videosffmpeg"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        
        self.placeLab.hidden = YES;
        if (self.textV.text.length > 1000) {

        }else {
            self.numberLab.text = [NSString stringWithFormat:@"%lu/1000", (unsigned long)self.textV.text.length];
        }
    }else {
        self.placeLab.hidden = NO;
        self.numberLab.text = @"0/1000";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.textV.text.length > 1000) {
        
        self.textV.text = [self.textV.text stringByReplacingCharactersInRange:range withString:@""];
        self.numberLab.text = @"1000/1000";
        return NO;
    }else {
        if([text isEqualToString:@"\n"]) {
            [self.view endEditing:YES];
        }
        return YES;
    }
}

@end
