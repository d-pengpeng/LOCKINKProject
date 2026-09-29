//
//  MHInviteIMFriendView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/20.
//

#import "MHInviteIMFriendView.h"

@implementation MHInviteIMFriendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
     
        self.backgroundColor = UIColor.clearColor;
        UIButton *deeletBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        deeletBB.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deeletBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deeletBB];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(self.width/2-140, self.height/2-145, 280, 285);
        oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:oneVV];
        
        UIImageView *bacImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 285)];
        bacImg.image = [UIImage imageNamed:@"age_sliderImg3"];
        [oneVV addSubview:bacImg];
        
        UIImageView *logImV = [HistoryRecordModel createImgImgView];
        logImV.frame = CGRectMake(121, 38, 38, 38);
        logImV.image = [UIImage imageNamed:@"role_imgs15"];
        [oneVV addSubview:logImV];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        self.oneLab.frame = CGRectMake(20, CGRectGetMaxY(logImV.frame)+10, 240, 26);
        [oneVV addSubview:self.oneLab];
        
        self.twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        self.twoLab.frame = CGRectMake(20, CGRectGetMaxY(self.oneLab.frame), 240, 26+10);
        self.twoLab.numberOfLines = 0;
        [oneVV addSubview:self.twoLab];
        
        self.thrLab = [HistoryRecordModel createLabLabTextColor:RGB(217, 217, 217) fontFloat:14 textAlignment:NSTextAlignmentCenter];
        self.thrLab.frame = CGRectMake(20, CGRectGetMaxY(self.twoLab.frame), 240, 26+10);
        self.thrLab.numberOfLines = 0;
        [oneVV addSubview:self.thrLab];
        
        self.lefBtn = [HistoryRecordModel createImgBtn];
        self.lefBtn.frame = CGRectMake(38, CGRectGetMaxY(self.thrLab.frame)+23-8, 92, 36);
        self.lefBtn.layer.borderColor = RGB(198, 164, 214).CGColor;
        self.lefBtn.layer.borderWidth = 1;
        self.lefBtn.layer.cornerRadius = 6;
        self.lefBtn.backgroundColor = UIColor.clearColor;
        [self.lefBtn setTitle:eLocalizedString(@"message_tile7") forState:UIControlStateNormal];
        [self.lefBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.lefBtn.titleLabel.font = SYS_Font(14);
        [self.lefBtn addTarget:self action:@selector(lefBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:self.lefBtn];
        
        self.rigBtn = [HistoryRecordModel createImgBtn];
        self.rigBtn.frame = CGRectMake(CGRectGetMaxX(self.lefBtn.frame)+20, CGRectGetMaxY(self.thrLab.frame)+23-8, 92, 36);
        self.rigBtn.layer.cornerRadius = 6;
        self.rigBtn.backgroundColor = RGB(138, 0, 197);
        [self.rigBtn setTitle:eLocalizedString(@"message_tile6") forState:UIControlStateNormal];
        [self.rigBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.rigBtn.titleLabel.font = SYS_Font(14);
        [self.rigBtn addTarget:self action:@selector(rigBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:self.rigBtn];
        
        UIButton *deleBBB = [HistoryRecordModel createImgBtn];
        deleBBB.frame = CGRectMake(oneVV.width-16-36, 16, 36, 36);
        [deleBBB setImage:[UIImage imageNamed:@"delete_img1"] forState:UIControlStateNormal];
        [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:deleBBB];
    }
    return self;
}

- (void)addUUIUTypeTwo:(BOOL)isBoo recordIId:(NSString *)id_id
{
    self.recordId = minStr(id_id);
    if(isBoo) {
        
        [requestToolClass getNetworkWithUrl:request_device_getPermissionTransferRecord andParameter:@{@"recordId":id_id} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            self.al_dic = info;
            self.oneLab.text = minStr(info[@"deviceName"]);
            if([self.dayid intValue] > 0) {
                if(self.tyyM == 1) {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@%@", self.dayid, eLocalizedString(@"role_name14"), eLocalizedString(@"chat_all23")];
                }else {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@%@", self.dayid, eLocalizedString(@"role_name14"), eLocalizedString(@"chat_all22")];
                }
            }else {
                if(self.tyyM == 1) {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting38"), eLocalizedString(@"chat_all23")];
                }else {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting38"), eLocalizedString(@"chat_all22")];
                }
            }
            
            if([minStr(info[@"status"]) intValue] == 1) {

                self.thrLab.text = eLocalizedString(@"role_setting15");
            }else if([minStr(info[@"status"]) intValue] == 2) {

                self.thrLab.text = @"";

                self.rigBtn.hidden = YES;
                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile8") forState:UIControlStateNormal];
            }else {

                self.thrLab.text = @"";
                self.rigBtn.hidden = YES;

                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile9") forState:UIControlStateNormal];
            }
        } fail:^(NSString * _Nonnull msg) {
 
        }];
    }else {
        [requestToolClass getNetworkWithUrl:request_device_getPermissionTransferRecord andParameter:@{@"recordId":id_id} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            self.al_dic = info;
            if([self.dayid intValue] > 0) {
                if(self.tyyM == 1) {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@%@", self.dayid, eLocalizedString(@"role_name14"), eLocalizedString(@"chat_all23")];
                }else {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@%@", self.dayid, eLocalizedString(@"role_name14"), eLocalizedString(@"chat_all22")];
                }
            }else {
                if(self.tyyM == 1) {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting38"), eLocalizedString(@"chat_all23")];
                }else {
                    self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting38"), eLocalizedString(@"chat_all22")];
                }
            }
            
            self.oneLab.text = minStr(info[@"deviceName"]);
         
            if([minStr(info[@"status"]) intValue] == 1) {

                self.thrLab.text = eLocalizedString(@"role_setting15");
                self.rigBtn.hidden = YES;
                self.lefBtn.hidden = YES;
            }else if([minStr(info[@"status"]) intValue] == 2) {

                self.thrLab.text = @"";

                self.rigBtn.hidden = YES;
                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile8") forState:UIControlStateNormal];
            }else {

                self.thrLab.text = @"";
                self.rigBtn.hidden = YES;

                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile9") forState:UIControlStateNormal];
            }
        } fail:^(NSString * _Nonnull msg) {
 
        }];
        
    }
}

- (void)addUUIUType:(BOOL)isBoo recordIId:(nonnull NSString *)id_id
{
    self.recordId = minStr(id_id);
    if(isBoo) {
        
        [requestToolClass getNetworkWithUrl:request_device_getInvitationRecord andParameter:@{@"recordId":id_id} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            self.al_dic = info;
            self.oneLab.text = minStr(info[@"deviceName"]);
            
            if([minStr(info[@"type"]) intValue] == 1) {
                self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting14"), eLocalizedString(@"my_about6_6L")];
            }else {
                self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting14"), eLocalizedString(@"my_about7_7L")];
            }
            
            if([minStr(info[@"status"]) intValue] == 1) {

                self.thrLab.text = eLocalizedString(@"role_setting15");
            }else if([minStr(info[@"status"]) intValue] == 2) {

                self.thrLab.text = @"";

                self.rigBtn.hidden = YES;
                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile8") forState:UIControlStateNormal];
            }else {

                self.thrLab.text = @"";
                self.rigBtn.hidden = YES;

                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile9") forState:UIControlStateNormal];
            }
        } fail:^(NSString * _Nonnull msg) {
 
        }];
    }else {
        [requestToolClass getNetworkWithUrl:request_device_getInvitationRecord andParameter:@{@"recordId":id_id} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            self.al_dic = info;
            self.oneLab.text = minStr(info[@"deviceName"]);
            if([minStr(info[@"type"]) intValue] == 1) {
                self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting14"), eLocalizedString(@"my_about6_6L")];
            }else {
                self.twoLab.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"role_setting14"), eLocalizedString(@"my_about7_7L")];
            }
            if([minStr(info[@"status"]) intValue] == 1) {

                self.thrLab.text = eLocalizedString(@"role_setting15");
                self.rigBtn.hidden = YES;
                self.lefBtn.hidden = YES;
            }else if([minStr(info[@"status"]) intValue] == 2) {

                self.thrLab.text = @"";

                self.rigBtn.hidden = YES;
                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile8") forState:UIControlStateNormal];
            }else {

                self.thrLab.text = @"";
                self.rigBtn.hidden = YES;

                self.lefBtn.x = 94;
                self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
                self.lefBtn.userInteractionEnabled = NO;
                [self.lefBtn setTitle:eLocalizedString(@"message_tile9") forState:UIControlStateNormal];
            }
        } fail:^(NSString * _Nonnull msg) {
 
        }];
        
    }
}

- (void)lefBtnMethod
{
    if(self.isRRRR) {
        return;
    }
    self.isRRRR = YES;
    if(self.isZhuanYiBo) {
        [requestToolClass postNetworkWithUrl:request_device_acceptOrDeclinePermissionTransfer andParameter:@{@"recordId":self.recordId, @"accepted":@"false"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.thrLab.text = @"";
            self.lefBtn.x = 94;
            self.rigBtn.hidden = YES;
            self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
            self.lefBtn.userInteractionEnabled = NO;
            [self.lefBtn setTitle:eLocalizedString(@"message_tile9") forState:UIControlStateNormal];
            self.isRRRR = NO;
            if(self.block_) {
                self.block_(NO, self.al_dic);
            }
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRR = NO;
        }];
    }else {
        [requestToolClass postNetworkWithUrl:request_device_acceptOrDeclineInvitation andParameter:@{@"recordId":self.recordId, @"accepted":@"false"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.thrLab.text = @"";
            self.lefBtn.x = 94;
            self.rigBtn.hidden = YES;
            self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
            self.lefBtn.userInteractionEnabled = NO;
            [self.lefBtn setTitle:eLocalizedString(@"message_tile9") forState:UIControlStateNormal];
            self.isRRRR = NO;
            if(self.block_) {
                self.block_(NO, self.al_dic);
            }
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRR = NO;
        }];
    }
}

- (void)rigBtnMethod
{
    if(self.isRRRR) {
        return;
    }
    self.isRRRR = YES;
    if(self.isZhuanYiBo) {
        [requestToolClass postNetworkWithUrl:request_device_acceptOrDeclinePermissionTransfer andParameter:@{@"recordId":self.recordId, @"accepted":@"true"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.thrLab.text = @"";
            self.lefBtn.x = 94;
            self.rigBtn.hidden = YES;
            self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
            self.lefBtn.userInteractionEnabled = NO;
            [self.lefBtn setTitle:eLocalizedString(@"message_tile8") forState:UIControlStateNormal];
            self.isRRRR = NO;
            if(self.block_) {
                self.block_(NO, self.al_dic);
            }
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRR = NO;
        }];
    }else {
        [requestToolClass postNetworkWithUrl:request_device_acceptOrDeclineInvitation andParameter:@{@"recordId":self.recordId, @"accepted":@"true"} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.thrLab.text = @"";
            self.lefBtn.x = 94;
            self.rigBtn.hidden = YES;
            self.lefBtn.layer.borderColor = UIColor.clearColor.CGColor;
            self.lefBtn.userInteractionEnabled = NO;
            [self.lefBtn setTitle:eLocalizedString(@"message_tile8") forState:UIControlStateNormal];
            
            self.isRRRR = NO;
            if(self.block_) {
                self.block_(YES, self.al_dic);
            }
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRR = NO;
        }];
    }
}

- (void)deleBtnMethod
{
    [self removeFromSuperview];
}

@end
