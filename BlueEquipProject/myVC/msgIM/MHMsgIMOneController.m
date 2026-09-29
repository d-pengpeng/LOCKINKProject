//
//  MHMsgIMOneController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/5.
//

#import "MHMsgIMOneController.h"
#import "MHMsgIMOneCell.h"
#import "MHSystemMsgModel.h"

@interface MHMsgIMOneController ()<UITableViewDelegate, UITableViewDataSource, MHMsgIMOneCellDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) NSInteger pageN;
@end

@implementation MHMsgIMOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navView.backgroundColor = RGB(247, 247, 247);
    self.titleName.text = eLocalizedString(@"IMMsg_all1");
    
    UIImageView *imgPlacV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    imgPlacV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:imgPlacV];
    
    UIView *oneMM = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    oneMM.backgroundColor = RGBA(255, 255, 255, 0.6);
    [self.view addSubview:oneMM];
    
    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHMsgIMOneCell class] forCellReuseIdentifier:@"MHMsgIMOneCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
}

//MARK: tableview代理方法
-(void)loadrefreshing{
    
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
    [requestToolClass postNetworkWithUrl:request_message_pageInteractiveMessage andParameter:@{@"page":[NSString stringWithFormat:@"%ld", self.pageN], @"size":@"10"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];

        NSArray *datadata = info[@"records"];
        if (self.pageN == 1) {
            [self.datasMut removeAllObjects];
        }
        
        for (NSDictionary *dicML in datadata) {
            MHSystemMsgModel *model = [MHSystemMsgModel mj_objectWithKeyValues:dicML];
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
    MHMsgIMOneCell *cell = [MHMsgIMOneCell cellWithTabelView:tableView];
    [cell addModelToDataModel:self.datasMut[indexPath.row]];
    cell.deleagte_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
