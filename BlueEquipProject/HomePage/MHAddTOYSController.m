//
//  MHAddTOYSController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/30.
//

#import "MHAddTOYSController.h"
#import <SVGAPlayer/SVGAPlayer.h>
#import <SVGAPlayer/SVGAParser.h>
#import "WIFIListView.h"

@interface MHAddTOYSController ()
{
    NSTimer *timeLL;
}
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) UIView *twoVV;
@property (nonatomic, assign) int numLL;
@property (nonatomic, strong) WIFIListView *WIFIListV;
@property (nonatomic, strong) NSArray *listArr;

@property (nonatomic, strong) UILabel *searchLab;
@property (nonatomic, strong) UIImageView *gifImgV;

@end

@implementation MHAddTOYSController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timeLL invalidate];
    timeLL = nil;
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.titleName.text = eLocalizedString(@"home_title3");
    self.showImgVV = NO;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    UIImageView *splIMgVV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    splIMgVV.image = [UIImage imageNamed:@"allBackImgs_toys"];
    [self.view addSubview:splIMgVV];
    
    self.gifImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:self.gifImgV];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"equipmentImgsGif.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    self.gifImgV.image = [UIImage sd_imageWithGIFData:data];
    
    [self.view addSubview:self.navView];
        
    self.oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    self.oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.oneVV];
    
    UILabel *onLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    onLab.text = eLocalizedString(@"toys_all12");
    onLab.numberOfLines = 0;
    [self.oneVV addSubview:onLab];
    [onLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneVV.mas_left).offset(30);
        make.right.equalTo(self.oneVV.mas_right).offset(-30);
        make.bottom.equalTo(self.oneVV.mas_bottom).offset(-TARBARHEIGHT);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    UILabel *onLab2 = [HistoryRecordModel createLabLabTextColor:RGB(208, 96, 255) fontFloat:14 textAlignment:NSTextAlignmentCenter];
    onLab2.text = eLocalizedString(@"toys_all13");
    [self.oneVV addSubview:onLab2];
    [onLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneVV.mas_left).offset(30);
        make.right.equalTo(self.oneVV.mas_right).offset(-30);
        make.bottom.equalTo(onLab.mas_top).offset(-4);
    }];
    
    //MARK:  svg动画
//    SVGAPlayer *player = [[SVGAPlayer alloc] initWithFrame:CGRectMake(self.oneVV.width/2-50, self.oneVV.yz_centerY-130, 100, 100)];
//    player.fillMode = @"Forward";
//    [self.oneVV addSubview:player];
//
//    SVGAParser *parser = [[SVGAParser alloc] init];
//    [parser parseWithNamed:@"VibrationSvga" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
//        if (videoItem != nil) {
//            player.videoItem = videoItem;
//            [player startAnimation];
//        }
//    } failureBlock:^(NSError * _Nonnull error) {
//
//    }];
        
    self.twoVV = [[UIView alloc] init];
    self.twoVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.twoVV];
    [self.twoVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.offset(351);
        make.height.offset(384);
    }];
    
    UIImageView *oneIMgV = [HistoryRecordModel createImgImgView];
    oneIMgV.backgroundColor = RGB(230, 208, 248);
    oneIMgV.clipsToBounds = YES;
    oneIMgV.layer.cornerRadius = 12;
    [self.twoVV addSubview:oneIMgV];
    [oneIMgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoVV.mas_top).offset(23);
        make.left.right.bottom.equalTo(self.twoVV);
    }];
    
    UIImageView *oneIMgV3 = [HistoryRecordModel createImgImgView];
    oneIMgV3.image = [UIImage imageNamed:@"toysAllImg1"];
    [self.twoVV addSubview:oneIMgV3];
    [oneIMgV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoVV.mas_top);
        make.right.equalTo(self.twoVV.mas_right);
        make.width.offset(76);
        make.height.offset(72);
    }];
    
    UILabel *onLab4 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    onLab4.text = eLocalizedString(@"toys_all1");
    onLab4.font = [UIFont systemFontOfSize:14 weight:0.3];
    [oneIMgV addSubview:onLab4];
    [onLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneIMgV.mas_left).offset(14);
        make.top.equalTo(oneIMgV.mas_top).offset(20);
    }];
    
    UIView *TwoVVV = [HistoryRecordModel createViewUIUI];
    TwoVVV.backgroundColor = UIColor.clearColor;
    [oneIMgV addSubview:TwoVVV];
    [TwoVVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneIMgV.mas_left).offset(14);
        make.right.equalTo(oneIMgV.mas_right).offset(-14);
        make.top.equalTo(oneIMgV.mas_top).offset(68);
        make.bottom.equalTo(oneIMgV.mas_bottom).offset(-14);
    }];
    
    UIImageView *subIMG1 = [HistoryRecordModel createImgImgView];
    subIMG1.image = [UIImage imageNamed:@"toysAllImg2"];
    [TwoVVV addSubview:subIMG1];
    [subIMG1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TwoVVV.mas_left).offset(1);
        make.top.equalTo(TwoVVV.mas_top).offset(1);
        make.width.height.offset(18);
    }];
    UILabel *subILab1 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
    subILab1.text = eLocalizedString(@"toys_all2");
    subILab1.numberOfLines = 0;
    [TwoVVV addSubview:subILab1];
    [subILab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subIMG1.mas_right).offset(6);
        make.top.equalTo(subIMG1.mas_top);
        make.right.equalTo(TwoVVV.mas_right).offset(-1);
        make.height.mas_greaterThanOrEqualTo(18);
    }];
    
    UIImageView *subIMG2 = [HistoryRecordModel createImgImgView];
    subIMG2.image = [UIImage imageNamed:@"toysAllImg2"];
    [TwoVVV addSubview:subIMG2];
    [subIMG2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TwoVVV.mas_left).offset(1);
        make.top.equalTo(subILab1.mas_bottom).offset(28);
        make.width.height.offset(18);
    }];
    UILabel *subILab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
    subILab2.text = eLocalizedString(@"toys_all3");
    subILab2.numberOfLines = 0;
    [TwoVVV addSubview:subILab2];
    [subILab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subIMG2.mas_right).offset(6);
        make.top.equalTo(subIMG2.mas_top);
        make.right.equalTo(TwoVVV.mas_right).offset(-1);
        make.height.mas_greaterThanOrEqualTo(18);
    }];
    
    UIImageView *subIMG3 = [HistoryRecordModel createImgImgView];
    subIMG3.image = [UIImage imageNamed:@"toysAllImg2"];
    [TwoVVV addSubview:subIMG3];
    [subIMG3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TwoVVV.mas_left).offset(1);
        make.top.equalTo(subIMG2.mas_bottom).offset(28);
        make.width.height.offset(18);
    }];
    UILabel *subILab3 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
    subILab3.text = eLocalizedString(@"toys_all4");
    subILab3.numberOfLines = 0;
    [TwoVVV addSubview:subILab3];
    [subILab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subIMG3.mas_right).offset(6);
        make.top.equalTo(subIMG3.mas_top);
        make.right.equalTo(TwoVVV.mas_right).offset(-1);
        make.height.mas_greaterThanOrEqualTo(18);
    }];
    self.twoVV.hidden = YES;
    
    if([LYUserDefault userDefault].isLoginBoo) {
        [requestToolClass getNetworkWithUrl:request_device_listAll andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.listArr = info;
            [self methodUIUIUIUIU];
        } fail:^(NSString * _Nonnull msg) {
            self.listArr = @[];
            [self methodUIUIUIUIU];
        }];
    }else {
        self.listArr = @[];
        [self methodUIUIUIUIU];
    }
    
    timeLL = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethodUI) userInfo:nil repeats:YES];
    
}

- (void)methodUIUIUIUIU
{
    self.WIFIListV = [[WIFIListView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:self.WIFIListV];
    if(self.arrList.count > 0) {
        [self.WIFIListV addDataList:self.arrList choseArr:self.macsList rowN:self.listArr];
    }else {
        self.WIFIListV.hidden = YES;
    }
    [self.WIFIListV isBBLEBooMehtodBoo:[FloatingWindowModel shareInstance].isEnableBluetooth];
    WEAKSELF
    self.WIFIListV.block_ = ^(NSInteger typeN, NSString * _Nonnull isStrM) {
      
        [weakSelf connectServiceMehtodTT:typeN isboo:[isStrM boolValue]];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bleServicesNotifMethod:) name:@"bleServicesNotif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluuConnectedNotifMethod:) name:@"bluuConnectedNotif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluuConnectedNotifMethod:) name:@"bluuConnectedNotif5" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotifTwo" object:nil];
    });
}

- (void)connectServiceMehtodTT:(NSInteger)tyyy isboo:(BOOL)boo
{
    [SVProgressHUD dismiss];
    if (tyyy == 10000) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if(self.macsList.count > tyyy) {
            [SVProgressHUD show];
            NSString *macSS = self.macsList[tyyy];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PostNotifServiceNotifName" object:nil userInfo:@{@"rowN":minIntStr((int)tyyy), @"mac":macSS, @"sericeArr":self.arrList}];
        }
    }
}

- (void)bluuConnectedNotifMethod:(NSNotification *)notiffB
{
    [SVProgressHUD dismiss];
    NSDictionary *MMM = notiffB.object;
    if([minStr(MMM[@"status"]) intValue] == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        
    }
}

- (void)bleServicesNotifMethod:(NSNotification *)notiFF
{
    NSDictionary *dicM = notiFF.userInfo;
    self.arrList = dicM[@"sericeArr"];
    self.macsList = dicM[@"macsArr"];
    if(self.arrList.count > 0) {
        self.WIFIListV.hidden = NO;
        [self.WIFIListV addDataList:self.arrList choseArr:self.macsList rowN:self.listArr];
        
        self.twoVV.hidden = YES;
        self.oneVV.hidden = NO;
        
    }else {
        self.WIFIListV.hidden = YES;
    }
}

- (void)timeMethodUI
{
    if(self.numLL > 29) {
        if(self.arrList.count <= 0){
            self.oneVV.hidden = YES;
            self.twoVV.hidden = NO;
        }
    }else {
        self.numLL = self.numLL+1;
    }
}

@end


