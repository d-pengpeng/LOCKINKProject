//
//  myContactSelectController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/12.
//

#import "myContactSelectController.h"
#import "TUIContactSelectController.h"
#import "TUIGroupConversationListController.h"
#import "myGroupCreateEditerController.h"

@interface myContactSelectController ()

@property (nonatomic, strong) TUIContactSelectController *TUIContactSelectC;
@property (nonatomic, assign) BOOL isRequestBoo;
@end

@implementation myContactSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleName.text = eLocalizedString(@"contact_friend1");
    if(self.isGroupBoo) {
        switch (self.typeGroup) {
            case 1:
            {
                self.titleName.text = eLocalizedString(@"chat_al26");
            }
                break;
            case 2:
            {
                self.titleName.text = eLocalizedString(@"chat_al27");
            }
                break;
            case 3:
            {
                self.titleName.text = eLocalizedString(@"chat_al28");
            }
                break;
            case 4:
            {
                self.titleName.text = eLocalizedString(@"chat_al29");
            }
                break;
            case 5:
            {
                self.titleName.text = eLocalizedString(@"chat_al22");
            }
                break;
                
            default:
                break;
        }
    }
    
    self.TUIContactSelectC = [[TUIContactSelectController alloc] init];
    self.TUIContactSelectC.isGroupBoo = self.isGroupBoo;
    if(self.isGroupBoo) {
        self.TUIContactSelectC.typeGroup = self.typeGroup;
        self.TUIContactSelectC.groupArr = self.groupArr;
    }
    [self addChildViewController:self.TUIContactSelectC];
    self.TUIContactSelectC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    self.TUIContactSelectC.view.backgroundColor = GroupBackColor;
    [self.view addSubview:self.TUIContactSelectC.view];
    [self.TUIContactSelectC uploadUIUIUIUIMehtod];
    WEAKSELF
    self.TUIContactSelectC.finishBlock = ^(NSArray<TUICommonContactSelectCellData *> * _Nonnull selectArray) {
      
        [weakSelf addGrouChatMethod:selectArray];
    };
    [self.view addSubview:self.navView];
}

- (void)addGrouChatMethod:(NSArray<TUICommonContactSelectCellData *> *)arrMM
{
    if(arrMM.count <= 0) {
        return;
    }
    NSMutableArray *members = [NSMutableArray array];
    //遍历contacts，初始化群组成员信息、群组名称信息
    
    if(self.isGroupBoo) {
        
        if(self.typeGroup == 1) {
            NSString *grouIdsss = @"";
            for (TUICommonContactSelectCellData *item in arrMM) {
                [members addObject:item.identifier];
                grouIdsss = grouIdsss.length>0 ? [NSString stringWithFormat:@"%@,%@", grouIdsss, item.identifier]:minStr(item.identifier);
            }
            if(members.count<=0) {
                return;
            }
//            if(self.isRequestBoo) {
//                return;
//            }
//            self.isRequestBoo = YES;
//            [requestToolClass postNetworkWithUrl:request_group_addGroupUser andParameter:@{@"groupid":self.groupId, @"uid":grouIdsss} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                if(self.block_) {
//                    self.block_(@"", @"");
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//                self.isRequestBoo = NO;
//            } fail:^(NSString * _Nonnull msg) {
//                self.isRequestBoo = NO;
//            }];
//
//            [[V2TIMManager sharedInstance] inviteUserToGroup:self.groupId userList:members succ:^(NSArray<V2TIMGroupMemberOperationResult *> *resultList) {
//
//                if(self.block_) {
//                    self.block_(@"", @"");
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//            } fail:^(int code, NSString *desc) {
//                [SVProgressHUD showInfoWithStatus:desc];
//            }];
        }else if(self.typeGroup == 2) {
            for (TUICommonContactSelectCellData *item in arrMM) {
                [members addObject:item.identifier];
            }
            if(members.count<=0) {
                return;
            }
            [[V2TIMManager sharedInstance] kickGroupMember:self.groupId memberList:members reason:@"无" succ:^(NSArray<V2TIMGroupMemberOperationResult *> *resultList) {
                
                if(self.block_) {
                    self.block_(@"", @"");
                }
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(int code, NSString *desc) {
                [SVProgressHUD showInfoWithStatus:desc];
            }];
        }else if(self.typeGroup == 3) {
            for (TUICommonContactSelectCellData *item in arrMM) {
                [members addObject:item.identifier];
            }
            if(members.count<=0) {
                return;
            }
            [[V2TIMManager sharedInstance] transferGroupOwner:self.groupId member:minStr(members[0]) succ:^{
                
                if(self.block_) {
                    self.block_(@"", @"");
                }
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(int code, NSString *desc) {
                [SVProgressHUD showInfoWithStatus:desc];
            }];
        }else if(self.typeGroup == 4) {
            
            if(arrMM.count<=0) {
                return;
            }
//            TUICommonContactSelectCellData *itemML = arrMM[0];
//            NSDictionary *muteDic = @{@"uid":minStr(itemML.identifier), @"groupid":self.groupId, @"type":@"0"};
//            [requestToolClass postNetworkWithUrl:request_group_forbidSendMsg andParameter:muteDic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                if(self.twoblock_) {
//                    self.twoblock_(arrMM);
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//            } fail:^(NSString * _Nonnull msg) {
//
//            }];
            
//            [[V2TIMManager sharedInstance] muteGroupMember:self.groupId member:itemML.identifier muteTime:300 succ:^{
//
//                if(self.twoblock_) {
//                    self.twoblock_(arrMM);
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//            } fail:^(int code, NSString *desc) {
//                [SVProgressHUD showInfoWithStatus:desc];
//            }];
        }else if(self.typeGroup == 5) {
            
            if(arrMM.count<=0) {
                return;
            }
            TUICommonContactSelectCellData *itemML = arrMM[0];
            [[V2TIMManager sharedInstance] setGroupMemberRole:self.groupId member:itemML.identifier newRole:V2TIM_GROUP_MEMBER_ROLE_ADMIN succ:^{
                
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"my_request_success")];
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(int code, NSString *desc) {
                [SVProgressHUD showInfoWithStatus:desc];
            }];
        }
    }else {
        for (TUICommonContactSelectCellData *item in arrMM) {
            V2TIMCreateGroupMemberInfo *member = [[V2TIMCreateGroupMemberInfo alloc] init];
            member.userID = item.identifier;
            member.role = V2TIM_GROUP_MEMBER_ROLE_MEMBER;
            [members addObject:member];
        }
        NSString *nameStr = [NSString stringWithFormat:@"%@群", [LYUserDefault userDefault].user_nickname];
        [self addNames:nameStr faceUrl:@"" arrMM:members];
        //    myGroupCreateEditerController *vc = [[myGroupCreateEditerController alloc] init];
        //    [self.navigationController pushViewController:vc animated:YES];
        //    vc.block_ = ^(NSString * _Nonnull nameStr, NSString * _Nonnull faceUrl) {
        //
        //        [self addNames:nameStr faceUrl:faceUrl arrMM:members];
        //    };
    }
}

- (void)addNames:(NSString *)nameStr faceUrl:(NSString *)faceUrl arrMM:(NSArray *)members
{
    if(self.isRequestBoo) {
        return;
    }
    self.isRequestBoo = YES;
    V2TIMGroupInfo *info = [[V2TIMGroupInfo alloc] init];
    info.groupName = nameStr;
    info.faceURL = faceUrl;
    info.groupType = GroupType_Public;
    info.groupAddOpt = V2TIM_GROUP_ADD_ANY;
    [[V2TIMManager sharedInstance] createGroup:info memberList:members succ:^(NSString *groupID) {

//        NSDictionary *dicMM = @{@"groupid":groupID, @"name":nameStr, @"img":faceUrl};
//        [requestToolClass postNetworkWithUrl:request_group_addgroup andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//            [self.navigationController popViewControllerAnimated:NO];
//            if(self.block_) {
//                self.block_(nameStr, groupID);
//            }
//            self.isRequestBoo = NO;
//        } fail:^(NSString * _Nonnull msg) {
//            self.isRequestBoo = NO;
//        }];
    } fail:^(int code, NSString *desc) {
        self.isRequestBoo = NO;
        [SVProgressHUD showInfoWithStatus:desc];
    }];
}


@end
