//
//  RootViewController.m
//  FireJob
//
//  Created by Edwin on 2023/10/20.
//

#import "RootViewController.h"
#import "UIImage+Color.h"
#import "CJNavigationController.h"
#import "MHfindController.h"
#import "MHhomeManageController.h"
#import "MHMessageMangerController.h"
#import "MHMyController.h"
#import "MHConnectLinkController.h"

@interface RootViewController ()<V2TIMFriendshipListener, V2TIMConversationListener>

@property (nonatomic, strong) UILabel *msgitem;
@property (nonatomic, strong) UIView *tabVVVV;
@property (nonatomic, strong) MHMessageMangerController *MHMessageMangerC;
@property (nonatomic, assign) BOOL isBB;
@property (nonatomic, assign) int redNum;
@property (nonatomic, assign) BOOL selecTabbarBoo;
@property (nonatomic, assign) int selTabbar1;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_imgV"];
    [self setUpAllChildVc];
    [self configureMXtabbar];
    
    self.redNum = 0;
    self.selTabbar1 = 1;
    
    [[V2TIMManager sharedInstance] addFriendListener:self];
    [[V2TIMManager sharedInstance] addConversationListener:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MessageNotifUploadMethod) name:@"MessageNotifUpload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabbarHiddenNotifffMethod:) name:customTabbaNotifi object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabbarHiddenNotifffMethodTwo:) name:customTabbaNotifi2 object:nil];
    
    self.tabBar.hidden = YES;
    
    NSArray *imgsArr = @[@"tabbarIcon1", @"tabbarIcon2", @"tabbarIcon3", @"tabbarIcon4", @"tabbarIcon5"];
    NSArray *namsArr = @[@"tabbar_tit1", @"tabbar_tit2", @"", @"tabbar_tit3", @"tabbar_tit4"];
    self.tabVVVV = [HistoryRecordModel createViewUIUI];
    if(TARBARHEIGHT > 50) {
        self.tabVVVV.frame = CGRectMake(12, _window_height-20-TARBARHEIGHT, _window_width-24, 68);
    }else {
        self.tabVVVV.frame = CGRectMake(12, _window_height-38-TARBARHEIGHT, _window_width-24, 68);
    }
    self.tabVVVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.tabVVVV];
    
    UIView *twoPlacV = [HistoryRecordModel createViewUIUI];
    twoPlacV.frame = CGRectMake(0, 10, _window_width-24, 58);
    twoPlacV.backgroundColor = RGB(35, 22, 73);
    [self.tabVVVV addSubview:twoPlacV];
    
    CGFloat w_fiv = (_window_width-24)/5;
    for (int i=0; i<imgsArr.count; i++) {
        
        UIView *fivVV = [[UIView alloc] initWithFrame:CGRectMake(w_fiv*i, 10, w_fiv, 58)];
        fivVV.backgroundColor = UIColor.clearColor;
        [self.tabVVVV addSubview:fivVV];
        
        if(i==2) {
            UIImageView *fivImgV = [HistoryRecordModel createImgImgView];
            fivImgV.image = [UIImage imageNamed:imgsArr[i]];
            [self.tabVVVV addSubview:fivImgV];
            fivImgV.frame = CGRectMake(w_fiv*2+(w_fiv-60)/2, 0, 60, 60);
        }else {
            UIImageView *fivImgV = [HistoryRecordModel createImgImgView];
            fivImgV.image = [UIImage imageNamed:imgsArr[i]];
            [fivVV addSubview:fivImgV];
            fivImgV.frame = CGRectMake((w_fiv-26)/2, 8, 26, 26);
            
            UILabel *fivLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:11 textAlignment:NSTextAlignmentCenter];
            fivLab.frame = CGRectMake(0, 34, w_fiv, 24);
            fivLab.text = eLocalizedString(namsArr[i]);
            fivLab.font = SYS_Font(11);
            fivLab.tag = 9900+i;
            [fivVV addSubview:fivLab];
            if(i==0) {
                fivLab.textColor = RGB(208, 96, 255);
            }
            
            if(i==3) {
                self.msgitem = [HistoryRecordModel createLabLabTextColor:UIColor.redColor fontFloat:8 textAlignment:NSTextAlignmentCenter];
                self.msgitem.backgroundColor = UIColor.redColor;
                self.msgitem.clipsToBounds = YES;
                self.msgitem.layer.cornerRadius = 5;
                [fivVV addSubview:self.msgitem];
                [self.msgitem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(fivImgV.mas_right);
                    make.top.equalTo(fivImgV.mas_top);
                    make.height.offset(10);
//                    make.width.mas_greaterThanOrEqualTo(10);
                    make.width.offset(10);
                }];
                self.msgitem.hidden = YES;
            }
        }
        
        UIButton *fivBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, w_fiv-10, 48)];
        fivBtn.tag = 9800+i;
        [fivBtn addTarget:self action:@selector(fivBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [fivVV addSubview:fivBtn];
    }
    
    [self getUnreadMsg];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceMessageUnreadCountNotifMethod:) name:@"deviceMessageUnreadCountNotif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodFriendNotifUploadMethod) name:@"goodFriendNotifUpload" object:nil];
    
}

- (void)goodFriendNotifUploadMethod
{
    if(([LYUserDefault userDefault].msgRed_start>0) || ([LYUserDefault userDefault].msgRed_start2>0)) {
        
    }else {
        self.msgitem.hidden = YES;
    }
}

- (void)onFriendApplicationListAdded:(NSArray<V2TIMFriendApplication *> *)applicationList
{
    BOOL isBBBB = NO;
    for (V2TIMFriendApplication *model in applicationList) {
        if(model.type == V2TIM_FRIEND_APPLICATION_COME_IN) {
            isBBBB = YES;
        }
    }
    if (isBBBB) {
        self.msgitem.hidden = NO;
        self.msgitem.text = @"9";
        self.MHMessageMangerC.isGoodBoo = YES;
    }else{
        self.MHMessageMangerC.isGoodBoo = NO;
        if(([LYUserDefault userDefault].msgRed_start>0) || ([LYUserDefault userDefault].msgRed_start2>0)) {
            
        }else {
            self.msgitem.hidden = YES;
        }
    }
}

- (void)deviceMessageUnreadCountNotifMethod:(NSNotification *)notifff
{
//    NSString *numStr = minStr(notifff.object);
    NSDictionary *dicMM = notifff.userInfo;
    NSString *numStr = minStr(dicMM[@"redOne"]);
    NSString *numStr2 = minStr(dicMM[@"redTwo"]);
    
    if (([numStr intValue] > 0) || ([numStr2 intValue] > 0)) {
        self.msgitem.hidden = NO;
        self.msgitem.text = @"9";
        self.isBB = YES;
    }else{
        self.msgitem.hidden = YES;
        self.isBB = NO;
    }
}

- (void)fivBtnMethods:(UIButton *)btn
{
    
    if (self.selTabbar1 != (int)(btn.tag-9800+1)) {
        self.selecTabbarBoo = YES;
    }
    
    self.tabVVVV.hidden = NO;
    
    self.selTabbar1 = (int)(btn.tag-9800+1);
    
    UILabel *fivsLab = [self.tabVVVV viewWithTag:9900];
    UILabel *fivsLab2 = [self.tabVVVV viewWithTag:9901];
    UILabel *fivsLab3 = [self.tabVVVV viewWithTag:9903];
    UILabel *fivsLab4 = [self.tabVVVV viewWithTag:9904];
    
    switch (btn.tag) {
        case 9800:
        {
            fivsLab.textColor = RGB(208, 96, 255);
            fivsLab2.textColor = UIColor.whiteColor;
            fivsLab3.textColor = UIColor.whiteColor;
            fivsLab4.textColor = UIColor.whiteColor;
            self.selectedIndex = 0;
        }
            break;
        case 9801:
        {
            fivsLab.textColor = UIColor.whiteColor;
            fivsLab2.textColor = RGB(208, 96, 255);
            fivsLab3.textColor = UIColor.whiteColor;
            fivsLab4.textColor = UIColor.whiteColor;
            self.selectedIndex = 1;
        }
            break;
        case 9802:
        {
            fivsLab.textColor = UIColor.whiteColor;
            fivsLab2.textColor = UIColor.whiteColor;
            fivsLab3.textColor = UIColor.whiteColor;
            fivsLab4.textColor = UIColor.whiteColor;
            self.selectedIndex = 2;
        }
            break;
        case 9803:
        {
            fivsLab.textColor = UIColor.whiteColor;
            fivsLab2.textColor = UIColor.whiteColor;
            fivsLab3.textColor = RGB(208, 96, 255);
            fivsLab4.textColor = UIColor.whiteColor;
            self.selectedIndex = 3;
        }
            break;
        case 9804:
        {
            fivsLab.textColor = UIColor.whiteColor;
            fivsLab2.textColor = UIColor.whiteColor;
            fivsLab3.textColor = UIColor.whiteColor;
            fivsLab4.textColor = RGB(208, 96, 255);
            self.selectedIndex = 4;
        }
            break;
            
        default:
            break;
    }
    
    self.tabVVVV.hidden = NO;
}

- (void)tabbarHiddenNotifffMethod:(NSNotification *)notiff
{
    self.tabBar.hidden = YES;
    
    if (!self.selecTabbarBoo) {

        NSString *mmSt = minStr(notiff.object);
        
        if([mmSt intValue]==2) {
            self.tabVVVV.hidden = YES;
        }else {
            self.tabVVVV.hidden = NO;
        }
    }
    
}

- (void)tabbarHiddenNotifffMethodTwo:(NSNotification *)notiff
{
    if ([minStr(notiff.object) intValue] == self.selTabbar1) {
        self.selecTabbarBoo = NO;
    }
}

- (void)MessageNotifUploadMethod
{
    [self getUnreadMsg];
}

- (void)onTotalUnreadMessageCountChanged:(UInt64) totalUnreadCoun
{
    self.msgitem.hidden = NO;
    if (totalUnreadCoun == 0) {
        if(([LYUserDefault userDefault].msgRed_start>0) || ([LYUserDefault userDefault].msgRed_start2>0)) {
            
        }else {
            self.msgitem.hidden = YES;
            self.isBB = NO;
        }
    }else {
        self.msgitem.text = @"9";
        self.isBB = YES;
    }
}


- (void)setUpAllChildVc {
    
    MHhomeManageController  *homeVV = [[MHhomeManageController alloc]init];
    MHfindController *auctionVV2 = [[MHfindController alloc] init];
    MHConnectLinkController *auctionVV = [[MHConnectLinkController alloc] init];
    MHMessageMangerController *messageIMVV = [[MHMessageMangerController alloc] init];
    MHMyController *minVC = [[MHMyController alloc] init];
    
    self.MHMessageMangerC = messageIMVV;

    [self setUpOneChildVcWithVc:homeVV Image:@"tabbarIcon1" selectedImage:@"tabbarIcon1" title:@""];
    [self setUpOneChildVcWithVc:auctionVV2 Image:@"tabbarIcon1" selectedImage:@"tabbarIcon1" title:@""];
    [self setUpOneChildVcWithVc:auctionVV Image:@"tabbarIcon1" selectedImage:@"tabbarIcon1" title:@""];
    [self setUpOneChildVcWithVc:messageIMVV Image:@"tabbarIcon1" selectedImage:@"tabbarIcon1" title:@""];
    [self setUpOneChildVcWithVc:minVC Image:@"tabbarIcon1" selectedImage:@"tabbarIcon1" title:@""];
    
//    msgitem = messageIMVV.tabBarItem;
    self.selectedIndex = 0;
}

- (void)getUnreadMsg
{
    [[V2TIMManager sharedInstance] getTotalUnreadMessageCount:^(UInt64 totalCount) {
        self.msgitem.hidden = NO;
        if (totalCount == 0) {
            if(([LYUserDefault userDefault].msgRed_start>0) || ([LYUserDefault userDefault].msgRed_start2>0)) {
                
            }else {
                self.msgitem.hidden = YES;
                self.isBB = NO;
            }
        }else {
            self.msgitem.text = @"9";
            self.isBB = YES;
        }

    } fail:^(int code, NSString *desc) {

    }];
}


- (void)configureMXtabbar {

    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    textAttrs[NSForegroundColorAttributeName] = GrayText;
     
    // 选中时字体颜色和选中图片颜色一致
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    selectedTextAttrs[NSForegroundColorAttributeName] = normalColors;

    // 通过appearance统一设置所有UITabBarItem的文字属性样式
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];

    if (@available(iOS 13.0, *)) {
        self.tabBar.tintColor = normalColors;
    }
    self.view.backgroundColor = RGB(28, 37, 46);//[UIColor groupTableViewBackgroundColor];
}

- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    CJNavigationController *nav = [[CJNavigationController alloc]initWithRootViewController:Vc];
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    [Vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -7)];
    [Vc.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, 5, 0)];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
