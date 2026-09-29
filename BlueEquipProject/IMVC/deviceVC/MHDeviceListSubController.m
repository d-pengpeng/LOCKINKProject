//
//  MHDeviceListSubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import "MHDeviceListSubController.h"
#import "MHDeviceListMsgCell.h"
#import "MHDeviceListMsgModel.h"
#import "MHRecordingAuthenticationController.h"

@interface MHDeviceListSubController ()<UITableViewDelegate, UITableViewDataSource, MHDeviceListMsgCellDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) NSInteger pageN;
@property (nonatomic, assign) BOOL isRRRR;
@end

@implementation MHDeviceListSubController
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
    
    self.redNavView = YES;
    self.titleName.textColor = UIColor.blackColor;
    self.titleName.text = minStr(self.dicMod[@"deviceName"]);

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
    [self.appTableView registerClass:[MHDeviceListMsgCell class] forCellReuseIdentifier:@"MHDeviceListMsgCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
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
    [requestToolClass postNetworkWithUrl:request_message_pageDeviceMessage andParameter:@{@"page":[NSString stringWithFormat:@"%ld", self.pageN], @"size":@"10", @"deviceId":minStr(self.dicMod[@"deviceId"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];

        NSArray *datadata = info[@"records"];
        if (self.pageN == 1) {
            [self.datasMut removeAllObjects];
        }

        for (NSDictionary *dicdic in datadata) {
            MHDeviceListMsgModel *model = [MHDeviceListMsgModel mj_objectWithKeyValues:dicdic];
            [self.datasMut addObject:model];
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
    MHDeviceListMsgCell *cell = [MHDeviceListMsgCell cellWithTabelView:tableView];
    [cell addModelToDataModel:self.datasMut[indexPath.row] indPP:indexPath];
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)MHDeviceListMsgCellDelegateType:(NSInteger)typeNN indPM:(NSIndexPath *)dinpp
{
    MHDeviceListMsgModel *model = self.datasMut[dinpp.row];
    switch (model.type) {
        case 201:
        {
            MHRecordingAuthenticationController *vc = [[MHRecordingAuthenticationController alloc] init];
            vc.msgModel = model;
            if(typeNN==2) {
                vc.accepted_str = @"false";
            }else {
                vc.accepted_str = @"true";
            }
            [self.navigationController pushViewController:vc animated:YES];
            WEAKSELF
            vc.block_ = ^{
                __strong __typeof(self)self = weakSelf;
                [self loadHeadData];
            };
            
        }
            break;
        case 202:
        {//申请主人开锁
            if(self.isRRRR) {
                return;
            }
            self.isRRRR = YES;
            NSDictionary *dicM = @{@"messageId":minIntStr(model.messageId), @"accepted":@"true"};
            if(typeNN==2) {
                dicM = @{@"messageId":minIntStr(model.messageId), @"accepted":@"false"};
            }
            [requestToolClass postNetworkWithUrl:request_message_acceptOrDeclineUnlockRequest andParameter:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                self.isRRRR = NO;
                [self loadHeadData];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRR = NO;
            }];
        }
            break;
        case 203:
        {
            if(self.isRRRR) {
                return;
            }
            self.isRRRR = YES;
            NSDictionary *dicM = @{@"messageId":minIntStr(model.messageId), @"accepted":@"true"};
            if(typeNN==2) {
                dicM = @{@"messageId":minIntStr(model.messageId), @"accepted":@"false"};
            }
            [requestToolClass postNetworkWithUrl:request_message_acceptOrDeclineBeMater andParameter:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                self.isRRRR = NO;
                [self loadHeadData];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRR = NO;
            }];
        }
            break;
        case 204:
        {
            MHRecordingAuthenticationController *vc = [[MHRecordingAuthenticationController alloc] init];
            vc.msgModel = model;
            vc.isRecivBoo2 = YES;
            if(typeNN==2) {
                vc.accepted_str = @"false";
            }else {
                vc.accepted_str = @"true";
            }
            [self.navigationController pushViewController:vc animated:YES];
            WEAKSELF
            vc.block_ = ^{
                __strong __typeof(self)self = weakSelf;
                [self loadHeadData];
            };
            
        }
            break;
            
        default:
            break;
    }
}

@end
