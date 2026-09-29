//
//  MHRoleFriendSelectController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "MHRoleFriendSelectController.h"
#import "MHRankingPlaceView.h"
#import "MHFriendChooseCell.h"
#import "MHFriendChooseModel.h"
#import "c2cChatController.h"

@interface MHRoleFriendSelectController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *friendListMut;
@property (nonatomic, strong) NSMutableArray *searchListMut;
@property (nonatomic, strong) UITextField *input_textF;
@property (nonatomic, assign) BOOL isSearchBB;
@property (nonatomic, assign) BOOL isRRRRR;
@end

@implementation MHRoleFriendSelectController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (NSMutableArray *)friendListMut
{
    if (!_friendListMut) {
        _friendListMut = [NSMutableArray array];
    }
    return _friendListMut;
}

- (NSMutableArray *)searchListMut
{
    if (!_searchListMut) {
        _searchListMut = [NSMutableArray array];
    }
    return _searchListMut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"role_name6");
    self.redNavView = NO;
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    UIView *linVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, 8)];
    linVV.backgroundColor = RGB(243, 224, 251);
    [self.view addSubview:linVV];
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+64, _window_width, _window_height-NAVHEIGHT-64-TARBARHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 70;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHFriendChooseCell class] forCellReuseIdentifier:@"MHFriendChooseCell"];
    [self.view addSubview:_appTableView];
    
    UILabel *mmmmrl = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:13 textAlignment:NSTextAlignmentCenter];
    mmmmrl.frame = CGRectMake(20, _window_height-TARBARHEIGHT, _window_width-40, 45);
    mmmmrl.text = eLocalizedString(@"msg_UIUIStr4");
    mmmmrl.numberOfLines = 0;
    [self.view addSubview:mmmmrl];
    
    self.input_textF = [[UITextField alloc] initWithFrame:CGRectMake(12, NAVHEIGHT+20, _window_width-24, 32)];
    self.input_textF.backgroundColor = RGB(243, 224, 251);
    self.input_textF.layer.cornerRadius = 16;
    self.input_textF.font = SYS_Font(14);
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"role_setting8") attributes: @{NSForegroundColorAttributeName:RGB(219, 169, 240), NSFontAttributeName:self.input_textF.font}];
    self.input_textF.attributedPlaceholder = attrString4;
    self.input_textF.delegate = self;
    self.input_textF.textColor = UIColor.blackColor;
    self.input_textF.returnKeyType = UIReturnKeySearch;
    [self.input_textF addTarget:self action:@selector(textFieldShouldChangeMethod:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.input_textF];
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 32)];
    leftV.backgroundColor = UIColor.clearColor;
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7, 18, 18)];
    leftIcon.image = [UIImage imageNamed:@"searchImgs_2"];
    [leftV addSubview:leftIcon];
    self.input_textF.leftView = leftV;
    self.input_textF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rigtV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 32)];
    rigtV.backgroundColor = UIColor.clearColor;
    UIButton *rigDelet = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [rigDelet setImage:[UIImage imageNamed:@"deleteImg_white"] forState:UIControlStateNormal];
    [rigDelet addTarget:self action:@selector(clearTextMMehtod) forControlEvents:UIControlEventTouchUpInside];
    [rigtV addSubview:rigDelet];
    self.input_textF.rightView = rigtV;
    self.input_textF.rightViewMode = UITextFieldViewModeAlways;
    
    
    [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
            
        for (V2TIMFriendInfo *mode in infoList) {
            MHFriendChooseModel *modelLL = [[MHFriendChooseModel alloc] init];
            modelLL.nickName = mode.friendRemark.length>0 ? mode.friendRemark : mode.userFullInfo.nickName;
            modelLL.userId = mode.userID;
            modelLL.faceURL = mode.userFullInfo.faceURL;
            [self.friendListMut addObject:modelLL];
        }
        [self.appTableView reloadData];
    } fail:^(int code, NSString *desc) {
        
    }];
    
}

- (void)clearTextMMehtod
{
    self.input_textF.text = @"";
    self.isSearchBB = NO;
    [self.appTableView reloadData];
}

- (void)textFieldShouldChangeMethod:(UITextField *)textField
{
    if(textField.text.length > 0) {
        self.isSearchBB = YES;
        [self.searchListMut removeAllObjects];
        
        for (MHFriendChooseModel *modelLL in self.friendListMut) {
            if([modelLL.nickName containsString:minStr(textField.text)]) {
                [self.searchListMut addObject:modelLL];
            }
        }
        [self.appTableView reloadData];
    }else {
        self.isSearchBB = NO;
        [self.appTableView reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isSearchBB) {
        return self.searchListMut.count;
    }else {
        return self.friendListMut.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHFriendChooseCell *cell = [MHFriendChooseCell cellWithTabelView:tableView];
    if(self.isSearchBB) {
        [cell addModelToDataModel:self.searchListMut[indexPath.row]];
    }else {
        [cell addModelToDataModel:self.friendListMut[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if(self.isHeBoo) {
        
        if(self.isSearchBB) {
            MHFriendChooseModel *modelLL = self.searchListMut[indexPath.row];
            if(self.block_) {
                self.block_(minStr(modelLL.userId), minStr(modelLL.faceURL), modelLL.nickName?modelLL.nickName:@"");
            }
        }else {
            MHFriendChooseModel *modelLL = self.friendListMut[indexPath.row];
            if(self.block_) {
                self.block_(minStr(modelLL.userId), minStr(modelLL.faceURL), modelLL.nickName?modelLL.nickName:@"");
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if(self.isRRRRR) {
            return;
        }
        self.isRRRRR = YES;
        if(self.isSearchBB) {
            
            MHFriendChooseModel *modelLL = self.searchListMut[indexPath.row];
            if (modelLL.nickName && modelLL.nickName.length>0) {
                [self twoBtnMethodName:modelLL.nickName userId:minStr(modelLL.userId)];
            }else {
                [self twoBtnMethodName:@"" userId:minStr(modelLL.userId)];
            }
            
        }else {
            MHFriendChooseModel *modelLL = self.friendListMut[indexPath.row];
            if (modelLL.nickName && modelLL.nickName.length>0) {
                [self twoBtnMethodName:modelLL.nickName userId:minStr(modelLL.userId)];
            }else {
                [self twoBtnMethodName:@"" userId:minStr(modelLL.userId)];
            }
        }

    }
}

- (void)twoBtnMethodName:(NSString *)nickN userId:(NSString *)userId
{
    MHRankingPlaceView *vc = [[MHRankingPlaceView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:vc];
    vc.nickNam = nickN;
    if([self.typeMM isEqualToString:@"6"]) {
        [vc addDataToDic:6];
    }else {
        [vc addDataToDic:7];
    }
    vc.block_ = ^(BOOL isBBB) {
        if(isBBB) {
            [self requestMethodType:userId Name:nickN];
        }else {
            self.isRRRRR = NO;
        }
    };
}

- (void)requestMethodType:(NSString *)userId Name:(NSString *)nickN
{
    [SVProgressHUD show];
    [requestToolClass postNetworkWithUrl:request_device_generateInvitationRecord andParameter:@{@"deviceId":self.deviceId, @"inviteeId":userId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.isRRRRR = NO;
//        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
//        [self.navigationController popViewControllerAnimated:YES];
        
        c2cChatController *vc = [[c2cChatController alloc] init];
        vc.chatId = userId;
        vc.showName = nickN;
        vc.typeIdRec = self.typeId;
        vc.recordId = minStr(info[@"recordId"]);
        [self.navigationController pushViewController:vc animated:YES];
    } fail:^(NSString * _Nonnull msg) {
        self.isRRRRR = NO;
    }];
}

@end
