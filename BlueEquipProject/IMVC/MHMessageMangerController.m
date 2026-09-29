//
//  MHMessageMangerController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/4.
//

#import "MHMessageMangerController.h"
#import "myConversationListController.h"
#import "myContactListController.h"
#import "FSPageContentView.h"
#import "mySearchFriendViewController.h"

@interface MHMessageMangerController ()<FSPageContentViewDelegate, V2TIMFriendshipListener>

@property (nonatomic, strong) FSPageContentView *pageContentV;
@property (nonatomic, strong) UIView *thrLinV;
@property (nonatomic, strong) UIButton *unReadBtn;
@end

@implementation MHMessageMangerController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    //设置常亮不锁屏
//    [[UIApplication sharedApplication] setIdleTimerDisabled:[LYUserDefault userDefault].isScreenAwake];
    [[UIApplication sharedApplication] setIdleTimerDisabled:[FloatingWindowModel shareInstance].bluetoothBtn_bo];
    
    //MARK: 获取客服ID
    [requestToolClass getNetworkWithUrl:request_other_getAllServiceUid andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSString class]]) {
            [LYUserDefault saveKefuId:minStr(info)];
        }else {
            [LYUserDefault saveKefuId:@""];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi2 object:@"4"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideBackBnt = YES;
    self.redNavView = YES;
    self.backImgV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    self.showImgVV = YES;
    [self createNavRightImage:[UIImage imageNamed:@"IM_searchImg1"]];
    
    [[V2TIMManager sharedInstance] addFriendListener:self];
    
    NSArray *namsAr = @[@"tabbar_tit3", @"message_tile10"];
    CGFloat ww_thr = 0;
    for (int i=0; i<namsAr.count; i++) {
        
        CGFloat w_lefX = [HistoryRecordModel jiSuanWith:eLocalizedString(namsAr[i]) font:22]+10;
        if(i==0) {
            ww_thr = _window_width/2-w_lefX;
        }else {
            ww_thr = _window_width/2;
        }
        UIView *thrMV = [[UIView alloc] initWithFrame:CGRectMake(ww_thr, self.navView.height-44, w_lefX, 44)];
        thrMV.backgroundColor = UIColor.clearColor;
        [self.navView addSubview:thrMV];
        
        UILabel *thrlLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:18 textAlignment:NSTextAlignmentCenter];
        thrlLLab.frame = CGRectMake(0, 0, w_lefX, 44);
        thrlLLab.text = eLocalizedString(namsAr[i]);
        thrlLLab.tag = 1100+i;
        thrlLLab.font = [UIFont systemFontOfSize:18 weight:1];
        [thrMV addSubview:thrlLLab];
        
        
        if(i==0) {
            thrlLLab.textColor = RGB(176, 51, 228);
            self.thrLinV = [[UIView alloc] initWithFrame:CGRectMake(ww_thr+(w_lefX-18)/2, self.navView.height-8, 18, 2)];
            self.thrLinV.clipsToBounds = YES;
            self.thrLinV.layer.cornerRadius = 1;
            self.thrLinV.backgroundColor = RGB(176, 51, 228);
            [self.navView addSubview:self.thrLinV];
        }else {
            self.unReadBtn = [HistoryRecordModel createImgBtn];
            self.unReadBtn.frame = CGRectMake(w_lefX-18, 0, 10, 10);
            self.unReadBtn.backgroundColor = UIColor.redColor;
            self.unReadBtn.layer.cornerRadius = 5;
            self.unReadBtn.titleLabel.font = SYS_Font(8);
            self.unReadBtn.titleLabel.textColor = UIColor.whiteColor;
            [thrMV addSubview:self.unReadBtn];
            self.unReadBtn.hidden = YES;
        }
        UIButton *emBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w_lefX-10, 44)];
        emBtn.tag = 1200+i;
        [emBtn addTarget:self action:@selector(thrBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [thrMV addSubview:emBtn];
    }
    
    NSMutableArray *contentVCs = [NSMutableArray array];
    myConversationListController *VC = [[myConversationListController alloc] init];
    [contentVCs addObject:VC];
    myContactListController *VC2 = [[myContactListController alloc] init];
    [contentVCs addObject:VC2];
    VC2.block_ = ^(NSInteger redNum) {
      
        if(redNum > 0) {
            
            self.unReadBtn.hidden = NO;
            
        }else {
            self.unReadBtn.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goodFriendNotifUpload" object:nil];
        }
    };
    
    self.unReadBtn.hidden = !self.isGoodBoo;
    if(TARBARHEIGHT > 50) {
        self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+14, _window_width, _window_height-NAVHEIGHT-14-20-TARBARHEIGHT) childVCs:contentVCs parentVC:self delegate:self];
    }else {
        self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+14, _window_width, _window_height-NAVHEIGHT-14-38-TARBARHEIGHT) childVCs:contentVCs parentVC:self delegate:self];
    }
    
    self.pageContentV.contentViewCanScroll = YES;
    [self.view addSubview:self.pageContentV];
    self.pageContentV.contentViewCurrentIndex = 0;
    self.pageContentV.backgroundColor = UIColor.clearColor;
}

- (void)onFriendApplicationListAdded:(NSArray<V2TIMFriendApplication *> *)applicationList;
{
    BOOL isFFF = NO;
    for (V2TIMFriendApplication *model in applicationList) {
        if(model.type == V2TIM_FRIEND_APPLICATION_COME_IN){
            isFFF = YES;
        }
    }
    if(isFFF) {
        self.unReadBtn.hidden = NO;
    }else {
        self.unReadBtn.hidden = YES;
    }
}

- (void)thrBtnMethods:(UIButton *)btn
{
    UILabel *oneLab = [self.navView viewWithTag:1100];
    UILabel *oneLab2 = [self.navView viewWithTag:1101];
    
    CGFloat ww_thr = (_window_width-88*2)/2;
    CGFloat w_lefX = [HistoryRecordModel jiSuanWith:eLocalizedString(@"tabbar_tit3") font:22]+10;
    CGFloat w_lefX2 = [HistoryRecordModel jiSuanWith:eLocalizedString(@"message_tile10") font:22]+10;
    
    if(btn.tag == 1200) {
        ww_thr = _window_width/2-w_lefX;
        
        oneLab.textColor = RGB(176, 51, 228);
        oneLab2.textColor = UIColor.blackColor;
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = ww_thr+(w_lefX-18)/2;
        }];
        self.pageContentV.contentViewCurrentIndex = 0;
    }else {
        ww_thr = _window_width/2;
        oneLab.textColor = UIColor.blackColor;
        oneLab2.textColor = RGB(176, 51, 228);
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = ww_thr+(w_lefX2-18)/2;
        }];
        self.pageContentV.contentViewCurrentIndex = 1;
    }
}
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    UILabel *oneLab = [self.navView viewWithTag:1100];
    UILabel *oneLab2 = [self.navView viewWithTag:1101];
    
    CGFloat ww_thr = (_window_width-88*2)/2;
    CGFloat w_lefX = [HistoryRecordModel jiSuanWith:eLocalizedString(@"tabbar_tit3") font:22]+10;
    CGFloat w_lefX2 = [HistoryRecordModel jiSuanWith:eLocalizedString(@"message_tile10") font:22]+10;
    
    if(endIndex == 0) {
        ww_thr = _window_width/2-w_lefX;
        oneLab.textColor = RGB(176, 51, 228);
        oneLab2.textColor = UIColor.blackColor;
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = ww_thr+(w_lefX-18)/2;
        }];

    }else {
        ww_thr = _window_width/2;
        oneLab.textColor = UIColor.blackColor;
        oneLab2.textColor = RGB(176, 51, 228);
        [UIView animateWithDuration:0.3 animations:^{
            self.thrLinV.x = ww_thr+(w_lefX2-18)/2;
        }];
    }
}

- (void)rightImageAction:(UIButton *)sender
{
    mySearchFriendViewController *vc = [[mySearchFriendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
