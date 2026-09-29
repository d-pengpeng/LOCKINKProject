//
//  MHUserGuideController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/9.
//

#import "MHUserGuideController.h"
#import "FSPageContentView.h"
#import "foundInformationView.h"
#import "Q_AListController.h"

@interface MHUserGuideController ()<FSPageContentViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;
@property (nonatomic, strong) foundInformationView *foundInformationV;
@end

@implementation MHUserGuideController
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
    
    self.titleName.text = eLocalizedString(@"my_settings2");
    self.navView.backgroundColor = RGB(247, 247, 247);

    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    [SVProgressHUD show];
    [requestToolClass getNetworkWithUrl:request_faq_listAll andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
 
        if([info isKindOfClass:[NSArray class]]) {
            [self UIUIUIUIMethod:(NSArray *)info];
        }

    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)UIUIUIUIMethod:(NSArray *)arr
{
    NSMutableArray *contentVCs = [NSMutableArray array];
    NSMutableArray *namsDatas = [NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        NSDictionary *dicMM = arr[i];
        [namsDatas addObject:minStr(dicMM[@"categoryName"])];
        Q_AListController *VC = [[Q_AListController alloc] init];
        VC.arrLList = dicMM[@"faqList"];
        [contentVCs addObject:VC];
    }
    
    self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+50, _window_width, _window_height-NAVHEIGHT-50) childVCs:contentVCs parentVC:self delegate:self];
    self.pageContentV.contentViewCanScroll = YES;
    [self.view addSubview:self.pageContentV];
    self.pageContentV.contentViewCurrentIndex = 0;
    
    self.foundInformationV = [[foundInformationView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, 50)];
    [self.view addSubview:self.foundInformationV];
    [self.foundInformationV addGuideTopTitleMethodDataToDic:namsDatas];
    self.foundInformationV.backgroundColor = UIColor.clearColor;
    WEAKSELF
    self.foundInformationV.block_ = ^(NSInteger type, NSInteger num) {
        
        weakSelf.pageContentV.contentViewCurrentIndex = num;
    };

}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    [self.foundInformationV changeGuideTitleXIndex:endIndex];
}

@end
