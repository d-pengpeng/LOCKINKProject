//
//  MHRoleMoreListController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "MHRoleMoreListController.h"
#import "MHRoleMoreListCell.h"
#import "MHRoleMoreListModel.h"
#import "MHRoleSetCoreLocatView.h"

@interface MHRoleMoreListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;

@property (nonatomic, strong) UIButton *oneBtn;
@property (nonatomic, strong) UIButton *twoBtn;
@end

@implementation MHRoleMoreListController

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
    self.redNavView = NO;
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
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
    [self.appTableView registerClass:[MHRoleMoreListCell class] forCellReuseIdentifier:@"MHRoleMoreListCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    if(self.typeNN == 1) {
        self.titleName.text = eLocalizedString(@"role_setting18");
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
        clearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [clearBtn setTitle:eLocalizedString(@"role_setting44") forState:0];
        [clearBtn setTitleColor:RGB(202, 76, 255) forState:0];
        [clearBtn addTarget:self action:@selector(clearBtnTitleMehtod) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:clearBtn];
    }else if(self.typeNN == 2) {
        
        self.titleName.text = eLocalizedString(@"role_setting19");
    }else if (self.typeNN == 3) {
        
        self.titleName.text = self.roleOneModel.name;
        
        UIView *oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, 38)];
        oneVV.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:oneVV];
        
        self.appTableView.frame = CGRectMake(0, NAVHEIGHT+38, _window_width, _window_height-NAVHEIGHT-38);
        
        self.oneBtn = [HistoryRecordModel createImgBtn];
        [self.oneBtn setTitle:eLocalizedString(@"role_setting19") forState:UIControlStateNormal];
        [self.oneBtn setTitleColor:RGB(94, 94, 94) forState:UIControlStateNormal];
        [self.oneBtn setTitleColor:normalColors forState:UIControlStateSelected];
        self.oneBtn.titleLabel.font = SYS_Font(14);
        [self.oneBtn addTarget:self action:@selector(oneBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.oneBtn];
        [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(5);
            make.top.bottom.equalTo(oneVV);
            make.width.mas_greaterThanOrEqualTo(56);
        }];
        
        self.twoBtn = [HistoryRecordModel createImgBtn];
        [self.twoBtn setTitle:eLocalizedString(@"role_setting19_19") forState:UIControlStateNormal];
        [self.twoBtn setTitleColor:RGB(94, 94, 94) forState:UIControlStateNormal];
        [self.twoBtn setTitleColor:normalColors forState:UIControlStateSelected];
        self.twoBtn.titleLabel.font = SYS_Font(14);
        [self.twoBtn addTarget:self action:@selector(oneBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.twoBtn];
        [self.twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneBtn.mas_right).offset(20);
            make.top.bottom.equalTo(oneVV);
            make.width.mas_greaterThanOrEqualTo(56);
        }];
        
        self.oneBtn.selected = YES;
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        linVV.frame = CGRectMake(0, 37, _window_width, 1);
        [oneVV addSubview:linVV];
    }
    
    [self loadrefreshing];
}

- (void)oneBtnMethod:(UIButton *)btn
{
    if(btn == self.oneBtn) {
        
        self.oneBtn.selected = YES;
        self.twoBtn.selected = NO;
        self.typeNN = 3;
    }else {
        self.oneBtn.selected = NO;
        self.twoBtn.selected = YES;
        self.typeNN = 4;
    }
    [self.appTableView.mj_header beginRefreshing];
}

- (void)clearBtnTitleMehtod
{
    MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    vc.roleOneModel = self.roleOneModel;
    [vc addUIUIUIUMethodType:2];
    vc.block_ = ^(NSArray * _Nonnull arrList) {
        [requestToolClass getNetworkWithUrl:request_device_clearLocationLockCloseLog andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            [self.datasMut removeAllObjects];
            [self.appTableView reloadData];
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    };
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
    NSDictionary *dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"deviceId":minIntStr(self.roleOneModel.id)};
    NSString *url_url = request_device_pageLocationLockCloseLog;
    if(self.typeNN == 2) {
        url_url = request_device_pageDeviceLog;
        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"deviceId":minIntStr(self.roleOneModel.id), @"type":@"1"};
    }if(self.typeNN == 3) {
        url_url = request_device_pageDeviceLog;
        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"deviceId":minIntStr(self.roleOneModel.id), @"type":@"1"};
    }if(self.typeNN == 4) {
        url_url = request_device_pageDeviceLog;
        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"deviceId":minIntStr(self.roleOneModel.id), @"type":@"2"};
    }
    [requestToolClass postNetworkWithUrl:url_url andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

        if([info isKindOfClass:[NSDictionary class]]) {

            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            for (NSDictionary *dicM in listAr) {
                MHRoleMoreListModel *model = [MHRoleMoreListModel mj_objectWithKeyValues:dicM];
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
    MHRoleMoreListCell *cell = [MHRoleMoreListCell cellWithTabelView:tableView];
    if(self.typeNN == 1) {
        [cell addModelToDataModel:self.datasMut[indexPath.row]];
    }else {
        [cell addModelToDataModelTwo:self.datasMut[indexPath.row]];
    }
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.typeNN == 1) {
        return YES;
    }else {
        return NO;
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:eLocalizedString(@"home_delete") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.view addSubview:vc];
        vc.roleOneModel = self.roleOneModel;
        [vc addUIUIUIUMethodType:2];
        vc.block_ = ^(NSArray * _Nonnull arrList) {
            MHRoleMoreListModel *model = self.datasMut[indexPath.row];
            [requestToolClass getNetworkWithUrl:request_device_deleteLocationLockCloseLog andParameter:@{@"recordId":model.recordId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

                [self.datasMut removeObjectAtIndex:indexPath.row];
                [self.appTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } fail:^(NSString * _Nonnull msg) {

            }];
        };
        
        NSLog(@"点击了删除");
    }];
    action0.backgroundColor = UIColor.redColor;
    
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了关注");
//      // 收回左滑出现的按钮(退出编辑模式)
//        tableView.editing = NO;
//    }];
//    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        NSLog(@"点击了编辑");
//
//        tableView.editing = NO;
//    }];
    return @[action0];
}

@end
