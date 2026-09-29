//
//  MHRoleTwoYSBXController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import "MHRoleTwoYSBXController.h"
#import "MHRoleTwoYSBXCell.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHRoleTwoSDDJStartView.h"

@interface MHRoleTwoYSBXController ()<UITableViewDelegate, UITableViewDataSource, MHRoleTwoYSBXCellDelegate>
{
    NSTimer *messsageTimerTwo;
}
@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *oneMutArr;
@property (nonatomic, assign) int pageN;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, strong) UIButton *addBBBtb;
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) MHRoleTwoSDDJStartView *MHRoleTwoSDDJStartV;
@property (nonatomic, assign) BOOL time_Boo;
@property (nonatomic, assign) BOOL xxx_Boo;
@property (nonatomic, assign) BOOL xxx_Boo2;
@end

@implementation MHRoleTwoYSBXController

- (NSMutableArray *)oneMutArr
{
    if (!_oneMutArr) {
        _oneMutArr = [NSMutableArray array];
    }
    return _oneMutArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    //预设波形
    
    _oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    _oneVV.layer.cornerRadius = 0;
    _oneVV.clipsToBounds = YES;
    _oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_oneVV];
    
    UIView *plaVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    plaVV.layer.cornerRadius = 0;
    plaVV.clipsToBounds = YES;
    plaVV.backgroundColor = RGBA(130, 54, 231, 0.76);
    [self.oneVV addSubview:plaVV];
    
    self.typeStr = @"1";
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _oneVV.height) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 70;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHRoleTwoYSBXCell class] forCellReuseIdentifier:@"MHRoleTwoYSBXCell"];
    [self.oneVV addSubview:_appTableView];
    
    self.addBBBtb = [HistoryRecordModel createImgBtn];
    self.addBBBtb.frame = CGRectMake(10, _oneVV.height-58, 48, 48);
    [self.addBBBtb setImage:[UIImage imageNamed:@"add_bxImgs1"] forState:UIControlStateNormal];
    [self.addBBBtb addTarget:self action:@selector(adddBtnmethodUIUIUI) forControlEvents:UIControlEventTouchUpInside];
    [self.oneVV addSubview:self.addBBBtb];
    self.addBBBtb.hidden = YES;
    
    
    _appTableView.frame = CGRectMake(0, 0, _window_width, _oneVV.height-58);
    self.typeStr = @"2";
    self.addBBBtb.hidden = NO;
    
//    NSArray *nam_Arr = @[@"two_nams23", @"two_nams24"];
//    for (int i=0; i<nam_Arr.count; i++) {
//        UIButton *tit_Btn = [HistoryRecordModel createImgBtn];
//        tit_Btn.frame = CGRectMake(i*_window_width/2, 0, _window_width/2, 30);
//        tit_Btn.tag = 2000+i;
//        tit_Btn.layer.cornerRadius = 0;
//        tit_Btn.backgroundColor = UIColor.whiteColor;
//        [tit_Btn setTitle:eLocalizedString(nam_Arr[i]) forState:UIControlStateNormal];
//        [tit_Btn setTitleColor:RGB(43, 12, 56) forState:UIControlStateNormal];
//        [tit_Btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
//        tit_Btn.titleLabel.font = SYS_Font(16);
//        [tit_Btn addTarget:self action:@selector(titBtnMethodUIUIUTag:) forControlEvents:UIControlEventTouchUpInside];
//        [self.oneVV addSubview:tit_Btn];
//        if (i==0) {
//            tit_Btn.selected = YES;
//            tit_Btn.backgroundColor = normalColors;
//        }
//    }
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 30, _window_width, _oneVV.height-30)];
    [self.oneVV addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    
    self.MHRoleTwoSDDJStartV = [[MHRoleTwoSDDJStartView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.oneVV.height)];
    [self.view addSubview:self.MHRoleTwoSDDJStartV];
    WEAKSELF
    self.MHRoleTwoSDDJStartV.block_ = ^{

        weakSelf.oneVV.hidden = NO;
        weakSelf.MHRoleTwoSDDJStartV.hidden = YES;
        weakSelf.xxx_Boo = NO;
        [weakSelf stopMethodUIUIUI];
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":weakSelf.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
        
    };

    self.MHRoleTwoSDDJStartV.hidden = YES;
    
    
    
    [self loadrefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadEnterForwodMethodTag:) name:kNeedEnterForegroundNote object:nil];
}

- (void)uploadEnterForwodMethodTag:(NSNotification *)notifff
{
    NSString *sss_msg = notifff.object;
    if ([minStr(sss_msg) intValue] == 1) {
        self.xxx_Boo2 = NO;
    }else {
        self.xxx_Boo = NO;
        self.xxx_Boo2 = YES;
    }
}

//MARK: 添加
- (void)adddBtnmethodUIUIUI
{
    if (self.block_) {
        self.block_(2);
    }
}

- (void)stopMethodUIUIUI
{
    [messsageTimerTwo invalidate];
    messsageTimerTwo = nil;

}

- (void)titBtnMethodUIUIUTag:(UIButton *)btn
{
    UIButton *tit_Btn = [self.view viewWithTag:2000];
    UIButton *tit_Btn2 = [self.view viewWithTag:2001];
    
    if (btn.tag == 2000) {
        tit_Btn.selected = YES;
        tit_Btn2.selected = NO;
        tit_Btn2.backgroundColor = UIColor.whiteColor;
        tit_Btn.backgroundColor = normalColors;
        
        _appTableView.frame = CGRectMake(0, 30, _window_width, _oneVV.height-30);
        self.typeStr = @"1";
        self.addBBBtb.hidden = YES;
    }else {
        tit_Btn.selected = NO;
        tit_Btn2.selected = YES;
        tit_Btn2.backgroundColor = normalColors;
        tit_Btn.backgroundColor = UIColor.whiteColor;
        
        _appTableView.frame = CGRectMake(0, 30, _window_width, _oneVV.height-30-68);
        self.typeStr = @"2";
        self.addBBBtb.hidden = NO;
    }
    
    [self.appTableView.mj_header beginRefreshing];
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
    [requestToolClass postNetworkWithUrl:request_waveform_pageWaveform andParameter:@{@"type":self.typeStr, @"page":minIntStr(self.pageN)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        NSArray *arr_list = info[@"records"];
        
        if (self.pageN == 1) {
            [self.oneMutArr removeAllObjects];
        }
        for (NSDictionary *dcMMM in arr_list) {
            [self.oneMutArr addObject:dcMMM];
        }
        
        self.noDataImgV.hidden = self.oneMutArr.count>0 ? YES:NO;
        if (self.oneMutArr.count>0) {
            [self.appTableView.mj_footer setHidden:NO];
        }else {
            [self.appTableView.mj_footer setHidden:YES];
        }
        if (arr_list.count<[minStr(info[@"size"]) intValue]) {
            [self.appTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.appTableView reloadData];
        
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        self.noDataImgV.hidden = self.oneMutArr.count>0 ? YES:NO;
        [self.appTableView reloadData];
        
        if (self.oneMutArr.count>0) {
            [self.appTableView.mj_footer setHidden:NO];
        }else {
            [self.appTableView.mj_footer setHidden:YES];
        }
    }];
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.oneMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHRoleTwoYSBXCell *cell = [MHRoleTwoYSBXCell cellWithTabelView:tableView];
    cell.dicMM = self.oneMutArr[indexPath.row];
    cell.indPPP = indexPath;
    if ([self.typeStr isEqualToString:@"2"]) {
        [cell addModelToDataModelUser];
        cell.delegate_ = self;
    }else {
        [cell addModelToDataModel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [FloatingWindowModel shareInstance].bxMutArr = self.oneMutArr;
    [FloatingWindowModel shareInstance].bx_row = indexPath.row;
    
//    if (self.block_) {
//        self.block_(1);
//    }
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if (isEEEqq) {
        self.oneVV.hidden = YES;
        self.MHRoleTwoSDDJStartV.hidden = NO;
        [self.MHRoleTwoSDDJStartV addBXUploadMethod];
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"true", @"frequency":@"1", @"voltage":minIntStr([self.MHRoleTwoSDDJStartV getPlayFFFHHH])}];
        if (messsageTimerTwo == nil) {
            messsageTimerTwo = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
        }

    }else {
        if (self.isConnDevic) {
            self.oneVV.hidden = YES;
            self.MHRoleTwoSDDJStartV.hidden = NO;
            [self.MHRoleTwoSDDJStartV addBXUploadMethod];
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"true", @"frequency":@"1", @"voltage":minIntStr([self.MHRoleTwoSDDJStartV getPlayFFFHHH])}];
            if (messsageTimerTwo == nil) {
                messsageTimerTwo = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
            }
        
        }else {
            if (self.twoBBlock_) {
                self.twoBBlock_(1);
            }
        }
    }
    
}

- (void)roleTwoYSBXCelldelegateDeleteRow:(NSIndexPath *)indMMP
{
    NSDictionary *dicWW = self.oneMutArr[indMMP.row];
    
    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.tabBarController.view addSubview:vcLocat];
    [vcLocat addTwoNewTextfUIUIMethod:3];
    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
      
        if (arrList.count > 0) {
            
            [requestToolClass postNetworkWithUrl:request_waveform_batchDelete andParameter:@{@"idList":minStr(dicWW[@"id"])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                [self.oneMutArr removeObjectAtIndex:indMMP.row];
                [self.appTableView reloadData];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
    };
}

//MARK: 定时 取值
- (void)daojishiMethodUIUI
{
    if (self.xxx_Boo2) {
        if (!self.xxx_Boo) {
            self.xxx_Boo = YES;
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
        }
    }else {
        if (!self.time_Boo2) {
            BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
            
            if (self.MHRoleTwoSDDJStartV.hidden == NO) {
                
                if ((self.MHRoleTwoSDDJStartV.play_Btn.selected == YES) && ([self.MHRoleTwoSDDJStartV getPlayFFFHHH]>=0)) {
                    
                    self.xxx_Boo = NO;
                    
                    if(isEEEqq) {
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"true", @"frequency":@"1", @"voltage":minIntStr([self.MHRoleTwoSDDJStartV getPlayFFFHHH])}];
                    }else {
                        if(self.isConnDevic) {
                            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"true", @"frequency":@"1", @"voltage":minIntStr([self.MHRoleTwoSDDJStartV getPlayFFFHHH])}];
                        }
                    }
                }else {
                    
                    if (!self.xxx_Boo) {
                        self.xxx_Boo = YES;
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
                    }
                }
            }else {
                if (!self.xxx_Boo) {
                    self.xxx_Boo = YES;
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
                }
            }
        }else {
            if (!self.xxx_Boo) {
                self.xxx_Boo = YES;
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"REALTIME-SHOCK", @"deviceId":self.devicId, @"openLongShock":@"false", @"frequency":@"1", @"voltage":@"0"}];
            }
        }
    }
}
    
- (void)uploadUIUIUI
{
    
}

@end
