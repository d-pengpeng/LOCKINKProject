//
//  eBaseViewController.m
//  FireJob
//
//  Created by Edwin on 2023/10/20.
//

#import "eBaseViewController.h"
//#import "SVProgressHUD.h"
#import "MHBehaviorReporter.h"

/// 页面停留 enterTime 字典，key = VC 指针地址字符串
static NSMutableDictionary *_enterTimeMap(void) {
    static NSMutableDictionary *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = [NSMutableDictionary dictionary];
    });
    return map;
}

/// page_leave 去重：记录每个 VC 指针是否已上报过 leave
static NSMutableSet *_leaveReportedSet(void) {
    static NSMutableSet *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [NSMutableSet set];
    });
    return set;
}

/// 系统/第三方控制器黑名单：这些 VC 不做 page_view/page_leave 上报
/// 原因：系统弹窗、图片选择器、分享面板、IM 内部容器等不是"用户浏览的页面"
static NSArray<NSString *> *_systemBlockList(void) {
    static NSArray *list = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = @[
            // UIKit 系统容器
            @"UIViewController",
            @"UINavigationController",
            @"UITabBarController",
            @"UISplitViewController",
            @"UIPageViewController",
            @"UIPanelViewController",
            @"UIAlertController",
            @"UIActivityViewController",
            @"UIInputViewController",
            @"UISearchController",
            @"UIReferenceLibraryViewController",
            @"UIImagePickerController",
            // Photos
            @"PHPickerViewController",
            @"PHAssetPickerViewController",
            // 文档/预览
            @"UIDocumentPickerViewController",
            @"UIDocumentBrowserViewController",
            @"QLPreviewController",
            // 消息/邮件
            @"MFMessageComposeViewController",
            @"MFMailComposeViewController",
            // 通讯录
            @"ABPeoplePickerNavigationController",
            @"CNContactPickerViewController",
            // 其它系统
            @"SKStoreProductViewController",
            @"SFSafariViewController",
            @"SFSymbolViewController",
            @"AVAudioRecorderViewController",
            @"AVVideoCaptureViewController",
            @"AVCaptureViewController",
            @"GKGameCenterViewController",
            @"MFMediaPickerViewController",
            @"SKCloudServiceSetupViewController",
            // IM SDK 容器（TUIContactSelectController 等容器类不记页面）
            @"TUIBaseChatViewController", // 但子类 c2cChatController 是业务页面，自己会单独上报
            @"TUIMessageController",
            // Masonry/SVProgressHUD 等非 VC（以防万一）
            @"SVProgressHUD",
        ];
    });
    return list;
}

/// 判断是否应跳过 page_view/page_leave 上报
static BOOL _shouldTrackPage(UIViewController *vc) {
    if (!vc) return NO;
    NSString *clsName = NSStringFromClass([vc class]);
    if (clsName.length == 0) return NO;
    // 黑名单精确匹配
    if ([_systemBlockList() containsObject:clsName]) return NO;
    // 前缀过滤（避免漏报系统子类如 XXAlertController）
    NSArray *prefixes = @[
        @"UIAlert",
        @"UIActivity",
        @"UIInput",
        @"UISearch",
        @"UIImagePicker",
        @"PHPicker",
        @"UIDocument",
        @"QLPreview",
        @"SKStore",
        @"SFSafari",
        @"WKWebView",
    ];
    for (NSString *p in prefixes) {
        if ([clsName hasPrefix:p]) return NO;
    }
    return YES;
}

@interface eBaseViewController ()

@end

@implementation eBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = GroupBackColor;//[UIColor groupTableViewBackgroundColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    
    self.backImgV = [HistoryRecordModel createImgImgView];
    self.backImgV.frame = CGRectMake(0, 0, _window_width, _window_height);
    self.backImgV.image = [UIImage imageNamed:@"allBackImgs"];
    [self.view addSubview:self.backImgV];
    self.backImgV.hidden = YES;
    
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _window_width, NAVHEIGHT)];
    self.navView.backgroundColor = [UIColor whiteColor];
    self.navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.navView];
    
    self.headIII = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, NAVHEIGHT)];
    self.headIII.image = [UIImage imageNamed:@"expertTopImg"];
    [self.navView addSubview:self.headIII];
    self.headIII.hidden = YES;
    
    //标题
    self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(50, TIMESTATUSHEIGHT, _window_width-50*2, 40)];
    [self.titleName setFont:SYS_Font(17)];
    self.titleName.textColor=UIColor.blackColor;
    self.titleName.textAlignment=NSTextAlignmentCenter;
    [self.navView addSubview:self.titleName];
    
    
    self.backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBnt.frame = CGRectMake(10, TIMESTATUSHEIGHT+2, 40, 40);
    self.backBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:UIControlStateNormal];
    self.backBnt.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.backBnt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.backBnt];

    //底部线条
//    self.navLine = [[UIView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT-0.3, _window_width, 0.3)];
//    self.navLine.backgroundColor = GroupBackColor;
//    [self.navView addSubview:self.navLine];
    
  
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitUserInfoNotice) name:@"exitToLogin" object:nil];
    
}

- (void)setShowImgVV:(BOOL)showImgVV
{
    self.backImgV.hidden = !showImgVV;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 系统/第三方控制器不做 page_view 上报
    if (!_shouldTrackPage(self)) return;
    
    // 重置 leave 去重标记（每次 appear 都允许下次 disappear 上报）
    [_leaveReportedSet() removeObject:[NSString stringWithFormat:@"%p", self]];
    
    NSString *page = NSStringFromClass([self class]);
    NSString *key = [NSString stringWithFormat:@"%p", self];
    // enterTime 只记首次，后续 viewDidAppear 不覆盖（弹窗 present/dismiss 不应重置停留起点）
    if (!_enterTimeMap()[key]) {
        _enterTimeMap()[key] = @([[NSDate date] timeIntervalSince1970]);
        [[MHBehaviorReporter shared] trackPageView:page fromPage:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 系统/第三方控制器不做 page_leave 上报
    if (!_shouldTrackPage(self)) return;
    
    // 只在"真正离开"时报 leave，被半透明弹窗 present 覆盖不算
    // isMovingFromParentViewController → 导航栈 pop/push 覆盖
    // isBeingDismissed → dismiss
    BOOL reallyLeaving = self.isMovingFromParentViewController || self.isBeingDismissed;
    if (!reallyLeaving) return;
    
    // 去重：同一 VC 实例真正离开只报一条
    NSString *selfKey = [NSString stringWithFormat:@"%p", self];
    if ([_leaveReportedSet() containsObject:selfKey]) return;
    [_leaveReportedSet() addObject:selfKey];
    
    NSString *page = NSStringFromClass([self class]);
    NSString *key = [NSString stringWithFormat:@"%p", self];
    NSNumber *enter = _enterTimeMap()[key];
    if (page.length > 0 && enter) {
        NSTimeInterval durationMs = MAX(0, ([[NSDate date] timeIntervalSince1970] - enter.doubleValue) * 1000);
        [[MHBehaviorReporter shared] trackPageLeave:page durationMs:(NSInteger)durationMs];
        [_enterTimeMap() removeObjectForKey:key];
    }
}

#pragma mark - App 切后台时补报 page_leave

+ (void)flushPageLeaveForBackground {
    // 取当前 topVC，从 enterTimeMap 里找 enterTime，补报 page_leave
    UIViewController *topVC = [MHBehaviorReporter topViewController];
    if (!topVC || !_shouldTrackPage(topVC)) return;
    
    NSString *key = [NSString stringWithFormat:@"%p", topVC];
    NSNumber *enter = _enterTimeMap()[key];
    if (!enter) return;
    
    // 检查是否已上报过
    if ([_leaveReportedSet() containsObject:key]) return;
    [_leaveReportedSet() addObject:key];
    
    NSString *page = NSStringFromClass([topVC class]);
    NSTimeInterval durationMs = MAX(0, ([[NSDate date] timeIntervalSince1970] - enter.doubleValue) * 1000);
    [[MHBehaviorReporter shared] trackPageLeave:page durationMs:(NSInteger)durationMs];
    [_enterTimeMap() removeObjectForKey:key];
}

#pragma mark - tab 切换 / 外部主动触发

/// 主动对某个 VC 补报 page_leave（tab 切换场景）
+ (void)flushLeaveForVC:(UIViewController *)vc {
    if (!vc || !_shouldTrackPage(vc)) return;
    
    NSString *key = [NSString stringWithFormat:@"%p", vc];
    
    // 已上报过就不重复
    if ([_leaveReportedSet() containsObject:key]) return;
    // 没有 enterTime 说明没报过 view，leave 也跳过
    NSNumber *enter = _enterTimeMap()[key];
    if (!enter) return;
    
    [_leaveReportedSet() addObject:key];
    
    NSString *page = NSStringFromClass([vc class]);
    NSTimeInterval durationMs = MAX(0, ([[NSDate date] timeIntervalSince1970] - enter.doubleValue) * 1000);
    [[MHBehaviorReporter shared] trackPageLeave:page durationMs:(NSInteger)durationMs];
    [_enterTimeMap() removeObjectForKey:key];
}

/// 主动对某个 VC 补报 page_view（tab 切换场景）
+ (void)flushViewForVC:(UIViewController *)vc {
    if (!vc || !_shouldTrackPage(vc)) return;
    
    NSString *key = [NSString stringWithFormat:@"%p", vc];
    // 已有 enterTime 说明之前已报过 view，不重复
    if (_enterTimeMap()[key]) return;
    
    // 清除 leave 去重标记（允许下次 disappear 上报）
    [_leaveReportedSet() removeObject:key];
    
    _enterTimeMap()[key] = @([[NSDate date] timeIntervalSince1970]);
    NSString *page = NSStringFromClass([vc class]);
    [[MHBehaviorReporter shared] trackPageView:page fromPage:nil];
}

-(void)setHideBackBnt:(BOOL)hideBackBnt{
    self.backBnt.hidden = hideBackBnt;
    
}

-(void)setHideNavView:(BOOL)hideNavView {
    self.navView.hidden = hideNavView;
}


-(void)setRedNavView:(BOOL)redNavView {
    if (redNavView) {
        
        self.navView.backgroundColor = UIColor.clearColor;
        [self.backBnt setImage:[UIImage imageNamed:@"EventLiving_back"] forState:0];
        self.titleName.textColor= UIColor.whiteColor;
    }else {

        self.navView.backgroundColor = UIColor.whiteColor;
        [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:0];
        self.titleName.textColor = UIColor.blackColor;
    }
}


-(void)createNavLeftImage:(UIImage *)image {
    
    UIButton *leftBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBnt.frame = CGRectMake(-10, TIMESTATUSHEIGHT, 60, 40);
    leftBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [leftBnt setImage:image forState:UIControlStateNormal];
    leftBnt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    backItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBnt addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBnt];
    
}

-(void)createNavRightImage:(UIImage *)image {
    
    UIButton *rightImgBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightImgBnt.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    rightImgBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightImgBnt setImage:image forState:UIControlStateNormal];
    rightImgBnt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    backItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightImgBnt addTarget:self action:@selector(rightImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightImgBnt];
    
}


-(void)createNavRightTitle:(NSString *)title {
    
    UIButton *rightBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBnt.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    rightBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBnt.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBnt setTitle:title forState:0];
    if ([title isEqualToString:eLocalizedString(@"home_set_Commit")]||[title isEqualToString:eLocalizedString(@"delete_name")]) {
        [rightBnt setTitleColor:UIColor.blackColor forState:0];
    }else {
        [rightBnt setTitleColor:UIColor.whiteColor forState:0];
    }
    [rightBnt addTarget:self action:@selector(rightTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBnt];
    
}

- (void)createNavLeftTitle:(NSString *)title
{
    UIButton *leftBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBnt.frame = CGRectMake(-10, TIMESTATUSHEIGHT, 60, 40);
    leftBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    leftBnt.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBnt setTitle:title forState:0];
    if([title isEqualToString:eLocalizedString(@"backP_back")]) {
        [leftBnt setTitleColor:UIColor.whiteColor forState:0];
    }else {
        [leftBnt setTitleColor:RGB(50, 50, 50) forState:0];
    }
    [leftBnt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBnt];
}


-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightTitleAction:(UIButton *)sender{
}

-(void)rightImageAction:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)leftAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)reloadDataWithCurrentView:(BOOL)isCurrent{
    NSLog(@"退出登录");
}



-(BOOL)pageLoadMore:(NSDictionary *)dict {
    
    if ([dict[@"obj"][@"current"] intValue] < [dict[@"obj"][@"pages"] intValue]) {
        return YES;
    }
    return NO;
}

#pragma mark----SVProgressHUD----

-(void)configHUD {
    
    //设置HUD的Style
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeBlack)];
//
//    //设置HUD和文本的颜色
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//
//    //设置HUD背景颜色
//    [SVProgressHUD setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
//
//    [SVProgressHUD setMaximumDismissTimeInterval:1];
//
//    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
//

    //设置提示框的边角弯曲半径
//    [SVProgressHUD setCornerRadius:5];

    
}

-(void)hideHUD {
    
//    [SVProgressHUD dismiss];
}

-(void)showLoading {
    [self configHUD];
    [self hideHUD];
//    [SVProgressHUD showWithStatus:@"请稍后"];
}


-(void)showInfoHUD:(NSString *)info {
    [self configHUD];
    [self hideHUD];
//    [SVProgressHUD showInfoWithStatus:info];
    
}

-(void)showSuccessHUD:(NSString *)success {
    [self configHUD];
    [self hideHUD];
//    [SVProgressHUD showSuccessWithStatus:success];
    
}


-(void)showHUD:(NSString *)title {
//    [SVProgressHUD showWithStatus:title];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)exitUserInfoNotice{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
