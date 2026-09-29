//
//  myFriendProfileController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/23.
//

#import "myFriendProfileController.h"
#import "c2cChatController.h"
#import "TUICore.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"
//#import "expertRewardView.h"

@interface myFriendProfileController ()

@property (nonatomic, strong) UIButton *switBtn;
@end

@implementation myFriendProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navView.backgroundColor = UIColor.clearColor;
    
    self.titleName.text = eLocalizedString(@"friendProfle_ttt");
    
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(0, NAVHEIGHT, _window_width, 138);
    oneVV.layer.cornerRadius = 0;
    [self.view addSubview:oneVV];
    
    UIImageView *avatorImg = [HistoryRecordModel createImgImgView];
    [oneVV addSubview:avatorImg];
    [avatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneVV.mas_top).offset(20);
        make.centerX.equalTo(oneVV.mas_centerX);
        make.width.height.offset(60);
    }];
    if(!self.isChatBoo) {
        [avatorImg sd_setImageWithURL:[NSURL URLWithString:self.f_faceUrl] placeholderImage:normal_placeHeadImg];
    }else {
        [avatorImg sd_setImageWithURL:self.avator_Url placeholderImage:normal_placeHeadImg];
    }
    
    UILabel *phoneLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:16 textAlignment:NSTextAlignmentCenter];
    phoneLab.text = self.f_Nickname;
    [oneVV addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatorImg.mas_bottom).offset(20);
        make.left.equalTo(oneVV.mas_left).offset(20);
        make.right.equalTo(oneVV.mas_right).offset(-20);
    }];
    
    UIView *oneVV2 = [HistoryRecordModel createViewUIUI];
    oneVV2.frame = CGRectMake(0, NAVHEIGHT+148, _window_width, 52);
    oneVV2.layer.cornerRadius = 0;
    [self.view addSubview:oneVV2];
    
    UILabel *mesgmdrLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:15 textAlignment:NSTextAlignmentLeft];
    mesgmdrLab.text = eLocalizedString(@"message_mdr");
    [oneVV2 addSubview:mesgmdrLab];
    [mesgmdrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneVV2.mas_left).offset(12);
        make.centerY.equalTo(oneVV2.mas_centerY);
        make.right.equalTo(oneVV2.mas_right).offset(-80);
    }];
    
    self.switBtn = [HistoryRecordModel createImgBtn];
    [self.switBtn setBackgroundImage:[UIImage imageNamed:@"meSetting_switch_normal"] forState:UIControlStateNormal];
    [self.switBtn setBackgroundImage:[UIImage imageNamed:@"meSetting_switch_select"] forState:UIControlStateSelected];
    [self.switBtn addTarget:self action:@selector(swithBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV2 addSubview:self.switBtn];
    [self.switBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneVV2.mas_right).offset(-12);
        make.centerY.equalTo(oneVV2.mas_centerY);
        make.width.offset(60);
        make.height.offset(30);
    }];
    
    [[V2TIMManager sharedInstance] getC2CReceiveMessageOpt:@[self.f_UserId]
                                                      succ:^(NSArray<V2TIMUserReceiveMessageOptInfo *> *optList) {
        for (V2TIMReceiveMessageOptInfo *info in optList) {
            if ([info.userID isEqual:self.f_UserId]) {
                self.switBtn.selected = (info.receiveOpt == V2TIM_RECEIVE_NOT_NOTIFY_MESSAGE);
            }
        }
    } fail:nil];
    
    
    UIButton *sendMessageBtn = [HistoryRecordModel createImgBtn];
    sendMessageBtn.frame = CGRectMake(12, _window_height-110-TARBARHEIGHT, _window_width-24, 40);
    sendMessageBtn.backgroundColor = normalColors;
    [sendMessageBtn setTitle:eLocalizedString(@"send_msg") forState:UIControlStateNormal];
    [sendMessageBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sendMessageBtn.titleLabel.font = SYS_Font(15);
    [sendMessageBtn addTarget:self action:@selector(sendMessageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageBtn];
    if([[LYUserDefault userDefault].t_id isEqualToString:self.f_UserId]) {
        sendMessageBtn.backgroundColor = GrayText204;
        sendMessageBtn.userInteractionEnabled = NO;
        self.switBtn.userInteractionEnabled = NO;
    }else {
        
//        [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
//
//            BOOL boo_bo = NO;
//            for (V2TIMFriendInfo *infK in infoList) {
//
//                if([self.f_UserId isEqualToString:infK.userID]) {
//                    boo_bo = YES;
//                }
//            }
//            if(boo_bo) {
//                UIButton *deletefriendBtn = [HistoryRecordModel createImgBtn];
//                deletefriendBtn.frame = CGRectMake(12, _window_height-50-TARBARHEIGHT, _window_width-24, 40);
//                deletefriendBtn.backgroundColor = UIColor.whiteColor;
//                [deletefriendBtn setTitle:eLocalizedString(@"delete_friend") forState:UIControlStateNormal];
//                [deletefriendBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
//                deletefriendBtn.titleLabel.font = SYS_Font(15);
//                [deletefriendBtn addTarget:self action:@selector(deleteFriendBtn) forControlEvents:UIControlEventTouchUpInside];
//                [self.view addSubview:deletefriendBtn];
//            }else {
//                UIButton *deletefriendBtn = [HistoryRecordModel createImgBtn];
//                deletefriendBtn.frame = CGRectMake(12, _window_height-50-TARBARHEIGHT, _window_width-24, 40);
//                deletefriendBtn.backgroundColor = UIColor.whiteColor;
//                [deletefriendBtn setTitle:eLocalizedString(@"goodFriend_ttt") forState:UIControlStateNormal];
//                [deletefriendBtn setTitleColor:normalColors forState:UIControlStateNormal];
//                deletefriendBtn.titleLabel.font = SYS_Font(15);
//                [deletefriendBtn addTarget:self action:@selector(addFriendBtn) forControlEvents:UIControlEventTouchUpInside];
//                [self.view addSubview:deletefriendBtn];
//                self.switBtn.userInteractionEnabled = NO;
//            }
//        } fail:^(int code, NSString *desc) {
//
//        }];
    }
}

- (void)addFriendBtn
{
//    expertRewardView *vc = [[expertRewardView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//    [self.view addSubview:vc];
//    [vc addUIUIUITYpe:1 modelDic:@{} addFriend:[NSString stringWithFormat:@"我是%@", [LYUserDefault userDefault].t_id]];
//    vc.block_ = ^(NSInteger typeL, NSString * _Nonnull money) {
//      
//        if(typeL == 1) {
//            V2TIMFriendAddApplication *application = [[V2TIMFriendAddApplication alloc] init];
//            application.addWording = money;
//            application.friendRemark = money;
//            application.userID = self.f_UserId;
//            application.addSource = @"iOS";
//            application.addType = V2TIM_FRIEND_TYPE_BOTH;
//        
//            [[V2TIMManager sharedInstance] addFriend:application succ:^(V2TIMFriendOperationResult *result) {
//                        
//                [self.navigationController popViewControllerAnimated:YES];
//            } fail:^(int code, NSString *desc) {
//                
//            }];
//        }
//    };
}

- (void)deleteFriendBtn
{
    __weak typeof(self) weakSelf = self;
    [[V2TIMManager sharedInstance] deleteFromFriendList:@[self.f_UserId] deleteType:V2TIM_FRIEND_TYPE_BOTH succ:^(NSArray<V2TIMFriendOperationResult *> *resultList) {
        
        NSString * conversationID = [NSString stringWithFormat:@"c2c_%@",weakSelf.f_UserId];
        //MARK: 置顶
        [[TUIConversationPin sharedInstance] removeTopConversation:conversationID callback:nil];
        [[V2TIMManager sharedInstance] deleteConversation:conversationID succ:nil fail:nil];
//        if (IS_NOT_EMPTY_NSSTRING(conversationID)) {
//            [TUICore notifyEvent:TUICore_TUIConversationNotify subKey:TUICore_TUIConversationNotify_RemoveConversationSubKey object:self param:@{TUICore_TUIConversationNotify_RemoveConversationSubKey_ConversationID : conversationID}];
//        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"languageChagneMethodNotif" object:@"3"];
    } fail:nil];
}

- (void)sendMessageBtn
{
    if(self.isChatBoo) {
        [self.navigationController popViewControllerAnimated:NO];
    }else {
        [[FloatingWindowModel shareInstance] switchChatDetailControlNick:self.f_Nickname hostId:self.f_UserId];
    }
}

- (void)swithBtnMethod
{
    self.switBtn.selected = !self.switBtn.selected;
    V2TIMReceiveMessageOpt opt;
    if (self.switBtn.selected) {
        opt = V2TIM_RECEIVE_NOT_NOTIFY_MESSAGE;
    } else {
        opt = V2TIM_RECEIVE_MESSAGE;
    }
    [[V2TIMManager sharedInstance] setC2CReceiveMessageOpt:@[self.f_UserId] opt:opt succ:nil fail:nil];
}

@end
