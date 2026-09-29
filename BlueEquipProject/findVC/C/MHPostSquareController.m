//
//  MHPostSquareController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/8.
//

#import "MHPostSquareController.h"
#import "LFImagePickerController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PopBottomView.h"
#import <CoreLocation/CoreLocation.h>
#import "MHVioceRecordView.h"
#import "TUIDefine.h"
#import "MHSearchLocationController.h"

@interface MHPostSquareController ()<UITextViewDelegate, LFImagePickerControllerDelegate, CLLocationManagerDelegate, AVAudioPlayerDelegate>

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
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UILabel *placeLab;
@property (nonatomic, strong) UILabel *numberLab;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *Videos;

@property (nonatomic, copy) NSString *imgUrlStr;

@property (nonatomic, strong) UILabel *addresLab;
@property (nonatomic, strong) UILabel *addresLab2;
@property (nonatomic, copy) NSString *adresMsg;

@property (nonatomic, copy) NSString *thrTyp;
@property (nonatomic, copy) NSString *durationStr;
@end

@implementation MHPostSquareController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
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
    
    self.redNavView = NO;
    self.titleName.text = eLocalizedString(@"plaza_all14");
    
    
    CGFloat w_ww = [HistoryRecordModel jiSuanWith:eLocalizedString(@"home_Publish") font:14]+10;
    
    UIButton *rightImgBtn = [[UIButton alloc] init];
    rightImgBtn.frame = CGRectMake(_window_width-12-w_ww, TIMESTATUSHEIGHT+12, w_ww, 20);
    [rightImgBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_Imgs2"] forState:UIControlStateNormal];
    [rightImgBtn setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
    [rightImgBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightImgBtn.titleLabel.font = SYS_Font(12);
    [rightImgBtn addTarget:self action:@selector(pulishImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightImgBtn];
    
    UIImageView *backIMgV = [HistoryRecordModel createImgImgView];
    backIMgV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:backIMgV];
    [backIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(100);
    }];
    
    self.imgUrlStr = @"";
    self.thrTyp = @"";
    self.durationStr = @"";
    self.photos = [NSMutableArray array];
    self.Videos = [NSMutableArray array];
    
    self.one_VV = [HistoryRecordModel createViewUIUI];
    self.one_VV.frame = CGRectMake(12, NAVHEIGHT+10, _window_width-24, 162);
    self.one_VV.backgroundColor = UIColor.clearColor;
    self.one_VV.layer.cornerRadius = 0;
    [self.view addSubview:self.one_VV];
    
    UIImageView *placeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 152)];
    placeImgV.image = [UIImage imageNamed:@"sqarePost_Imgs1"];
    [self.one_VV addSubview:placeImgV];
    
    self.two_VV = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92)];
    [self.view addSubview:self.two_VV];
    
    self.thr_VV = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101)];
    self.thr_VV.clipsToBounds = YES;
    self.thr_VV.layer.cornerRadius = 8;
    self.thr_VV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.thr_VV];
    
    UIImageView *placeImgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 101)];
    placeImgV2.image = [UIImage imageNamed:@"sqarePost_Imgs1"];
    [self.thr_VV addSubview:placeImgV2];
    
    self.placeLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentLeft];
    self.placeLab.text = eLocalizedString(@"postPlaza_placeText");
    [self.one_VV addSubview:self.placeLab];
    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.one_VV.mas_left).offset(12);
        make.top.equalTo(self.one_VV.mas_top).offset(18);
    }];
    
    self.numberLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:12 textAlignment:NSTextAlignmentRight];
    self.numberLab.text = @"0/1000";
    [self.one_VV addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.one_VV.mas_right).offset(-12);
        make.bottom.equalTo(self.one_VV.mas_bottom).offset(-22);
    }];
    
    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(12, 12, self.one_VV.width-24, self.one_VV.height-24)];
    self.textV.font = SYS_Font(14);
    self.textV.textColor = GrayText102;
    self.textV.backgroundColor = UIColor.clearColor;
    self.textV.delegate = self;
    self.textV.returnKeyType = UIReturnKeyDone;
    [self.one_VV addSubview:self.textV];
    
    NSArray *imgsAr = @[@"sqarePost_Imgs3", @"sqarePost_Imgs4"];
    NSArray *namsAr = @[@"plaza_all15", @"plaza_all16"];
    for (int i=0; i<imgsAr.count; i++) {
        
        UIImageView *adresImg = [HistoryRecordModel createImgImgView];
        adresImg.frame = CGRectMake(10, 17+i*51, 16, 16);
        adresImg.image = [UIImage imageNamed:imgsAr[i]];
        [self.thr_VV addSubview:adresImg];
        
        UILabel *adresLLlab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        adresLLlab.frame = CGRectMake(34, i*51, 100, 50);
        adresLLlab.numberOfLines = 0;
        adresLLlab.text = eLocalizedString(namsAr[i]);
        [self.thr_VV addSubview:adresLLlab];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        nexImgv.frame = CGRectMake(self.thr_VV.width-24, 18+i*51, 14, 14);
        nexImgv.image = [UIImage imageNamed:@"home_next2"];
        [self.thr_VV addSubview:nexImgv];
        
        if(i==0){
            self.addresLab = [HistoryRecordModel createLabLabTextColor:normalPurpleColors fontFloat:14 textAlignment:NSTextAlignmentRight];
            self.addresLab.frame = CGRectMake(self.thr_VV.width/2, 0, self.thr_VV.width/2-32, 50);
            [self.thr_VV addSubview:self.addresLab];
            
            UIButton *towAlSelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.thr_VV.width/2, i*51, self.thr_VV.width/2, 50)];
            [towAlSelBtn addTarget:self action:@selector(twoMethodUIUIOne) forControlEvents:UIControlEventTouchUpInside];
            [self.thr_VV addSubview:towAlSelBtn];
            
        }else {
            self.addresLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
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

- (void)pulishImageAction
{
    [self.view endEditing:YES];
//    if((self.textV.text.length>0) && ((self.photos.count>0) || (self.pathOne.length>0))) {
    if(self.textV.text.length>0) {
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
    }
}

- (void)uploadRequestMMM
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *locat_str = @"";
        if(self.addresLab.text.length > 0) {
            locat_str = self.addresLab.text;
        }
        if(self.isRoleGongTouBoo) {
            
            NSString *fil_str = self.imgUrlStr;
            NSString *fil_fm = @"";
            if([self.thrTyp isEqualToString:@"VIDEO"]) {
                NSArray *ar_ar = [self.imgUrlStr componentsSeparatedByString:@","];
                fil_str = ar_ar[0];
                fil_fm = ar_ar[1];
            }
            
            NSDictionary *dicMMM = @{@"deviceId":self.reqestDicAr[0], @"perLockoutPeriod":self.reqestDicAr[1], @"deadline":self.reqestDicAr[2], @"conditions":self.reqestDicAr[3], @"executeImmediately":self.reqestDicAr[4], @"unlockReminderEnabled":self.reqestDicAr[5], @"unlockVoltage":self.reqestDicAr[6], @"text":minStr(self.textV.text), @"mediaUrls":fil_str, @"mediaType":self.thrTyp, @"location":locat_str, @"visibility":self.adresMsg, @"videoCover":fil_fm, @"audioDuration":self.durationStr};
            if (self.frequency) {
                dicMMM = @{@"deviceId":self.reqestDicAr[0], @"perLockoutPeriod":self.reqestDicAr[1], @"deadline":self.reqestDicAr[2], @"conditions":self.reqestDicAr[3], @"executeImmediately":self.reqestDicAr[4], @"unlockReminderEnabled":self.reqestDicAr[5], @"unlockVoltage":self.reqestDicAr[6], @"text":minStr(self.textV.text), @"mediaUrls":fil_str, @"mediaType":self.thrTyp, @"location":locat_str, @"visibility":self.adresMsg, @"videoCover":fil_fm, @"audioDuration":self.durationStr, @"frequency":self.frequency, @"shockMinute":self.shockMinute};
            }
            [requestToolClass postNetworkWithUrl:request_voteRecord_post andParameter:dicMMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
    //            [self.navigationController popViewControllerAnimated:YES];
                [self.navigationController popToViewController:self.selfUpVC animated:YES];
            } fail:^(NSString * _Nonnull msg) {

            }];
        }else {
            
            NSString *fil_str = self.imgUrlStr;
            NSString *fil_fm = @"";
            if([self.thrTyp isEqualToString:@"VIDEO"]) {
                NSArray *ar_ar = [self.imgUrlStr componentsSeparatedByString:@","];
                fil_str = ar_ar[0];
                fil_fm = ar_ar[1];
            }
            NSDictionary *dicMMM = @{@"text":minStr(self.textV.text), @"mediaUrls":fil_str, @"mediaType":self.thrTyp, @"location":locat_str, @"visibility":self.adresMsg, @"videoCover":fil_fm, @"audioDuration":self.durationStr};
            [requestToolClass postNetworkWithUrl:request_square_post andParameter:dicMMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                if([self.delegate_ respondsToSelector:@selector(postTopicContrDelegateMethod)]) {
                    [self.delegate_ postTopicContrDelegateMethod];
                }
//                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"find_push1")];
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
    });
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
        self.durationStr = minIntStr(oneIn);
        
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
//        [imgBtn addTarget:self action:@selector(voiceMMMMMM) forControlEvents:UIControlEventTouchUpInside];
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
//        self.durationStr = minIntStr(oneIn);
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
    self.durationStr = @"";
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
    imagePicker.allowTakePicture = YES;
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
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    //根据需求设置
    imagePicker.allowTakePicture = YES;
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
    self.durationStr = @"";
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
        self.durationStr = @"";
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
        self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        
        UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
        addFilBtn.frame = CGRectMake(0, 0, 92, 92);
        [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
        [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.two_VV addSubview:addFilBtn];
        
        self.thrTyp = @"";
        
    }else {
        
        [self.photos removeObjectAtIndex:btn.tag-2200];
        [self.two_VV removeAllSubviews];
        self.durationStr = @"";
        if(self.photos.count > 2) {
            self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 194);
            self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        }else {
            self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame), _window_width-24, 92);
            self.thr_VV.frame = CGRectMake(12, CGRectGetMaxY(self.two_VV.frame)+20, _window_width-24, 101);
        }
        
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
        return YES;
    }
}

@end
