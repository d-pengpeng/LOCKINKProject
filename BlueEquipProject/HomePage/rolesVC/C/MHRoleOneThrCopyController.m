//
//  MHRoleOneThrCopyController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/13.
//

#import "MHRoleOneThrCopyController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MHRoleSetCoreLocatView.h"
#import "MHRoleThrRecordController.h"
#import "MHSearLockImgView.h"
#import "MHLimitsAuthorityView.h"


@interface MHRoleOneThrCopyController ()<UITextFieldDelegate, MKMapViewDelegate, MKLocalSearchCompleterDelegate>
{
    NSTimer *messsageTimer;
}
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) NSArray *arLis;
@property (nonatomic, strong) UITextField *textFFF;
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, copy) NSString *locatStr;
@property (nonatomic, copy) NSString *locatStr2;
@property (nonatomic, copy) NSString *latitudeStr;
@property (nonatomic, copy) NSString *longitudeStr;
@property (nonatomic, strong) NSMutableArray *datMut;
@property (nonatomic, assign) CLLocationCoordinate2D oCoordinNew;
@property (nonatomic, assign) CLLocationCoordinate2D oCoordinOther;
@property (nonatomic, strong) UIButton *searBBBBtn;
@property (nonatomic, strong) MHSearLockImgView *MHSearLockImgV;
@property (nonatomic, strong) MKPointAnnotation *pointAnnotAtion;
@property (nonatomic, strong) MKPointAnnotation *pointAnnotAtOther;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKLocalSearch *locSearchM;
@property (nonatomic, strong) MKLocalSearchRequest *locSearchRequest;
@property (nonatomic, strong) MKCircle *cirleV;
@property (nonatomic, strong) UIButton *placBtn;
@end

@implementation MHRoleOneThrCopyController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSArray *viewCtrolsArr = self.navigationController.viewControllers;
    if ([viewCtrolsArr indexOfObject:self] == NSNotFound) {
        [messsageTimer invalidate];
        messsageTimer = nil;
    }
}

//‌TomTom地图使用的坐标系是WGS-84地理坐标系‌
//高德地图使用的坐标系是GCJ-02（火星坐标系)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    UIView *oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-280-34+20)];
    oneVV.layer.cornerRadius = 15;
    oneVV.clipsToBounds = YES;
    [self.view addSubview:oneVV];

//    if([minStr(self.roleOneModel.locationLockInfo[@"recordId"]) intValue] > 0) {
    if([minStr(self.roleOneModel.locationLockUnlockLatitude) doubleValue] > 0) {
        float numFF = [minStr(self.roleOneModel.locationLockInfo[@"unlockVoltage"]) floatValue];
        if([minStr(self.roleOneModel.locationLockInfo[@"unlockReminderEnabled"]) boolValue]) {
            self.arLis = @[minStr(self.roleOneModel.locationLockInfo[@"location"]), minIntStr(self.roleOneModel.locationLockUnlockRangeInKm), @"true", [NSString stringWithFormat:@"%.1f", numFF/100]];
        }else {
            self.arLis = @[minStr(self.roleOneModel.locationLockInfo[@"location"]), minIntStr(self.roleOneModel.locationLockUnlockRangeInKm), @"false", [NSString stringWithFormat:@"%.1f", numFF/100]];
        }
    }
    
    self.locatStr = @"";
    self.locatStr2 = @"";
    self.latitudeStr = @"";
    self.longitudeStr = @"";
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-280-54)];
    self.mapView.maskView = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [oneVV addSubview:self.mapView];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow; //是否跟随自己位置

    
    self.locSearchRequest = [[MKLocalSearchRequest alloc] init];

    self.placBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-280-54)];
    self.placBtn.backgroundColor = UIColor.clearColor;
    [self.placBtn addTarget:self action:@selector(placePBtnMMM) forControlEvents:UIControlEventTouchUpInside];
    [oneVV addSubview:self.placBtn];
    self.placBtn.hidden = YES;
    
    self.datMut = [NSMutableArray array];
    
    UIView *linVV = [[UIView alloc] initWithFrame:CGRectMake((_window_width-84)/2, 12, 84, 8)];
    linVV.backgroundColor = RGBA(138, 0, 197, 0.15);
    [oneVV addSubview:linVV];
    
    UIView *spavV = [[UIView alloc] initWithFrame:CGRectMake(12, 32, _window_width-56, 32)];
    spavV.backgroundColor = UIColor.clearColor;
    spavV.layer.cornerRadius = 8;
    [oneVV addSubview:spavV];
    
    UIView *colVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width-56, 32)];
    colVV.backgroundColor = RGBA(138, 0, 197, 0.45);
    [spavV addSubview:colVV];
    
    UIButton *searBBBB = [HistoryRecordModel createImgBtn];
    searBBBB.frame = CGRectMake(0, 0, spavV.width, 32);
    [searBBBB setImage:[UIImage imageNamed:@"searchImgs"] forState:UIControlStateNormal];
    [searBBBB setTitle:eLocalizedString(@"role_setting8") forState:UIControlStateNormal];
    [searBBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    searBBBB.titleLabel.font = SYS_Font(14);
    [searBBBB layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    [searBBBB addTarget:self action:@selector(searchBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [spavV addSubview:searBBBB];
    self.searBBBBtn = searBBBB;
    
    self.textFFF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, spavV.width-24, 32)];
    self.textFFF.backgroundColor = UIColor.clearColor;
    self.textFFF.textColor = UIColor.whiteColor;
    self.textFFF.font = SYS_Font(14);
    self.textFFF.delegate = self;
    self.textFFF.rightViewMode = UITextFieldViewModeAlways;
    self.textFFF.returnKeyType = UIReturnKeySearch;
    [spavV addSubview:self.textFFF];
    
    UIView *deleVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [deleBBB setImage:[UIImage imageNamed:@"search_recordImgs2"] forState:UIControlStateNormal];
    [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [deleVVV addSubview:deleBBB];
    self.textFFF.rightView = deleVVV;
    self.textFFF.hidden = YES;
    
    self.MHSearLockImgV = [[MHSearLockImgView alloc] initWithFrame:CGRectMake(12, 32+32, _window_width-56, 74)];
    self.MHSearLockImgV.isAppleMapBoo = YES;
    [oneVV addSubview:self.MHSearLockImgV];
    WEAKSELF
    self.MHSearLockImgV.block_ = ^(NSInteger numTyp) {
        [weakSelf addAnnountUIUI:numTyp];
    };
    self.MHSearLockImgV.hidden = YES;
    
    //记录
    UIButton *recordBBBB = [HistoryRecordModel createImgBtn];
    recordBBBB.frame = CGRectMake(_window_width-44, spavV.y-6, 44, 44);
    [recordBBBB setImage:[UIImage imageNamed:@"search_recordImgs"] forState:UIControlStateNormal];
    [recordBBBB addTarget:self action:@selector(recordBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV addSubview:recordBBBB];
    
    _locationBtn = [HistoryRecordModel createImgBtn];
    _locationBtn.frame = CGRectMake((_window_width-200)/2, oneVV.height-130, 200, 38);
    [_locationBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [_locationBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
    [_locationBtn setTitle:eLocalizedString(@"role_name52") forState:UIControlStateNormal];
    [_locationBtn setTitle:eLocalizedString(@"role_name52_1") forState:UIControlStateSelected];
    [_locationBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = SYS_Font(14);
    [_locationBtn addTarget:self action:@selector(chatBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV addSubview:_locationBtn];
    
    _locationBtn.selected = self.roleOneModel.locationLockEnabled;
    
//    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
//        self.pointAnnotAtOther = [[MKPointAnnotation alloc] init];
//        self.pointAnnotAtOther.coordinate = CLLocationCoordinate2DMake([self.roleOneModel.locationLockUnlockLatitude doubleValue], [self.roleOneModel.locationLockUnlockLongitude doubleValue]);
//        self.pointAnnotAtOther.title = self.roleOneModel.masterNickName;
//        self.pointAnnotAtOther.subtitle = self.roleOneModel.masterNickName;
//        [self.mapView addAnnotation:self.pointAnnotAtOther];
//    }
    
    if([minStr(self.roleOneModel.locationLockUnlockLatitude) doubleValue] > 0) {
        self.pointAnnotAtion = [[MKPointAnnotation alloc] init];
        self.pointAnnotAtion.coordinate = CLLocationCoordinate2DMake([self.roleOneModel.locationLockUnlockLatitude doubleValue], [self.roleOneModel.locationLockUnlockLongitude doubleValue]);
        self.pointAnnotAtion.title = minStr(self.roleOneModel.locationLockInfo[@"location"]);
        self.pointAnnotAtion.subtitle = minStr(self.roleOneModel.locationLockInfo[@"location"]);
        [self.mapView addAnnotation:self.pointAnnotAtion];
        
        self.cirleV = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake([self.roleOneModel.locationLockUnlockLatitude doubleValue], [self.roleOneModel.locationLockUnlockLongitude doubleValue]) radius:1000*self.roleOneModel.locationLockUnlockRangeInKm]; //MARK: 范围 半径
        [self.mapView addOverlay:self.cirleV];
        
        self.latitudeStr = self.roleOneModel.locationLockUnlockLatitude;
        self.longitudeStr = self.roleOneModel.locationLockUnlockLongitude;
    }
    
    if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
        if (self->messsageTimer == nil) {
            self->messsageTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(uploadLocationMMMM) userInfo:nil repeats:YES];
        }
    }
}

- (void)uploadLocationMMMM
{
    if(self.locatStr.length>0) {
        if(self.twoBlock_) {
            self.twoBlock_([NSString stringWithFormat:@"%f", self.oCoordinOther.latitude], [NSString stringWithFormat:@"%f", self.oCoordinOther.longitude]);
        }
    }
}

- (void)placePBtnMMM
{
    self.MHSearLockImgV.hidden = YES;
    self.placBtn.hidden = YES;
}

//MARK: 更新佩戴者位置
- (void)uploadUIUILatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        
        if(self.pointAnnotAtOther) {
            [self.mapView removeAnnotation:self.pointAnnotAtOther];
        }
        self.pointAnnotAtOther = nil;
        
        self.pointAnnotAtOther = [[MKPointAnnotation alloc] init];
        self.pointAnnotAtOther.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        self.pointAnnotAtOther.title = self.roleOneModel.masterNickName;
        self.pointAnnotAtOther.subtitle = self.roleOneModel.masterNickName;
        [self.mapView addAnnotation:self.pointAnnotAtOther];
    }
}


//MARK: 更新是否没收权限
- (void)uploadUIUIUITwo
{
    if(self.isBMMM) {
        [_locationBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateNormal];
        [_locationBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
    }else {
        [_locationBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [_locationBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
    }
}

- (void)uploadUIUIUI
{
    if(self.roleOneModel.locationLockEnabled) {
        NSLog(@"--888--");
        _locationBtn.selected = YES;
    }else {
        _locationBtn.selected = NO;
    }
    
    if(self.cirleV) {
        [self.mapView removeOverlay:self.cirleV];
    }
    self.cirleV = nil;
    
    if(self.pointAnnotAtion) {
        [self.mapView removeAnnotation:self.pointAnnotAtion];
    }
    self.pointAnnotAtion = nil;
    
    self.pointAnnotAtion = [[MKPointAnnotation alloc] init];
    self.pointAnnotAtion.coordinate = CLLocationCoordinate2DMake([self.roleOneModel.locationLockUnlockLatitude doubleValue], [self.roleOneModel.locationLockUnlockLongitude doubleValue]);
    self.pointAnnotAtion.title = self.roleOneModel.masterNickName;
    self.pointAnnotAtion.subtitle = self.roleOneModel.masterNickName;
    [self.mapView addAnnotation:self.pointAnnotAtion];
    
    
    self.cirleV = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake([self.latitudeStr doubleValue], [self.longitudeStr doubleValue]) radius:1000*self.roleOneModel.locationLockUnlockRangeInKm];
    [self.mapView addOverlay:self.cirleV];
    
    MKCoordinateSpan span;

    if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
        double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:self.oCoordinOther.latitude Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:self.oCoordinOther.longitude];
        
        if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
            
            span.longitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
            span.latitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
        }else {
            span.longitudeDelta = 0.02*ww_dou/1000+0.03+0.02*self.roleOneModel.locationLockUnlockRangeInKm;
            span.latitudeDelta = 0.02*ww_dou/1000+0.03+0.02*self.roleOneModel.locationLockUnlockRangeInKm;
        }

    }else {
        
        span.longitudeDelta = 0.02;
        span.latitudeDelta = 0.02;
    }
    
    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake([self.latitudeStr doubleValue], [self.longitudeStr doubleValue]);
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    
    float numFF = [minStr(self.roleOneModel.locationLockInfo[@"unlockVoltage"]) floatValue];
    if([minStr(self.roleOneModel.locationLockInfo[@"location"]) boolValue]) {
        self.arLis = @[minStr(self.roleOneModel.locationLockInfo[@"location"]), minIntStr(self.roleOneModel.locationLockUnlockRangeInKm), @"true", [NSString stringWithFormat:@"%.1f", numFF/100]];
    }else {
        self.arLis = @[minStr(self.roleOneModel.locationLockInfo[@"location"]), minIntStr(self.roleOneModel.locationLockUnlockRangeInKm), @"false", [NSString stringWithFormat:@"%.1f", numFF/100]];
    }
}

- (void)recordBtnMethod
{
    [self.view endEditing:YES];
    
    self.MHSearLockImgV.hidden = YES;
    self.placBtn.hidden = YES;
    if(self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }

    MHRoleThrRecordController *vc = [[MHRoleThrRecordController alloc] init];
    vc.devicId = self.devicId;
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK: 搜索
- (void)searchBtnMethod
{
    if(self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    self.textFFF.hidden = NO;
    [self.textFFF becomeFirstResponder];
    self.searBBBBtn.hidden = YES;
}

//MARK: 搜索打点
- (void)addAnnountUIUI:(NSInteger)typMM
{
    self.MHSearLockImgV.hidden = YES;
    self.placBtn.hidden = YES;
//    if(self.pointAnnotAtion) {
//        [self.mapView removeAnnotation:self.pointAnnotAtion];
//    }
//    self.pointAnnotAtion = nil;
//
//    if(self.cirleV) {
//        [self.mapView removeOverlay:self.cirleV];
//    }
//    self.cirleV = nil;
//
//    MKMapItem *mapIte = self.datMut[typMM];
//
//    self.pointAnnotAtion = [[MKPointAnnotation alloc] init];
//    self.pointAnnotAtion.coordinate = CLLocationCoordinate2DMake(mapIte.placemark.location.coordinate.latitude, mapIte.placemark.location.coordinate.longitude);
//    self.pointAnnotAtion.title = mapIte.placemark.name;
//    self.pointAnnotAtion.subtitle = mapIte.placemark.locality;
//    [self.mapView addAnnotation:self.pointAnnotAtion];
//
//    self.cirleV = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(mapIte.placemark.location.coordinate.latitude, mapIte.placemark.location.coordinate.longitude) radius:1000*self.roleOneModel.locationLockUnlockRangeInKm];
//    [self.mapView addOverlay:self.cirleV];
//
//
//    MKCoordinateSpan span;
//
//    double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:mapIte.placemark.location.coordinate.latitude Lat2:self.oCoordinOther.latitude Long1:mapIte.placemark.location.coordinate.longitude Long2:self.oCoordinOther.longitude];
//
//    if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {
//
//        span.longitudeDelta = 0.01*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
//        span.latitudeDelta = 0.01*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
//    }else {
//        span.longitudeDelta = 0.01*ww_dou/1000+0.03;
//        span.latitudeDelta = 0.01*ww_dou/1000+0.03;
//    }
//
//    MKCoordinateRegion region;
//    region.center = CLLocationCoordinate2DMake(mapIte.placemark.location.coordinate.latitude, mapIte.placemark.location.coordinate.longitude);
//    region.span = span;
//    [self.mapView setRegion:region animated:YES];
    
    MKMapItem *mapIte = self.datMut[typMM];
    
    self.arLis = @[mapIte.name, self.arLis[1], self.arLis[2], self.arLis[3]];
    
    MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    vc.arrFind = self.arLis;
    vc.readName = self.realName;
    [self.selfVVC.view addSubview:vc];
//    if([self.realName isEqualToString:kCharactName2]) {
        [vc addUIUIUTwo];
//    }else {
//        [vc addUIUIU];
//    }
    vc.block_ = ^(NSArray * _Nonnull arrList) {
        self.arLis = arrList;
        
        CLLocationCoordinate2D oCoordin = CLLocationCoordinate2DMake(mapIte.placemark.location.coordinate.latitude, mapIte.placemark.location.coordinate.longitude);
        self.oCoordinNew = oCoordin;
        self.latitudeStr = [NSString stringWithFormat:@"%f", oCoordin.latitude];
        self.longitudeStr = [NSString stringWithFormat:@"%f", oCoordin.longitude];

        if(self.cirleV) {
            [self.mapView removeOverlay:self.cirleV];
        }
        self.cirleV = nil;
        self.cirleV = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(mapIte.placemark.location.coordinate.latitude, mapIte.placemark.location.coordinate.longitude) radius:1000*self.roleOneModel.locationLockUnlockRangeInKm];
        [self.mapView addOverlay:self.cirleV];
        
        [self uploadMMMM];
    };
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length <= 0) {
        self.searBBBBtn.hidden = NO;
    }else {
        self.searBBBBtn.hidden = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFFF endEditing:YES];
    
    self.locSearchM = nil;
    
    if(textField.text.length <= 0) {
        self.searBBBBtn.hidden = NO;
        self.MHSearLockImgV.hidden = YES;
        self.placBtn.hidden = YES;
    }else {
        self.searBBBBtn.hidden = YES;
        
//        CLLocationCoordinate2D coor = _mapView.userLocation.coordinate;
//
//        AMapGeoPoint *locationpp = [AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
//
//        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
//        request.location = locationpp;
//        request.keywords = minStr(textField.text);
////        request.city = @"";
////        request.cityLimit = YES;
//        request.showFieldsType = AMapPOISearchShowFieldsTypeAll;
//        [self.locSearchM AMapPOIKeywordsSearch:request];
        
        
        MKCoordinateSpan span;
        if(self.roleOneModel.locationLockUnlockRangeInKm > 0) {
            span.longitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
            span.latitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
        }else {
            span.longitudeDelta = 0.02;
            span.latitudeDelta = 0.02;
        }

        MKCoordinateRegion region;
        region.center = self.oCoordinOther;
        region.span = span;
        [self.mapView setRegion:region animated:YES];

        self.locSearchRequest.region = region;
        self.locSearchRequest.naturalLanguageQuery = minStr(textField.text);
        self.locSearchRequest.resultTypes = MKLocalSearchResultTypePointOfInterest;
        self.locSearchM = [[MKLocalSearch alloc] initWithRequest:self.locSearchRequest];
        [self.locSearchM startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
            if(!error) {
                [self.datMut removeAllObjects];
                
                for (MKMapItem *mapIte in response.mapItems) {

//                    double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:mapIte.placemark.location.coordinate.latitude Lat2:self.oCoordinNew.latitude Long1:mapIte.placemark.location.coordinate.longitude Long2:self.oCoordinNew.longitude];
////                    if(ww_dou < 1000*self.roleOneModel.locationLockUnlockRangeInKm) {
//                    if(ww_dou < 10000) {
                        [self.datMut addObject:mapIte];
//                    }
                }
                //MARK: 排序
                [self.datMut sortUsingComparator:^NSComparisonResult(MKMapItem *obj1, MKMapItem *obj2) {
                    
                    double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:obj1.placemark.location.coordinate.latitude Lat2:self.oCoordinOther.latitude Long1:obj1.placemark.location.coordinate.longitude Long2:self.oCoordinOther.longitude];
                    
                    double ww_dou2 = [HistoryRecordModel distanceBetweenOrderByLat1:obj2.placemark.location.coordinate.latitude Lat2:self.oCoordinOther.latitude Long1:obj2.placemark.location.coordinate.longitude Long2:self.oCoordinOther.longitude];
                    
                    if(ww_dou > ww_dou2) {
                        return (NSComparisonResult)NSOrderedDescending;
                    }
                    
                    if(ww_dou < ww_dou2) {
                        return (NSComparisonResult)NSOrderedAscending;
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];

                if(self.datMut.count > 2) {
                    self.MHSearLockImgV.frame = CGRectMake(12, 32+32, _window_width-56, 12+62*3);
                }else {
                    if(self.datMut.count > 0) {
                        self.MHSearLockImgV.frame = CGRectMake(12, 32+32, _window_width-56, 12+62*self.datMut.count);
                    }else {
                        self.MHSearLockImgV.frame = CGRectMake(12, 32+32, _window_width-56, 12+62);
                    }
                }
                [self.MHSearLockImgV addListArr:self.datMut coor:self.oCoordinNew];
                self.MHSearLockImgV.hidden = NO;
                self.placBtn.hidden = NO;
            }
        }];
    }
    return YES;
}

//MARK: 开启、关闭定位锁
- (void)chatBtnMethod
{
    if(self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([minStr(self.roleOneModel.locationLockRecordId) intValue] > 0) {
        [requestToolClass getNOMsgNetworkWithUrl:request_device_switchLocationLockRecordStatus andParameter:@{@"recordId":minStr(self.roleOneModel.locationLockRecordId)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
//            self.locationBtn.selected = !self.locationBtn.selected;
            
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    }else {
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err6")];
    }
}

//MARK: 更新位置
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKUserLocation *modeUser = (MKUserLocation *)annotation;
        CLLocationCoordinate2D oCoordin = annotation.coordinate;
        self.oCoordinNew = oCoordin;
        self.oCoordinOther = oCoordin;
        
        [self.geocoder reverseGeocodeLocation:modeUser.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

            for (CLPlacemark *place in placemarks) {
                //获得的定位信息
                NSString * str = place.name;

                NSString * str2 = place.thoroughfare;
                //获得所在的位置(某市)
                NSString * str3 = place.locality;
                //获得所在市的某区
                NSString * str4 = place.subLocality;
                //获得省份(形成区域)
                NSString * str5 = place.administrativeArea;
                if(str4) {
                    self.locatStr = [NSString stringWithFormat:@"%@%@%@%@", str5, str3, str4, str];
                }else {
                    self.locatStr = [NSString stringWithFormat:@"%@%@%@%@", str5, str3, str2, str];
                }
                self.locatStr2 = str;
                
//                if([minStr(self.roleOneModel.locationLockInfo[@"recordId"]) intValue] <= 0) {
                if([minStr(self.roleOneModel.locationLockUnlockLatitude) doubleValue] <= 0) {
                    self.arLis = @[self.locatStr2, @"0", @"false", @"0"];
                }
            }
        }];
        
        if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
            MKCoordinateSpan span;
            double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:self.oCoordinOther.latitude Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:self.oCoordinOther.longitude];

            if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {

                span.longitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
                span.latitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
            }else {
                span.longitudeDelta = 0.02*ww_dou/1000+0.03+0.02*self.roleOneModel.locationLockUnlockRangeInKm;
                span.latitudeDelta = 0.02*ww_dou/1000+0.03+0.02*self.roleOneModel.locationLockUnlockRangeInKm;
            }
            MKCoordinateRegion region;
            region.center = oCoordin;
            region.span = span;
            [self.mapView setRegion:region animated:NO];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            if([self.roleOneModel.locationLockUnlockLatitude doubleValue] > 0) {
                MKCoordinateSpan span;
                double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:[self.roleOneModel.locationLockUnlockLatitude doubleValue] Lat2:self.oCoordinOther.latitude Long1:[self.roleOneModel.locationLockUnlockLongitude doubleValue] Long2:self.oCoordinOther.longitude];

                if(self.roleOneModel.locationLockUnlockRangeInKm*1000 > ww_dou) {

                    span.longitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
                    span.latitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
                }else {
                    span.longitudeDelta = 0.02*ww_dou/1000+0.03+0.02*self.roleOneModel.locationLockUnlockRangeInKm;
                    span.latitudeDelta = 0.02*ww_dou/1000+0.03+0.02*self.roleOneModel.locationLockUnlockRangeInKm;
                }
                MKCoordinateRegion region;
                region.center = oCoordin;
                region.span = span;
                [self.mapView setRegion:region animated:NO];
            }
        });
        
        if([self.roleOneModel.currRole isEqualToString:@"SERVANT"]) {
            
            if(self.twoBlock_) {
                self.twoBlock_([NSString stringWithFormat:@"%f", self.oCoordinOther.latitude], [NSString stringWithFormat:@"%f", self.oCoordinOther.longitude]);
            }
        }
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier2";
        MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"me_2locationImg"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;

    }else if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        if(self.pointAnnotAtOther && (self.pointAnnotAtOther == annotation)) {
            annotationView.image = [UIImage imageNamed:@"me_locationImg"];
        }else {
            annotationView.image = nil;
        }
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }else {
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if([self.roleOneModel.currRole isEqualToString:@"MASTER"]) {
        CLLocationCoordinate2D oCoordin = userLocation.location.coordinate;
        self.oCoordinOther = oCoordin;
    }else {
        CLLocationCoordinate2D oCoordin = userLocation.location.coordinate;
        double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:oCoordin.latitude Lat2:self.oCoordinOther.latitude Long1:oCoordin.longitude Long2:self.oCoordinOther.longitude];
        if(ww_dou > 20) {
            self.oCoordinOther = oCoordin;
            if(self.twoBlock_) {
                self.twoBlock_([NSString stringWithFormat:@"%f", self.oCoordinOther.latitude], [NSString stringWithFormat:@"%f", self.oCoordinOther.longitude]);
            }
        }
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [self.view endEditing:YES];
    
//    MKAnnotationView被点中时被设为YES 再次点击 如果为 selected = yes 就不再响应， 故设置 selected 为No
    [self.mapView deselectAnnotation:view.annotation animated:YES];
    
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        
        self.arLis = @[self.locatStr2, self.arLis[1], self.arLis[2], self.arLis[3]];
        
        MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        vc.arrFind = self.arLis;
        vc.readName = self.realName;
        [self.selfVVC.view addSubview:vc];
//        if([self.realName isEqualToString:kCharactName2]) {
            [vc addUIUIUTwo];
//        }else {
//            [vc addUIUIU];
//        }
        vc.block_ = ^(NSArray * _Nonnull arrList) {
            self.arLis = arrList;
            
            CLLocationCoordinate2D oCoordin = view.annotation.coordinate;
            self.oCoordinNew = oCoordin;
            self.latitudeStr = [NSString stringWithFormat:@"%f", oCoordin.latitude];
            self.longitudeStr = [NSString stringWithFormat:@"%f", oCoordin.longitude];

            if(self.cirleV) {
                [self.mapView removeOverlay:self.cirleV];
            }
            self.cirleV = nil;
            self.cirleV = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(view.annotation.coordinate.latitude, view.annotation.coordinate.longitude) radius:1000*self.roleOneModel.locationLockUnlockRangeInKm];
            [self.mapView addOverlay:self.cirleV];
            
            [self uploadMMMM];
        };
    }else if ([view.annotation isKindOfClass:[MKPointAnnotation class]]) {
        if(self.pointAnnotAtion == view.annotation) {
            
            self.arLis = @[view.annotation.title, self.arLis[1], self.arLis[2], self.arLis[3]];
            MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            vc.arrFind = self.arLis;
            vc.readName = self.realName;
            [self.selfVVC.view addSubview:vc];
//            if([self.realName isEqualToString:kCharactName2]) {
                [vc addUIUIUTwo];
//            }else {
//                [vc addUIUIU];
//            }
            vc.block_ = ^(NSArray * _Nonnull arrList) {
                self.arLis = arrList;
                
                CLLocationCoordinate2D oCoordin = view.annotation.coordinate;
                if(view) {
                    self.oCoordinNew = oCoordin;
                    self.latitudeStr = [NSString stringWithFormat:@"%f", oCoordin.latitude];
                    self.longitudeStr = [NSString stringWithFormat:@"%f", oCoordin.longitude];
                    
                    if(self.cirleV) {
                        [self.mapView removeOverlay:self.cirleV];
                    }
                    self.cirleV = nil;
                    self.cirleV = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(view.annotation.coordinate.latitude, view.annotation.coordinate.longitude) radius:1000*self.roleOneModel.locationLockUnlockRangeInKm];
                    [self.mapView addOverlay:self.cirleV];
                    
                    [self uploadMMMM];
                }
            };
        }
    }
    
    MKCoordinateSpan span;
    if(self.roleOneModel.locationLockUnlockRangeInKm > 0) {
        span.longitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
        span.latitudeDelta = 0.02*self.roleOneModel.locationLockUnlockRangeInKm+0.03;
    }else {
        span.longitudeDelta = 0.02;
        span.latitudeDelta = 0.02;
    }

    MKCoordinateRegion region;
    region.center = view.annotation.coordinate;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    
    self.MHSearLockImgV.hidden = YES;
    self.placBtn.hidden = YES;
}

//MARK: 保存定位锁
- (void)uploadMMMM
{
    [SVProgressHUD show];
    NSString *dy_lab = [NSString stringWithFormat:@"%.f", [minStr(self.arLis[3]) floatValue]*100];
    NSDictionary *dicmV = @{@"deviceId":minIntStr(self.roleOneModel.id), @"latitude":self.latitudeStr, @"longitude":self.longitudeStr, @"location":self.arLis[0], @"unlockRangeInKm":self.arLis[1], @"unlockReminderEnabled":self.arLis[2], @"unlockVoltage":dy_lab};
    [requestToolClass postNetworkWithUrl:request_device_saveLocationLockInfo andParameter:dicmV success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if(self.block_) {
            self.block_();
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)deleBtnMethod
{
    self.textFFF.text = @"";
    self.MHSearLockImgV.hidden = YES;
    self.placBtn.hidden = YES;
}

//MARK: 绘制圆
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKCircle class]]) {
        MKCircle *cirl_KK = (MKCircle *)overlay;
        MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:cirl_KK];
        circleRenderer.lineWidth    = 2.f;
        circleRenderer.strokeColor  = RGBA(202, 76, 255, 1);
        circleRenderer.fillColor    = RGBA(202, 76, 255, 0.12);
        return circleRenderer;
    }
    return nil;
}

@end
