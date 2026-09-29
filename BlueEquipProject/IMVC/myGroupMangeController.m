//
//  myGroupMangeController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/21.
//

#import "myGroupMangeController.h"
#import "myContactSelectController.h"
#import "TUIGroupMemberCellData.h"
#import "muteGroupListCell.h"
#import "TUICommonModel.h"

@interface myGroupMangeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *selectTable;
@property (nonatomic, strong) UIButton *switchBBtn;
@property (nonatomic, strong) UIView *twoVVV;
@property (nonatomic, strong) NSMutableArray *dataMutArr;
@property (nonatomic, strong) NSMutableArray *idMutArr;
@end

@implementation myGroupMangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"chat_all9");
    
    self.dataMutArr = [NSMutableArray array];
    self.idMutArr = [NSMutableArray array];
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(12, NAVHEIGHT+14, _window_width-24, 142);
    [self.view addSubview:oneVV];
    
    NSArray *namAr = @[@"chat_al22", @"chat_al23"];
    for (int i=0; i<2; i++) {
        UILabel *namLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        namLab.frame = CGRectMake(12, 18+59*i, _window_width/2, 22);
        namLab.text = eLocalizedString(namAr[i]);
        [oneVV addSubview:namLab];
        
        if(i==0) {
            UIImageView *nexImgV = [[UIImageView alloc] init];
            nexImgV.image = [UIImage imageNamed:@"EventLiving_living_next"];
            [oneVV addSubview:nexImgV];
            [nexImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(oneVV.mas_right).offset(-12);
                make.centerY.equalTo(namLab.mas_centerY);
                make.width.height.offset(22);
            }];
            
            UIButton *manageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, oneVV.width, 58)];
            [manageBtn addTarget:self action:@selector(managerBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:manageBtn];
        }else {
            
            self.switchBBtn = [HistoryRecordModel createImgBtn];
            [self.switchBBtn setBackgroundImage:[UIImage imageNamed:@"meSetting_switch_normal"] forState:UIControlStateNormal];
            [self.switchBBtn setBackgroundImage:[UIImage imageNamed:@"meSetting_switch_select"] forState:UIControlStateSelected];
            [self.switchBBtn addTarget:self action:@selector(switchBBBMethod:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:self.switchBBtn];
            [self.switchBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(oneVV.mas_right).offset(-12);
                make.centerY.equalTo(namLab.mas_centerY);
                make.width.offset(42);
                make.height.offset(24);
            }];
            self.switchBBtn.selected = self.allMuted;
            
            UILabel *namLab2 = [HistoryRecordModel createLabLabTextColor:RGB(169, 169, 169) fontFloat:12 textAlignment:NSTextAlignmentLeft];
            namLab2.numberOfLines = 2;
            namLab2.text = eLocalizedString(@"chat_al24");
            [oneVV addSubview:namLab2];
            [namLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(oneVV.mas_left).offset(12);
                make.top.equalTo(oneVV.mas_bottom).offset(-35);
                make.right.equalTo(oneVV.mas_right).offset(-12);
            }];
        }
    }
    
    self.twoVVV = [HistoryRecordModel createViewUIUI];
    self.twoVVV.frame = CGRectMake(12, CGRectGetMaxY(oneVV.frame)+12, _window_width-24, _window_height-CGRectGetMaxY(oneVV.frame)-32);
    self.twoVVV.backgroundColor = GroupBackColor;
    [self.view addSubview:self.twoVVV];
    
    UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.twoVVV.width, 58)];
    twoBtn.backgroundColor = UIColor.whiteColor;
    twoBtn.layer.cornerRadius = 10;
    twoBtn.clipsToBounds = YES;
    [twoBtn addTarget:self action:@selector(twoAddBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.twoVVV addSubview:twoBtn];
    
    UIImageView *imgTT = [[UIImageView alloc] init];
    imgTT.image = [UIImage imageNamed:@"message_imgs5"];
    [twoBtn addSubview:imgTT];
    [imgTT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoBtn.mas_left).offset(12);
        make.centerY.equalTo(twoBtn.mas_centerY);
        make.width.height.offset(16);
    }];
    
    UILabel *addNamLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    addNamLab.text = eLocalizedString(@"chat_al25");
    addNamLab.numberOfLines = 0;
    [twoBtn addSubview:addNamLab];
    [addNamLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgTT.mas_right).offset(3);
        make.centerY.equalTo(twoBtn.mas_centerY);
        make.right.equalTo(twoBtn.mas_right).offset(-12);
    }];
    
    _selectTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.twoVVV.width, self.twoVVV.height-80) style:UITableViewStylePlain];
    [_selectTable registerClass:[muteGroupListCell class] forCellReuseIdentifier:@"muteGroupListCell"];
    _selectTable.delegate = self;
    _selectTable.dataSource = self;
    _selectTable.backgroundColor = GroupBackColor;
    _selectTable.separatorStyle = NO;
    self.selectTable.sectionHeaderTopPadding = 0;
    [self.twoVVV addSubview:_selectTable];
    
    if(self.allMuted) {
        self.twoVVV.hidden = YES;
    }
    [self requestUIUIUIMethod];
}

- (void)managerBtnMethod
{
    [[V2TIMManager sharedInstance] getGroupMemberList:self.chatId filter:V2TIM_GROUP_MEMBER_FILTER_COMMON nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {

        NSMutableArray *membersData = [NSMutableArray array];
        for (V2TIMGroupMemberFullInfo *fullInfo in memberList) {
            
            TUIGroupMemberCellData *data = [[TUIGroupMemberCellData alloc] init];
            data.identifier = fullInfo.userID;
            data.name = fullInfo.userID;
            data.avatarUrl = fullInfo.faceURL;
            if (fullInfo.nameCard.length > 0) {
                data.name = fullInfo.nameCard;
            } else if (fullInfo.friendRemark.length > 0) {
                data.name = fullInfo.friendRemark;
            } else if (fullInfo.nickName.length > 0) {
                data.name = fullInfo.nickName;
            }
            [membersData addObject:data];
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 5;
        vc.groupArr = membersData;
        [self.navigationController pushViewController:vc animated:YES];
    
    } fail:^(int code, NSString *msg) {
        [SVProgressHUD showInfoWithStatus:msg];
    }];
}

- (void)switchBBBMethod:(UIButton *)btn
{
    self.switchBBtn.selected = !self.switchBBtn.selected;
    
    [[V2TIMManager sharedInstance] getGroupsInfo:@[self.chatId] succ:^(NSArray<V2TIMGroupInfoResult *> *groupResultList) {
            
        if(groupResultList.count>0) {
            V2TIMGroupInfoResult *resultModel = groupResultList[0];
            V2TIMGroupInfo *info = resultModel.info;
            info.allMuted = self.switchBBtn.selected==YES ? YES:NO;
            info.groupID = self.chatId;
            [[V2TIMManager sharedInstance] setGroupInfo:info succ:^{
                
                self.twoVVV.hidden = self.switchBBtn.selected==YES ? YES:NO;
            } fail:^(int code, NSString *desc) {
                [SVProgressHUD showInfoWithStatus:desc];
            }];
        }
    } fail:^(int code, NSString *desc) {
        [SVProgressHUD showInfoWithStatus:desc];
    }];
}

- (void)twoAddBtnMethod
{
    [[V2TIMManager sharedInstance] getGroupMemberList:self.chatId filter:V2TIM_GROUP_MEMBER_FILTER_COMMON nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
        NSMutableArray *membersData = [NSMutableArray array];
        for (V2TIMGroupMemberFullInfo *fullInfo in memberList) {
            
            TUIGroupMemberCellData *data = [[TUIGroupMemberCellData alloc] init];
            data.identifier = fullInfo.userID;
            data.name = fullInfo.userID;
            data.avatarUrl = fullInfo.faceURL;
            if (fullInfo.nameCard.length > 0) {
                data.name = fullInfo.nameCard;
            } else if (fullInfo.friendRemark.length > 0) {
                data.name = fullInfo.friendRemark;
            } else if (fullInfo.nickName.length > 0) {
                data.name = fullInfo.nickName;
            }
            if(![self.idMutArr containsObject:fullInfo.userID]) {
                [membersData addObject:data];
            }
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 4;
        vc.groupArr = membersData;
        [self.navigationController pushViewController:vc animated:YES];
        vc.twoblock_ = ^(NSArray * _Nonnull arrM) {
            [self requestUIUIUIMethod];
        };
    } fail:^(int code, NSString *msg) {
        [SVProgressHUD showInfoWithStatus:msg];
    }];
}

- (void)requestUIUIUIMethod
{
//    [requestToolClass postNetworkWithUrl:request_group_forbidSendMsgList andParameter:@{@"groupid":self.chatId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        [self.dataMutArr removeAllObjects];
//        [self.idMutArr removeAllObjects];
//        NSArray *arrMM = info;
//        for (NSDictionary *dicM in arrMM) {
//            TUIUserModel *model = [[TUIUserModel alloc] init];
//            model.userId = minStr(dicM[@"id"]);
//            model.avatar = minStr(dicM[@"avatar"]);
//            model.name = minStr(dicM[@"user_nickname"]);
//            [self.dataMutArr addObject:model];
//            [self.idMutArr addObject:minStr(model.userId)];
//        }
//        [self.selectTable reloadData];
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"muteGroupListCell";
    muteGroupListCell *cell = (muteGroupListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[muteGroupListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row < self.dataMutArr.count) {
        TUIUserModel *model = self.dataMutArr[indexPath.row];
        [cell fillWithDataModel:model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *rowActions = [NSMutableArray array];
    TUIUserModel *model = self.dataMutArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    {
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:eLocalizedString(@"fg_ConfirmRes4") handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
//            [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"fg_ConfirmRes2") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"event_Sure") selectedHandle:^(NSInteger index) {
//                if (index == 1) {
//                    
//                    NSDictionary *muteDic = @{@"uid":minStr(model.userId), @"groupid":self.chatId, @"type":@"1"};
//                    [requestToolClass postNetworkWithUrl:request_group_forbidSendMsg andParameter:muteDic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                        
//                        [tableView beginUpdates];
//                        [self.dataMutArr removeObjectAtIndex:indexPath.row];
//                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
//                        [tableView endUpdates];
//                    } fail:^(NSString * _Nonnull msg) {
//                        
//                    }];
//                }
//            }];
        }];
        action.backgroundColor = RGB(242, 77, 76);
        [rowActions addObject:action];
    }
    return rowActions;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
