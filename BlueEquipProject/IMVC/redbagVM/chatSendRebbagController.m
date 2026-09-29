//
//  chatSendRebbagController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/23.
//

#import "chatSendRebbagController.h"
#import "PopModifyView.h"
#import "myHomeSettingSubController.h"

@interface chatSendRebbagController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textFFF;
@property (nonatomic, strong) UITextField *textFFF2;
@property (nonatomic, strong) UITextField *textFFF3;
@property (nonatomic, strong) UILabel *jeLLab;
@property (nonatomic, strong) UILabel *oneTestLab;
@property (nonatomic, strong) UIImageView *jeLImgV;
@property (nonatomic, strong) UIView *oneUIUIV;
@property (nonatomic, assign) BOOL redPull_boo;
@end

@implementation chatSendRebbagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"redbag_open");
    self.navLine.hidden = YES;
    if(self.isC2CBoo) {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(12, NAVHEIGHT+24, _window_width-24, 58);
        [self.view addSubview:oneVV];
        
        UIView *oneVV2 = [HistoryRecordModel createViewUIUI];
        oneVV2.frame = CGRectMake(12, NAVHEIGHT+24+68, _window_width-24, 58);
        [self.view addSubview:oneVV2];
        
        UILabel *lab_lab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        lab_lab.text = eLocalizedString(@"chat_al32");
        [oneVV addSubview:lab_lab];
        [lab_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.centerY.equalTo(oneVV.mas_centerY);
        }];
        
        self.textFFF = [[UITextField alloc] init];
        self.textFFF.textColor = UIColor.blackColor;
        self.textFFF.font = SYS_Font(16);
        NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"chat_al33") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1),NSFontAttributeName:self.textFFF.font}];
        self.textFFF.attributedPlaceholder = attrString4;
        self.textFFF.delegate = self;
        self.textFFF.textAlignment = NSTextAlignmentRight;
        self.textFFF.keyboardType = UIKeyboardTypeNumberPad;
        [oneVV addSubview:self.textFFF];
        [self.textFFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneVV.mas_right).offset(-12);
            make.top.bottom.equalTo(oneVV);
            make.width.offset(_window_width/2);
        }];
        
        self.textFFF2 = [[UITextField alloc] init];
        self.textFFF2.textColor = GrayTextColor;
        self.textFFF2.font = SYS_Font(20);
        NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"chat_al30") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1),NSFontAttributeName:self.textFFF2.font}];
        self.textFFF2.attributedPlaceholder = attrString2;
        self.textFFF2.delegate = self;
        [oneVV2 addSubview:self.textFFF2];
        [self.textFFF2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV2.mas_left).offset(12);
            make.right.equalTo(oneVV2.mas_right).offset(-12);
            make.top.bottom.equalTo(oneVV2);
        }];
        
        UIView *moneyVV = [HistoryRecordModel createViewUIUI];
        moneyVV.backgroundColor = UIColor.clearColor;
        [self.view addSubview:moneyVV];
        [moneyVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(oneVV2.mas_bottom).offset(180);
            make.height.offset(60);
        }];
        
        UILabel *moneyLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:30 textAlignment:NSTextAlignmentCenter];
//        moneyLab.text = [LYUserDefault userDefault].balance;
        [moneyVV addSubview:moneyLab];
        [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(moneyVV);
        }];
        
        UIImageView *imMonyV = [HistoryRecordModel createImgImgView];
        imMonyV.image = [UIImage imageNamed:@"livingSignIn_img8"];
        [moneyVV addSubview:imMonyV];
        [imMonyV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(moneyLab.mas_right).offset(3);
            make.top.equalTo(moneyLab.mas_centerY);
            make.right.equalTo(moneyVV.mas_right);
            make.width.height.offset(20);
        }];
        
        UIButton *sendRebBtn = [HistoryRecordModel createImgBtn];
        sendRebBtn.layer.cornerRadius = 8;
        sendRebBtn.backgroundColor = RGB(253, 113, 111);
        [sendRebBtn setTitle:eLocalizedString(@"redbag_open") forState:UIControlStateNormal];
        [sendRebBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sendRebBtn.titleLabel.font = SYS_Font(18);
        [sendRebBtn addTarget:self action:@selector(sendRedbagMethdoUIUI) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sendRebBtn];
        [sendRebBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyVV.mas_bottom).offset(20);
            make.centerX.equalTo(moneyVV.mas_centerX);
            make.width.offset(200);
            make.height.offset(50);
        }];
    }else {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(12, NAVHEIGHT+24, _window_width-24, 58);
        [self.view addSubview:oneVV];
        self.oneUIUIV = oneVV;
        
        UIView *oneVV3 = [HistoryRecordModel createViewUIUI];
        oneVV3.frame = CGRectMake(12, CGRectGetMaxY(oneVV.frame)+30, _window_width-24, 58);
        [self.view addSubview:oneVV3];
        
        UIView *oneVV2 = [HistoryRecordModel createViewUIUI];
        oneVV2.frame = CGRectMake(12, CGRectGetMaxY(oneVV3.frame)+30, _window_width-24, 58);
        [self.view addSubview:oneVV2];
        
        self.jeLImgV = [HistoryRecordModel createImgImgView];
        self.jeLImgV.image = [UIImage imageNamed:@"pinRedbagImg1"];
        [oneVV addSubview:self.jeLImgV];
        [self.jeLImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.centerY.equalTo(oneVV.mas_centerY);
            make.width.height.offset(18);
        }];
        
        _jeLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        _jeLLab.text = eLocalizedString(@"chat_al34");
        [oneVV addSubview:_jeLLab];
        [_jeLLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(12);
            make.centerY.equalTo(oneVV.mas_centerY);
        }];
        self.jeLImgV.hidden = YES;
        
        self.textFFF = [[UITextField alloc] init];
        self.textFFF.textColor = UIColor.blackColor;
        self.textFFF.font = SYS_Font(16);
        NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"chat_al33") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1),NSFontAttributeName:self.textFFF.font}];
        self.textFFF.attributedPlaceholder = attrString4;
        self.textFFF.delegate = self;
        self.textFFF.textAlignment = NSTextAlignmentRight;
        self.textFFF.keyboardType = UIKeyboardTypeNumberPad;
        [oneVV addSubview:self.textFFF];
        [self.textFFF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneVV.mas_right).offset(-12);
            make.top.bottom.equalTo(oneVV);
            make.width.offset(_window_width/2);
        }];
        
        self.oneTestLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.view addSubview:self.oneTestLab];
        [self.oneTestLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(oneVV.mas_bottom);
            make.height.offset(30);
        }];
        self.oneTestLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"chat_al40") All:eLocalizedString(@"chat_al39") nameFont:SYS_Font(12) allFont:SYS_Font(12) nameColor:RGB(227, 172, 114) allColor:GrayText];
        UIButton *cliMMM = [[UIButton alloc] init];
        [cliMMM addTarget:self action:@selector(selectBtnMethodUI:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cliMMM];
        [cliMMM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(oneVV.mas_bottom);
            make.height.offset(30);
        }];
        
        UILabel *lab_lab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        lab_lab.text = eLocalizedString(@"chat_al57");
        [oneVV3 addSubview:lab_lab];
        [lab_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV3.mas_left).offset(12);
            make.centerY.equalTo(oneVV3.mas_centerY);
        }];
        
        self.textFFF3 = [[UITextField alloc] init];
        self.textFFF3.textColor = UIColor.blackColor;
        self.textFFF3.font = SYS_Font(16);
        NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"chat_al36") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1),NSFontAttributeName:self.textFFF3.font}];
        self.textFFF3.attributedPlaceholder = attrString3;
        self.textFFF3.delegate = self;
        self.textFFF3.textAlignment = NSTextAlignmentRight;
        self.textFFF3.keyboardType = UIKeyboardTypeNumberPad;
        [oneVV3 addSubview:self.textFFF3];
        [self.textFFF3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneVV3.mas_right).offset(-12);
            make.top.bottom.equalTo(oneVV3);
            make.width.offset(_window_width/2);
        }];
        
        
        self.textFFF2 = [[UITextField alloc] init];
        self.textFFF2.textColor = GrayTextColor;
        self.textFFF2.font = SYS_Font(20);
        NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"chat_al30") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1),NSFontAttributeName:self.textFFF2.font}];
        self.textFFF2.attributedPlaceholder = attrString2;
        self.textFFF2.delegate = self;
        [oneVV2 addSubview:self.textFFF2];
        [self.textFFF2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV2.mas_left).offset(12);
            make.right.equalTo(oneVV2.mas_right).offset(-12);
            make.top.bottom.equalTo(oneVV2);
        }];
        
        UIView *moneyVV = [HistoryRecordModel createViewUIUI];
        moneyVV.backgroundColor = UIColor.clearColor;
        [self.view addSubview:moneyVV];
        [moneyVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(oneVV2.mas_bottom).offset(80);
            make.height.offset(60);
        }];
        
        UILabel *moneyLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:30 textAlignment:NSTextAlignmentCenter];
//        moneyLab.text = [LYUserDefault userDefault].balance;
        [moneyVV addSubview:moneyLab];
        [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(moneyVV);
        }];
        
        UIImageView *imMonyV = [HistoryRecordModel createImgImgView];
        imMonyV.image = [UIImage imageNamed:@"livingSignIn_img8"];
        [moneyVV addSubview:imMonyV];
        [imMonyV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(moneyLab.mas_right).offset(3);
            make.top.equalTo(moneyLab.mas_centerY);
            make.right.equalTo(moneyVV.mas_right);
            make.width.height.offset(20);
        }];
        
        UIButton *sendRebBtn = [HistoryRecordModel createImgBtn];
        sendRebBtn.layer.cornerRadius = 8;
        sendRebBtn.backgroundColor = RGB(253, 113, 111);
        [sendRebBtn setTitle:eLocalizedString(@"redbag_open") forState:UIControlStateNormal];
        [sendRebBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sendRebBtn.titleLabel.font = SYS_Font(18);
        [sendRebBtn addTarget:self action:@selector(sendRedbagMethdoUIUI) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sendRebBtn];
        [sendRebBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyVV.mas_bottom).offset(20);
            make.centerX.equalTo(moneyVV.mas_centerX);
            make.width.offset(200);
            make.height.offset(50);
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]){
        [self.view endEditing:YES];
    }
    return YES;
}

- (void)selectBtnMethodUI:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(btn.selected == YES){
        
        self.jeLImgV.hidden = NO;
        [self.jeLLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneUIUIV.mas_left).offset(34);
        }];
        _jeLLab.text = eLocalizedString(@"chat_al35");
        self.oneTestLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"chat_al38") All:eLocalizedString(@"chat_al37") nameFont:SYS_Font(12) allFont:SYS_Font(12) nameColor:RGB(227, 172, 114) allColor:GrayText];
    }else {
        
        self.jeLImgV.hidden = YES;
        [self.jeLLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneUIUIV.mas_left).offset(12);
        }];
        _jeLLab.text = eLocalizedString(@"chat_al34");
        self.oneTestLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"chat_al40") All:eLocalizedString(@"chat_al39") nameFont:SYS_Font(12) allFont:SYS_Font(12) nameColor:RGB(227, 172, 114) allColor:GrayText];
    }
}

- (void)sendRedbagMethdoUIUI
{
    if(self.isC2CBoo) {
        
        if(self.textFFF.text.length > 0) {
            
            if ([LYUserDefault userDefault].is_defray_pass) {
                
                PopModifyView *modify = [[PopModifyView alloc]init];
                modify.titleString = eLocalizedString(@"my_topup_password");
                modify.isSingleCommit = YES;
                modify.textfield.keyboardType = UIKeyboardTypeNumberPad;
                modify.textfield.secureTextEntry = YES;
                modify.blockTextToModify = ^(NSString *name, NSString *phone) {

//                    if(self.redPull_boo) {
//                        return;
//                    }
//                    self.redPull_boo = YES;
//                    NSDictionary *dic = @{@"anchor_id":self.chatId, @"amount":minStr(self.textFFF.text), @"number":@"1", @"is_luck":@"0", @"type":@"2", @"password":minStr(name), @"remark":self.textFFF2.text.length>0?self.textFFF2.text:eLocalizedString(@"chat_al30")};
//                    [requestToolClass postNetworkWithUrl:request_Red_envelope_insert andParameter:dic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                        if(self.block_) {
//                            self.block_(@[@"1", minStr(info[@"id"]), self.textFFF2.text.length>0 ? self.textFFF2.text:eLocalizedString(@"chat_al30")]);
//                        }
//                        [self.navigationController popViewControllerAnimated:YES];
//                    } fail:^(NSString * _Nonnull msg) {
//                        self.redPull_boo = NO;
//                    }];
                };
                [modify show];
            }else {
                myHomeSettingSubController *vc = [[myHomeSettingSubController alloc] init];
                vc.typeN = payPasswordTypeN;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }else {
        if((self.textFFF.text.length > 0)&&(self.textFFF3.text.length > 0)) {
            
            if ([LYUserDefault userDefault].is_defray_pass) {
                
                PopModifyView *modify = [[PopModifyView alloc]init];
                modify.titleString = eLocalizedString(@"my_topup_password");
                modify.isSingleCommit = YES;
                modify.textfield.keyboardType = UIKeyboardTypeNumberPad;
                modify.textfield.secureTextEntry = YES;
                modify.blockTextToModify = ^(NSString *name, NSString *phone) {

//                    if(self.redPull_boo) {
//                        return;
//                    }
//                    self.redPull_boo = YES;
//                    NSDictionary *dic = @{@"anchor_id":self.chatId, @"amount":minStr(self.textFFF.text), @"number":minStr(self.textFFF3.text), @"is_luck":self.jeLImgV.hidden==YES?@"0":@"1", @"type":@"4", @"password":minStr(name), @"remark":self.textFFF2.text.length>0?self.textFFF2.text:eLocalizedString(@"chat_al30")};
//                    [requestToolClass postNetworkWithUrl:request_Red_envelope_insert andParameter:dic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                        
//                        if(self.block_) {
//                            self.block_(@[@"1", minStr(info[@"id"]), self.textFFF2.text.length>0 ? self.textFFF2.text:eLocalizedString(@"chat_al30")]);
//                        }
//                        [self.navigationController popViewControllerAnimated:YES];
//                    } fail:^(NSString * _Nonnull msg) {
//                        self.redPull_boo = NO;
//                    }];
                };
                [modify show];
            }else {
                myHomeSettingSubController *vc = [[myHomeSettingSubController alloc] init];
                vc.typeN = payPasswordTypeN;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }
}

@end
