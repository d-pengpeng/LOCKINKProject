//
//  MHSystemMessageController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/18.
//

#import "MHSystemMessageController.h"
#import "MHSystemMsgCell.h"
#import "MHSystemMsgModel.h"
#import "MHSystemMsgTwoCell.h"
@interface MHSystemMessageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) NSInteger pageN;

@end

@implementation MHSystemMessageController

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
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.titleName.text = eLocalizedString(@"IMMsg_all3");
    self.redNavView = NO;
    self.navView.backgroundColor = UIColor.clearColor;

    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHSystemMsgCell class] forCellReuseIdentifier:@"MHSystemMsgCell"];
    [self.appTableView registerClass:[MHSystemMsgTwoCell class] forCellReuseIdentifier:@"MHSystemMsgTwoCell"];
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
            NSString *numStr = minStr(info[@"systemMessageUnreadCount"]);
            [LYUserDefault saveMsgNoRedStart2:[numStr integerValue]];
            
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
    [requestToolClass postNetworkWithUrl:request_message_pageSystemMessage andParameter:@{@"page":[NSString stringWithFormat:@"%ld", self.pageN], @"size":@"10"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];

        NSArray *datadata = info[@"records"];
        if (self.pageN == 1) {
            [self.datasMut removeAllObjects];
        }

        for (NSDictionary *dicdic in datadata) {
            MHSystemMsgModel *model = [MHSystemMsgModel mj_objectWithKeyValues:dicdic];
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
        
        [self uploadMehtodUnreadMsg];
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasMut.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MHSystemMsgModel *model = self.datasMut[section];
    return 1+model.msgList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHSystemMsgModel *model = self.datasMut[indexPath.section];
    if(indexPath.row > 0) {
        
        MHSystemMsgTwoCell *cell = [MHSystemMsgTwoCell cellWithTabelView:tableView];
        [cell addModelToDataModel:model.msgList[indexPath.row-1]];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MHSystemMsgCell *cell = [MHSystemMsgCell cellWithTabelView:tableView];
        [cell addModelToDataModel:model.date];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

@end
