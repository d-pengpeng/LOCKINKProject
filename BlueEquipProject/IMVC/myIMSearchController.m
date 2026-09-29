//
//  myIMSearchController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/28.
//

#import "myIMSearchController.h"
#import "myIMSearchCell.h"
#import "myContactListController.h"
#import "myGroupConversationListController.h"
#import "myIMSearchModel.h"
#import "myJoinGroupController.h"

@interface myIMSearchController ()<UITableViewDelegate, UITableViewDataSource, myIMSearchCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) BOOL isboo;
@property (nonatomic, assign) BOOL isDeleteboo;
@property (nonatomic,strong) UITextField *textfield_;
@property (nonatomic, strong) UILabel *namTwoLab;
@end

@implementation myIMSearchController

- (NSMutableArray *)datasMut
{
    if (!_datasMut) {
        _datasMut = [NSMutableArray array];
    }
    return _datasMut;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textfield_ = [[UITextField alloc]initWithFrame:CGRectMake(12, NAVHEIGHT+12, _window_width-24, 32)];
    _textfield_.backgroundColor = UIColor.whiteColor;
    _textfield_.layer.cornerRadius = 16;
    _textfield_.layer.masksToBounds = YES;
    _textfield_.leftViewMode = UITextFieldViewModeAlways;
//        _textfield_.rightViewMode = UITextFieldViewModeWhileEditing;
    _textfield_.rightViewMode = UITextFieldViewModeAlways;
    _textfield_.textAlignment = NSTextAlignmentLeft;
    _textfield_.font = SYS_Font(14);
    _textfield_.returnKeyType = UIReturnKeyDone;
    _textfield_.delegate = self;
    _textfield_.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_textfield_];
    UIView *lView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 32)];
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 8, 16, 16)];
    leftView.image = [UIImage imageNamed:@"live_search_search"];
    [lView addSubview:leftView];
    _textfield_.leftView = lView;
    
    UIButton *oneBtnUI = [[UIButton alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.textfield_.frame)+12, _window_width-24, 70)];
    oneBtnUI.layer.cornerRadius = 6;
    oneBtnUI.clipsToBounds = YES;
    oneBtnUI.backgroundColor = UIColor.whiteColor;
    [oneBtnUI addTarget:self action:@selector(oneBtnUIUIUMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneBtnUI];
    
    UIImageView *nextImg = [HistoryRecordModel createImgImgView];
    nextImg.image = [UIImage imageNamed:@"EventLiving_living_next"];
    [oneBtnUI addSubview:nextImg];
    [nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneBtnUI.mas_right).offset(-12);
        make.centerY.equalTo(oneBtnUI.mas_centerY);
        make.width.height.offset(18);
    }];
    
    UIImageView *nOneImg = [HistoryRecordModel createImgImgView];
    [oneBtnUI addSubview:nOneImg];
    [nOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneBtnUI.mas_left).offset(12);
        make.centerY.equalTo(oneBtnUI.mas_centerY);
        make.width.height.offset(42);
    }];
    
    UILabel *namOnLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    namOnLab.numberOfLines = 0;
    [oneBtnUI addSubview:namOnLab];
    [namOnLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nOneImg.mas_right).offset(8);
        make.centerY.equalTo(oneBtnUI.mas_centerY);
        make.right.equalTo(oneBtnUI.mas_right).offset(-40);
    }];
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(oneBtnUI.frame)+36, _window_width-24, _window_height-TARBARHEIGHT-CGRectGetMaxY(oneBtnUI.frame)-36) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.whiteColor;
    _appTableView.clipsToBounds = YES;
    _appTableView.layer.cornerRadius = 8;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[myIMSearchCell class] forCellReuseIdentifier:@"myIMSearchCell"];
    [self.view addSubview:_appTableView];
 
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneBtnUI.frame)+36, _window_width, _window_height-TARBARHEIGHT-CGRectGetMaxY(oneBtnUI.frame)-36)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
//    [self loadrefreshing];
    
    UIView *twoV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneBtnUI.frame), _window_width, 36)];
    twoV.backgroundColor = GroupBackColor;
    [self.view addSubview:twoV];
    _namTwoLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    _namTwoLab.text = eLocalizedString(@"contact_friend10");
    [twoV addSubview:_namTwoLab];
    [_namTwoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoV.mas_left).offset(12);
        make.top.equalTo(twoV.mas_top).offset(8);
        make.right.equalTo(twoV.mas_right).offset(-12);
        make.bottom.equalTo(twoV.mas_bottom);
    }];
    
    UIView *thrV = [[UIView alloc] initWithFrame:CGRectMake(0, _window_height-TARBARHEIGHT, _window_width, TARBARHEIGHT)];
    thrV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:thrV];
    UIButton *thrUploadB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, 49)];
    thrUploadB.backgroundColor = UIColor.whiteColor;
    [thrUploadB setTitle:eLocalizedString(@"contact_friend9") forState:UIControlStateNormal];
    [thrUploadB setTitleColor:RGB(227, 172, 114) forState:UIControlStateNormal];
    thrUploadB.titleLabel.font = SYS_Font(14);
    [thrUploadB setImage:[UIImage imageNamed:@"chat_imgs14"] forState:UIControlStateNormal];
    [thrUploadB layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleRight imageTitleSpace:3];
    [thrUploadB addTarget:self action:@selector(thrUpladBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [thrV addSubview:thrUploadB];
    
    if(self.isC2CBoo) {
        self.titleName.text = eLocalizedString(@"contact_friend3");
        
        NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"contact_friend8") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1), NSFontAttributeName:_textfield_.font}];
        _textfield_.attributedPlaceholder = attrString4;
        
        nOneImg.image = [UIImage imageNamed:@"message_imgs4"];
        namOnLab.text = eLocalizedString(@"contact_ttt");
        
    }else {
        self.titleName.text = eLocalizedString(@"contact_friend6");
        
        NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"contact_friend11") attributes:@{NSForegroundColorAttributeName:RGBA(169, 169, 169, 1), NSFontAttributeName:_textfield_.font}];
        _textfield_.attributedPlaceholder = attrString4;
        
        nOneImg.image = [UIImage imageNamed:@"chat_imgs15"];
        namOnLab.text = eLocalizedString(@"contact_friend12");
    }
    
    [self RequestListData];
}

- (void)thrUpladBtnMethod
{
    //刷新
    [self RequestListData];
}

- (void)oneBtnUIUIUMethod
{
    if(self.isC2CBoo) {
        myContactListController *vc = [[myContactListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        myGroupConversationListController *vc = [[myGroupConversationListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)RequestListData
{
//    _namTwoLab.hidden = _textfield_.text.length>0 ? YES:NO;
//    if(self.isboo) {
//        return;
//    }
//    self.isboo = YES;
//    [SVProgressHUD show];
//    NSDictionary *dicM = @{@"search":_textfield_.text.length>0 ? minStr(_textfield_.text):@""};
//    if(self.isDeleteboo) {
//        dicM = @{@"search":@""};
//    }
//    NSString *urlStr = request_group_getRecommendGroupList;
//    if(self.isC2CBoo) {
//        urlStr = request_group_getRecommendUserList;
//    }
//    [requestToolClass postNetworkWithUrl:urlStr andParameter:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//        [SVProgressHUD dismiss];
//        [self.datasMut removeAllObjects];
//        NSArray *arr_M = info;
//        for (NSDictionary *dicMM in arr_M) {
//            myIMSearchModel *model = [myIMSearchModel mj_objectWithKeyValues:dicMM];
//            [self.datasMut addObject:model];
//        }
//        self.noDataImgV.hidden = self.datasMut.count>0 ? YES:NO;
//        [self.appTableView reloadData];
//        self.isboo = NO;
//        self.isDeleteboo = NO;
//    } fail:^(NSString * _Nonnull msg) {
//        self.isboo = NO;
//        self.isDeleteboo = NO;
//    }];
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
    myIMSearchCell *cell = [myIMSearchCell cellWithTabelView:tableView];
    [cell addModelToDataMode:self.datasMut[indexPath.row] lisC2CBoo:self.isC2CBoo indexP:indexPath.row];
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myIMSearchModel *model = self.datasMut[indexPath.row];
    if(self.isC2CBoo) {
        
        [[FloatingWindowModel shareInstance] switchChatDetailControlNick:minStr(model.user_nickname) hostId:minIntStr(model.id)];
    }else {
        
        myJoinGroupController *vc = [[myJoinGroupController alloc] init];
        vc.groupId = model.groupid;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^{
          
            [[V2TIMManager sharedInstance] joinGroup:model.groupid msg:nil succ:^{
                
                [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:model.name hostId:model.groupid];
            }fail:^(int code, NSString *msg) {
                if(code == 10013) {
                    [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:model.name hostId:model.groupid];
                }else {
                    [SVProgressHUD showInfoWithStatus:msg];
                }
            }];
        };
    }
}

- (void)myIMSearchCellDDetgateNrwo:(NSInteger)rowN
{
//    myIMSearchModel *model = self.datasMut[rowN];
//    if(self.isC2CBoo) {
//
//        if(model.is_follow) {
////            if(switch_M2OrM3) {
//                [[FloatingWindowModel shareInstance] switchChatDetailControlNick:minStr(model.user_nickname) hostId:minIntStr(model.id)];
////            }
//        }else {
//
//            NSDictionary *dicdic = @{@"id":minIntStr(model.id)};
//            [requestToolClass postNetworkWithUrl:request_Member_attention andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//                model.is_follow = YES;
//                [self.appTableView reloadData];
//            } fail:^(NSString * _Nonnull msg) {
//
//            }];
//        }
//    }else {
//
//        myJoinGroupController *vc = [[myJoinGroupController alloc] init];
//        vc.groupId = model.groupid;
//        [self.navigationController pushViewController:vc animated:YES];
//        vc.block_ = ^{
//
//            [[V2TIMManager sharedInstance] joinGroup:model.groupid msg:nil succ:^{
//
//                [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:model.name hostId:model.groupid];
//            }fail:^(int code, NSString *msg) {
//                if(code == 10013) {
//                    [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:model.name hostId:model.groupid];
//                }else {
//                    [SVProgressHUD showInfoWithStatus:msg];
//                }
//            }];
//        };
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        [_textfield_ resignFirstResponder];
        [self RequestListData];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.isDeleteboo = YES;
    [self RequestListData];
    return YES;
}

@end
