//
//  MHSearchLocationController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/4/3.
//

#import "MHSearchLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MHSearLocationCell.h"

@interface MHSearchLocationController ()<MKLocalSearchCompleterDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKLocalSearch *locSearchM;
@property (nonatomic, strong) MKLocalSearchRequest *locSearchRequest;
@property (nonatomic, strong) NSMutableArray *datMut;
@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, assign) CLLocationCoordinate2D oCoordinNew;
@property (nonatomic, strong) UITextField *input_textF;
@end

@implementation MHSearchLocationController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
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
    self.titleName.text = eLocalizedString(@"plaza_all15");
    self.navView.backgroundColor = UIColor.clearColor;
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+98, _window_width, _window_height-NAVHEIGHT-98) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 70;
    _appTableView.clipsToBounds = YES;
    _appTableView.layer.cornerRadius = 8;
    _appTableView.backgroundColor = UIColor.whiteColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHSearLocationCell class] forCellReuseIdentifier:@"MHSearLocationCell"];
    [self.view addSubview:_appTableView];
    
    self.input_textF = [[UITextField alloc] initWithFrame:CGRectMake(12, NAVHEIGHT+8, _window_width-24, 34)];
    self.input_textF.backgroundColor = RGB(243, 224, 251);
    self.input_textF.layer.cornerRadius = 16;
    self.input_textF.font = SYS_Font(14);
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"role_setting8") attributes: @{NSForegroundColorAttributeName:RGB(219, 169, 240), NSFontAttributeName:self.input_textF.font}];
    self.input_textF.attributedPlaceholder = attrString4;
    self.input_textF.delegate = self;
    self.input_textF.textColor = UIColor.blackColor;
    self.input_textF.returnKeyType = UIReturnKeySearch;
    self.input_textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.input_textF addTarget:self action:@selector(textFieldShouldChangeMethod:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.input_textF];
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 34)];
    leftV.backgroundColor = UIColor.clearColor;
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, 18, 18)];
    leftIcon.image = [UIImage imageNamed:@"searchImgs_2"];
    [leftV addSubview:leftIcon];
    self.input_textF.leftView = leftV;
    self.input_textF.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *noShowBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+50, _window_width, 48)];
    noShowBtn.backgroundColor = UIColor.whiteColor;
    [noShowBtn addTarget:self action:@selector(noShowBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noShowBtn];
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    [noShowBtn addSubview:linVV];
    [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noShowBtn.mas_left).offset(12);
        make.right.equalTo(noShowBtn.mas_right).offset(-12);
        make.bottom.equalTo(noShowBtn.mas_bottom);
        make.height.offset(1);
    }];
    UILabel *noSLab = [HistoryRecordModel createLabLabTextColor:RGB(202, 76, 255) fontFloat:16 textAlignment:NSTextAlignmentLeft];
    noSLab.text = eLocalizedString(@"plaza_all15_15");
    [noShowBtn addSubview:noSLab];
    [noSLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noShowBtn.mas_left).offset(12);
        make.right.equalTo(noShowBtn.mas_right).offset(-12);
        make.top.bottom.equalTo(noShowBtn);
    }];
    
    self.datMut = [NSMutableArray array];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locSearchRequest = [[MKLocalSearchRequest alloc] init];
    [self.locationManager startUpdatingLocation];
}

- (void)textFieldShouldChangeMethod:(UITextField *)textField
{
    if(textField.text.length > 0) {
        
        [self searchListMethodTxf:minStr(textField.text)];
    }else {
        
        [self searchListMethodTxf:@"restaurant"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if(textField.text.length > 0) {
        
        [self searchListMethodTxf:minStr(textField.text)];
    }else {
        
        [self searchListMethodTxf:@"restaurant"];
    }
    return YES;
}

//MARK: 定位
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
 
    if(locations.count > 0) {
        
        CLLocation * location1 = [locations lastObject];
        
        [self.locationManager stopUpdatingLocation];
        
        self.oCoordinNew = location1.coordinate;
        
        [self searchListMethodTxf:@"restaurant"];
    }
}

- (void)searchListMethodTxf:(NSString *)sarTst
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.oCoordinNew, 5000, 5000);
    
    self.locSearchRequest.region = region;
    self.locSearchRequest.naturalLanguageQuery = sarTst;
    self.locSearchRequest.resultTypes = MKLocalSearchResultTypePointOfInterest;
    self.locSearchM = [[MKLocalSearch alloc] initWithRequest:self.locSearchRequest];
    [self.locSearchM startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if(!error) {
            [self.datMut removeAllObjects];
            
            for (MKMapItem *mapIte in response.mapItems) {
                [self.datMut addObject:mapIte];
            }
            //MARK: 排序
            [self.datMut sortUsingComparator:^NSComparisonResult(MKMapItem *obj1, MKMapItem *obj2) {
                
                double ww_dou = [HistoryRecordModel distanceBetweenOrderByLat1:obj1.placemark.location.coordinate.latitude Lat2:self.oCoordinNew.latitude Long1:obj1.placemark.location.coordinate.longitude Long2:self.oCoordinNew.longitude];
                
                double ww_dou2 = [HistoryRecordModel distanceBetweenOrderByLat1:obj2.placemark.location.coordinate.latitude Lat2:self.oCoordinNew.latitude Long1:obj2.placemark.location.coordinate.longitude Long2:self.oCoordinNew.longitude];
                
                if(ww_dou > ww_dou2) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if(ww_dou < ww_dou2) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            [self.appTableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datMut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHSearLocationCell *cell = [MHSearLocationCell cellWithTabelView:tableView];
    [cell addTwoModelToDataModel:self.datMut[indexPath.row] coor:self.oCoordinNew];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKMapItem *model = self.datMut[indexPath.row];
    NSString *nnLL = [NSString stringWithFormat:@"%@%@%@", model.placemark.administrativeArea?model.placemark.administrativeArea:@"", model.placemark.locality?model.placemark.locality:@"", model.placemark.thoroughfare?model.placemark.thoroughfare:@""];
    if(self.block_) {
        self.block_(nnLL);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)noShowBtnMethod
{
    if(self.block_) {
        self.block_(@"");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
