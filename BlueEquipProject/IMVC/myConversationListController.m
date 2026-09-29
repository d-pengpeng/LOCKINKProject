//
//  myConversationListController.m
//  DragonTeethLive
//
//  Created by Edwin on 2022/10/24.
//

#import "myConversationListController.h"
#import "myContactListController.h"
#import "mySearchAddViewController.h"
#import "mySearchFriendViewController.h"
#import "TUIContactViewDataProvider.h"
#import "JX_SelectMenuView.h"
#import "myContactSelectController.h"
#import "myGroupChatController.h"
#import "tabConserTopView.h"
//#import "DIYScanViewController.h"
//#import "StyleDIY.h"
#import "myIMSearchController.h"

#import "TUIConversationCell.h"
#import "TUIConversationListDataProvider.h"
#import "TUIDefine.h"
#import "TUICore.h"

#import "MHMsgIMOneController.h"
#import "MHDeviceListController.h"
#import "MHSystemMessageController.h"
#import "MHRankingPlaceView.h"

static NSString *kConversationCell_ReuseId = @"TConversationCell";

@interface myConversationListController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, TUIConversationListDataProviderDelegate, TUINotificationProtocol, JXSelectMenuViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, strong) TUIConversationListDataProvider *dataProvider;
@property (nonatomic, strong) UITextField *input_textF;
@property (nonatomic, strong) UILabel *msgitem;
@property (nonatomic, strong) UILabel *msgitem2;
@property (nonatomic, assign) NSInteger selDeleteRow;
@end

@implementation myConversationListController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    if ([TOKEN length]>1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageNotifUpload" object:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    @weakify(self)
    [RACObserve(self.dataProvider, dataList) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView reloadData];

        self.noDataImgV.hidden = self.dataProvider.dataList.count>0 ? YES:NO;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selDeleteRow = 10000;
    self.hideNavView = YES;
    if(TARBARHEIGHT > 50) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, _window_width, _window_height-NAVHEIGHT-14-110-20-TARBARHEIGHT)];
    }else {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, _window_width, _window_height-NAVHEIGHT-14-110-38-TARBARHEIGHT)];
    }
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0);
    [_tableView registerClass:[TUIConversationCell class] forCellReuseIdentifier:kConversationCell_ReuseId];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //如果不加这一行代码，依然可以实现点击反馈，但反馈会有轻微延迟，体验不好。
    _tableView.delaysContentTouches = YES;
    self.tableView.sectionHeaderTopPadding = 0;
    [self.view addSubview:_tableView];
    
    // 在viewDidLoad中添加长按手势
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
        initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.7; // 设置长按触发时间
    [self.tableView addGestureRecognizer:lpgr];

    
    UIView *topVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 110)];
    topVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:topVV];
    
    UIView *linVV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, _window_width, 10)];
    linVV.backgroundColor = RGB(243, 224, 251);
    [topVV addSubview:linVV];
    
    NSArray *thrNamAr = @[@"IMMsg_all1", @"IMMsg_all2", @"IMMsg_all3"];
    NSArray *thrImgAr = @[@"IM_searchImg2", @"IM_searchImg3", @"IM_searchImg4"];
    CGFloat w_thr = _window_width/3;
    for (int i=0; i<thrNamAr.count; i++) {
        UIView *topTHrV = [[UIView alloc] initWithFrame:CGRectMake(w_thr*i, 0, w_thr, 100)];
        topTHrV.backgroundColor = UIColor.clearColor;
        [topVV addSubview:topTHrV];
        
        UIImageView *thrImgV = [HistoryRecordModel createImgImgView];
        thrImgV.frame = CGRectMake((w_thr-60)/2, 0, 60, 60);
        thrImgV.image = [UIImage imageNamed:thrImgAr[i]];
        [topTHrV addSubview:thrImgV];
        
        UILabel *thrNNNN = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        thrNNNN.frame = CGRectMake(0, 60, w_thr, 32);
        thrNNNN.text = eLocalizedString(thrNamAr[i]);
        [topTHrV addSubview:thrNNNN];
        
        UIButton *btnsBBB = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, w_thr-20, 90)];
        btnsBBB.tag = 210+i;
        [btnsBBB addTarget:self action:@selector(btnThrBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [topTHrV addSubview:btnsBBB];
        
        if(i==1) {
            self.msgitem = [HistoryRecordModel createLabLabTextColor:UIColor.redColor fontFloat:8 textAlignment:NSTextAlignmentCenter];
            self.msgitem.backgroundColor = UIColor.redColor;
            self.msgitem.clipsToBounds = YES;
            self.msgitem.layer.cornerRadius = 5;
            [thrImgV addSubview:self.msgitem];
            [self.msgitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(thrImgV.mas_right);
                make.top.equalTo(thrImgV.mas_top);
                make.height.offset(10);
                make.width.mas_greaterThanOrEqualTo(10);
            }];
            self.msgitem.hidden = YES;
        }if(i==2) {
            self.msgitem2 = [HistoryRecordModel createLabLabTextColor:UIColor.redColor fontFloat:8 textAlignment:NSTextAlignmentCenter];
            self.msgitem2.backgroundColor = UIColor.redColor;
            self.msgitem2.clipsToBounds = YES;
            self.msgitem2.layer.cornerRadius = 5;
            [thrImgV addSubview:self.msgitem2];
            [self.msgitem2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(thrImgV.mas_right);
                make.top.equalTo(thrImgV.mas_top);
                make.height.offset(10);
                make.width.mas_greaterThanOrEqualTo(10);
            }];
            self.msgitem2.hidden = YES;
        }
    }
    
    if([LYUserDefault userDefault].msgRed_start > 0) {
        self.msgitem.hidden = NO;
        self.msgitem.text = @"6";
    }
    
    if([LYUserDefault userDefault].msgRed_start2 > 0) {
        self.msgitem2.hidden = NO;
        self.msgitem2.text = @"6";
    }

    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-TARBARHEIGHT-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    @weakify(self)
    [RACObserve(self.dataProvider, dataList) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView reloadData];
        self.noDataImgV.hidden = self.dataProvider.dataList.count>0 ? YES:NO;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadIMListNotifMethod) name:@"uploadIMListNotif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceMessageUnreadCountNotifMethod:) name:@"deviceMessageUnreadCountNotif" object:nil];
}

//MARK: 行 长按
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        
        if (indexPath) {
            // 在这里处理长按逻辑
            if (self.dataProvider.dataList.count > indexPath.row) {
                TUIConversationCellData *cellData = [self.dataProvider.dataList objectAtIndex:indexPath.row];
                
                if (!cellData.isOnTopKF) {
                    
                    self.selDeleteRow = indexPath.row;
                    [self.tableView reloadData];
                    
                    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.tabBarController.view addSubview:vc];
                    [vc addIMMsgDataToTag:1];
                    vc.block_ = ^(BOOL isBBB) {
                        
                        self.selDeleteRow = 10000;
                        if(isBBB) {
                            [self.tableView beginUpdates];
                            [self.dataProvider removeData:cellData];
                            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                            [self.tableView endUpdates];
                        }else {
                            [self.tableView reloadData];
                        }
                    };
                }
            }
        }
    }
}




- (void)deviceMessageUnreadCountNotifMethod:(NSNotification *)notifff
{
    NSDictionary *dicMM = notifff.userInfo;
    NSString *numStr = minStr(dicMM[@"redOne"]);
    NSString *numStr2 = minStr(dicMM[@"redTwo"]);
//    NSString *numStr = minStr(notifff.object);
    if ([numStr intValue] > 0) {
        
        self.msgitem.hidden = NO;
        self.msgitem.text = numStr;
    }else if ([numStr2 intValue] > 0) {
        
        self.msgitem2.hidden = NO;
        self.msgitem2.text = numStr2;
    }else{
        self.msgitem.hidden = YES;
        [LYUserDefault saveMsgNoRedStart:0];
    }
}

- (void)btnThrBtnMethod:(UIButton *)btn
{
    if(btn.tag == 210) {
        
        MHMsgIMOneController *vc = [[MHMsgIMOneController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag == 211) {
        
        MHDeviceListController *vc = [[MHDeviceListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(int numLL) {
          
            if (numLL > 0) {
                self.msgitem.hidden = NO;
                self.msgitem.text = @"6";
            }else{
                self.msgitem.hidden = YES;
            }
        };
    }else {
        MHSystemMessageController *vc = [[MHSystemMessageController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(int numLL) {
          
            if (numLL > 0) {
                self.msgitem2.hidden = NO;
                self.msgitem2.text = @"6";
            }else{
                self.msgitem2.hidden = YES;
            }
        };
    }
}

- (void)uploadIMListNotifMethod
{
    [_dataProvider loadConversationTwo];
    @weakify(self)
    [RACObserve(self.dataProvider, dataList) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView reloadData];
        self.noDataImgV.hidden = self.dataProvider.dataList.count>0 ? YES:NO;
    }];
    if (![LYUserDefault userDefault].isLoginBoo) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataProvider.dataList = @[];
            [self.tableView reloadData];
        });
    }
}

- (void)conversationListBotmClicke
{
    if ([TOKEN length]>1) {
        myIMSearchController *vc = [[myIMSearchController alloc] init];
        vc.isC2CBoo = YES; //发现好友
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)dealloc {
    [TUICore unRegisterEventByObject:self];
}

- (TUIConversationListDataProvider *)dataProvider
{
    if (!_dataProvider) {
        _dataProvider = [TUIConversationListDataProvider new];
        _dataProvider.delegate = self;
        [_dataProvider loadConversation];
    }
    return _dataProvider;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataProvider.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataProvider.dataList[indexPath.row] heightOfWidth:Screen_Width];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)didSelectConversation:(TUIConversationCell *)cell
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell.convData.userID.length > 0) {
        
        [[FloatingWindowModel shareInstance] switchChatDetailControlNick:cell.convData.title hostId:cell.convData.userID];
    }else if(cell.convData.groupID.length > 0) {
        
        [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:cell.convData.title hostId:cell.convData.groupID];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TUIConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:kConversationCell_ReuseId forIndexPath:indexPath];
    TUIConversationCellData *data = [self.dataProvider.dataList objectAtIndex:indexPath.row];
    // cselector 由使用 data 数据的 cell 点击触发
    if (!data.cselector) {
        data.cselector = @selector(didSelectConversation:);
    }
    [cell fillWithData:data];

    //可以在此处修改，也可以在对应cell的初始化中进行修改。用户可以灵活的根据自己的使用需求进行设置。
    cell.changeColorWhenTouched = YES;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.selDeleteRow==indexPath.row) {
        cell.contentView.backgroundColor = RGBA(0, 0, 0, 0.2);
    }else {
        cell.contentView.backgroundColor = UIColor.clearColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
           [cell setSeparatorInset:UIEdgeInsetsMake(0, 75, 0, 0)];
        if (indexPath.row == (self.dataProvider.dataList.count - 1)) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }

    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.dataProvider loadConversation];
}


@end
