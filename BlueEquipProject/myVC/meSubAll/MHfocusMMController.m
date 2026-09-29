//
//  MHfocusMMController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import "MHfocusMMController.h"
#import "MHVisitorModel.h"
#import "MHfocusCell.h"
#import "MHOthrMyController.h"

@interface MHfocusMMController ()<UITableViewDelegate, UITableViewDataSource, MHfocusCellDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;

@end

@implementation MHfocusMMController

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
    self.titleName.text = self.isFensi ? eLocalizedString(@"me_allNames7"):eLocalizedString(@"plaza_all1");
    
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    _datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHfocusCell class] forCellReuseIdentifier:@"MHfocusCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
}

-(void)loadrefreshing {
    
    WEAKSELF
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeadData];
    }];
    
    // 马上进入刷新状态
    [self.appTableView.mj_header beginRefreshing];
    
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadFootData];
    }];
}

- (void)loadHeadData {
    
    self.pageN = 1;
    [self RequestListData];
}

- (void)loadFootData {
    
    self.pageN ++;
    [self RequestListData];
}

- (void)RequestListData
{
    NSDictionary *dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10"};
    NSString *url_url = request_user_pageFollowing;
    if(self.isFensi) {
        url_url = request_user_pageFollower;
    }
    [requestToolClass postNetworkWithUrl:url_url andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            for (NSDictionary *dicM in listAr) {
                MHVisitorModel *model = [MHVisitorModel mj_objectWithKeyValues:dicM];
                [self.datasMut addObject:model];
            }
            
            if(listAr <= 0) {
                [self.appTableView.mj_header endRefreshing];
                [self.appTableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.appTableView.mj_header endRefreshing];
                [self.appTableView.mj_footer endRefreshing];
            }
            if(self.datasMut.count>0) {
                self.noDataImgV.hidden = YES;
                [self.appTableView.mj_footer setHidden:NO];
            }else {
                self.noDataImgV.hidden = NO;
                [self.appTableView.mj_footer setHidden:YES];
            }
            [self.appTableView reloadData];
        }else {
            [self.appTableView.mj_header endRefreshing];
            [self.appTableView.mj_footer endRefreshing];
        }

    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];

    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasMut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHfocusCell *cell = [MHfocusCell cellWithTabelView:tableView];
    if(self.isFensi) {
        [cell addDataToFensiModel:self.datasMut[indexPath.row] indeP:indexPath.row];
    }else {
        [cell addDataToModel:self.datasMut[indexPath.row] indeP:indexPath.row];
    }
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)MHfocusCellDelegateMEthodClickAvatorRow:(NSInteger)indPP
{
    MHVisitorModel *model = self.datasMut[indPP];
    MHOthrMyController *vc = [[MHOthrMyController alloc] init];
    vc.otherId = minStr(model.uid);
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^{
        [self loadHeadData];
    };
}

- (void)MHfocusCellDelegateMEthodRow:(NSInteger)indPP
{
    MHVisitorModel *model = self.datasMut[indPP];
    NSString *urlMM = [NSString stringWithFormat:@"%@?followingId=%@", request_user_followOrUnfollow, model.uid];
    [requestToolClass getNetworkWithUrl:urlMM andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if(self.isFensi) {
            model.isFollowed = !model.isFollowed;
        }else {
            [self.datasMut removeObjectAtIndex:indPP];
        }
        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

@end
