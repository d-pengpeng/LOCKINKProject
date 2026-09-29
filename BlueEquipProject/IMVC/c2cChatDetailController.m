//
//  c2cChatDetailController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/20.
//

#import "c2cChatDetailController.h"
#import "PopModifyView.h"
#import "MHOthrMyController.h"

@interface c2cChatDetailController ()

@property (nonatomic, strong) UISwitch *switBtn;
@property (nonatomic, strong) UISwitch *switBtn2;
@property (nonatomic, strong) UISwitch *switBtn3;
@property (nonatomic, strong) UILabel *bzLab;
@property (nonatomic, strong) V2TIMFriendInfo *myIMFriendInfo;
@property (nonatomic, assign) BOOL isBBBoo;
@property (nonatomic, strong) V2TIMConversation *addConv;

@property (nonatomic, strong) UIView *fulVV5;
@property (nonatomic, strong) UIView *fulVV6;
@end

@implementation c2cChatDetailController

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
    self.redNavView = NO;
    self.titleName.text = eLocalizedString(@"expertTitl_detail");
    
    [[V2TIMManager sharedInstance] getConversation:[NSString stringWithFormat:@"c2c_%@",self.chatId] succ:^(V2TIMConversation *conv) {
            
        [self addUIUIUIUIUI:conv];
    } fail:^(int code, NSString *desc) {
        [SVProgressHUD showInfoWithStatus:desc];
    }];
}

- (void)addUIUIUIUIUI:(V2TIMConversation *)conv
{
    self.addConv = conv;

    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(0, NAVHEIGHT, _window_width, 94);
    oneVV.layer.cornerRadius = 0;
    [self.view addSubview:oneVV];
    
    UIImageView *HeadImgV = [HistoryRecordModel createImgImgView];
    HeadImgV.layer.cornerRadius = 8;
    [oneVV addSubview:HeadImgV];
    [HeadImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneVV.mas_top).offset(12);
        make.left.equalTo(oneVV.mas_left).offset(12);
        make.width.height.offset(60);
    }];
    [HeadImgV sd_setImageWithURL:[NSURL URLWithString:conv.faceUrl] placeholderImage:normal_placeHeadImg];
    
    UILabel *nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    nickLab.frame = CGRectMake(82, 12, _window_width-100, 30);
    nickLab.text = conv.showName;
    [oneVV addSubview:nickLab];
    
    UILabel *nickLab2 = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentLeft];
    nickLab2.frame = CGRectMake(82, 42+5, _window_width-100, 20);
    [oneVV addSubview:nickLab2];
    
    UIView *linVVV = [HistoryRecordModel createLineViewUIUI];
    linVVV.frame = CGRectMake(0, 0, _window_width, 1);
    [oneVV addSubview:linVVV];
    
    UIButton *clickAvatar = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, _window_width/2, 60)];
    [clickAvatar addTarget:self action:@selector(clickAvatarMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV addSubview:clickAvatar];
    
    //备注
    UIView *oneVV2_2 = [HistoryRecordModel createViewUIUI];
    oneVV2_2.frame = CGRectMake(0, CGRectGetMaxY(oneVV.frame)+10, _window_width, 50);
    oneVV2_2.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:oneVV2_2];
    
    UILabel *commLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
    commLab.text = eLocalizedString(@"chat_all5");
    [oneVV2_2 addSubview:commLab];
    [commLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneVV2_2.mas_left).offset(12);
        make.centerY.equalTo(oneVV2_2.mas_centerY);
    }];
    
    UIImageView *nex_22 = [HistoryRecordModel createImgImgView];
    nex_22.image = [UIImage imageNamed:@"next_Img2"];
    [oneVV2_2 addSubview:nex_22];
    [nex_22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV2_2.mas_right).offset(-12);
        make.centerY.equalTo(oneVV2_2.mas_centerY);
        make.width.height.offset(18);
    }];
    
    self.bzLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
    self.bzLab.numberOfLines = 0;
    [oneVV2_2 addSubview:self.bzLab];
    [self.bzLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nex_22.mas_left).offset(-4);
        make.top.bottom.equalTo(oneVV2_2);
        make.width.offset(100);
    }];
    
    UIButton *nexBtn22 = [[UIButton alloc] init];
    [nexBtn22 addTarget:self action:@selector(CommentNameBBBMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV2_2 addSubview:nexBtn22];
    [nexBtn22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(oneVV2_2);
    }];
    
    UIView *oneVVtwo_all = [HistoryRecordModel createViewUIUI];
    oneVVtwo_all.frame = CGRectMake(0, CGRectGetMaxY(oneVV2_2.frame), _window_width, _window_height);
    oneVVtwo_all.layer.cornerRadius = 0;
    oneVVtwo_all.backgroundColor = UIColor.clearColor;
    [self.view addSubview:oneVVtwo_all];
    
    //MARK: 消息免打扰
    UIView *oneVV2_3 = [HistoryRecordModel createViewUIUI];
    oneVV2_3.frame = CGRectMake(0, 10, _window_width, 50);
    oneVV2_3.backgroundColor = UIColor.whiteColor;
    [oneVVtwo_all addSubview:oneVV2_3];
    
    UILabel *mesgmdrLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
    mesgmdrLab.text = eLocalizedString(@"message_mdr");
    [oneVV2_3 addSubview:mesgmdrLab];
    [mesgmdrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneVV2_3.mas_left).offset(12);
        make.centerY.equalTo(oneVV2_3.mas_centerY);
    }];
    
    self.switBtn = [[UISwitch alloc] init];
    self.switBtn.onTintColor = normalColors;
    [self.switBtn addTarget:self action:@selector(swithBtnMethod) forControlEvents:UIControlEventValueChanged];
    [oneVV2_3 addSubview:self.switBtn];
    [self.switBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV2_3.mas_right).offset(-12);
        make.centerY.equalTo(mesgmdrLab.mas_centerY);
        make.width.offset(43);
        make.height.offset(26);
    }];
    
    self.switBtn.on = conv.recvOpt==V2TIM_RECEIVE_NOT_NOTIFY_MESSAGE?YES:NO;

    UIView *linVVV2 = [HistoryRecordModel createLineViewUIUI];
    linVVV2.frame = CGRectMake(0, 49, _window_width, 1);
    [oneVV2_3 addSubview:linVVV2];
    
    //置顶
    UIView *oneVV2_4 = [HistoryRecordModel createViewUIUI];
    oneVV2_4.frame = CGRectMake(0, CGRectGetMaxY(oneVV2_3.frame), _window_width, 50);
    oneVV2_4.backgroundColor = UIColor.whiteColor;
    [oneVVtwo_all addSubview:oneVV2_4];
    
    UILabel *mesgmdrLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
    mesgmdrLab2.text = eLocalizedString(@"chat_all3");
    [oneVV2_4 addSubview:mesgmdrLab2];
    [mesgmdrLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(oneVV2_4);
        make.left.equalTo(oneVV2_4.mas_left).offset(12);
        make.right.equalTo(oneVV2_4.mas_right).offset(-80);
    }];

    self.switBtn2 = [[UISwitch alloc] init];
    self.switBtn2.onTintColor = normalColors;
    [self.switBtn2 addTarget:self action:@selector(swithBtnMethodTwoMM) forControlEvents:UIControlEventValueChanged];
    [oneVV2_4 addSubview:self.switBtn2];
    [self.switBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV2_4.mas_right).offset(-12);
        make.centerY.equalTo(oneVV2_4.mas_centerY);
        make.width.offset(43);
        make.height.offset(26);
    }];
    [self.switBtn2 setOn:conv.isPinned];
    
    //清空聊天记录
    UIView *oneVV2_44 = [HistoryRecordModel createViewUIUI];
    oneVV2_44.frame = CGRectMake(0, CGRectGetMaxY(oneVV2_4.frame)+10, _window_width, 50);
    oneVV2_44.backgroundColor = UIColor.whiteColor;
    [oneVVtwo_all addSubview:oneVV2_44];
    UILabel *mesgmdrLab4 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
    mesgmdrLab4.text = eLocalizedString(@"chat_all4");
    [oneVV2_44 addSubview:mesgmdrLab4];
    [mesgmdrLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneVV2_44.mas_left).offset(12);
        make.centerY.equalTo(oneVV2_44.mas_centerY);
    }];
    UIImageView *nex_24 = [HistoryRecordModel createImgImgView];
    nex_24.image = [UIImage imageNamed:@"next_Img2"];
    [oneVV2_44 addSubview:nex_24];
    [nex_24 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV2_44.mas_right).offset(-12);
        make.centerY.equalTo(oneVV2_44.mas_centerY);
        make.width.height.offset(18);
    }];
    UIButton *oneVV3 = [HistoryRecordModel createImgBtn];
    oneVV3.frame = CGRectMake(0, 0, _window_width, 50);
    [oneVV3 addTarget:self action:@selector(clearAllChatMessageMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV2_44 addSubview:oneVV3];
    
    //黑名单
    UIView *oneVV2_5 = [HistoryRecordModel createViewUIUI];
    oneVV2_5.frame = CGRectMake(0, CGRectGetMaxY(oneVV2_44.frame)+10, _window_width, 50);
    oneVV2_5.backgroundColor = UIColor.whiteColor;
    [oneVVtwo_all addSubview:oneVV2_5];
    self.fulVV5 = oneVV2_5;
    UILabel *mesgmdrLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
    mesgmdrLab3.text = eLocalizedString(@"message_tile5");
    [oneVV2_5 addSubview:mesgmdrLab3];
    [mesgmdrLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneVV2_5.mas_left).offset(12);
        make.centerY.equalTo(oneVV2_5.mas_centerY);
    }];
    
    self.switBtn3 = [[UISwitch alloc] init];
    self.switBtn3.onTintColor = normalColors;
    [self.switBtn3 addTarget:self action:@selector(swithBtnMethodTblackBookMM) forControlEvents:UIControlEventValueChanged];
    [oneVV2_5 addSubview:self.switBtn3];
    [self.switBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV2_5.mas_right).offset(-12);
        make.centerY.equalTo(oneVV2_5.mas_centerY);
        make.width.offset(43);
        make.height.offset(26);
    }];
    
    [[V2TIMManager sharedInstance] getBlackList:^(NSArray<V2TIMFriendInfo *> *infoList) {
            
        for (V2TIMFriendInfo *inff in infoList) {
            if([inff.userID isEqualToString:self.chatId]) {
                self.switBtn3.on = YES;
            }
        }
    } fail:^(int code, NSString *desc) {
        
    }];
    
    //删除好友
    UIView *oneVV2_6 = [HistoryRecordModel createViewUIUI];
    oneVV2_6.frame = CGRectMake(12, CGRectGetMaxY(oneVV2_5.frame)+10, _window_width-24, 50);
    oneVV2_6.backgroundColor = UIColor.whiteColor;
    [oneVVtwo_all addSubview:oneVV2_6];
    self.fulVV6 = oneVV2_6;
    
    UILabel *mesgmdrLab6 = [HistoryRecordModel createLabLabTextColor:UIColor.redColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
    mesgmdrLab6.text = eLocalizedString(@"chat_all7");
    [oneVV2_6 addSubview:mesgmdrLab6];
    [mesgmdrLab6 mas_makeConstraints:^(MASConstraintMaker *make) {
     make.center.equalTo(oneVV2_6);
    }];

    UIButton *oneVV6 = [HistoryRecordModel createImgBtn];
    oneVV6.frame = CGRectMake(0, 0, _window_width, 50);
    [oneVV6 addTarget:self action:@selector(deleteFriendMessageMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV2_6 addSubview:oneVV6];
    self.fulVV6.hidden = NO;
    
    [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
            
        BOOL isBBF = NO;
        for (V2TIMFriendInfo *mod in infoList) {
            if([mod.userID isEqualToString:self.chatId]) {
                isBBF = YES;
            }
        }
        if(isBBF) {
            if(self.isShowSend) {
                UIButton *sendMessageBtn = [HistoryRecordModel createImgBtn];
//                sendMessageBtn.frame = CGRectMake(12, CGRectGetMaxY(oneVV2_4.frame)+20+124, _window_width-24, 48);
                sendMessageBtn.frame = CGRectMake(12, CGRectGetMaxY(oneVV2_5.frame)+10, _window_width-24, 48);
                sendMessageBtn.backgroundColor = UIColor.whiteColor;
                [sendMessageBtn setTitle:eLocalizedString(@"send_msg") forState:UIControlStateNormal];
                [sendMessageBtn setTitleColor:normalColors forState:UIControlStateNormal];
                sendMessageBtn.titleLabel.font = SYS_Font(15);
                [sendMessageBtn addTarget:self action:@selector(sendMessageBtn) forControlEvents:UIControlEventTouchUpInside];
                [oneVVtwo_all addSubview:sendMessageBtn];
                
                oneVV2_6.frame = CGRectMake(12, CGRectGetMaxY(sendMessageBtn.frame)+10, _window_width-24, 50);
            }
        }else {
            self.fulVV6.hidden = YES;
            if(!self.isShowSend) {
                UIButton *sendMessageBtn = [HistoryRecordModel createImgBtn];
//                sendMessageBtn.frame = CGRectMake(12, CGRectGetMaxY(oneVV2_4.frame)+20+124, _window_width-24, 48);
                sendMessageBtn.frame = CGRectMake(12, CGRectGetMaxY(oneVV2_5.frame)+10, _window_width-24, 48);
                sendMessageBtn.backgroundColor = UIColor.whiteColor;
                [sendMessageBtn setTitle:eLocalizedString(@"message_tile12") forState:UIControlStateNormal];
                [sendMessageBtn setTitleColor:normalColors forState:UIControlStateNormal];
                sendMessageBtn.titleLabel.font = SYS_Font(15);
                [sendMessageBtn addTarget:self action:@selector(sendAddFriendMessageBtn) forControlEvents:UIControlEventTouchUpInside];
                [oneVVtwo_all addSubview:sendMessageBtn];
            }
            
            oneVV2_2.hidden = YES;
            oneVVtwo_all.frame = CGRectMake(0, CGRectGetMaxY(oneVV.frame)+10, _window_width, _window_height);
        }
    } fail:^(int code, NSString *desc) {
        
    }];
    
    [[V2TIMManager sharedInstance] getFriendsInfo:@[self.chatId] succ:^(NSArray<V2TIMFriendInfoResult *> *resultList) {
        if(resultList.count>0) {
            V2TIMFriendInfoResult *friendResud = resultList[0];
            self.myIMFriendInfo = friendResud.friendInfo;
            self.bzLab.text = self.myIMFriendInfo.friendRemark;
            
            nickLab2.text = [NSString stringWithFormat:@"ID: %@", self.myIMFriendInfo.userID];
       
        }
    } fail:^(int code, NSString *desc) {
        
    }];
    
    
//    5.11 清空群聊本地及云端的消息（不删除会话）
}

- (void)clickAvatarMethod
{
    MHOthrMyController *vc = [[MHOthrMyController alloc] init];
    vc.otherId = minStr(self.chatId);
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendAddFriendMessageBtn
{
    V2TIMFriendAddApplication *application = [[V2TIMFriendAddApplication alloc] init];
    application.addWording = [LYUserDefault userDefault].user_nickname;
//  application.friendRemark = money;
    application.userID = self.chatId;
    application.addSource = @"iOS";
    application.addType = V2TIM_FRIEND_TYPE_BOTH;
    [[V2TIMManager sharedInstance] addFriend:application succ:^(V2TIMFriendOperationResult *result) {

        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(int code, NSString *desc) {

    }];
}

- (void)sendMessageBtn
{
    [[FloatingWindowModel shareInstance] switchChatDetailControlNick:self.addConv.showName hostId:self.chatId];
}

- (void)CommentNameBBBMethod
{
    if(self.fulVV6.hidden == NO) {
        PopModifyView *modify = [[PopModifyView alloc]init];
        modify.titleString = eLocalizedString(@"chat_all5");
        modify.isSingleCommit = YES;
        modify.blockTextToModify = ^(NSString *name, NSString *phone) {
            
            self.myIMFriendInfo.friendRemark = name;
            [[V2TIMManager sharedInstance] setFriendInfo:self.myIMFriendInfo succ:^{
                self.bzLab.text = name;
            } fail:^(int code, NSString *desc) {
                
            }];
        };
        [modify show];
    }
}

- (void)swithBtnMethod
{
    V2TIMReceiveMessageOpt opt;
    if([self.switBtn isOn]) {
        opt = V2TIM_RECEIVE_NOT_NOTIFY_MESSAGE;
    } else {
        opt = V2TIM_RECEIVE_MESSAGE;
    }
    [[V2TIMManager sharedInstance] setC2CReceiveMessageOpt:@[self.chatId] opt:opt succ:^{
            
    } fail:^(int code, NSString *desc) {
        if([self.switBtn isOn]) {
            self.switBtn.on = NO;
        }else {
            self.switBtn.on = YES;
        }
    }];
}

- (void)swithBtnMethodTwoMM
{
    if([self.switBtn2 isOn]) {
        [[V2TIMManager sharedInstance] pinConversation:self.conversationID isPinned:YES succ:^{
                    
        } fail:^(int code, NSString *desc) {
            self.switBtn2.on = YES;
        }];
    }else {
        [[V2TIMManager sharedInstance] pinConversation:self.conversationID isPinned:NO succ:^{
                    
        } fail:^(int code, NSString *desc) {
            self.switBtn2.on = NO;
        }];
    }
}

- (void)swithBtnMethodTblackBookMM
{
    if([self.switBtn3 isOn]) {
        [[V2TIMManager sharedInstance] addToBlackList:@[self.chatId] succ:^(NSArray<V2TIMFriendOperationResult *> *resultList) {
            
        } fail:^(int code, NSString *desc) {
            self.switBtn3.on = YES;
        }];
    }else {
        [[V2TIMManager sharedInstance] deleteFromBlackList:@[self.chatId] succ:^(NSArray<V2TIMFriendOperationResult *> *resultList) {
            
//            V2TIMFriendAddApplication *application = [[V2TIMFriendAddApplication alloc] init];
//            application.addWording = [LYUserDefault userDefault].user_nickname;
//            application.userID = self.chatId;
//            application.addSource = @"iOS";
//            application.addType = V2TIM_FRIEND_TYPE_BOTH;
//
//            [[V2TIMManager sharedInstance] addFriend:application succ:^(V2TIMFriendOperationResult *result) {
//
//            } fail:^(int code, NSString *desc) {
//
//            }];
        } fail:^(int code, NSString *desc) {
            self.switBtn3.on = NO;
        }];
    }
}

- (void)clearAllChatMessageMethod
{
    
    [SGActionView showAlertWithTitle:nil message:[NSString stringWithFormat:@"%@?", eLocalizedString(@"chat_all4")] leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
        if (index == 1) {
            [[V2TIMManager sharedInstance] clearC2CHistoryMessage:self.chatId succ:^{
                    
                [self.navigationController popToRootViewControllerAnimated:YES];
            } fail:^(int code, NSString *desc) {
                
            }];
        }
    }];
}

- (void)deleteFriendMessageMethod
{
    [SGActionView showAlertWithTitle:nil message:[NSString stringWithFormat:@"%@?", eLocalizedString(@"chat_all7")] leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
        if (index == 1) {
            [[V2TIMManager sharedInstance] deleteFromFriendList:@[self.chatId] deleteType:V2TIM_FRIEND_TYPE_BOTH succ:^(NSArray<V2TIMFriendOperationResult *> *resultList) {
                
                self.fulVV6.hidden = YES;
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(int code, NSString *desc) {
                
            }];
        }
    }];
}

@end
