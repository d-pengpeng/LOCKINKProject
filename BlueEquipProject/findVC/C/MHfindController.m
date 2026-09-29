//
//  MHfindController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/18.
//

#import "MHfindController.h"
#import "FSPageContentView.h"
#import "MHfindSubPatternsController.h"

@interface MHfindController ()<FSPageContentViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;
@property (nonatomic, strong) UIView *thrLinV;
@end

@implementation MHfindController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
    //设置常亮不锁屏
//    [[UIApplication sharedApplication] setIdleTimerDisabled:[LYUserDefault userDefault].isScreenAwake];
    [[UIApplication sharedApplication] setIdleTimerDisabled:[FloatingWindowModel shareInstance].bluetoothBtn_bo];

    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"2"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi2 object:@"2"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.redNavView = YES;
    self.hideBackBnt = YES;
    self.navView.backgroundColor = RGB(1, 0, 2);
    self.view.backgroundColor = RGB(1, 0, 2);
    
    NSArray *namsAr = @[@"plaza_all1", @"plaza_all2", @"tabbar_tit1"];
    
    CGFloat one_ff = [HistoryRecordModel jiSuanWith:eLocalizedString(@"plaza_all1") font:20]+10;
    CGFloat one_ff2 = [HistoryRecordModel jiSuanWith:eLocalizedString(@"plaza_all2") font:20]+10;
    CGFloat one_ff3 = [HistoryRecordModel jiSuanWith:eLocalizedString(@"tabbar_tit1") font:20]+10;
    
    if(one_ff < 76) {
        one_ff = 76;
    }
    if(one_ff2 < 76) {
        one_ff2 = 76;
    }
    if(one_ff3 < 76) {
        one_ff3 = 76;
    }
    
    CGFloat ww_thr = (_window_width-one_ff-one_ff2-one_ff3)/2;
    for (int i=0; i<namsAr.count; i++) {
        
        UIView *thrMV = [[UIView alloc] init];
        if(i==0) {
            thrMV.frame = CGRectMake(ww_thr, self.navView.height-44, one_ff, 44);
        }else if (i==1) {
            thrMV.frame = CGRectMake(ww_thr+one_ff, self.navView.height-44, one_ff2, 44);
        }else {
            thrMV.frame = CGRectMake(ww_thr+one_ff+one_ff2, self.navView.height-44, one_ff3, 44);
        }
        thrMV.tag = 1300+i;
        thrMV.backgroundColor = UIColor.clearColor;
        [self.navView addSubview:thrMV];
        
        UILabel *thrlLLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:18 textAlignment:NSTextAlignmentCenter];
        thrlLLab.frame = CGRectMake(0, 0, thrMV.width, 44);
        thrlLLab.text = eLocalizedString(namsAr[i]);
        thrlLLab.tag = 1100+i;
        thrlLLab.font = [UIFont systemFontOfSize:18 weight:1];
        [thrMV addSubview:thrlLLab];
        
        if(i==1) {
            thrlLLab.textColor = RGB(176, 51, 228);
            self.thrLinV = [[UIView alloc] initWithFrame:CGRectMake(ww_thr+one_ff+(one_ff2-18)/2, self.navView.height-8, 18, 2)];
            self.thrLinV.clipsToBounds = YES;
            self.thrLinV.layer.cornerRadius = 1;
            self.thrLinV.backgroundColor = RGB(176, 51, 228);
            [self.navView addSubview:self.thrLinV];
        }
        UIButton *emBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, thrMV.width, 44)];
        emBtn.tag = 1200+i;
        [emBtn addTarget:self action:@selector(thrBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [thrMV addSubview:emBtn];
    }
    
    NSMutableArray *contentVCs = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        MHfindSubPatternsController *VC = [[MHfindSubPatternsController alloc] init];
        VC.typeN = i;
        VC.selfVC = self;
        [contentVCs addObject:VC];
    }
    
    self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+14, _window_width, _window_height-NAVHEIGHT-14) childVCs:contentVCs parentVC:self delegate:self];
    self.pageContentV.contentViewCanScroll = YES;
    [self.view addSubview:self.pageContentV];
    self.pageContentV.contentViewCurrentIndex = 1;
}

- (void)thrBtnMethods:(UIButton *)btn
{
    UIView *oneVV = [self.navView viewWithTag:1300];
    UIView *oneVV2 = [self.navView viewWithTag:1301];
    UIView *oneVV3 = [self.navView viewWithTag:1302];
    
    UILabel *oneLab = [self.navView viewWithTag:1100];
    UILabel *oneLab2 = [self.navView viewWithTag:1101];
    UILabel *oneLab3 = [self.navView viewWithTag:1102];
    
    if(btn.tag == 1200) {
       
        oneLab.textColor = RGB(176, 51, 228);
        oneLab2.textColor = UIColor.whiteColor;
        oneLab3.textColor = UIColor.whiteColor;
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = oneVV.x+(oneVV.width-18)/2;
        }];
        self.pageContentV.contentViewCurrentIndex = 0;
    }else if (btn.tag == 1201) {
       
        oneLab.textColor = UIColor.whiteColor;
        oneLab2.textColor = RGB(176, 51, 228);
        oneLab3.textColor = UIColor.whiteColor;
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = oneVV2.x+(oneVV2.width-18)/2;
        }];
        self.pageContentV.contentViewCurrentIndex = 1;
    }else {
        oneLab.textColor = UIColor.whiteColor;
        oneLab2.textColor = UIColor.whiteColor;
        oneLab3.textColor = RGB(176, 51, 228);
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = oneVV3.x+(oneVV3.width-18)/2;
        }];
        self.pageContentV.contentViewCurrentIndex = 2;
    }
}
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    UIView *oneVV = [self.navView viewWithTag:1300];
    UIView *oneVV2 = [self.navView viewWithTag:1301];
    UIView *oneVV3 = [self.navView viewWithTag:1302];
    
    UILabel *oneLab = [self.navView viewWithTag:1100];
    UILabel *oneLab2 = [self.navView viewWithTag:1101];
    UILabel *oneLab3 = [self.navView viewWithTag:1102];
    
    if(endIndex == 0) {
       
        oneLab.textColor = RGB(176, 51, 228);
        oneLab2.textColor = UIColor.whiteColor;
        oneLab3.textColor = UIColor.whiteColor;
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = oneVV.x+(oneVV.width-18)/2;
        }];
    }else if (endIndex == 1) {
       
        oneLab.textColor = UIColor.whiteColor;
        oneLab2.textColor = RGB(176, 51, 228);
        oneLab3.textColor = UIColor.whiteColor;
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = oneVV2.x+(oneVV2.width-18)/2;
        }];
    }else {
        oneLab.textColor = UIColor.whiteColor;
        oneLab2.textColor = UIColor.whiteColor;
        oneLab3.textColor = RGB(176, 51, 228);
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = oneVV3.x+(oneVV3.width-18)/2;
        }];
    }
}

@end
