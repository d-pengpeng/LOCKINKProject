//
//  MHRoleSettingController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "MHRoleSettingController.h"
#import "MHRoleSetSubController.h"
#import "FSPageContentView.h"
@interface MHRoleSettingController ()<FSPageContentViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;

@property (nonatomic, strong) UIView *spacVV;
@property (nonatomic, strong) UIView *topV;
@end

@implementation MHRoleSettingController

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
    self.navView.backgroundColor = UIColor.clearColor;
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    self.titleName.text = eLocalizedString(@"my_settings");
//    [self createNavRightImage:[UIImage imageNamed:@"role_imgs12"]];
    
    _topV = [[UIView alloc] initWithFrame:CGRectMake(12, NAVHEIGHT+5, _window_width-24, 38)];
    _topV.backgroundColor = UIColor.clearColor;
    _topV.clipsToBounds = YES;
    _topV.layer.cornerRadius = 19;
    [self.view addSubview:_topV];
    
    UIView *topPlacV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 38)];
    topPlacV.backgroundColor = RGBA(138, 0, 197, 0.15);
    [_topV addSubview:topPlacV];
    
    CGFloat w_xx = (_window_width-24)/3;
    
    self.spacVV = [HistoryRecordModel createViewUIUI];
    self.spacVV.frame = CGRectMake((w_xx-70)/2, 3, 70, 32);
    self.spacVV.backgroundColor = RGB(138, 0, 197);
    self.spacVV.layer.cornerRadius = 16;
    [_topV addSubview:self.spacVV];
    
    NSArray *namAr = @[@"role_name22", @"role_name23", @"role_name24"];
    for (int i=0; i<namAr.count; i++) {
        UIButton *thrTopB = [HistoryRecordModel createImgBtn];
        thrTopB.frame = CGRectMake(i*w_xx, 0, w_xx, 38);
        [thrTopB setTitle:eLocalizedString(namAr[i]) forState:UIControlStateNormal];
        [thrTopB setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [thrTopB setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        thrTopB.titleLabel.font = SYS_Font(16);
        thrTopB.tag = 3200+i;
        [thrTopB addTarget:self action:@selector(thrTopBtns:) forControlEvents:UIControlEventTouchUpInside];
        [_topV addSubview:thrTopB];
        if(i==0) {
            thrTopB.selected = YES;
        }
    }
    
    NSMutableArray *contentVCs = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        MHRoleSetSubController *VC = [[MHRoleSetSubController alloc] init];
        VC.typN = i;
        VC.devicId = self.devicId;
        VC.selfUpVC = self.selfUpVC;
        VC.devicTyy = self.devicTyp;
        [contentVCs addObject:VC];
        VC.block_ = ^(BOOL isboo) {
            [self block_blockUpload:isboo];
        };
    }
    
    self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+50, _window_width, _window_height-NAVHEIGHT-50) childVCs:contentVCs parentVC:self delegate:self];
    self.pageContentV.contentViewCanScroll = YES;
    self.pageContentV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.pageContentV];
    self.pageContentV.contentViewCurrentIndex = self.numTpy;
    
    [self UIUIUIUIUI:self.numTpy];
}

- (void)block_blockUpload:(BOOL)isboo
{
    if(self.block_) {
        self.block_(isboo);
    }
}

- (void)thrTopBtns:(UIButton *)btn
{
    [UIView animateWithDuration:0.3 animations:^{
        self.spacVV.centerX = btn.centerX;
    }];
    
    for (int i=0; i<3; i++) {
        UIButton *suBtn = [self.topV viewWithTag:3200+i];
        if(btn == suBtn) {
            suBtn.selected = YES;
            self.pageContentV.contentViewCurrentIndex = i;
        }else {
            suBtn.selected = NO;
        }
    }
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    [self UIUIUIUIUI:endIndex];
}

- (void)UIUIUIUIUI:(NSInteger)endIndex
{
    for (int i=0; i<3; i++) {
        UIButton *suBtn = [self.topV viewWithTag:3200+i];
        if(endIndex == i) {
            suBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.spacVV.centerX = suBtn.centerX;
            }];
        }else {
            suBtn.selected = NO;
        }
    }
}

@end
