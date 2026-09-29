//
//  MHRoleThrBXGLController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/11.
//

#import "MHRoleThrBXGLController.h"
#import "MHRoleTwoYSBXCell.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHBoXingModel.h"
#import "MHLimitsAuthorityView.h"

@interface MHRoleThrBXGLController ()<UITableViewDelegate, UITableViewDataSource, MHRoleTwoYSBXCellDelegate>
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
@property (nonatomic, assign) BOOL time_Boo;
@property (nonatomic, assign) BOOL xxx_Boo;
@property (nonatomic, assign) BOOL xxx_Boo2;
@property (nonatomic, assign) BOOL link_Boo;
@property (nonatomic, strong) NSArray *cont_bxArr;
@property (nonatomic, assign) int bf_num;
@property (nonatomic, assign) int bf_num22;
@property (nonatomic, assign) BOOL controling_boo; //是否是 被控制设备
@property (nonatomic, assign) BOOL controling_boo2;
@end

@implementation MHRoleThrBXGLController

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
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _oneVV.height-58) style:UITableViewStylePlain];
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
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 30, _window_width, _oneVV.height-30)];
    [self.oneVV addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadEnterForwodMethodTag:) name:kNeedEnterForegroundNote object:nil];
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq && [self.devicTyp isEqualToString:kCharactName7]) {
        self.controling_boo = YES;
    }
    
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
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    //要把播放关掉
    if (self.block_) {
        self.block_(3);
    }
}

- (void)stopMethodUIUIUI
{
    if (messsageTimerTwo) {
        [messsageTimerTwo invalidate];
        messsageTimerTwo = nil;
    }
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
    [requestToolClass postNetworkWithUrl:request_waveform_ab_pageWaveform andParameter:@{@"deviceId":self.devicId, @"page":minIntStr(self.pageN)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        NSArray *arr_list = info[@"records"];
        
        if (self.pageN == 1) {
            [self.oneMutArr removeAllObjects];
            if (self.time_Boo) {
                [self stopMethodUIUIUI];
                [self sendSocketThreeDataMethodstop];
            }
            self.bf_num = -1;
        }
        for (NSDictionary *dcMMM in arr_list) {
            MHBoXingModel *model = [MHBoXingModel mj_objectWithKeyValues:dcMMM];
            [self.oneMutArr addObject:model];
        }
        
        int boo_boo = -1;
        if([self.devicTyp isEqualToString:kCharactName7] && !self.isBMMM && self.controling_boo && !self.time_Boo2) {
            
            if ([FloatingWindowModel shareInstance].boxing_play>0) {
                
                if (!self.controling_boo2) {
                    
                    self.controling_boo2 = YES;
                    
                    if (self.oneMutArr.count > [FloatingWindowModel shareInstance].boxing_play-1) {
                        MHBoXingModel *model = self.oneMutArr[[FloatingWindowModel shareInstance].boxing_play-1];
                        model.isPlayBoo = YES;
                        
                        boo_boo = [FloatingWindowModel shareInstance].boxing_play-1;
                    }
                }
                
            }
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
        
        if (boo_boo>=0) {
            
            [self roleTwoYSBXPlayBooRow:boo_boo];
        }
        
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
    MHRoleTwoYSBXCell_three *cell = [MHRoleTwoYSBXCell_three cellWithTabelView:tableView];
    cell.model = self.oneMutArr[indexPath.row];
    cell.indPPP = indexPath;
    [cell addModelToDataModelUser];
    cell.delegate_ = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

//MARK: 播放
- (void)roleTwoYSBXCelldelegateDeletePlayBooRow:(NSIndexPath *)indMMP
{
    if([self.devicTyp isEqualToString:kCharactName12] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    if([self.devicTyp isEqualToString:kCharactName15] && self.isBMMM) {
        MHLimitsAuthorityView *vc = [[MHLimitsAuthorityView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:vc];
        return;
    }
    
    MHBoXingModel *model = self.oneMutArr[indMMP.row];
    model.isPlayBoo = !model.isPlayBoo;
    
    for (MHBoXingModel *subMMM in self.oneMutArr) {
        if (subMMM.id != model.id) {
            subMMM.isPlayBoo = NO;
        }
    }
    [self.appTableView reloadData];
    
    self.time_Boo = model.isPlayBoo;
    if (model.isPlayBoo) {
        
        NSArray *bx_arr = [minStr(model.content) componentsSeparatedByString:@"-"];
        
        if (bx_arr.count > 5) {
            
            NSMutableArray *lis_arM = [NSMutableArray array];
            for (NSString *str_sub in bx_arr) {
                
                NSData *jsonData = [str_sub dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                if(jsonData) {
                    NSDictionary *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                    if (!error) {
                        
                        [lis_arM addObject:dicSub];
                    }
                }
                
            }
            if (lis_arM.count>0) {
                
                
                self.cont_bxArr = lis_arM;
                
                NSDictionary *dicSubD = self.cont_bxArr[0];
                
                if (self.bf_num22 == indMMP.row) {
                    
                    if (self.cont_bxArr.count <= self.bf_num) {
                        self.bf_num = -1;
                    }else {
                        if (self.bf_num>=0 && self.cont_bxArr.count>self.bf_num) {
                            dicSubD = self.cont_bxArr[self.bf_num];
                        }
                    }
                    
                }else {
                    self.bf_num22 = (int)indMMP.row;
                    self.bf_num = -1;
                }
                
                if (!messsageTimerTwo) {
                    messsageTimerTwo = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
                }
                
                BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                
                NSString *str_str = [NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"shakeIntensity"]) floatValue]];
                
                if(isEEEqq) {
                    
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                }else {
                    if(self.isConnDevic) {
                        
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                    }
                }
                
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].boxing_play = (int)indMMP.row+1;
                }
                
            }else {
                
                model.isPlayBoo = NO;
                self.time_Boo = NO;
                [self.appTableView reloadData];
                
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].boxing_play = 0;
                }
            }
        }else {
            NSData *jsonData = [minStr(model.content) dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSArray *lis_arM = @[];
            if(jsonData) {
                NSArray *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                if (!error) {
                    
                    lis_arM = dicSub;
                }
            }
            
            if (lis_arM.count>0) {
                
                
                self.cont_bxArr = lis_arM;
                
                NSDictionary *dicSubD = self.cont_bxArr[0];
                
                if (self.bf_num22 == indMMP.row) {
                    
                    if (self.cont_bxArr.count <= self.bf_num) {
                        self.bf_num = -1;
                    }else {
                        if (self.bf_num>=0 && self.cont_bxArr.count>self.bf_num) {
                            dicSubD = self.cont_bxArr[self.bf_num];
                        }
                    }
                    
                }else {
                    self.bf_num22 = (int)indMMP.row;
                    self.bf_num = -1;
                }
                
                if (!messsageTimerTwo) {
                    messsageTimerTwo = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
                }
                
                BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                
                NSString *str_str = [NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"shakeIntensity"]) floatValue]];
                if(isEEEqq) {
                    
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                }else {
                    if(self.isConnDevic) {
                        
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                    }
                }
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].boxing_play = (int)indMMP.row+1;
                }
            }else {
                
                model.isPlayBoo = NO;
                self.time_Boo = NO;
                [self.appTableView reloadData];
                
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].boxing_play = 0;
                }
            }
        }

    }else {
        
        if (self.controling_boo) {
            [FloatingWindowModel shareInstance].boxing_play = 0;
        }
        [self stopMethodUIUIUI];
        [self sendSocketThreeDataMethodstop];
    }
    
}

- (void)roleTwoYSBXCelldelegateDeleteRow:(NSIndexPath *)indMMP
{
    MHBoXingModel *model = self.oneMutArr[indMMP.row];
    MHRoleSetCoreLocatView *vcLocat = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.tabBarController.view addSubview:vcLocat];
    [vcLocat addTwoNewTextfUIUIMethod:3];
    vcLocat.block_ = ^(NSArray * _Nonnull arrList) {
      
        if (arrList.count > 0) {
            
            [requestToolClass postNetworkWithUrl:request_waveform_ab_batchDelete andParameter:@{@"deviceId":self.devicId, @"idList":minIntStr(model.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                if (model.isPlayBoo) {
                    
                    model.isPlayBoo = NO;
                    [self stopMethodUIUIUI];
    
                    [self sendSocketThreeDataMethodstop];
                }
                
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
            
            [self sendSocketThreeDataMethodstop];
        }
    }else {
        if (!self.time_Boo2) {
                
            if (self.time_Boo) {
                
                self.xxx_Boo = NO;
                
                if (self.cont_bxArr.count > 0) {
                    self.bf_num = self.bf_num+1;
                    if (self.cont_bxArr.count > self.bf_num) {
                        
                        NSDictionary *dicSubD = self.cont_bxArr[self.bf_num];
                        
                        BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                        
                        NSString *str_str = [NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"shakeIntensity"]) floatValue]];
                        if(isEEEqq) {
                            
                            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                        }else {
                            if(self.isConnDevic) {
                                
                                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                            }
                        }
                        
                    }else {
                        
                        [self stopMethodUIUIUI];
                        MHBoXingModel *model = self.oneMutArr[self.bf_num22];
                        model.isPlayBoo = NO;
                        self.time_Boo = NO;
                        [self.appTableView reloadData];
                        
                        [self sendSocketThreeDataMethodstop];
                        
                        self.bf_num = -1;
                    }

                }else {
                    
                    [self stopMethodUIUIUI];
                    MHBoXingModel *model = self.oneMutArr[self.bf_num22];
                    model.isPlayBoo = NO;
                    self.time_Boo = NO;
                    [self.appTableView reloadData];
                    
                    [self sendSocketThreeDataMethodstop];
                    
                    self.bf_num = -1;
                }
  
            }else {
                
                if (!self.xxx_Boo) {
                    self.xxx_Boo = YES;
                    [self sendSocketThreeDataMethodstop];
                }
            }

        }else {
            if (!self.xxx_Boo) {
                self.xxx_Boo = YES;
                [self sendSocketThreeDataMethodstop];
            }
        }
    }
}

- (BOOL)getBooMEthod
{
    return self.time_Boo;
}

- (void)uploadUIUIUI
{
    if (self.time_Boo2&&self.time_Boo2_old) {
        [self sendSocketThreeDataMethodstop];
    }
    
}

- (void)sendSocketThreeDataMethodstop
{
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"1", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0", @"frequency":@"0"}];
    }else {
        if(self.isConnDevic) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"false", @"spinDirection":@"1", @"spinIntensity":@"0", @"shakeIntensity":@"0", @"inElectricMode":@"false", @"voltage":@"0", @"frequency":@"0"}];
        }
    }
    
}


/***
 设备 7  启动设备播放
 */
- (void)roleTwoYSBXPlayBooRow:(int)indMMP
{
    
    MHBoXingModel *model = self.oneMutArr[indMMP];
    
    self.time_Boo = model.isPlayBoo;
    if (model.isPlayBoo) {
        
        NSArray *bx_arr = [minStr(model.content) componentsSeparatedByString:@"-"];
        
        if (bx_arr.count > 5) {
            
            NSMutableArray *lis_arM = [NSMutableArray array];
            for (NSString *str_sub in bx_arr) {
                
                NSData *jsonData = [str_sub dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                if(jsonData) {
                    NSDictionary *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                    if (!error) {
                        
                        [lis_arM addObject:dicSub];
                    }
                }
                
            }
            if (lis_arM.count>0) {
                
                
                self.cont_bxArr = lis_arM;
                
                NSDictionary *dicSubD = self.cont_bxArr[0];
                
                if (self.bf_num22 == indMMP) {
                    
                    if (self.cont_bxArr.count <= self.bf_num) {
                        self.bf_num = -1;
                    }else {
                        if (self.bf_num>=0 && self.cont_bxArr.count>self.bf_num) {
                            dicSubD = self.cont_bxArr[self.bf_num];
                        }
                    }
                    
                }else {
                    self.bf_num22 = indMMP;
                    self.bf_num = -1;
                }
                
                if (!messsageTimerTwo) {
                    messsageTimerTwo = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
                }
                
                BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                
                NSString *str_str = [NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"shakeIntensity"]) floatValue]];
                
                if(isEEEqq) {
                    
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                }else {
                    if(self.isConnDevic) {
                        
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                    }
                }
                
            }else {
                
                model.isPlayBoo = NO;
                self.time_Boo = NO;
                [self.appTableView reloadData];
                
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].boxing_play = 0;
                }
            }
        }else {
            NSData *jsonData = [minStr(model.content) dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSArray *lis_arM = @[];
            if(jsonData) {
                NSArray *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                if (!error) {
                    
                    lis_arM = dicSub;
                }
            }
            
            if (lis_arM.count>0) {
  
                self.cont_bxArr = lis_arM;
                
                NSDictionary *dicSubD = self.cont_bxArr[0];
                
                if (self.bf_num22 == indMMP) {
                    
                    if (self.cont_bxArr.count <= self.bf_num) {
                        self.bf_num = -1;
                    }else {
                        if (self.bf_num>=0 && self.cont_bxArr.count>self.bf_num) {
                            dicSubD = self.cont_bxArr[self.bf_num];
                        }
                    }
                    
                }else {
                    self.bf_num22 = indMMP;
                    self.bf_num = -1;
                }
                
                if (!messsageTimerTwo) {
                    messsageTimerTwo = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiMethodUIUI) userInfo:nil repeats:YES];
                }
                
                BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                
                NSString *str_str = [NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"shakeIntensity"]) floatValue]];
                if(isEEEqq) {
                    
                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                }else {
                    if(self.isConnDevic) {
                        
                        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"AIRPLANE-BOTTLE-MANUAL-MODE-UPLOAD", @"deviceId":self.devicId, @"inSpinMode":@"true", @"spinDirection":@"1", @"spinIntensity":str_str, @"shakeIntensity":str_str, @"inElectricMode":@"true", @"voltage":[NSString stringWithFormat:@"%.f", [minStr(dicSubD[@"voltage"]) floatValue]], @"frequency":minStr(dicSubD[@"electricFrequency"])}];
                    }
                }
              
            }else {
                
                model.isPlayBoo = NO;
                self.time_Boo = NO;
                [self.appTableView reloadData];
                
                if (self.controling_boo) {
                    [FloatingWindowModel shareInstance].boxing_play = 0;
                }
            }
        }

    }else {
        
        if (self.controling_boo) {
            [FloatingWindowModel shareInstance].boxing_play = 0;
        }
        [self stopMethodUIUIUI];
        [self sendSocketThreeDataMethodstop];
    }
    
}


@end
