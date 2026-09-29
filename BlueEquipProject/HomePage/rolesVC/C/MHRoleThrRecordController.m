//
//  MHRoleThrRecordController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/20.
//

#import "MHRoleThrRecordController.h"
#import "MHRoleThrRecordCell.h"
#import "MHRoleThrRecordModel.h"

@interface MHRoleThrRecordController ()<UITableViewDelegate, UITableViewDataSource, MHRoleThrRecordCDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;

@end

@implementation MHRoleThrRecordController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (NSMutableArray *)datasMut
{
    if (!_datasMut) {
        _datasMut = [NSMutableArray array];
    }
    return _datasMut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.titleName.textColor = UIColor.blackColor;
    self.titleName.text = eLocalizedString(@"role_setting9");
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHRoleThrRecordCell class] forCellReuseIdentifier:@"MHRoleThrRecordCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
}

-(void)loadrefreshing {
    
    WEAKSELF
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeadData];
    }];
    
    // 马上进入刷新状态
    [self.appTableView.mj_header beginRefreshing];

//     设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
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
    NSDictionary *dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"deviceId":self.devicId};
    
    [requestToolClass postNetworkWithUrl:request_device_pageLocationLockLog andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            for (NSDictionary *dicM in listAr) {
                MHRoleThrRecordModel *model = [MHRoleThrRecordModel mj_objectWithKeyValues:dicM];
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
    MHRoleThrRecordCell *cell = [MHRoleThrRecordCell cellWithTabelView:tableView];
    [cell addDataToModel:self.datasMut[indexPath.row] indeP:indexPath];
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)roleThrRecordCDelegateRow:(NSIndexPath *)indPP
{
    MHRoleThrRecordModel *model = self.datasMut[indPP.row];
    
}

@end
