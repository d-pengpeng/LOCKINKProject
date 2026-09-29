//
//  MHsettingPasswordController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/1.
//

#import "MHsettingPasswordController.h"

@interface MHsettingPasswordController ()<UITextFieldDelegate>
{
    NSTimer *messsageTimer;
    int messageIssssss;//短信倒计时  60s
}

@property (nonatomic, strong) UIButton *yzmBtn;
@property (nonatomic, assign) BOOL isBBB;
@end

@implementation MHsettingPasswordController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [messsageTimer invalidate];
    messsageTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.showImgVV = YES;
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    linVV.frame = CGRectMake(0, NAVHEIGHT-1, _window_width, 1);
    linVV.backgroundColor = RGB(121, 121, 121);
    [self.navView addSubview:linVV];
    self.titleName.text = eLocalizedString(@"my_settings");
    
    if(self.typeM == 1) {
        self.titleName.text = eLocalizedString(@"my_settings13");
        
        UILabel *accLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        accLab.frame = CGRectMake(12, NAVHEIGHT+3, _window_width-24, 46);
        accLab.text = eLocalizedString(@"my_settings15");
        [self.view addSubview:accLab];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(12, NAVHEIGHT+49, _window_width-24, 109);
        oneVV.backgroundColor = RGB(46, 54, 65);
        [self.view addSubview:oneVV];
        messageIssssss = 60;
        
        NSArray *arrLis = @[@"", eLocalizedString(@"my_settings14")];
        for (int i=0; i<arrLis.count; i++) {
            
            UIView *subVV = [[UIView alloc] initWithFrame:CGRectMake(0, i*55, oneVV.width, 54)];
            subVV.backgroundColor = UIColor.clearColor;
            [oneVV addSubview:subVV];
            if(i==0) {
                UILabel *subLLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                subLLL.frame = CGRectMake(12, 0, oneVV.width-24, subVV.height);
                subLLL.text = [LYUserDefault userDefault].emailAuccount;
                [subVV addSubview:subLLL];
            }else {
                UITextField *textCodeFF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, oneVV.width-110, subVV.height)];
                textCodeFF.textColor = UIColor.whiteColor;
                textCodeFF.font = SYS_Font(12);
                NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:arrLis[i] attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:textCodeFF.font}];
                textCodeFF.attributedPlaceholder = attrString3;
                textCodeFF.returnKeyType = UIReturnKeyDone;
                textCodeFF.delegate = self;
                textCodeFF.tag = 600+i;
                [subVV addSubview:textCodeFF];
                
                if(i==1) {
                    textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
                    
                    self.yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneVV.width-90, 15, 78, 24)];
                    [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
                    [self.yzmBtn setTitleColor:RGB(13, 223, 255) forState:UIControlStateNormal];
                    self.yzmBtn.titleLabel.font = SYS_Font(12);
                    self.yzmBtn.layer.borderColor = RGB(13, 223, 255).CGColor;
                    self.yzmBtn.layer.borderWidth = 1;
                    self.yzmBtn.layer.cornerRadius = 4;
                    [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
                    [subVV addSubview:self.yzmBtn];
                }
            }
            if(i==0) {
                UIView *linVV = [HistoryRecordModel createLineViewUIUI];
                linVV.frame = CGRectMake(0, 54, oneVV.width, 1);
                linVV.backgroundColor = RGB(121, 121, 121);
                [oneVV addSubview:linVV];
            }
        }
        
        UIView *twoVV = [HistoryRecordModel createViewUIUI];
        twoVV.backgroundColor = UIColor.clearColor;
        twoVV.layer.borderColor = UIColor.whiteColor.CGColor;
        twoVV.layer.borderWidth = 1;
        [self.view addSubview:twoVV];
        [twoVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(oneVV.mas_bottom).offset(20);
            make.height.mas_greaterThanOrEqualTo(200);
        }];
        
        UILabel *twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        twoLab.text = eLocalizedString(@"my_settings17");
        [twoVV addSubview:twoLab];
        [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoVV.mas_left).offset(12);
            make.top.equalTo(twoVV.mas_top).offset(12);
            make.right.equalTo(twoVV.mas_right).offset(-12);
            make.height.offset(20);
        }];
        
        UILabel *twoLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        twoLab2.text = eLocalizedString(@"my_settings18");
        twoLab2.numberOfLines = 0;
        [twoVV addSubview:twoLab2];
        [twoLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoVV.mas_left).offset(12);
            make.top.equalTo(twoLab.mas_bottom).offset(8);
            make.right.equalTo(twoVV.mas_right).offset(-12);
        }];
        
        UILabel *twoLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        twoLab3.text = eLocalizedString(@"my_settings19");
        twoLab3.numberOfLines = 0;
        [twoVV addSubview:twoLab3];
        [twoLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoVV.mas_left).offset(12);
            make.top.equalTo(twoLab2.mas_bottom).offset(6);
            make.right.equalTo(twoVV.mas_right).offset(-12);
        }];
        
        UILabel *twoLab4 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        twoLab4.text = eLocalizedString(@"my_settings20");
        twoLab4.numberOfLines = 0;
        [twoVV addSubview:twoLab4];
        [twoLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoVV.mas_left).offset(12);
            make.top.equalTo(twoLab3.mas_bottom).offset(6);
            make.right.equalTo(twoVV.mas_right).offset(-12);
            make.bottom.equalTo(twoVV.mas_bottom).offset(-12);
        }];
        
        UIButton *addPlayBtn2 = [HistoryRecordModel createImgBtn];
        addPlayBtn2.frame = CGRectMake(20, _window_height-TARBARHEIGHT-46, _window_width-40, 46);
        [addPlayBtn2 setBackgroundImage:[UIImage imageNamed:@"ModeImgs13"] forState:UIControlStateNormal];
        [addPlayBtn2 setTitle:eLocalizedString(@"my_settings16") forState:UIControlStateNormal];
        [addPlayBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        addPlayBtn2.titleLabel.font = SYS_Font(18);
        [addPlayBtn2 addTarget:self action:@selector(addPlayMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addPlayBtn2];
        
    }else {
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(12, NAVHEIGHT+15, _window_width-24, 220);
        oneVV.backgroundColor = RGB(46, 54, 65);
        [self.view addSubview:oneVV];
        messageIssssss = 60;
        
        NSArray *arrLis = @[@"", eLocalizedString(@"my_settings14"), eLocalizedString(@"login_all9"), eLocalizedString(@"login_all14")];
        for (int i=0; i<arrLis.count; i++) {
            
            UIView *subVV = [[UIView alloc] initWithFrame:CGRectMake(0, i*55, oneVV.width, 54)];
            subVV.backgroundColor = UIColor.clearColor;
            [oneVV addSubview:subVV];
            if(i==0) {
                UILabel *subLLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
                subLLL.frame = CGRectMake(12, 0, oneVV.width-24, subVV.height);
                subLLL.text = [LYUserDefault userDefault].emailAuccount;
                [subVV addSubview:subLLL];
            }else {
                UITextField *textCodeFF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, oneVV.width-110, subVV.height)];
                textCodeFF.textColor = UIColor.whiteColor;
                textCodeFF.font = SYS_Font(12);
                NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:arrLis[i] attributes:
                                                   @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:textCodeFF.font}];
                textCodeFF.attributedPlaceholder = attrString3;
                textCodeFF.returnKeyType = UIReturnKeyDone;
                textCodeFF.delegate = self;
                textCodeFF.tag = 600+i;
                [subVV addSubview:textCodeFF];
                
                if(i==1) {
                    textCodeFF.keyboardType= UIKeyboardTypeNumberPad;
                    
                    self.yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneVV.width-90, 15, 78, 24)];
                    [self.yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
                    [self.yzmBtn setTitleColor:RGB(13, 223, 255) forState:UIControlStateNormal];
                    self.yzmBtn.titleLabel.font = SYS_Font(12);
                    self.yzmBtn.layer.borderColor = RGB(13, 223, 255).CGColor;
                    self.yzmBtn.layer.borderWidth = 1;
                    self.yzmBtn.layer.cornerRadius = 4;
                    [self.yzmBtn addTarget:self action:@selector(codeRegistClick) forControlEvents:UIControlEventTouchUpInside];
                    [subVV addSubview:self.yzmBtn];
                }else {
                    textCodeFF.keyboardType= UIKeyboardTypePhonePad;
                }
            }
            if(i<3) {
                UIView *linVV = [HistoryRecordModel createLineViewUIUI];
                linVV.frame = CGRectMake(0, 54+i*55, oneVV.width, 1);
                linVV.backgroundColor = RGB(121, 121, 121);
                [oneVV addSubview:linVV];
            }
        }
        
        UIButton *addPlayBtn2 = [HistoryRecordModel createImgBtn];
        addPlayBtn2.frame = CGRectMake(20, 285+NAVHEIGHT, _window_width-40, 46);
        [addPlayBtn2 setBackgroundImage:[UIImage imageNamed:@"ModeImgs13"] forState:UIControlStateNormal];
        [addPlayBtn2 setTitle:eLocalizedString(@"home_done") forState:UIControlStateNormal];
        [addPlayBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        addPlayBtn2.titleLabel.font = SYS_Font(18);
        [addPlayBtn2 addTarget:self action:@selector(addPlayMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addPlayBtn2];
    }
}

- (void)addPlayMethodTwo
{
    if(self.typeM == 1) {
        
        NSString *msgLL = [NSString stringWithFormat:@"%@?", eLocalizedString(@"my_settings10")];
        [SGActionView showAlertWithTitle:nil message:msgLL leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
            if (index == 1) {
                UITextField *textCodeFF = [self.view viewWithTag:601];
                if(textCodeFF.text.length>0) {
//                    if(self.isBBB) {
//                        return;
//                    }
//                    self.isBBB = YES;
//                    [requestToolClass getNetworkWithUrl:request_user_logoutByEmail andParameter:@{@"code":minStr(textCodeFF.text)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                        [LYUserDefault clearLoginCache];
//                        [self.navigationController popViewControllerAnimated:YES];
//                    } fail:^(NSString * _Nonnull msg) {
//                        self.isBBB = NO;
//                    }];
                }
            }
        }];
    }else {
        UITextField *textCodeFF = [self.view viewWithTag:601];
        UITextField *textCodeFF2 = [self.view viewWithTag:602];
        UITextField *textCodeFF3 = [self.view viewWithTag:603];
        
        if((textCodeFF.text.length>0)&&(textCodeFF2.text.length>0)&&(textCodeFF3.text.length>0)) {
//            if(self.isBBB) {
//                return;
//            }
//            self.isBBB = YES;
//            [SVProgressHUD show];
//            NSDictionary *dicMM = @{@"email":[LYUserDefault userDefault].emailAuccount, @"code":textCodeFF.text, @"password":minStr(textCodeFF2.text), @"confirmPassword":minStr(textCodeFF3.text)};
//            [requestToolClass postNetworkWithUrl:request_user_retrievePasswordByEmail andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                self.isBBB = NO;
//                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
//                [self.navigationController popViewControllerAnimated:YES];
//            } fail:^(NSString * _Nonnull msg) {
//                self.isBBB = NO;
//                [SVProgressHUD showInfoWithStatus:msg];
//            }];
        }
    }
}

- (void)codeRegistClick
{
    if (messageIssssss > 58) {
        [self requestYZMcode];
    }
    if (messsageTimer == nil) {
        messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    }
}

//MARK: 获取验证码
- (void)requestYZMcode
{
//    NSString *phoneStr = [LYUserDefault userDefault].emailAuccount;
//    NSDictionary *dicdic = @{@"email":phoneStr, @"type":self.typeM == 1?@"3":@"2"};
//    [requestToolClass getNetworkWithUrl:request_user_getCode andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//        
//    } fail:^(NSString * _Nonnull msg) {
//        
//    }];
}

//获取验证码倒计时
-(void)daojishi{
    [_yzmBtn setTitle:[NSString stringWithFormat:@"%ds",messageIssssss] forState:UIControlStateNormal];
    _yzmBtn.userInteractionEnabled = NO;
    if (messageIssssss<=0) {
        [_yzmBtn setTitle:eLocalizedString(@"login_all5") forState:UIControlStateNormal];
        _yzmBtn.userInteractionEnabled = YES;
        [messsageTimer invalidate];
        messsageTimer = nil;
        messageIssssss = 60;
    }
    messageIssssss-=1;
}

@end
