//
//  mySearchAddViewController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/24.
//

#import "mySearchAddViewController.h"
#import "myConversationListCell.h"
//#import "expertRewardView.h"
#import "searchFriendAddModel.h"

@interface mySearchAddViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, myConversationListCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) NSMutableArray *friendListMut;
@property (nonatomic, strong) UISearchBar *searchVV;
@property (nonatomic, strong) UIView *placeLLab;
@property (nonatomic, strong) UITextField *input_textF;

@end

@implementation mySearchAddViewController

-(void)viewWillAppear:(BOOL)animated {
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
    self.redNavView = YES;
    self.titleName.text = eLocalizedString(@"message_tile12");
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:0];
    self.titleName.textColor = UIColor.blackColor;
    
    self.datasMut = [NSMutableArray array];
    self.friendListMut = [NSMutableArray array];
    
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+52, _window_width, _window_height-NAVHEIGHT-52) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
//    [self.appTableView registerClass:[myConversationListCell class] forCellReuseIdentifier:@"myConversationListCell"];
    [self.view addSubview:_appTableView];
    
    
    self.input_textF = [[UITextField alloc] initWithFrame:CGRectMake(12, NAVHEIGHT+10, _window_width-24, 32)];
    self.input_textF.backgroundColor = RGB(243, 224, 251);
    self.input_textF.layer.cornerRadius = 16;
    self.input_textF.font = SYS_Font(14);
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"msg_UIUIStr3") attributes: @{NSForegroundColorAttributeName:GrayText, NSFontAttributeName:self.input_textF.font}];
    self.input_textF.attributedPlaceholder = attrString4;
    self.input_textF.delegate = self;
    self.input_textF.textColor = UIColor.blackColor;
    self.input_textF.returnKeyType = UIReturnKeySearch;
    self.input_textF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.input_textF addTarget:self action:@selector(textFieldShouldChangeMethod:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.input_textF];
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 32)];
    leftV.backgroundColor = UIColor.clearColor;
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7, 18, 18)];
    leftIcon.image = [UIImage imageNamed:@"searchImgs_2"];
    [leftV addSubview:leftIcon];
    self.input_textF.leftView = leftV;
    self.input_textF.leftViewMode = UITextFieldViewModeAlways;
    
    
//    UIView *topVVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, 85)];
//    topVVV.backgroundColor = GroupBackColor;
//    [self.view addSubview:topVVV];
//
//    _searchVV = [[UISearchBar alloc] initWithFrame:CGRectMake(12, 2, _window_width-24, 36)];
//    _searchVV.backgroundColor = UIColor.whiteColor;
//    _searchVV.placeholder = eLocalizedString(@"searchID_addF");
//    _searchVV.backgroundImage = [UIImage new];
//    _searchVV.barTintColor = [UIColor whiteColor];
//    if (@available(iOS 13.0, *)) {
//        _searchVV.searchTextField.textColor = GrayTextColor;
//    } else {
//        // Fallback on earlier versions
//    }
//    _searchVV.showsCancelButton = NO;
//    _searchVV.delegate = self;
//    if (@available(iOS 13.0, *)) {
//        _searchVV.searchTextField.backgroundColor = [UIColor whiteColor];
//    }
//    [topVVV addSubview:_searchVV];
//
//    [_searchVV becomeFirstResponder];
//
//    UILabel *sear_lab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    sear_lab.text = eLocalizedString(@"searchID_ruselt");
//    [topVVV addSubview:sear_lab];
//    [sear_lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(topVVV.mas_left).offset(12);
//        make.top.equalTo(self.searchVV.mas_bottom).offset(20);
//    }];
    
//    self.placeLLab = [[UIView alloc] init];
//    self.placeLLab.clipsToBounds = YES;
//    self.placeLLab.layer.cornerRadius = 6;
//    self.placeLLab.layer.borderColor = RGB(169, 169, 169).CGColor;
//    self.placeLLab.layer.borderWidth = 1;
//    [self.view addSubview:self.placeLLab];
//    [self.placeLLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(12);
//        make.top.equalTo(self.navView.mas_bottom).offset(70);
//        make.right.equalTo(self.view.mas_right).offset(-12);
//    }];
//
//    NSArray *arrList = @[@"goodFriend_search1", @"goodFriend_search2", @"goodFriend_search3", @"goodFriend_search4", @"goodFriend_search5"];
//
//    UILabel *placeLab_one = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    placeLab_one.numberOfLines = 0;
//    placeLab_one.text = eLocalizedString(arrList[0]);
//    [self.placeLLab addSubview:placeLab_one];
//    [placeLab_one mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(30);
//        make.top.equalTo(self.placeLLab.mas_top).offset(10);
//        make.right.equalTo(self.placeLLab.mas_right).offset(-12);
//    }];
//    UIView *lin_one = [[UIView alloc] init];
//    lin_one.backgroundColor = normalColors;
//    lin_one.clipsToBounds = YES;
//    lin_one.layer.cornerRadius = 4;
//    [self.placeLLab addSubview:lin_one];
//    [lin_one mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(12);
//        make.top.equalTo(placeLab_one.mas_top).offset(5);
//        make.width.height.offset(8);
//    }];
//
//    UILabel *placeLab_one2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    placeLab_one2.numberOfLines = 0;
//    placeLab_one2.text = eLocalizedString(arrList[1]);
//    [self.placeLLab addSubview:placeLab_one2];
//    [placeLab_one2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(30);
//        make.top.equalTo(placeLab_one.mas_bottom).offset(10);
//        make.right.equalTo(self.placeLLab.mas_right).offset(-12);
//    }];
//    UIView *lin_one2 = [[UIView alloc] init];
//    lin_one2.backgroundColor = normalColors;
//    lin_one2.clipsToBounds = YES;
//    lin_one2.layer.cornerRadius = 4;
//    [self.placeLLab addSubview:lin_one2];
//    [lin_one2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(12);
//        make.top.equalTo(placeLab_one2.mas_top).offset(5);
//        make.width.height.offset(8);
//    }];
//
//    UILabel *placeLab_one3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    placeLab_one3.numberOfLines = 0;
//    placeLab_one3.text = eLocalizedString(arrList[2]);
//    [self.placeLLab addSubview:placeLab_one3];
//    [placeLab_one3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(30);
//        make.top.equalTo(placeLab_one2.mas_bottom).offset(10);
//        make.right.equalTo(self.placeLLab.mas_right).offset(-12);
//    }];
//    UIView *lin_one3 = [[UIView alloc] init];
//    lin_one3.backgroundColor = normalColors;
//    lin_one3.clipsToBounds = YES;
//    lin_one3.layer.cornerRadius = 4;
//    [self.placeLLab addSubview:lin_one3];
//    [lin_one3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(12);
//        make.top.equalTo(placeLab_one3.mas_top).offset(5);
//        make.width.height.offset(8);
//    }];
//
//    UILabel *placeLab_one4 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    placeLab_one4.numberOfLines = 0;
//    placeLab_one4.text = eLocalizedString(arrList[3]);
//    [self.placeLLab addSubview:placeLab_one4];
//    [placeLab_one4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(30);
//        make.top.equalTo(placeLab_one3.mas_bottom).offset(10);
//        make.right.equalTo(self.placeLLab.mas_right).offset(-12);
//    }];
//    UIView *lin_one4 = [[UIView alloc] init];
//    lin_one4.backgroundColor = normalColors;
//    lin_one4.clipsToBounds = YES;
//    lin_one4.layer.cornerRadius = 4;
//    [self.placeLLab addSubview:lin_one4];
//    [lin_one4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(12);
//        make.top.equalTo(placeLab_one4.mas_top).offset(5);
//        make.width.height.offset(8);
//    }];
//
//    UILabel *placeLab_one5 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    placeLab_one5.numberOfLines = 0;
//    placeLab_one5.text = eLocalizedString(arrList[4]);
//    [self.placeLLab addSubview:placeLab_one5];
//    [placeLab_one5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(30);
//        make.top.equalTo(placeLab_one4.mas_bottom).offset(10);
//        make.right.equalTo(self.placeLLab.mas_right).offset(-12);
//        make.bottom.equalTo(self.placeLLab.mas_bottom).offset(-10);
//    }];
//    UIView *lin_one5 = [[UIView alloc] init];
//    lin_one5.backgroundColor = normalColors;
//    lin_one5.clipsToBounds = YES;
//    lin_one5.layer.cornerRadius = 4;
//    [self.placeLLab addSubview:lin_one5];
//    [lin_one5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.placeLLab.mas_left).offset(12);
//        make.top.equalTo(placeLab_one5.mas_top).offset(5);
//        make.width.height.offset(8);
//    }];
    
    
    [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
            
        for (V2TIMFriendInfo *mode in infoList) {
            [self.friendListMut addObject:mode.userID];
        }
    } fail:^(int code, NSString *desc) {
        
    }];
    [self.input_textF becomeFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [SVProgressHUD show];
    NSString *key_url = [NSString stringWithFormat:@"%@?nickName=%@", request_user_userSearch, textField.text];
    [requestToolClass getNetworkWithUrl:key_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [self.datasMut removeAllObjects];
        NSArray *list_arr = info;
        if(list_arr.count > 0) {

            for (NSDictionary *dicM in list_arr) {
                if(![minStr(dicM[@"id"]) isEqualToString:[LYUserDefault userDefault].t_id]) {
                    searchFriendAddModel *model = [[searchFriendAddModel alloc] init];
                    model.userID = minStr(dicM[@"id"]);
                    model.nickName = minStr(dicM[@"nickName"]);
                    model.faceURL = minStr(dicM[@"handImg"]);
                    if([self.friendListMut containsObject:minStr(dicM[@"id"])]) {
                        model.isFriend = YES;
                    }
                    [self.datasMut addObject:model];
                }
            }
            self.placeLLab.hidden = YES;
        }else {
            [self.datasMut removeAllObjects];
            self.placeLLab.hidden = NO;
        }

        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        [self.datasMut removeAllObjects];
        self.placeLLab.hidden = NO;
        [self.appTableView reloadData];
    }];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [SVProgressHUD show];
    NSString *key_url = [NSString stringWithFormat:@"%@?nickName=%@", request_user_userSearch, searchBar.text];
    [requestToolClass getNetworkWithUrl:key_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSArray *list_arr = info;
        if(list_arr.count > 0) {
            
            for (NSDictionary *dicM in list_arr) {
                if(![minStr(dicM[@"id"]) isEqualToString:[LYUserDefault userDefault].t_id]) {
                    searchFriendAddModel *model = [[searchFriendAddModel alloc] init];
                    model.userID = minStr(dicM[@"id"]);
                    model.nickName = minStr(dicM[@"nickName"]);
                    model.faceURL = minStr(dicM[@"handImg"]);
                    if([self.friendListMut containsObject:minStr(dicM[@"id"])]) {
                        model.isFriend = YES;
                    }
                    [self.datasMut addObject:model];
                }
            }
            self.placeLLab.hidden = YES;
        }else {
            [self.datasMut removeAllObjects];
            self.placeLLab.hidden = NO;
        }
        
        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        [self.datasMut removeAllObjects];
        self.placeLLab.hidden = NO;
        [self.appTableView reloadData];
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
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
    myConversationListCell *cell = [myConversationListCell cellWithTabelView:tableView];
    [cell addmyHornAddFriendCellDic:self.datasMut[indexPath.row]];
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)myConversationListCellAddFriendUserId:(NSString *)user_idd
{
    V2TIMFriendAddApplication *application = [[V2TIMFriendAddApplication alloc] init];
    application.addWording = [LYUserDefault userDefault].user_nickname;
//  application.friendRemark = money;
    application.userID = user_idd;
    application.addSource = @"iOS";
    application.addType = V2TIM_FRIEND_TYPE_BOTH;

    [[V2TIMManager sharedInstance] addFriend:application succ:^(V2TIMFriendOperationResult *result) {

        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(int code, NSString *desc) {

    }];
}

@end
