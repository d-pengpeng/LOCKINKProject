//
//  MHVisitorController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import "MHVisitorController.h"
#import "FSPageContentView.h"
#import "MHVisitorListController.h"

@interface MHVisitorController ()<FSPageContentViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;
@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;
@end

@implementation MHVisitorController

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
    
    self.titleName.text = eLocalizedString(@"me_allNames9"); //访客
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIView *topVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, 39)];
    topVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:topVV];
    
    UIView *topVV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 39)];
    topVV2.backgroundColor = RGBA(255, 255, 255, 0.6);
    [topVV addSubview:topVV2];
    
    CGFloat ww_oneF = [HistoryRecordModel jiSuanWith:eLocalizedString(@"me_allNames18") font:14]+24;
    CGFloat ww_oneF2 = [HistoryRecordModel jiSuanWith:eLocalizedString(@"me_allNames19") font:14]+24;
    
    self.oneBtn = [HistoryRecordModel createImgBtn];
    self.oneBtn.frame = CGRectMake(2, 0, ww_oneF, 38);
    [self.oneBtn setTitle:eLocalizedString(@"me_allNames18") forState:UIControlStateNormal];
    [self.oneBtn setTitleColor:RGB(94, 94, 94) forState:UIControlStateNormal];
    [self.oneBtn setTitleColor:normalColors forState:UIControlStateSelected];
    self.oneBtn.titleLabel.font = SYS_Font(14);
    [self.oneBtn addTarget:self action:@selector(oneTwoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [topVV addSubview:self.oneBtn];
    self.oneBtn.selected = YES;
    
    self.twoBtn = [HistoryRecordModel createImgBtn];
    self.twoBtn.frame = CGRectMake(2+ww_oneF, 0, ww_oneF2, 38);
    [self.twoBtn setTitle:eLocalizedString(@"me_allNames19") forState:UIControlStateNormal];
    [self.twoBtn setTitleColor:RGB(94, 94, 94) forState:UIControlStateNormal];
    [self.twoBtn setTitleColor:normalColors forState:UIControlStateSelected];
    self.twoBtn.titleLabel.font = SYS_Font(14);
    [self.twoBtn addTarget:self action:@selector(oneTwoBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [topVV addSubview:self.twoBtn];
    
    
    UIView *linvV = [HistoryRecordModel createLineViewUIUI];
    linvV.frame = CGRectMake(0, 38, _window_width, 1);
    [topVV addSubview:linvV];
    
    MHVisitorListController *vcOne = [[MHVisitorListController alloc] init];
    vcOne.numL = @"1";
    
    MHVisitorListController *vcTwo = [[MHVisitorListController alloc] init];
    vcTwo.numL = @"2";
    
    NSArray *arrMut = @[vcOne, vcTwo];
    
    self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+39, _window_width, _window_height-NAVHEIGHT-39) childVCs:arrMut parentVC:self delegate:self];
    self.pageContentV.contentViewCanScroll = YES;
    [self.view addSubview:self.pageContentV];
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    if(endIndex == 0) {
        
        self.oneBtn.selected = YES;
        self.twoBtn.selected = NO;
    }else {
        self.oneBtn.selected = NO;
        self.twoBtn.selected = YES;
    }
}

- (void)oneTwoBtnMethod:(UIButton *)btn
{
    if(btn == self.oneBtn) {
        
        self.oneBtn.selected = YES;
        self.twoBtn.selected = NO;
        self.pageContentV.contentViewCurrentIndex = 0;
    }else {
        self.oneBtn.selected = NO;
        self.twoBtn.selected = YES;
        self.pageContentV.contentViewCurrentIndex = 1;
    }
}

@end
