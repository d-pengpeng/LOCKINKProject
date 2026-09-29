//
//  MHSquareRankingController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/9.
//

#import "MHSquareRankingController.h"
#import "MHrankingTwoCell.h"
#import "MHrankingOneCell.h"
#import "MHrankingUserModel.h"
#import "MHRankingPlaceView.h"
#import "MHOthrMyController.h"

@interface MHSquareRankingController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, copy) NSString *rankingStr;
@property (nonatomic, assign) BOOL isjoinBOne;
@property (nonatomic, assign) BOOL isjoinBTwo;
@property (nonatomic, strong) UIButton *joinBtn;
@property (nonatomic, strong) UIView *topPlacV;
@end

@implementation MHSquareRankingController
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
    UIImageView *oneImaVV = [HistoryRecordModel createImgImgView];
    oneImaVV.frame = CGRectMake(0, 0, _window_width, _window_height);
    oneImaVV.image = [UIImage imageNamed:@"rankingBackImg"];
    [self.view addSubview:oneImaVV];
    
    self.rankingStr = @"1";
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHrankingTwoCell class] forCellReuseIdentifier:@"MHrankingTwoCell"];
    [self.appTableView registerClass:[MHrankingOneCell class] forCellReuseIdentifier:@"MHrankingOneCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 470, _window_width, _window_height-470)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self.view addSubview:self.navView];
    self.titleName.text = eLocalizedString(@"plaza_all23");
    
    self.joinBtn = [HistoryRecordModel createImgBtn];
    self.joinBtn.frame = CGRectMake((_window_width-210)/2, _window_height-100, 210, 46);
    [self.joinBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [self.joinBtn setTitle:eLocalizedString(@"plaza_all24") forState:UIControlStateNormal];
    [self.joinBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.joinBtn.titleLabel.font = SYS_Font(14);
    [self.joinBtn addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.joinBtn];
    
    UIView *topVVV = [HistoryRecordModel createViewUIUI];
    topVVV.frame = CGRectMake((_window_width-268)/2, NAVHEIGHT+10, 268, 30);
    topVVV.layer.cornerRadius = 15;
    topVVV.backgroundColor = RGB(176, 51, 228);
    [self.view addSubview:topVVV];
    
    self.topPlacV = [HistoryRecordModel createViewUIUI];
    self.topPlacV.frame = CGRectMake(0, 0, 134, 30);
    self.topPlacV.backgroundColor = UIColor.blackColor;
    self.topPlacV.layer.cornerRadius = 15;
    [topVVV addSubview:self.topPlacV];
    
    UIButton *oneBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 134, 30)];
    [oneBBB setTitle:eLocalizedString(@"plaza_all25") forState:UIControlStateNormal];
    [oneBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    oneBBB.titleLabel.font = SYS_Font(16);
    [oneBBB addTarget:self action:@selector(oneTBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [topVVV addSubview:oneBBB];
    
    UIButton *oneBBB2 = [[UIButton alloc] initWithFrame:CGRectMake(134, 0, 134, 30)];
    [oneBBB2 setTitle:eLocalizedString(@"plaza_all27") forState:UIControlStateNormal];
    [oneBBB2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    oneBBB2.titleLabel.font = SYS_Font(16);
    [oneBBB2 addTarget:self action:@selector(oneTwoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [topVVV addSubview:oneBBB2];
    
    
    [self loadrefreshing];
}

- (void)sureBtnMethod
{
    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    if([self.rankingStr isEqualToString:@"1"]) {
        
        [vc addDataToDic:1];
    }else {
        [vc addDataToDic:2];
    }
    vc.block_ = ^(BOOL isBBB) {
        if(isBBB) {
            [self rankRquest];
        }
    };
}

- (void)rankRquest
{
    [SVProgressHUD show];
    NSString *url_rul = request_square_joinEnduranceRanking;
    if([self.rankingStr isEqualToString:@"2"]) {
        url_rul = request_square_joinBatteryRanking;
    }
    [requestToolClass getNetworkWithUrl:url_rul andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.joinBtn.hidden = YES;
        if([self.rankingStr isEqualToString:@"2"]) {
            self.isjoinBTwo = YES;
        }else {
            self.isjoinBOne = YES;
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)oneTBtnMethod
{
    [UIView animateWithDuration:0.3 animations:^{
        self.topPlacV.x = 0;
    }];
    self.rankingStr = @"1";
    [self RequestListData];
    
    self.joinBtn.hidden = self.isjoinBOne;
}

- (void)oneTwoBtnMethod
{
    [UIView animateWithDuration:0.3 animations:^{
        self.topPlacV.x = 134;
    }];
    self.rankingStr = @"2";
    [self RequestListData];
    
    self.joinBtn.hidden = self.isjoinBTwo;
}

-(void)loadrefreshing {
    
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

    [self.datasMut removeAllObjects];
    [self.appTableView reloadData];
    
    NSString *url_url = [NSString stringWithFormat:@"%@?category=%@", request_square_getRankings, self.rankingStr];
    
    [requestToolClass getNetworkWithUrl:url_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        
        
        self.joinBtn.hidden = [minStr(info[@"joined"]) boolValue];
        if([self.rankingStr isEqualToString:@"2"]) {
            self.isjoinBTwo = [minStr(info[@"joined"]) boolValue];
        }else {
            self.isjoinBOne = [minStr(info[@"joined"]) boolValue];
        }
        
        NSArray *dataAr = info[@"rankingList"];
        for (NSDictionary *dic in dataAr) {
            MHrankingUserModel *model = [MHrankingUserModel mj_objectWithKeyValues:dic];
            [self.datasMut addObject:model];
        }
        
        if(self.datasMut.count>0) {
            self.noDataImgV.hidden = YES;
        }else {
            self.noDataImgV.hidden = NO;
        }
        [self.appTableView reloadData];
        
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
    if(section == 0) {
        return 1;
    }else {
        return self.datasMut.count>3 ? (self.datasMut.count-3):0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {

        MHrankingOneCell *cell = [MHrankingOneCell cellWithTabelView:tableView];
        [cell addDataToArr:self.datasMut];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MHrankingTwoCell *cell = [MHrankingTwoCell cellWithTabelView:tableView];
        [cell addDataToModel:self.datasMut[indexPath.row+3] row:indexPath.row];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        MHrankingUserModel *model = self.datasMut[indexPath.row+3];
        MHOthrMyController *vc = [[MHOthrMyController alloc] init];
        vc.otherId = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
