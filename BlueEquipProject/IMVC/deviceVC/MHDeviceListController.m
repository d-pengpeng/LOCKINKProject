//
//  MHDeviceListController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import "MHDeviceListController.h"
#import "MHDeviceListCell.h"
#import "MHDeviceListSubController.h"

@interface MHDeviceListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) NSInteger pageN;
@property (nonatomic, assign) BOOL isRRRR;
@end

@implementation MHDeviceListController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self uploadMehtodUnreadMsg];
    if(!self.isRRRR) {
        [self loadHeadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.redNavView = YES;
    self.titleName.textColor = UIColor.blackColor;
    self.titleName.text = eLocalizedString(@"IMMsg_all2");
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHDeviceListCell class] forCellReuseIdentifier:@"MHDeviceListCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
    
}
- (void)uploadMehtodUnreadMsg
{
    [requestToolClass getNetworkWithUrl:request_message_getMessageOverview andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            NSString *numStr = minStr(info[@"deviceMessageUnreadCount"]);
            [LYUserDefault saveMsgNoRedStart:[numStr integerValue]];
            
            if(self.block_) {
                self.block_([numStr intValue]);
            }
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

//MARK: tableview代理方法
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
    self.isRRRR = YES;
    [requestToolClass postNetworkWithUrl:request_message_pageBoundDevice andParameter:@{@"page":[NSString stringWithFormat:@"%ld", self.pageN], @"size":@"10"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.isRRRR = NO;
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];

        NSArray *datadata = info[@"records"];
        if (self.pageN == 1) {
            [self.datasMut removeAllObjects];
        }

        for (NSDictionary *dicdic in datadata) {
            
            [self.datasMut addObject:dicdic];
        }

        if (datadata.count <= 0) {
            [self.appTableView.mj_footer endRefreshingWithNoMoreData];
        }

        if (self.datasMut.count > 0) {
            self.noDataImgV.hidden = YES;
            [self.appTableView.mj_footer setHidden:NO];
        }else {
            self.noDataImgV.hidden = NO;
            [self.appTableView.mj_footer setHidden:YES];
        }
        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        self.isRRRR = NO;
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
    MHDeviceListCell *cell = [MHDeviceListCell cellWithTabelView:tableView];
    [cell addModelToDataModel:self.datasMut[indexPath.row]];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHDeviceListSubController *vc = [[MHDeviceListSubController alloc] init];
    vc.dicMod = self.datasMut[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
