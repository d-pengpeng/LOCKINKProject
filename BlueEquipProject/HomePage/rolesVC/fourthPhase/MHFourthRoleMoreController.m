//
//  MHFourthRoleMoreController.m
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "MHFourthRoleMoreController.h"
#import "MHRoleMoreListController.h"
#import "MHRoleSetCoreLocatView.h"
#import "MHRoleFriendSelectController.h"
#import "MHRecordingAuthenticationController.h"
#import "c2cChatController.h"
#import "MHRankingPlaceView.h"

@interface MHFourthRoleMoreController ()
@property (nonatomic, strong) MHRoleSetCoreLocatView *roleSetCoreLocatV;
@property (nonatomic, copy) NSString *friendUid;
@property (nonatomic, copy) NSString *friendnick;
@end

@implementation MHFourthRoleMoreController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;

    self.titleName.text = eLocalizedString(@"home_more");
    [self.backBnt setImage:[UIImage imageNamed:@"fourth_backImg"] forState:0];
    
    UIImageView *oneImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    oneImgV.image = [UIImage imageNamed:@"fourth_backal_Img"];
    [self.view addSubview:oneImgV];
    [self.view addSubview:self.navView];
    
    self.friendUid = @"";
    self.friendnick = @"";
    
    if(self.isBooMM) {
        
        int rrr_sel = 0;
//        NSArray *tagArr = @[@"500", @"503"];
//        NSArray *arrM = @[@"role_setting16", @"role_setting19"];
//        if(!self.roleOneModel.matchingCompleted) {
//            arrM = @[@"role_setting25", @"role_setting19"];
//            tagArr = @[@"500", @"503"];
//        }
        
        NSArray *tagArr = @[@"500"];
        NSArray *arrM = @[@"role_setting16"];
        if(!self.roleOneModel.matchingCompleted) {
            arrM = @[@"role_setting25"];
        }
        
        for (int i=0; i<arrM.count; i++) {
            
            UIView *morVV = [[UIView alloc] init];
            morVV.backgroundColor = UIColor.clearColor;
            [self.view addSubview:morVV];
            
            if(i>rrr_sel) {
                morVV.frame = CGRectMake(0, NAVHEIGHT+10+i*49, _window_width, 49);
            }else {
                morVV.frame = CGRectMake(0, NAVHEIGHT+i*49, _window_width, 49);
            }
            
            UILabel *namLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            namLab.frame = CGRectMake(12, 0, _window_width-50, 49);
            namLab.text = eLocalizedString(arrM[i]);
            [morVV addSubview:namLab];
            
            UIImageView *nexIV = [HistoryRecordModel createImgImgView];
            nexIV.image = [UIImage imageNamed:@"home_next2_2"];
            [morVV addSubview:nexIV];
            [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(morVV.mas_right).offset(-12);
                make.centerY.equalTo(morVV.mas_centerY);
                make.width.height.offset(14);
            }];
            
            UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, _window_width, 40)];
            cliBBtn.tag = [minStr(tagArr[i]) intValue];
            [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
            [morVV addSubview:cliBBtn];
        }
        
    }else {
        
//        NSArray *arrM = @[@"role_setting30", @"role_setting31", @"role_setting25", @"role_setting26", @"role_setting36"];
//        NSArray *tagArr = @[@"504", @"505", @"506", @"507", @"510"];
        NSArray *arrM = @[@"role_setting30", @"role_setting31", @"role_setting25", @"role_setting26"];
        NSArray *tagArr = @[@"504", @"505", @"506", @"507"];

        for (int i=0; i<arrM.count; i++) {
            
            UIView *morVV = [[UIView alloc] init];
            morVV.backgroundColor = UIColor.clearColor;
            [self.view addSubview:morVV];
            
            if(i>1) {
                morVV.frame = CGRectMake(0, NAVHEIGHT+10+i*49, _window_width, 49);

                if (i==2) {
                    UIView *lin_hig = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+i*49, _window_width, 10)];
                    lin_hig.backgroundColor = RGBA(243, 224, 251, 0.4);
                    [self.view addSubview:lin_hig];
                }
                
            }else {
                morVV.frame = CGRectMake(0, NAVHEIGHT+i*49, _window_width, 49);
            }
            
            UILabel *namLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            namLab.frame = CGRectMake(12, 0, _window_width-50, 49);
            namLab.text = eLocalizedString(arrM[i]);
            [morVV addSubview:namLab];
            
            UIImageView *nexIV = [HistoryRecordModel createImgImgView];
            nexIV.image = [UIImage imageNamed:@"home_next2_2"];
            [morVV addSubview:nexIV];
            [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(morVV.mas_right).offset(-12);
                make.centerY.equalTo(morVV.mas_centerY);
                make.width.height.offset(14);
            }];
              
            if(i==0) {
                UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-52, 15, 40, 20)];
                cliBBtn.tag = [minStr(tagArr[i]) intValue];
                [cliBBtn setBackgroundImage:[UIImage imageNamed:@"switch_norlImg"] forState:UIControlStateNormal];
                [cliBBtn setBackgroundImage:[UIImage imageNamed:@"switch_selImg"] forState:UIControlStateSelected];
                [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
                [morVV addSubview:cliBBtn];
                cliBBtn.selected = self.roleOneModel.devicePublic;
            }else {
                if(i==1) {
                    UILabel *serNamLab = [HistoryRecordModel createLabLabTextColor:RGB(202, 76, 255) fontFloat:14 textAlignment:NSTextAlignmentRight];
                    serNamLab.frame = CGRectMake(100, 5, _window_width-136, 40);
                    serNamLab.text = self.roleOneModel.name;
                    serNamLab.tag = 600;
                    [morVV addSubview:serNamLab];
                }
                
                UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, _window_width, 40)];
                cliBBtn.tag = [minStr(tagArr[i]) intValue];
                [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
                [morVV addSubview:cliBBtn];
            }
        }
    }
    
}

- (void)clicListTagsMethod:(UIButton *)btn
{
    switch (btn.tag) {
        case 500:
        {
            //MARK: 佩戴者 解绑
            if(!self.roleOneModel.matchingCompleted) {

                MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:vc];
                [vc addDataToDic:11];
                vc.block_ = ^(BOOL isBBB) {
                    if(isBBB) {
                        [requestToolClass postNetworkWithUrl:request_device_unlink andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.macStrL];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            
                        }];
                        
                    }
                };
            }else {
                
                if(!self.roleOneModel.hardcoreModeEnabled) {
                    MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    vc.roleOneModel = self.roleOneModel;
                    [self.view addSubview:vc];
                    [vc addUIUIUIUMethodType:1];
                    vc.block_ = ^(NSArray * _Nonnull arrList) {
                        [requestToolClass getNetworkWithUrl:request_device_forceUnbind andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                            //                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.macStrL];
                            //                        [self.navigationController popToRootViewControllerAnimated:YES];
                            [self.navigationController popViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            
                        }];
                    };
                }else {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_10")];
                }
            }
        }
            break;
        case 501:
        {
            if(!self.roleOneModel.matchingCompleted) {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_1")];
                return;
            }
            //开启硬核模式
            if(!self.roleOneModel.hardcoreModeEnabled) {

                if(self.roleOneModel.allowOpenHardcoreMode) {
                    MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vc];
                    [vc addUIUIUIUMethodType:5];
                    vc.block_ = ^(NSArray * _Nonnull arrList) {
                        
                        [self recordingVoiceMethod];
                    };
                }else {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting58")];
                }
            }
        }
            break;
        case 502:
        {
//            if(!self.roleOneModel.matchingCompleted) {
//                return;
//            }
            MHRoleMoreListController *vc = [[MHRoleMoreListController alloc] init];
            vc.typeNN = 1;
            vc.roleOneModel = self.roleOneModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 503:
        {
//            if(!self.roleOneModel.matchingCompleted) {
//                return;
//            }
            MHRoleMoreListController *vc = [[MHRoleMoreListController alloc] init];
            vc.typeNN = 2;
            vc.roleOneModel = self.roleOneModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 504:
        {
            [requestToolClass getNetworkWithUrl:request_device_togglePublicityStatus andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                self.roleOneModel.devicePublic = !self.roleOneModel.devicePublic;
                btn.selected = !btn.selected;
                if(self.block_) {
                    self.block_();
                }
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
            break;
        case 505:
        {
            PopModifyView *modify = [[PopModifyView alloc]init];
            modify.titleString = eLocalizedString(@"role_setting31");
            modify.isSingleCommit = YES;
            modify.blockTextToModify = ^(NSString *name, NSString *phone) {
                
                [requestToolClass postNetworkWithUrl:request_device_updateDeviceName andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"name":name} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    self.roleOneModel.name = name;
                    UILabel *serNamLab = [self.view viewWithTag:600];
                    serNamLab.text = self.roleOneModel.name;
                    if(self.block_) {
                        self.block_();
                    }
                } fail:^(NSString * _Nonnull msg) {
                    
                }];
            };
            [modify show];
        }
            break;
        case 506:
        {
            //MARK: 主人 选择解绑
            if(!self.roleOneModel.matchingCompleted) {
                MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:vc];
                [vc addDataToDic:11];
                vc.block_ = ^(BOOL isBBB) {
                    if(isBBB) {
                        [requestToolClass postNetworkWithUrl:request_device_unlink andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.macStrL];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } fail:^(NSString * _Nonnull msg) {
                            
                        }];
                    }
                };
            }else {
                MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                [self.view addSubview:vc];
                [vc addUIUIUIUMethodType:3];
                vc.block_ = ^(NSArray * _Nonnull arrList) {
                    
                    [requestToolClass postNetworkWithUrl:request_device_unlink andParameter:@{@"deviceId":minIntStr(self.roleOneModel.id), @"role":minStr(arrList[0])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadBluoothNotifMMM" object:self.macStrL];
                        if([minStr(arrList[0]) isEqualToString:@"1"]) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }else {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    } fail:^(NSString * _Nonnull msg) {
                        
                    }];
                };
            }
        }
            break;
        case 507:
        {
            if(!self.roleOneModel.matchingCompleted) {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_1")];
                return;
            }
            [self.roleSetCoreLocatV removeFromSuperview];
            self.roleSetCoreLocatV = nil;
            
            self.roleSetCoreLocatV = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
            [self.view addSubview:self.roleSetCoreLocatV];
            [self.roleSetCoreLocatV addUIUIUIUMethodType:4];
            WEAKSELF
            self.roleSetCoreLocatV.twoBlock_ = ^(NSArray * _Nonnull arrList) {
                if(arrList.count == 2) {
                    
                    [weakSelf customTextUI];
                }else if (arrList.count == 3) {
                    
                    [weakSelf choosePeople];
                }else {
                    if(arrList.count > 0) {
                        if(self.friendUid.length > 0) {
                            [weakSelf requestMethodUIUI:arrList[0]];
                            weakSelf.roleSetCoreLocatV.hidden = YES;
                        }
                    }else {
                        weakSelf.roleSetCoreLocatV.hidden = YES;
                    }
                }
            };
        }
            break;
        case 508:
        {
            if(!self.roleOneModel.matchingCompleted) {
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"new_msg_1")];
                return;
            }
            //开启硬核模式
            if(!self.roleOneModel.hardcoreModeEnabled) {
                if(self.roleOneModel.allowOpenHardcoreMode) {
                    MHRoleSetCoreLocatView *vc = [[MHRoleSetCoreLocatView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    [self.view addSubview:vc];
                    [vc addUIUIUIUMethodType:5];
                    vc.block_ = ^(NSArray * _Nonnull arrList) {
                        
                        [self recordingVoiceMethod];
                    };
                }else {
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"role_setting58")];
                }
            }
        }
            break;
        case 509:
        {
//            if(!self.roleOneModel.matchingCompleted) {
//                return;
//            }
            MHRoleMoreListController *vc = [[MHRoleMoreListController alloc] init];
            vc.typeNN = 1;
            vc.roleOneModel = self.roleOneModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 510:
        {
//            if(!self.roleOneModel.matchingCompleted) {
//                return;
//            }
            MHRoleMoreListController *vc = [[MHRoleMoreListController alloc] init];
            vc.typeNN = 3;
            vc.roleOneModel = self.roleOneModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)customTextUI
{
    PopModifyView *modify = [[PopModifyView alloc]init];
    modify.titleString = eLocalizedString(@"role_setting26");
    modify.isSingleCommit = YES;
    modify.textfield.keyboardType = UIKeyboardTypeNumberPad;
    modify.blockTextToModify = ^(NSString *name, NSString *phone) {
        if([name intValue] > 0) {
            [self.roleSetCoreLocatV.customLab setTitle:name forState:UIControlStateNormal];
            [self.roleSetCoreLocatV customeUIUIUIU:name];
        }
    };
    [modify show];
}

- (void)choosePeople
{
    MHRoleFriendSelectController *vc = [[MHRoleFriendSelectController alloc] init];
    vc.isHeBoo = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^(NSString * _Nonnull userId, NSString * _Nonnull avatorStr, NSString * _Nonnull nickN) {
        UIImageView *avaImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        avaImgV.clipsToBounds = YES;
        avaImgV.layer.cornerRadius = 20;
        [self.roleSetCoreLocatV.avatorBtn addSubview:avaImgV];
        
        [avaImgV sd_setImageWithURL:[NSURL URLWithString:avatorStr] placeholderImage:normal_placeHeadImg];
        self.friendUid = userId;
        self.friendnick = nickN;
    };
}

- (void)requestMethodUIUI:(NSString *)dayStr
{
    c2cChatController *vc = [[c2cChatController alloc] init];
    vc.isTransferBo = YES;
    vc.chatId = self.friendUid;
    vc.showName = self.friendnick;
    vc.typeIdRec = @"5";
    vc.recordId = minIntStr(self.roleOneModel.id);
    vc.dayId = dayStr;
    [self.navigationController pushViewController:vc animated:YES];

}

//MARK: 录音认证
- (void)recordingVoiceMethod
{
    MHRecordingAuthenticationController *vc = [[MHRecordingAuthenticationController alloc] init];
    vc.roleOneModel = self.roleOneModel;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^{
        if (self.block_) {
            self.block_();
        }
    };
}

@end
