//
//  c2cChatController.m
//  DragonTeethLive
//
//  Created by Edwin on 2022/10/24.
//

#import "c2cChatController.h"
#import "TUIC2CChatViewController.h"
#import "TCUtil.h"
#import "TRedbagMessageCellData.h"
#import "TUCustomRedbagCellCell.h"
#import "c2cChatDetailController.h"
#import "chatSendRebbagController.h"
#import "receiveRedbagView.h"
#import "receiveRedbagController.h"
#import "MHReportJBViewController.h"

#import "TPatternMessageCellData.h"
#import "TUCustomPatternCellCell.h"
#import "TUCustomPlaceCellData.h"
#import "MHConnectJSVView.h"
#import "MHInviteIMFriendView.h"

#import "TUISystemMessageCellData.h"
#import "MHBehaviorReporter.h"

@interface c2cChatController ()<TUIChatControllerListener>

@property (nonatomic, strong) TUIC2CChatViewController *o2ochat;
@property (nonatomic, assign) BOOL isBBBoo;
@property (nonatomic, assign) int typeId;
@property (nonatomic, assign) BOOL isJSbMain;
@property (nonatomic, assign) BOOL isStopBo;
@property (nonatomic, copy) NSString *curTime;
@property (nonatomic, assign) BOOL isJS;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, strong) UIView *antiFraudView;
@property (nonatomic, assign) CGFloat antiTipH;
@property (nonatomic, strong) UILabel *antiLabel;
@property (nonatomic, copy) NSString *antiFraudTipText;   // /config/getConfig 拉到的反诈主文本
@property (nonatomic, copy) NSString *antiFraudLinkText;  // 可点击部分，默认"点此举报"
@end

@implementation c2cChatController

- (void)viewWillAppear:(BOOL)animated
{
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
    self.titleName.text = self.showName;
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:0];
    self.titleName.textColor = UIColor.blackColor;
    
    self.isStopBo = YES;

    // 反诈提示条 — 后端可配 chatBanner，无配置或 enabled=false 则隐藏
    NSDictionary *bannerConf = [LYUserDefault userDefault].chatBanner;
    BOOL bannerEnabled = YES;
    if (bannerConf && [bannerConf isKindOfClass:[NSDictionary class]]) {
        id enabledObj = bannerConf[@"enabled"];
        if (enabledObj && ![enabledObj isKindOfClass:[NSNull class]]) {
            bannerEnabled = [enabledObj respondsToSelector:@selector(boolValue)] ? [enabledObj boolValue] : YES;
        }
    }

    if (bannerEnabled) {
        self.antiTipH = 48;
        CGFloat antiBarH = 48;

        // 背景色：后端可下发 bgColor (#RRGGBB)，默认 #FFF8F0
        UIColor *bgColor = [UIColor colorWithRed:255/255.f green:248/255.f blue:240/255.f alpha:1.f];
        NSString *bgHex = bannerConf[@"bgColor"];
        if ([bgHex isKindOfClass:[NSString class]] && bgHex.length > 0) {
            UIColor *c = [self _colorFromHexString:bgHex];
            if (c) bgColor = c;
        }

        self.antiFraudView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, antiBarH)];
        self.antiFraudView.backgroundColor = bgColor;

        // 警告图标
        UIImageView *warningIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, (antiBarH - 18) / 2.0, 20, 18)];
        warningIcon.image = [UIImage systemImageNamed:@"exclamationmark.triangle"];
        warningIcon.tintColor = [UIColor colorWithRed:250/255.f green:140/255.f blue:22/255.f alpha:1.f];
        warningIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self.antiFraudView addSubview:warningIcon];

        // 关闭按钮 X
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(_window_width - 32, (antiBarH - 20) / 2.0, 20, 20);
        [closeBtn setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateNormal];
        closeBtn.tintColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.f];
        [closeBtn addTarget:self action:@selector(closeAntiFraudTip) forControlEvents:UIControlEventTouchUpInside];
        [self.antiFraudView addSubview:closeBtn];

        // 文本（含可点击的"点此举报"链接）
        CGFloat textX = 40;
        CGFloat textW = _window_width - textX - 36;
        self.antiLabel = [[UILabel alloc] initWithFrame:CGRectMake(textX, 0, textW, antiBarH)];
        self.antiLabel.numberOfLines = 2;
        self.antiLabel.font = SYS_Font(12);
        self.antiLabel.userInteractionEnabled = YES;

        // 先设默认文案，接口回来后会刷新
        [self _refreshAntiFraudLabel];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openAntiFraudReport)];
        [self.antiLabel addGestureRecognizer:tap];
        [self.antiFraudView addSubview:self.antiLabel];

        [self.view addSubview:self.antiFraudView];

        // 异步拉取反诈主文本 —— /config/getConfig?key=antifraudwarning
        // 成功：用后端返回字符串替换主文本；失败：保留本地默认
        [requestToolClass getNetworkWithUrl:request_config_getConfig
                               andParameter:@{@"key": @"antifraudwarning"}
                                    success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            if (code == 200 && [info isKindOfClass:[NSString class]] && ((NSString *)info).length > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.antiFraudTipText = (NSString *)info;
                    [self _refreshAntiFraudLabel];
                });
            }
        } fail:^(NSString * _Nonnull msg) {
            // 接口失败 —— 不做事，保留本地默认文案
        }];
    } else {
        // 后端 disabled，整条提示条隐藏，chat 顶部直接贴导航栏
        self.antiTipH = 0;
    }

    if(self.isHistoryBoo) {
        
        _o2ochat = [[TUIC2CChatViewController alloc] init];
        [_o2ochat setDelegate:self];
        [_o2ochat setConversationData:self.conversationData];
        _o2ochat.highlightKeyword = self.highlightKeyword;
        _o2ochat.locateMessage = self.locateMessage;
        _o2ochat.view.frame = CGRectMake(0, NAVHEIGHT+self.antiTipH, _window_width, _window_height-NAVHEIGHT-self.antiTipH);
        [self addChildViewController:_o2ochat];
        [self.view addSubview:_o2ochat.view];
        _o2ochat.inputController.host_Id = self.chatId;
        _o2ochat.inputController.isSendBoo = YES;//c2c样式
        _o2ochat.messageController.isC2CChat = YES;
        [_o2ochat.inputController.inputBar livingChatGIftAllUIIsShow:4];
        _o2ochat.view.frame = CGRectMake(0, NAVHEIGHT+self.antiTipH, _window_width, _window_height-NAVHEIGHT-self.antiTipH);
    }else {
        _o2ochat = [[TUIC2CChatViewController alloc] init];
        [_o2ochat setDelegate:self];
        TUIChatConversationModel *conversationData = [[TUIChatConversationModel alloc] init];
        conversationData.userID = self.chatId;
        [_o2ochat setConversationData:conversationData];
        _o2ochat.view.frame = CGRectMake(0, NAVHEIGHT+self.antiTipH, _window_width, _window_height-NAVHEIGHT-self.antiTipH);
        [self addChildViewController:_o2ochat];
        [self.view addSubview:_o2ochat.view];
        _o2ochat.inputController.host_Id = self.chatId;
        _o2ochat.inputController.isSendBoo = YES;//c2c样式
        _o2ochat.messageController.isC2CChat = YES;
        [_o2ochat.inputController.inputBar livingChatGIftAllUIIsShow:4];
        _o2ochat.view.frame = CGRectMake(0, NAVHEIGHT+self.antiTipH, _window_width, _window_height-NAVHEIGHT-self.antiTipH);
    }
    _o2ochat.view.backgroundColor = UIColor.clearColor;
    _o2ochat.messageController.view.backgroundColor = UIColor.clearColor;
    
    if(![self.chatId isEqualToString:[LYUserDefault userDefault].kefuId]) {
        UIButton *rightImgBnt2 = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-50, TIMESTATUSHEIGHT, 44, 44)];
        [rightImgBnt2 setImage:[UIImage imageNamed:@"ModeImgs7_77"] forState:UIControlStateNormal];
        [rightImgBnt2 addTarget:self action:@selector(rightImageActiUIUI) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:rightImgBnt2];
    }
    
    self.curTime = [HistoryRecordModel nowTimeInterval];
    if(self.recordId) {
        if([self.typeIdRec intValue] > 2) {
            
            [requestToolClass postNetworkWithUrl:request_device_generatePermissionTransferRecord andParameter:@{@"deviceId":self.recordId, @"days":self.dayId, @"toId":self.chatId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                NSDictionary *dic1 = @{@"businessID":@"permission_transfer", @"name":minStr(info[@"deviceName"]), @"avatar":minStr(info[@"deviceImg"]), @"id":minStr(info[@"recordId"]), @"day":self.dayId};
                NSString *jsonStr1 = [TCUtil dictionary2JsonStr:dic1];
                NSData *data1 =[jsonStr1 dataUsingEncoding:NSUTF8StringEncoding];
                V2TIMMessage *msgMM1 = [[V2TIMManager sharedInstance] createCustomMessage:data1];

                TPatternMessageCellData *custPatMsgCell = [[TPatternMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
                custPatMsgCell.innerMessage = msgMM1;
                custPatMsgCell.isC2CChat = YES;
                custPatMsgCell.name = [LYUserDefault userDefault].user_nickname;
                custPatMsgCell.avator = [LYUserDefault userDefault].avatar;
                custPatMsgCell.nickName = minStr(info[@"deviceName"]);
                custPatMsgCell.content = minStr(info[@"deviceImg"]);
                custPatMsgCell.type = self.typeIdRec;
                custPatMsgCell.dayId = self.dayId;
                [self.o2ochat.messageController sendMessage:custPatMsgCell];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
            
        }else {
            [requestToolClass getNetworkWithUrl:request_device_getInvitationRecord andParameter:@{@"recordId":self.recordId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                NSDictionary *dic1 = @{@"businessID":@"invite_friend", @"name":minStr(info[@"deviceName"]), @"avatar":minStr(info[@"deviceImg"]), @"id":minStr(info[@"recordId"]), @"type":self.typeIdRec};
                NSString *jsonStr1 = [TCUtil dictionary2JsonStr:dic1];
                NSData *data1 =[jsonStr1 dataUsingEncoding:NSUTF8StringEncoding];
                V2TIMMessage *msgMM1 = [[V2TIMManager sharedInstance] createCustomMessage:data1];

                TPatternMessageCellData *custPatMsgCell = [[TPatternMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
                custPatMsgCell.innerMessage = msgMM1;
                custPatMsgCell.isC2CChat = YES;
                custPatMsgCell.name = [LYUserDefault userDefault].user_nickname;
                custPatMsgCell.avator = [LYUserDefault userDefault].avatar;
                custPatMsgCell.nickName = minStr(info[@"deviceName"]);
                custPatMsgCell.content = minStr(info[@"deviceImg"]);
                custPatMsgCell.type = self.typeIdRec;
                [self.o2ochat.messageController sendMessage:custPatMsgCell];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [LYUserDefault saveAllEvents:YES];
//    });
    
//    + (UIImage *)outgoingBubble 气泡 conversationIDList 会话唯一 ID 列表，C2C 单聊组成方式：[NSString stringWithFormat:@"c2c_%@",userID]；群聊组成方式为 [NSString stringWithFormat:@"group_%@",groupID]
    
    NSString *convId = [self respondsToSelector:@selector(conversationIDList)] ? [self performSelector:@selector(conversationIDList)] : @"";
    if (![convId isKindOfClass:[NSString class]]) convId = @"";
    // targetType 根据 convId 前缀判断：c2c_ → user，group_ → group
    NSString *targetType = [convId hasPrefix:@"group_"] ? @"group" : @"user";
    [[MHBehaviorReporter shared] trackAction:@"chat_enter"
                                        page:NSStringFromClass([self class])
                                    fromPage:nil
                                  targetType:targetType
                                    targetId:convId
                                         ext:nil];
}

#pragma mark - 反诈提示条

/// 刷新反诈条文本。文案优先级：
///   /config/getConfig 接口返回  >  chatBanner.text  >  本地 InfoPlist.strings
/// linkText 优先级同上。颜色 chatBanner 可配。
- (void)_refreshAntiFraudLabel
{
    if (!self.antiLabel) return;

    NSDictionary *bannerConf = [LYUserDefault userDefault].chatBanner;

    // 主文本
    NSString *fullText = nil;
    if (self.antiFraudTipText.length > 0) {
        fullText = self.antiFraudTipText;   // /config/getConfig 刚拉到的
    } else if (bannerConf) {
        NSString *t = bannerConf[@"text"];
        if ([t isKindOfClass:[NSString class]] && t.length > 0) fullText = t;
    }
    if (fullText.length == 0) fullText = eLocalizedString(@"anti_fraud_tip");

    // 可点击文本
    NSString *linkText = nil;
    if (self.antiFraudLinkText.length > 0) {
        linkText = self.antiFraudLinkText;
    } else if (bannerConf) {
        NSString *lt = bannerConf[@"linkText"];
        if ([lt isKindOfClass:[NSString class]] && lt.length > 0) linkText = lt;
    }
    if (linkText.length == 0) linkText = eLocalizedString(@"anti_fraud_report");

    NSString *combinedText = [NSString stringWithFormat:@"%@%@", fullText, linkText ?: @""];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:combinedText];

    // 颜色
    UIColor *baseColor = [UIColor colorWithRed:89/255.f green:89/255.f blue:89/255.f alpha:1.f];
    UIColor *linkColor = [UIColor colorWithRed:24/255.f green:144/255.f blue:255/255.f alpha:1.f];
    if (bannerConf) {
        NSString *tc = bannerConf[@"textColor"];
        if ([tc isKindOfClass:[NSString class]] && tc.length > 0) {
            UIColor *c = [self _colorFromHexString:tc];
            if (c) baseColor = c;
        }
        NSString *lc = bannerConf[@"linkColor"];
        if ([lc isKindOfClass:[NSString class]] && lc.length > 0) {
            UIColor *c = [self _colorFromHexString:lc];
            if (c) linkColor = c;
        }
    }
    [attrStr addAttribute:NSForegroundColorAttributeName value:baseColor range:NSMakeRange(0, combinedText.length)];

    if (linkText.length > 0) {
        NSRange linkRange = [combinedText rangeOfString:linkText];
        if (linkRange.location != NSNotFound) {
            [attrStr addAttribute:NSForegroundColorAttributeName value:linkColor range:linkRange];
            [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:linkRange];
        }
    }
    self.antiLabel.attributedText = attrStr;
}

- (void)closeAntiFraudTip
{
    [UIView animateWithDuration:0.25 animations:^{
        self.antiFraudView.alpha = 0;
        self.antiTipH = 0;
        _o2ochat.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height - NAVHEIGHT);
    } completion:^(BOOL finished) {
        [self.antiFraudView removeFromSuperview];
    }];
}

- (void)openAntiFraudReport
{
    NSDictionary *bannerConf = [LYUserDefault userDefault].chatBanner;
    NSString *linkUrl = bannerConf[@"linkUrl"];
    if ([linkUrl isKindOfClass:[NSString class]] && linkUrl.length > 0) {
        NSURL *url = [NSURL URLWithString:linkUrl];
        if (url) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            return;
        }
    }
    // fallback：走 App 内举报页
    MHReportJBViewController *vc = [[MHReportJBViewController alloc] init];
    vc.typeL = @"USER";
    vc.targetIId = self.chatId;
    [self.navigationController pushViewController:vc animated:YES];
}

/// 把 "#RRGGBB" 或 "#RGB" 十六进制串转成 UIColor，失败返回 nil
- (UIColor *)_colorFromHexString:(NSString *)hex
{
    if (hex.length < 3) return nil;
    NSString *h = [hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([h hasPrefix:@"#"]) h = [h substringFromIndex:1];
    if (h.length == 3) {
        // 3 位简写：abc → aabbcc
        h = [NSString stringWithFormat:@"%c%c%c%c%c%c",
             [h characterAtIndex:0], [h characterAtIndex:0],
             [h characterAtIndex:1], [h characterAtIndex:1],
             [h characterAtIndex:2], [h characterAtIndex:2]];
    }
    if (h.length != 6) return nil;
    unsigned val = 0;
    NSScanner *scan = [NSScanner scannerWithString:h];
    if (![scan scanHexInt:&val]) return nil;
    CGFloat r = ((val >> 16) & 0xFF) / 255.f;
    CGFloat g = ((val >> 8)  & 0xFF) / 255.f;
    CGFloat b = ( val        & 0xFF) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void)rightImageActiUIUI
{
    c2cChatDetailController *vc = [[c2cChatDetailController alloc] init];
    vc.chatId = self.chatId;
    vc.typeId = self.typeId;
    vc.conversationID = [NSString stringWithFormat:@"c2c_%@",self.chatId];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)chatController:(TUIBaseChatViewController *)controller onSelectMessageAvatar:(TUIMessageCell *)cell
{
    if(![self.chatId isEqualToString:[LYUserDefault userDefault].kefuId]) {
        c2cChatDetailController *vc = [[c2cChatDetailController alloc] init];
        vc.chatId = cell.messageData.identifier;
        vc.typeId = self.typeId;
        vc.conversationID = [NSString stringWithFormat:@"c2c_%@",cell.messageData.identifier];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (TUIMessageCellData *)chatController:(TUIBaseChatViewController *)controller onNewMessage:(V2TIMMessage *)msg
{
    if (msg.elemType == V2TIM_ELEM_TYPE_CUSTOM) {

        NSDictionary *param = [TCUtil jsonData2Dictionary:msg.customElem.data];
        if (param != nil) {
            
            NSString *typeL = [NSString stringWithFormat:@"%@", param[@"businessID"]];
            if([typeL isEqualToString:@"invite_friend"]) {
                
                if([msg.sender isEqualToString:[LYUserDefault userDefault].t_id]) {
                    TPatternMessageCellData *cellData = [[TPatternMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
                    cellData.content = minStr(param[@"avatar"]);
                    cellData.avator = [LYUserDefault userDefault].avatar;
                    cellData.nickName = minStr(param[@"name"]);
                    cellData.name = [LYUserDefault userDefault].user_nickname;
                    cellData.recordId = minStr(param[@"id"]);
                    cellData.type = minStr(param[@"type"]);
                    return cellData;
                }else {
                    TPatternMessageCellData *cellData = [[TPatternMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
                    cellData.content = minStr(param[@"avatar"]);
                    cellData.avator = msg.faceURL;
                    cellData.nickName = minStr(param[@"name"]);
                    cellData.name = msg.nickName;
                    cellData.recordId = minStr(param[@"id"]);
                    cellData.type = minStr(param[@"type"]);
                    return cellData;
                }
            }else if([typeL isEqualToString:@"permission_transfer"]) {
                
                if([msg.sender isEqualToString:[LYUserDefault userDefault].t_id]) {
                    TPatternMessageCellData *cellData = [[TPatternMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
                    cellData.content = minStr(param[@"avatar"]);
                    cellData.avator = [LYUserDefault userDefault].avatar;
                    cellData.nickName = minStr(param[@"name"]);
                    cellData.name = [LYUserDefault userDefault].user_nickname;
                    cellData.recordId = minStr(param[@"id"]);
                    cellData.type = @"5";
                    cellData.dayId = minStr(param[@"day"]);
                    return cellData;
                }else {
                    TPatternMessageCellData *cellData = [[TPatternMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
                    cellData.content = minStr(param[@"avatar"]);
                    cellData.avator = msg.faceURL;
                    cellData.nickName = minStr(param[@"name"]);
                    cellData.name = msg.nickName;
                    cellData.recordId = minStr(param[@"id"]);
                    cellData.type = @"5";
                    cellData.dayId = minStr(param[@"day"]);
                    return cellData;
                }
            }else {
                if([typeL isEqualToString:@"invite_friendStatus"]) {
                    
                    TUCustomPlaceCellData *custPatMsgCell = [[TUCustomPlaceCellData alloc] initWithDirection:MsgDirectionOutgoing];
                    custPatMsgCell.isC2CChat = YES;
                    custPatMsgCell.contentFont = SYS_Font(15);
                    custPatMsgCell.contentColor = GrayText;
                    if([minStr(param[@"status"]) isEqualToString:@"2"]) {
                        custPatMsgCell.content = eLocalizedString(@"my_about24");
                    }else {
                        custPatMsgCell.content = eLocalizedString(@"my_about25");
                    }
                    return custPatMsgCell;
                }
                
                return nil;
            }
        }else {
            return nil;
        }
    }
    return nil;
}

- (void)chatController:(TUIBaseChatViewController *)controller onSelectMessageContent:(TUIMessageCell *)cell
{
    //点击红包
    if ([cell isKindOfClass:[TUCustomRedbagCellCell class]]) {
        NSDictionary *param = [TCUtil jsonData2Dictionary:cell.messageData.innerMessage.customElem.data];
        if([cell.messageData.identifier intValue]<=0) {
            
            receiveRedbagController *vc = [[receiveRedbagController alloc] init];
            vc.typeLL = 4;
            vc.isRequesBoo = YES;
            vc.redId = minStr(param[@"redBag"][@"redBagId"]);
            vc.remarkMsg = minStr(param[@"redBag"][@"remark"]);
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            
            if([cell.messageData.identifier isEqualToString:[LYUserDefault userDefault].t_id]) {
                receiveRedbagController *vc = [[receiveRedbagController alloc] init];
                vc.typeLL = 4;
                vc.isRequesBoo = YES;
                vc.redId = minStr(param[@"redBag"][@"redBagId"]);
                vc.remarkMsg = minStr(param[@"redBag"][@"remark"]);
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                
                receiveRedbagView *vc = [[receiveRedbagView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                vc.typeLLM = 1;
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
    }else if ([cell isKindOfClass:[TUCustomPatternCellCell class]]) {
        
        NSDictionary *param = [TCUtil jsonData2Dictionary:cell.messageData.innerMessage.customElem.data];
        NSString *typeL = [NSString stringWithFormat:@"%@", param[@"businessID"]];
        if([typeL isEqualToString:@"invite_friend"]) {
            
            if(cell.messageData.direction == MsgDirectionIncoming) {
                MHInviteIMFriendView *inviteIMFriendV = [[MHInviteIMFriendView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:inviteIMFriendV];
                [inviteIMFriendV addUUIUType:YES recordIId:minStr(param[@"id"])];
                inviteIMFriendV.block_ = ^(BOOL isBBoo, NSDictionary * _Nonnull dicMM) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeListUploadNotif" object:nil];
    //                [self sendCustomSystomUI:isBBoo dicAll:dicMM];
                };
            }else {
                
                MHInviteIMFriendView *inviteIMFriendV = [[MHInviteIMFriendView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:inviteIMFriendV];
                [inviteIMFriendV addUUIUType:NO recordIId:minStr(param[@"id"])];
            }
        }else if([typeL isEqualToString:@"permission_transfer"]) {
            
            if(cell.messageData.direction == MsgDirectionIncoming) {
                MHInviteIMFriendView *inviteIMFriendV = [[MHInviteIMFriendView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                inviteIMFriendV.isZhuanYiBo = YES;
                inviteIMFriendV.tyyM = 1;
                inviteIMFriendV.dayid = minStr(param[@"day"]);
                [self.view addSubview:inviteIMFriendV];
                [inviteIMFriendV addUUIUTypeTwo:YES recordIId:minStr(param[@"id"])];
                inviteIMFriendV.block_ = ^(BOOL isBBoo, NSDictionary * _Nonnull dicMM) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeListUploadNotif" object:nil];
    //                [self sendCustomSystomUI:isBBoo dicAll:dicMM];
                };
            }else {
                MHInviteIMFriendView *inviteIMFriendV = [[MHInviteIMFriendView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                inviteIMFriendV.isZhuanYiBo = YES;
                inviteIMFriendV.tyyM = 2;
                inviteIMFriendV.dayid = minStr(param[@"day"]);
                [self.view addSubview:inviteIMFriendV];
                [inviteIMFriendV addUUIUTypeTwo:NO recordIId:minStr(param[@"id"])];
            }
        }
    }
}

//MARK:  发送提示语 类似系统消息
- (void)sendCustomSystomUI:(BOOL)isBBoo dicAll:(NSDictionary *)dicAll
{
    NSDictionary *dic1 = @{@"businessID":@"invite_friendStatus", @"name":minStr(dicAll[@"deviceName"]), @"avatar":minStr(dicAll[@"mode_placeAA-03Img"]), @"id":minStr(dicAll[@"recordId"]), @"status":@"3"};
    if(isBBoo) {
        dic1 = @{@"businessID":@"invite_friendType", @"name":minStr(dicAll[@"deviceName"]), @"avatar":minStr(dicAll[@"mode_placeAA-03Img"]), @"id":minStr(dicAll[@"recordId"]), @"status":@"2"};
    }
    NSString *jsonStr1 = [TCUtil dictionary2JsonStr:dic1];
    NSData *data1 =[jsonStr1 dataUsingEncoding:NSUTF8StringEncoding];
    V2TIMMessage *msgMM1 = [[V2TIMManager sharedInstance] createCustomMessage:data1];

    TUCustomPlaceCellData *custPatMsgCell = [[TUCustomPlaceCellData alloc] initWithDirection:MsgDirectionOutgoing];
    custPatMsgCell.innerMessage = msgMM1;
    custPatMsgCell.isC2CChat = YES;
    custPatMsgCell.contentFont = SYS_Font(15);
    custPatMsgCell.contentColor = GrayText;
    if(isBBoo) {
        custPatMsgCell.content = eLocalizedString(@"my_about24");
    }else {
        custPatMsgCell.content = eLocalizedString(@"my_about25");
    }
    [self.o2ochat.messageController sendMessage:custPatMsgCell];
}

- (void)clickPatternMessageContent:(TUIMessageCell *)cell Type:(NSInteger)typeN
{
    
}

@end
