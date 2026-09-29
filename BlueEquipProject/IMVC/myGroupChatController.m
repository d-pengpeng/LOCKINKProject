//
//  myGroupChatController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/12.
//

#import "myGroupChatController.h"
#import "TUIGroupChatViewController.h"
#import "TUIChatConversationModel.h"
#import "TRedbagMessageCellData.h"
#import "TCUtil.h"
#import "TUCustomRedbagCellCell.h"
#import "myGroupInfoController.h"
#import "chatSendRebbagController.h"
#import "receiveRedbagView.h"
#import "receiveRedbagController.h"
#import "groupLivingMemebersView.h"

@interface myGroupChatController ()<TUIChatControllerListener>

@property (nonatomic, strong) TUIGroupChatViewController *chat;
@property (nonatomic, strong) UIButton *attentBBtn;
@property (nonatomic, copy) NSString *admsStr;
@property (nonatomic, strong) NSArray *mebsArr;
@end

@implementation myGroupChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = self.showName;
    self.titleName.textAlignment = NSTextAlignmentLeft;
    
    if(self.isHistoryBoo) {
        
        _chat = [[TUIGroupChatViewController alloc] init];
        [_chat setDelegate:self];
        [_chat setConversationData:self.conversationData];
        _chat.highlightKeyword = self.highlightKeyword;
        _chat.locateMessage = self.locateMessage;
        _chat.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
        [self addChildViewController:_chat];
        _chat.isGroupChatBo = YES;
        [self.view addSubview:_chat.view];
        _chat.inputController.host_Id = [LYUserDefault userDefault].t_id;
        _chat.inputController.isSendBoo = YES;//c2c样式
        _chat.inputController.isC2CChatGroupBoo = YES;
        _chat.messageController.isC2CChat = YES;
        _chat.messageController.isC2CChatGroupBoo = YES;
        [_chat.inputController.inputBar livingChatGIftAllUIIsShow:4];
    }else {
        _chat = [[TUIGroupChatViewController alloc] init];
        [_chat setDelegate:self];
        TUIChatConversationModel *conversationData = [[TUIChatConversationModel alloc] init];
        conversationData.groupType = GroupType_Public; //工作群（Work） ：类似普通微信群，创建后不能自由加入，必须由已经在群的用户邀请入群，同旧版本中的 Private。 GroupType_Community   Public
        conversationData.groupID = self.chatId;
        [_chat setConversationData:conversationData];
        _chat.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
        [self addChildViewController:_chat];
        _chat.isGroupChatBo = YES;
        [self.view addSubview:_chat.view];
        _chat.inputController.host_Id = [LYUserDefault userDefault].t_id;
        _chat.inputController.isSendBoo = YES;//c2c样式
        _chat.inputController.isC2CChatGroupBoo = YES;
        _chat.messageController.isC2CChat = YES;
        _chat.messageController.isC2CChatGroupBoo = YES;
        [_chat.inputController.inputBar livingChatGIftAllUIIsShow:4];
    }
    
    UIButton *rightImgBnt2 = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-50, TIMESTATUSHEIGHT, 50, 44)];
    [rightImgBnt2 setImage:[UIImage imageNamed:@"chat_imgs4"] forState:UIControlStateNormal];
    [rightImgBnt2 addTarget:self action:@selector(rightImageActiUIUI) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightImgBnt2];
    
    self.attentBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.attentBBtn.frame = CGRectMake(_window_width-120, TIMESTATUSHEIGHT+9, 60, 26);
    self.attentBBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.attentBBtn setTitle:eLocalizedString(@"chat_all5") forState:UIControlStateNormal];
    [self.attentBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.attentBBtn.layer.cornerRadius = 13;
    self.attentBBtn.backgroundColor = RGB(227, 172, 114);
    [self.attentBBtn addTarget:self action:@selector(rightImageMMMMMM) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.attentBBtn];
    self.attentBBtn.hidden = YES;
//    TUIDefine  自定义添加
    self.admsStr = @"";
    [[V2TIMManager sharedInstance] getGroupMemberList:self.chatId filter:V2TIM_GROUP_MEMBER_FILTER_OWNER nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
        for (V2TIMGroupMemberFullInfo *fullInfo in memberList) {
            self.admsStr = minStr(fullInfo.userID);
        }
        [[V2TIMManager sharedInstance] getGroupMemberList:self.chatId filter:V2TIM_GROUP_MEMBER_FILTER_ADMIN nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
            for (V2TIMGroupMemberFullInfo *fullInfo in memberList) {
                self.admsStr = [NSString stringWithFormat:@"%@,%@", self.admsStr, fullInfo.userID];
            }
            [self requestMembs];
        } fail:^(int code, NSString *msg) {
            [self requestMembs];
        }];
    } fail:^(int code, NSString *msg) {
        [self requestMembs];
    }];
}

- (void)requestMembs
{
//    if(self.admsStr.length > 0) {
//        [requestToolClass postNetworkWithUrl:request_group_getIsliveList andParameter:@{@"uid":self.admsStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//            
//            self.mebsArr = info;
//            self.attentBBtn.hidden = self.mebsArr.count>0 ? NO:YES;
//        } fail:^(NSString * _Nonnull msg) {
//            self.attentBBtn.hidden = YES;
//        }];
//    }else {
//        self.attentBBtn.hidden = YES;
//    }
}

- (void)rightImageActiUIUI
{
    myGroupInfoController *vc = [[myGroupInfoController alloc] init];
    vc.chatId = self.chatId;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
}
- (void)rightImageMMMMMM
{
//    groupLivingMemebersView *vc = [[groupLivingMemebersView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//    [self.view addSubview:vc];
//    [vc addMemebersArr:self.mebsArr];
//    vc.block_ = ^(NSInteger numL) {
//      
//        NSDictionary *dicMM = self.mebsArr[numL];
//        [[FloatingWindowModel shareInstance] switchUIUIUControlpullUrl:@"" gameNamesS:minStr(dicMM[@"user_nickname"]) hostId:minStr(dicMM[@"id"]) nickNN:minStr(dicMM[@"user_nickname"]) clarity:@{}];
//    };
}

- (void)chatController:(TUIBaseChatViewController *)chatController onSelectMoreCell:(TUIInputMoreCell *)cell
{
    if (cell.data == [TUIInputMoreCellData videoData]) {
        //红包
        chatSendRebbagController *vc = [[chatSendRebbagController alloc] init];
        vc.chatId = self.chatId;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(NSArray * _Nonnull arr) {
          
            NSDictionary *dic1 = @{@"type":@"10000",@"redBag":@{@"redBagId":arr[1], @"remark":arr[2]}};
            NSString *jsonStr1 = [TCUtil dictionary2JsonStr:dic1];
            NSData *data1 =[jsonStr1 dataUsingEncoding:NSUTF8StringEncoding];
            V2TIMMessage *msgMM1 = [[V2TIMManager sharedInstance] createCustomMessage:data1];
            
            TRedbagMessageCellData *msg = [[TRedbagMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
            msg.innerMessage = msgMM1;
            msg.isC2CChat = YES;
            msg.name = [LYUserDefault userDefault].user_nickname;
            msg.content = [NSString stringWithFormat:@" %@", arr[2]];
            [self.chat.messageController sendMessage:msg];
        };
    }
}
- (TUIMessageCellData *)chatController:(TUIBaseChatViewController *)controller onNewMessage:(V2TIMMessage *)msg
{
    if (msg.elemType == V2TIM_ELEM_TYPE_CUSTOM) {
        NSDictionary *param = [TCUtil jsonData2Dictionary:msg.customElem.data];
        if (param != nil) {
            NSString *typeL = [NSString stringWithFormat:@"%@", param[@"type"]];

            if ([typeL integerValue] == 10000) {
                NSDictionary *redbag = param[@"redBag"];
                if([msg.sender isEqualToString:[LYUserDefault userDefault].t_id]) {
                    TRedbagMessageCellData *cellData = [[TRedbagMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
                    cellData.content = [redbag[@"remark"] length]>0 ? redbag[@"remark"]:eLocalizedString(@"chat_al30");
                    cellData.name = msg.nickName;
                    cellData.isC2CChat = YES;
                    return cellData;
                }else {
                    NSLog(@"-123-%@", redbag[@"remark"]);
                    TRedbagMessageCellData *cellData = [[TRedbagMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
                    cellData.content = [redbag[@"remark"] length]>0 ? redbag[@"remark"]:eLocalizedString(@"chat_al30");
                    cellData.name = msg.nickName;
                    cellData.isC2CChat = YES;
                    return cellData;
                }
            }
        }else {
            return nil;
        }
    }
    return nil;
}

- (void)chatController:(TUIBaseChatViewController *)controller onSelectMessageContent:(TUIMessageCell *)cell
{
    if ([cell isKindOfClass:[TUCustomRedbagCellCell class]]) {
        //点击红包
        NSDictionary *param = [TCUtil jsonData2Dictionary:cell.messageData.innerMessage.customElem.data];
        
        receiveRedbagView *vc = [[receiveRedbagView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        vc.typeLLM = 2;
        vc.redId = minStr(param[@"redBag"][@"redBagId"]);
        vc.remarkStr = minStr(param[@"redBag"][@"remark"]);
        [self.view addSubview:vc];
        [vc requestMethodUrl:minStr(param[@"redBag"][@"redBagId"])];
        vc.block_ = ^(NSInteger numL, NSString * _Nonnull moneyStr, NSDictionary * _Nonnull alDDic) {
            receiveRedbagController *vc = [[receiveRedbagController alloc] init];
            vc.typeLL = numL;
            vc.redId = minStr(param[@"redBag"][@"redBagId"]);
            vc.moneyStr = moneyStr;
            vc.allDD = alDDic;
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
}

//3.8 切换群成员的角色 

@end
