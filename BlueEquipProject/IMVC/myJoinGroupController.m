//
//  myJoinGroupController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/10.
//

#import "myJoinGroupController.h"
#import "TUICommonModel.h"
@interface myJoinGroupController ()

@end

@implementation myJoinGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"contact_friend4");
    
    UIButton *addGroupBtn = [HistoryRecordModel createImgBtn];
    addGroupBtn.backgroundColor = RGB(227, 172, 114);
    addGroupBtn.layer.cornerRadius = 21;
    [addGroupBtn setTitle:eLocalizedString(@"contact_friend13") forState:UIControlStateNormal];
    addGroupBtn.titleLabel.font = SYS_Font(16);
    [addGroupBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [addGroupBtn addTarget:self action:@selector(addGroupMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addGroupBtn];
    [addGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TARBARHEIGHT);
        make.height.offset(42);
    }];
    
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(12, NAVHEIGHT+12, _window_width-24, 128);
    [self.view addSubview:oneVV];
    
    UIImageView *headImgV = [HistoryRecordModel createImgImgView];
    headImgV.frame = CGRectMake(12, 12, 46, 46);
    headImgV.layer.cornerRadius = 23;
    [oneVV addSubview:headImgV];
    
    UILabel *nickLab = [HistoryRecordModel createLabLabTextColor:RGB(0, 0, 0) fontFloat:14 textAlignment:NSTextAlignmentLeft];
    [oneVV addSubview:nickLab];
    [nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgV.mas_right).offset(12);
        make.centerY.equalTo(headImgV.mas_centerY);
        make.right.equalTo(oneVV.mas_right).offset(-12);
    }];
    
    UILabel *gongGLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    gongGLab.text = eLocalizedString(@"chat_al56");
    [oneVV addSubview:gongGLab];
    [gongGLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgV.mas_left);
        make.top.equalTo(headImgV.mas_bottom).offset(10);
        make.height.offset(27);
    }];
    
    UILabel *gGMsgLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentLeft];
    [oneVV addSubview:gGMsgLab];
    [gGMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgV.mas_left);
        make.top.equalTo(gongGLab.mas_bottom);
        make.right.equalTo(oneVV.mas_right).offset(-12);
        make.height.offset(24);
    }];
    
    [[V2TIMManager sharedInstance] getGroupsInfo:@[self.groupId] succ:^(NSArray<V2TIMGroupInfoResult *> *groupResultList) {
        if(groupResultList.count == 1){
            V2TIMGroupInfo *infoGG = groupResultList[0].info;
            if(infoGG.faceURL.length>0) {
                [headImgV sd_setImageWithURL:[NSURL URLWithString:infoGG.faceURL] placeholderImage:normal_placeHeadImg];
            }else {
                [TUIGroupAvatar getCacheGroupAvatar:self.groupId callback:^(UIImage *avatar) {
                    if (avatar != nil) { //已缓存群组头像
                        headImgV.image = avatar;
                    } else { //未缓存群组头像
                        [TUIGroupAvatar fetchGroupAvatars:self.groupId placeholder:normal_placeHeadImg callback:^(BOOL success, UIImage *image, NSString *groupID) {
                            if ([groupID isEqualToString:self.groupId]) {
                                // 需要判断下，防止复用问题
                                headImgV.image = image;
                            }
                        }];
                    }
                }];
            }
            nickLab.text = infoGG.groupName;
            gGMsgLab.text = infoGG.introduction;
        }
    } fail:^(int code, NSString *msg) {
        
    }];
    
    //二
    UIView *twoVV = [HistoryRecordModel createViewUIUI];
    twoVV.frame = CGRectMake(12, CGRectGetMaxY(oneVV.frame)+12, _window_width-24, 134);
    [self.view addSubview:twoVV];
    
    UILabel *twoNamLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    twoNamLab.text = eLocalizedString(@"chat_al58");
    [twoVV addSubview:twoNamLab];
    [twoNamLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoVV.mas_left).offset(12);
        make.top.equalTo(twoVV.mas_top);
        make.height.offset(44);
    }];
    
    UILabel *twoNamLab2 = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentRight];
    [twoVV addSubview:twoNamLab2];
    [twoNamLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(twoVV.mas_right).offset(-12);
        make.top.equalTo(twoVV.mas_top);
        make.height.offset(44);
    }];
    
    [[V2TIMManager sharedInstance] getGroupMemberList:self.groupId filter:V2TIM_GROUP_MEMBER_FILTER_ALL nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
        NSMutableArray *membersData = [NSMutableArray array];
        for (V2TIMGroupMemberFullInfo *fullInfo in memberList) {
            
            NSString *nam_st = @"";
            if (fullInfo.nameCard.length > 0) {
                nam_st = fullInfo.nameCard;
            } else if (fullInfo.friendRemark.length > 0) {
                nam_st = fullInfo.friendRemark;
            } else if (fullInfo.nickName.length > 0) {
                nam_st = fullInfo.nickName;
            }
            NSDictionary *memDic = @{@"avatar":fullInfo.faceURL, @"name":nam_st};
            [membersData addObject:memDic];
        }
        twoNamLab2.text = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"gong_1"), membersData.count, eLocalizedString(@"signIn_all25")];
        int allNum = membersData.count;
        if(allNum>5) {
            allNum = 5;
        }
        CGFloat w_ww = (_window_width-24)/5;
        for (int i=0; i<allNum; i++) {
            NSDictionary *dicSub = membersData[i];
            UIView *subAV = [HistoryRecordModel createViewUIUI];
            subAV.frame = CGRectMake(i*w_ww, 44, w_ww, 90);
            [twoVV addSubview:subAV];
            
            UIImageView *subHeadImg = [HistoryRecordModel createImgImgView];
            subHeadImg.layer.cornerRadius = 23;
            [subAV addSubview:subHeadImg];
            [subHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(subAV.mas_top);
                make.centerX.equalTo(subAV.mas_centerX);
                make.width.height.offset(46);
            }];
            [subHeadImg sd_setImageWithURL:[NSURL URLWithString:minStr(dicSub[@"avatar"])] placeholderImage:normal_placeHeadImg];
            
            UILabel *subLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
            subLab.text = minStr(dicSub[@"name"]);
            [subAV addSubview:subLab];
            [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(subHeadImg.mas_bottom);
                make.height.offset(40);
                make.left.equalTo(subAV.mas_left).offset(3);
                make.right.equalTo(subAV.mas_right).offset(-3);
            }];
        }
        
    } fail:^(int code, NSString *msg) {

    }];
    
    //三
    UIView *thrVV = [HistoryRecordModel createViewUIUI];
    thrVV.frame = CGRectMake(12, CGRectGetMaxY(twoVV.frame)+12, _window_width-24, 80);
    [self.view addSubview:thrVV];
    
    UILabel *thrNamLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    thrNamLab.text = eLocalizedString(@"contact_friend14");
    thrNamLab.numberOfLines = 0;
    [thrVV addSubview:thrNamLab];
    [thrNamLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thrVV.mas_left);
        make.centerY.equalTo(thrVV.mas_centerY);
        make.width.offset(66);
    }];
    
    UILabel *thrNamLab2 = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentCenter];
    thrNamLab2.numberOfLines = 0;
    [thrVV addSubview:thrNamLab2];
    [thrNamLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(thrVV.mas_right);
        make.centerY.equalTo(thrVV.mas_centerY);
        make.width.offset(74);
    }];
    
    [[V2TIMManager sharedInstance] getGroupMemberList:self.groupId filter:V2TIM_GROUP_MEMBER_FILTER_ADMIN nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
        NSMutableArray *membersData = [NSMutableArray array];
        for (V2TIMGroupMemberFullInfo *fullInfo in memberList) {
            
            NSString *nam_st = @"";
            if (fullInfo.nameCard.length > 0) {
                nam_st = fullInfo.nameCard;
            } else if (fullInfo.friendRemark.length > 0) {
                nam_st = fullInfo.friendRemark;
            } else if (fullInfo.nickName.length > 0) {
                nam_st = fullInfo.nickName;
            }
            [membersData addObject:minStr(fullInfo.faceURL)];
        }
        thrNamLab2.text = [NSString stringWithFormat:@"%@%lu%@", eLocalizedString(@"gong_1"), (unsigned long)membersData.count, eLocalizedString(@"signIn_all25")];
        int allNum = membersData.count;
        if(allNum>5) {
            allNum = 5;
        }
        for (int i=0; i<allNum; i++) {

            UIView *subAV = [HistoryRecordModel createViewUIUI];
            subAV.frame = CGRectMake(74+i*40, 25, 30, 30);
            [thrVV addSubview:subAV];
            
            UIImageView *subHeadImg = [HistoryRecordModel createImgImgView];
            subHeadImg.layer.cornerRadius = 23;
            [subAV addSubview:subHeadImg];
            [subHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(subAV.mas_top);
                make.centerX.equalTo(subAV.mas_centerX);
                make.width.height.offset(46);
            }];
            [subHeadImg sd_setImageWithURL:[NSURL URLWithString:minStr(membersData[i])] placeholderImage:normal_placeHeadImg];
        }
        
    } fail:^(int code, NSString *msg) {

    }];
}

- (void)addGroupMethod
{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.block_) {
        self.block_();
    }
}

@end
