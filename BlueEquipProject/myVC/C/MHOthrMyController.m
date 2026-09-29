//
//  MHOthrMyController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/13.
//

#import "MHOthrMyController.h"
#import "homeLivingOneCell.h"
#import "homeLivingTwoCell.h"
#import "foundInformationView.h"
#import "MHfindSubPatternsModel.h"
#import "PopBottomView.h"
#import "MHReportJBViewController.h"
#import "MHUserModel.h"

@interface MHOthrMyController ()<UITableViewDelegate, UITableViewDataSource, homeLivingOneCellDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic,strong) NSMutableArray *datasMut;
@property (nonatomic, assign) CGFloat oneFloatNum;
@property (nonatomic, assign) NSInteger typeP;
@property (nonatomic, assign) BOOL scrolBoo;
@property (nonatomic, strong) foundInformationView *foundInformationV;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) NSDictionary *userDic;

@end

@implementation MHOthrMyController

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
    
//    if([LYUserDefault userDefault].isLoginBoo) {
//
//        [self requestUIUIMethod];
//    }
}

- (void)requestUIUIMethod
{
    [requestToolClass getNetworkWithUrl:request_user_other andParameter:@{@"otherUid":self.otherId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

        self.userDic = info;
        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(2, 0, 3);
    self.redNavView = YES;
    
    _datasMut = [NSMutableArray array];
    
    self.oneFloatNum = 310-NAVHEIGHT-45;
    self.typeP = 0;
    
    self.listArr = @[eLocalizedString(@"plaza_all14"), eLocalizedString(@"me_allNames1"), eLocalizedString(@"plaza_all13"), eLocalizedString(@"me_allNames2")];
    
    self.appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) style:UITableViewStylePlain];
    self.appTableView.delegate = self;
    self.appTableView.dataSource = self;
    self.appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.appTableView.rowHeight = UITableViewAutomaticDimension;
    self.appTableView.estimatedRowHeight = 70;
    self.appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[homeLivingOneCell class] forCellReuseIdentifier:@"homeLivingOneCell"];
    [self.appTableView registerClass:[homeLivingTwoCell class] forCellReuseIdentifier:@"homeLivingTwoCell"];
    [self.view addSubview:self.appTableView];
    [self.view addSubview:self.navView];
    
    [self createNavRightImage:[UIImage imageNamed:@"rigMore_img1"]];
    
    [self loadrefreshing];
    
    [self.view addSubview:self.navView];
    
    UIButton *rightImgBnt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightImgBnt2.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    rightImgBnt2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightImgBnt2 setImage:[UIImage imageNamed:@"rigMore_img1"] forState:UIControlStateNormal];
    rightImgBnt2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightImgBnt2 addTarget:self action:@selector(rightImageClickMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightImgBnt2];
    
}

- (void)rightImageClickMethod
{
    MHUserModel *model = [MHUserModel mj_objectWithKeyValues:self.userDic];
    NSArray *array = @[@{@"name":eLocalizedString(@"me_allNames22"),@"id":@"3"},@{@"name":eLocalizedString(@"me_allNames23"),@"id":@"2"},@{@"name":eLocalizedString(@"home_Cancel")}];
    if(model.isBlocked) {
        array = @[@{@"name":eLocalizedString(@"me_allNames22_22"),@"id":@"3"},@{@"name":eLocalizedString(@"me_allNames23"),@"id":@"2"},@{@"name":eLocalizedString(@"home_Cancel")}];
    }
    
    PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
    pop.cancelColor = GrayTextColor;
    pop.data = array;
    pop.blockCallBackIndex = ^(NSDictionary *dictionary){
        
        if ([dictionary[@"id"] intValue] == 3) {
            
            if(model.isBlocked) {
                [SGActionView showAlertWithTitle:nil message:[NSString stringWithFormat:@"%@?", eLocalizedString(@"my_about23")] leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        [requestToolClass getNetworkWithUrl:request_other_blockOrUnblock andParameter:@{@"uid":minStr(self.userDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"my_about22_22")];
                            [self requestUIUIMethod];
                        } fail:^(NSString * _Nonnull msg) {
                            
                        }];
                    }
                }];
            }else {
                [SGActionView showAlertWithTitle:nil message:[NSString stringWithFormat:@"%@?", eLocalizedString(@"me_allNames22")] leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                    if (index == 1) {
                        [requestToolClass getNetworkWithUrl:request_other_blockOrUnblock andParameter:@{@"uid":minStr(self.userDic[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"my_about22")];
                            [self.navigationController popViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            
                        }];
                    }
                }];
            }
            
        }else if ([dictionary[@"id"] intValue] == 2) {
            MHReportJBViewController *vc = [[MHReportJBViewController alloc] init];
            vc.typeL = @"USER";
            vc.targetIId = self.otherId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [pop viewShow];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
 
    CGPoint offset = aScrollView.contentOffset;
    if(offset.y >= self.oneFloatNum) {
        NSLog(@"滑动y-y --%.0f",offset.y);
        if(!self.scrolBoo) {
            self.scrolBoo = YES;
            [self.appTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            [self.appTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else {
        if(offset.y < self.oneFloatNum-20){
            self.scrolBoo = NO;
        };
    }
}

-(void)loadrefreshing{
    
    WEAKSELF
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeadData];
    }];
    
    // 马上进入刷新状态
    [self.appTableView.mj_header beginRefreshing];
}

- (void)loadHeadData {
    
    [self RequestListData];
}

- (void)RequestListData
{
    NSString *url_url = request_user_pageOtherActivity;
    NSDictionary *dicMM = @{@"page":@"1", @"size":@"10", @"userId":self.otherId};
    if(self.typeP == 1){
        url_url = request_user_pageTimelineAlbum;
    }else if (self.typeP == 2) {
        url_url = request_album_pageOwnToysActivity;
    }else if (self.typeP == 3) {
        url_url = request_device_pageDevice;
    }
    
    [requestToolClass postNetworkWithUrl:url_url andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.datasMut removeAllObjects];
        NSArray *arrL = info[@"records"];
        if((self.typeP == 0) || (self.typeP == 2)) {
            for (NSDictionary *dciM in arrL) {
                MHfindSubPatternsModel *model = [MHfindSubPatternsModel mj_objectWithKeyValues:dciM];
                [self.datasMut addObject:model];
            }
        }else {
            for (NSDictionary *dciM in arrL) {
                [self.datasMut addObject:dciM];
            }
        }
        
        [self.appTableView reloadData];
        if([LYUserDefault userDefault].isLoginBoo) {

            [self requestUIUIMethod];
        }
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        homeLivingOneCell *cell = [homeLivingOneCell cellWithTabelView:tableView];
        if(self.userDic) {
            [cell addDataToOthrUser:self.userDic];
        }
        cell.delegate_ = self;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {

        homeLivingTwoCell *cell = [homeLivingTwoCell cellWithTabelView:tableView];
        cell.selVC = self;
        cell.othrId = self.otherId;
        [cell addDataToModel:self.listArr datList:self.datasMut typeL:self.typeP booScrol:self.scrolBoo vieControl:self];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WEAKSELF
        cell.block_ = ^(NSInteger selRow) {
            weakSelf.typeP = selRow;
            
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:weakSelf.typeP];
            [weakSelf.appTableView.mj_header beginRefreshing];
        };
        
        return cell;
    }
}

- (void)homeLivUploadMethod
{
    if(self.block_) {
        self.block_();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1) {
        return 44;
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headVVV = [self.appTableView viewWithTag:3390];
    if(!headVVV) {
        
        headVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 44)];
        headVVV.tag = 3390;
        
        UIView *bgV1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 20)];
        bgV1.clipsToBounds = YES;
        [headVVV addSubview:bgV1];
        
        UIImageView *pppImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 20)];
        pppImgV.image = [UIImage imageNamed:@"userSpacePlacImg"];
        [bgV1 addSubview:pppImgV];
        
        self.foundInformationV = [[foundInformationView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 44)];
        self.foundInformationV.layer.cornerRadius = 0;
        [headVVV addSubview:self.foundInformationV];
        self.foundInformationV.backgroundColor = RGB(1, 0, 2);
        [self.foundInformationV addVIdeoTopTitleMethodDataToDic:self.listArr];
        WEAKSELF
        self.foundInformationV.block_ = ^(NSInteger type, NSInteger num) {
            weakSelf.typeP = num;
            [weakSelf loadHeadData];
        };
    }
    
    [self.foundInformationV changeVIdeoTopTitleXIndex:self.typeP];
    return headVVV;
}

@end
