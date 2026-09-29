//
//  receiveRedbagController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import "receiveRedbagController.h"
#import "receiveRedbagCell.h"
#import "receiveRedbagModel.h"
//#import "withdrawalMyDetialListController.h"

@interface receiveRedbagController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic,strong) NSMutableArray *datasMut;
@property (nonatomic, strong) UILabel *oneLLab;

@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) UIView *twoVV;
@property (nonatomic, strong) UILabel *moneyLab;
@end

@implementation receiveRedbagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.navLine.hidden = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIImageView *imgVV = [HistoryRecordModel createImgImgView];
    imgVV.frame = CGRectMake(0, 0, _window_width, NAVHEIGHT+42);
    imgVV.image = [UIImage imageNamed:@"redbagIMgs4"];
    [self.view addSubview:imgVV];
    [self.view addSubview:self.navView];
    
    UIImageView *headIMg = [HistoryRecordModel createImgImgView];
    headIMg.image = normal_placeHeadImg;
    headIMg.layer.cornerRadius = 40;
    [self.view addSubview:headIMg];
    [headIMg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgVV.mas_centerX);
        make.centerY.equalTo(imgVV.mas_bottom);
        make.width.height.offset(80);
    }];
    
    UILabel *namLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
    namLab.text = @"某某发的红包";
    [self.view addSubview:namLab];
    [namLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headIMg.mas_bottom).offset(8);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(30);
    }];
    
    UILabel *namLab2 = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentCenter];
    namLab2.text = @"恭喜发财，大吉大利";
    [self.view addSubview:namLab2];
    [namLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(namLab.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.offset(28);
    }];
    
    self.oneVV = [[UIView alloc] init];
    self.oneVV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.oneVV];
    [self.oneVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(namLab2.mas_bottom);
        make.height.offset(112);
    }];
    
    self.moneyLab = [HistoryRecordModel createLabLabTextColor:RGB(227, 172, 114) fontFloat:40 textAlignment:NSTextAlignmentCenter];
    self.moneyLab.text = @"0";
    [self.oneVV addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneVV.mas_top).offset(12);
        make.centerX.equalTo(self.oneVV.mas_centerX).offset(-3);
        make.height.offset(54);
    }];
    
    UILabel *danweiLab = [HistoryRecordModel createLabLabTextColor:RGB(227, 172, 114) fontFloat:14 textAlignment:NSTextAlignmentLeft];
    danweiLab.text = eLocalizedString(@"home_one");
    [self.oneVV addSubview:danweiLab];
    [danweiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLab.mas_right);
        make.bottom.equalTo(self.moneyLab.mas_bottom).offset(-8);
    }];
    
    UIButton *qianboBtn = [[UIButton alloc] init];
    [qianboBtn setTitle:eLocalizedString(@"chat_al43") forState:UIControlStateNormal];
    [qianboBtn setTitleColor:RGB(227, 172, 114) forState:UIControlStateNormal];
    qianboBtn.titleLabel.font = SYS_Font(14);
    [qianboBtn addTarget:self action:@selector(qianbaoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.oneVV addSubview:qianboBtn];
    [qianboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab.mas_bottom);
        make.centerX.equalTo(self.oneVV.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(100);
        make.height.offset(46);
    }];
    
    CGFloat h_hh = _window_height-(NAVHEIGHT+42+218+TARBARHEIGHT+60);
    self.twoVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+42+218, _window_width, h_hh)];
    self.twoVV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.twoVV];
    
    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, _window_width, h_hh-40) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 70;
    _appTableView.backgroundColor = UIColor.whiteColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[receiveRedbagCell class] forCellReuseIdentifier:@"receiveRedbagCell"];
    [self.twoVV addSubview:_appTableView];
    
    UIView *lineV = [HistoryRecordModel createLineViewUIUI];
    lineV.frame = CGRectMake(0, 0, _window_width, 7);
    [self.twoVV addSubview:lineV];
    
    self.oneLLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentLeft];
    self.oneLLab.frame = CGRectMake(12, 7, _window_width-24, 32);
    self.oneLLab.text = @"";
    [self.twoVV addSubview:self.oneLLab];
    
    UILabel *msgLLLL = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentCenter];
    msgLLLL.text = eLocalizedString(@"chat_al44");
    msgLLLL.numberOfLines = 0;
    [self.view addSubview:msgLLLL];
    [msgLLLL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TARBARHEIGHT);
    }];

    if(self.isRequesBoo) {
        
//        NSDictionary *dicdic = @{@"id":self.redId};
//        [requestToolClass postNetworkWithUrl:request_Redenvelope_getRedInfo andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//            
//            NSDictionary *dicMM = info;
//            [headIMg sd_setImageWithURL:[NSURL URLWithString:dicMM[@"avatar"]] placeholderImage:normal_placeHeadImg];
//            namLab.text = minStr(dicMM[@"user_nickname"]);
//            namLab2.text = self.remarkMsg.length>0 ? self.remarkMsg:eLocalizedString(@"chat_al30");
//            NSString *is_snatched = minStr(dicMM[@"is_snatched"]);
//            if([is_snatched intValue]==0) {
//                
//                UIView *msgVVV = [HistoryRecordModel createViewUIUI];
//                [self.oneVV addSubview:msgVVV];
//                [msgVVV mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(self.moneyLab.mas_top);
//                    make.centerX.equalTo(self.oneVV.mas_centerX);
//                    make.left.right.equalTo(self.oneVV);
//                    make.height.offset(100);
//                }];
//                UILabel *detailllLab = [HistoryRecordModel createLabLabTextColor:RGB(227, 172, 114) fontFloat:14 textAlignment:NSTextAlignmentLeft];
//                detailllLab.text = eLocalizedString(@"chat_al61");
//                [msgVVV addSubview:detailllLab];
//                [detailllLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.center.equalTo(msgVVV);
//                }];
//                
//            }else if([is_snatched intValue]==1) {
////                self.moneyLab.text = minStr(dicMM[@"receive_amount"]);
//                NSString *monsy = @"";
//                NSArray *arrList = dicMM[@"receive_list"];
//                for (NSDictionary *diMM in arrList) {
//                    receiveRedbagModel *model = [receiveRedbagModel mj_objectWithKeyValues:diMM];
//                    [self.datasMut addObject:model];
//                    if([minIntStr(model.uid) isEqualToString:[LYUserDefault userDefault].t_id]) {
//                        monsy = model.amount;
//                    }
//                }
//                
//                if([monsy floatValue]>0) {
//                    self.moneyLab.text = monsy;
//                }else {
//                    self.oneVV.hidden = YES;
//                    CGFloat h_hh = _window_height-(NAVHEIGHT+42+218+TARBARHEIGHT+60)+112;
//                    self.twoVV.frame = CGRectMake(0, NAVHEIGHT+42+218-112, _window_width, h_hh);
//                }
//                
//                [self.appTableView reloadData];
//                
//            }else {
//                UIView *msgVVV = [HistoryRecordModel createViewUIUI];
//                [self.oneVV addSubview:msgVVV];
//                [msgVVV mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(self.moneyLab.mas_top);
//                    make.centerX.equalTo(self.oneVV.mas_centerX);
//                    make.left.right.equalTo(self.oneVV);
//                    make.height.offset(100);
//                }];
//                UILabel *detailllLab = [HistoryRecordModel createLabLabTextColor:RGB(227, 172, 114) fontFloat:14 textAlignment:NSTextAlignmentLeft];
//                detailllLab.text = eLocalizedString(@"chat_al62");
//                [msgVVV addSubview:detailllLab];
//                [detailllLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.center.equalTo(msgVVV);
//                }];
//            }
//        } fail:^(NSString * _Nonnull msg) {
//            
//        }];
    }else {
        [headIMg sd_setImageWithURL:[NSURL URLWithString:self.allDD[@"avatar"]] placeholderImage:normal_placeHeadImg];
        namLab.text = minStr(self.allDD[@"user_nickname"]);
        namLab2.text = self.remarkMsg.length>0 ? self.remarkMsg:eLocalizedString(@"chat_al30");
        
        NSString *monsy = @"";
        NSArray *arrList = self.allDD[@"receive_list"];
        NSString *isLuck = minStr(self.allDD[@"is_luck"]);
        CGFloat neF = 0;
        int selNu = -1;
        
        for (int i=0; i<arrList.count; i++) {
            NSDictionary *diMM = arrList[i];
      
            receiveRedbagModel *model = [receiveRedbagModel mj_objectWithKeyValues:diMM];
            [self.datasMut addObject:model];
            if([minIntStr(model.uid) isEqualToString:[LYUserDefault userDefault].t_id]) {
                monsy = model.amount;
            }
            if([model.amount floatValue] >= neF) {
                neF = [model.amount floatValue];
                selNu = i;
            }
        }
        if(self.moneyStr.length>0) {
            self.moneyLab.text = self.moneyStr;
        }else {
            if([monsy floatValue]>0) {
                self.moneyLab.text = monsy;
            }else {
                self.oneVV.hidden = YES;
                CGFloat h_hh = _window_height-(NAVHEIGHT+42+218+TARBARHEIGHT+60)+112;
                self.twoVV.frame = CGRectMake(0, NAVHEIGHT+42+218-112, _window_width, h_hh);
            }
        }
        
        if(self.typeLL != 4) {
            NSString *is_snatched = minStr(self.allDD[@"is_snatched"]);
            if([is_snatched intValue]==0) {
                
                self.oneLLab.text = [NSString stringWithFormat:@"%@%@%@，%@%@%@", self.allDD[@"number"], eLocalizedString(@"home_one"), eLocalizedString(@"chat_all1"), eLocalizedString(@"chat_all1_1"), self.allDD[@"receive_num"], eLocalizedString(@"home_one")];
            }else if ([is_snatched intValue]==1) {
                
//                if([self.allDD[@"receive_time"] intValue] > 60) {
//
//                    int strLL = [self.allDD[@"receive_time"] intValue]/60+1;
//                    self.oneLLab.text = [NSString stringWithFormat:@"%@%@%@，%d%@", self.allDD[@"number"], eLocalizedString(@"home_one"), eLocalizedString(@"chat_all1"), strLL, eLocalizedString(@"chat_all1_3")];
//                }else {
                    self.oneLLab.text = [NSString stringWithFormat:@"%@%@%@，%@%@", self.allDD[@"number"], eLocalizedString(@"home_one"), eLocalizedString(@"chat_all1"), self.allDD[@"receive_time"], eLocalizedString(@"chat_all1_3")];
//                }
                if([isLuck boolValue]) {
                    receiveRedbagModel *model = self.datasMut[selNu];
                    model.isCrown = YES;
                    [self.datasMut replaceObjectAtIndex:selNu withObject:model];
                }
            }
        }
        
        [self.appTableView reloadData];
    }
}

- (void)qianbaoBtnMethod
{
//    UIViewController *selfVC = [[FloatingWindowModel shareInstance] getCurrentViewController];
//    withdrawalMyDetialListController *vc = [[withdrawalMyDetialListController alloc] init];
//    [selfVC.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasMut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    receiveRedbagCell *cell = [receiveRedbagCell cellWithTabelView:tableView];
    [cell addDataModel:self.datasMut[indexPath.row]];
    cell.backgroundColor = UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
