//
//  TUISearchViewController.m
//  Pods
//
//  Created by harvy on 2020/12/24.
//

#import "TUIDefine.h"
#import "TUISearchViewController.h"
#import "TUISearchBar.h"
#import "TUISearchResultHeaderFooterView.h"
#import "TUISearchResultCell.h"
#import "TUISearchResultCellModel.h"
#import "TUISearchResultListController.h"
#import "TUISearchDataProvider.h"
#import "TUICore.h"
#import "TUIBaseChatViewController.h"

@interface TUISearchViewController () <UITableViewDelegate, UITableViewDataSource, TUISearchBarDelegate, TUISearchResultDelegate>

@property (nonatomic, strong) TUISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TUISearchDataProvider *dataProvider;

@end

@implementation TUISearchViewController

static NSString * const Id = @"cell";
static NSString * const HFId = @"HFId";

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataProvider = [[TUISearchDataProvider alloc] init];
    _dataProvider.delegate = self;
    [self setupViews];
}

- (void)setupViews
{

    self.view.backgroundColor = UIColor.clearColor;//[UIColor groupTableViewBackgroundColor];
//    _searchBar = [[TUISearchBar alloc] initWithFrame:CGRectMake(0, 0, _window_width, 44)];
//    [_searchBar setEntrance:NO];
//    _searchBar.delegate = self;
//    [self.view addSubview:_searchBar];
    
//    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColor.clearColor;//TController_Background_Color;//[UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 60.f;
    [_tableView registerClass:TUISearchResultCell.class forCellReuseIdentifier:Id];
    [_tableView registerClass:TUISearchResultHeaderFooterView.class forHeaderFooterViewReuseIdentifier:HFId];
    self.tableView.sectionHeaderTopPadding = 0;
    [self.view addSubview:_tableView];
    
//    [_searchBar.searchBar becomeFirstResponder];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, _window_width, self.view.frame.size.height);//self.view.bounds;
//    self.searchBar.frame = CGRectMake(0, 0, _window_width, 44);//CGRectMake(0, 0, self.view.mm_w, 44);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = TController_Background_Color;//[UIColor groupTableViewBackgroundColor];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:TController_Background_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.backgroundColor = nil;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

#pragma mark - TUISearchResultDelegate
- (void)onSearchError:(NSString *)errMsg
{
    
}

- (void)onSearchResults:(NSDictionary<NSNumber *,NSArray<TUISearchResultCellModel *> *> *)results forModules:(TUISearchResultModule)modules
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource、TUITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataProvider.resultSet.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *results = [self resultForSection:section];
    return results.count > kMaxNumOfPerModule ? kMaxNumOfPerModule : results.count;
}

- (TUISearchResultCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TUISearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:Id forIndexPath:indexPath];
    TUISearchResultModule module = self.isHistoryBoo? TUISearchResultModuleAll:TUISearchResultModuleContact;
    NSArray *results = [self resultForSection:indexPath.section module:&module];
    if (results.count <= indexPath.row) {
        return cell;
    }
    [cell fillWithData:results[indexPath.row]];
    cell.backgroundColor = UIColor.clearColor;
    cell.contentView.backgroundColor = UIColor.clearColor;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TUISearchResultModule module = self.isHistoryBoo? TUISearchResultModuleAll:TUISearchResultModuleContact;
    NSArray *results = [self resultForSection:section module:&module];
    if (results.count < kMaxNumOfPerModule) {
        return [UIView new];
    }
    __weak typeof(self) weakSelf = self;
    TUISearchResultHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HFId];
    footerView.isFooter = YES;
    //隐藏  更多
//    footerView.title = titleForModule(module, NO);
//    footerView.onTap = ^{
//        [weakSelf onSelectMoreModule:module results:results];
//    };
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSArray *results = [self resultForSection:section];
    if (results.count < kMaxNumOfPerModule) {
        return 10;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TUISearchResultModule module = self.isHistoryBoo? TUISearchResultModuleAll:TUISearchResultModuleContact;
    [self resultForSection:section module:&module];
    TUISearchResultHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HFId];
    headerView.isFooter = NO;
    headerView.title = titleForModule(module, YES);
    headerView.onTap = nil;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [self.searchBar endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TUISearchResultModule module = self.isHistoryBoo? TUISearchResultModuleAll:TUISearchResultModuleContact;
    NSArray *results = [self resultForSection:indexPath.section module:&module];
    if (results.count <= indexPath.row) {
        return;
    }
    TUISearchResultCellModel *cellModel = results[indexPath.row];
    
    if(self.isHistoryBoo) {
        [self onSelectModel:cellModel module:module];
    }else {
        if (module == TUISearchResultModuleContact && [cellModel.context isKindOfClass:V2TIMFriendInfo.class]) {
            V2TIMFriendInfo *friend = cellModel.context;
            if(self.delegate_ && [self.delegate_ respondsToSelector:@selector(selectTUISearchViewCCLickModel:)]) {
                [self.delegate_ selectTUISearchViewCCLickModel:friend];
            }
        }
    }
    [self onSelectModel:cellModel module:module];
}

#pragma mark - action
//MARK:  点击cell跳转
- (void)onSelectModel:(TUISearchResultCellModel *)cellModel module:(TUISearchResultModule)module
{
    [self.searchBar endEditing:YES];
    
    // 聊天记录，需要确认跳转的逻辑
    if (module == TUISearchResultModuleChatHistory) {
        if (![cellModel.context isKindOfClass:NSDictionary.class]) {
            return;
        }
        NSDictionary *convInfo = cellModel.context;
        NSString *conversationId = convInfo[kSearchChatHistoryConversationId];
        V2TIMConversation *conversation = convInfo[kSearchChatHistoryConverationInfo];
        NSArray *msgs = convInfo[kSearchChatHistoryConversationMsgs];
        if (msgs.count == 1) {
            // 直接跳转到会话页面
            NSDictionary *param = @{TUICore_TUIChatService_GetChatViewControllerMethod_TitleKey : cellModel.title ?: @"",
                                    TUICore_TUIChatService_GetChatViewControllerMethod_UserIDKey : conversation.userID ?: @"",
                                    TUICore_TUIChatService_GetChatViewControllerMethod_GroupIDKey : conversation.groupID ?: @"",
                                    TUICore_TUIChatService_GetChatViewControllerMethod_HighlightKeywordKey : self.searchBar.searchBar.text ?: @"",
                                    TUICore_TUIChatService_GetChatViewControllerMethod_LocateMessageKey : msgs.firstObject,
            };
            TUIBaseChatViewController *chatVC = [TUICore callService:TUICore_TUIChatService
                                                     method:TUICore_TUIChatService_GetChatViewControllerMethod
                                                      param:param];
//            [chatVC setTitle:cellModel.title?:cellModel.titleAttributeString.string];
//            [self.navigationController pushViewController:chatVC animated:YES];
            if([self.delegate_ respondsToSelector:@selector(TUISearchViewCSelectRow:highlightKeyword:imgMMMessage:)]) {
                [self.delegate_ TUISearchViewCSelectRow:chatVC.conversationData highlightKeyword:chatVC.highlightKeyword imgMMMessage:chatVC.locateMessage];
            }
            return;
        }
        
        // 跳转到会话详细搜索页面
        NSMutableArray *results = [NSMutableArray array];
        for (V2TIMMessage *message in msgs) {
            TUISearchResultCellModel *model = [[TUISearchResultCellModel alloc] init];
            model.title = message.nickName?:message.sender;
            NSString *desc = [TUISearchDataProvider matchedTextForMessage:message withKey:self.searchBar.searchBar.text];
            model.detailsAttributeString = [TUISearchDataProvider attributeStringWithText:desc key:self.searchBar.searchBar.text];
            model.avatarUrl = message.faceURL;
            model.avatarImage = conversation.type == V2TIM_C2C ? DefaultAvatarImage : DefaultGroupAvatarImage;
            model.context = message;
            [results addObject:model];
        }
        TUISearchResultListController *vc = [[TUISearchResultListController alloc] initWithResults:results
                                                                                           keyword:self.searchBar.searchBar.text
                                                                                            module:module
                                                                                             param:@{TUISearchChatHistoryParamKeyConversationId:conversationId}];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    // 非聊天记录，跳转到具体的会话
    NSDictionary *param = nil;
    // 联系人
    if (module == TUISearchResultModuleContact && [cellModel.context isKindOfClass:V2TIMFriendInfo.class]) {
        V2TIMFriendInfo *friend = cellModel.context;
        param = @{TUICore_TUIChatService_GetChatViewControllerMethod_TitleKey : cellModel.title ?: @"",
                                TUICore_TUIChatService_GetChatViewControllerMethod_UserIDKey : friend.userID ?: @"",
        };
        if([self.delegate_ respondsToSelector:@selector(TUISearchViewCSelectGroupid:name:isBOO:)]) {
            [self.delegate_ TUISearchViewCSelectGroupid:friend.userID ?: @"" name:cellModel.title ?: @"" isBOO:NO];
        }
    }
    // 群组
    if (module == TUISearchResultModuleGroup && [cellModel.context isKindOfClass:V2TIMGroupInfo.class]) {
        V2TIMGroupInfo *group = cellModel.context;
        param = @{TUICore_TUIChatService_GetChatViewControllerMethod_TitleKey : cellModel.title ?: @"",
                                TUICore_TUIChatService_GetChatViewControllerMethod_GroupIDKey : group.groupID ?: @"",
        };
        
        if([self.delegate_ respondsToSelector:@selector(TUISearchViewCSelectGroupid:name:isBOO:)]) {
            [self.delegate_ TUISearchViewCSelectGroupid:group.groupID ?: @"" name:cellModel.title ?: @"" isBOO:YES];
        }
    }
//    TUIBaseChatViewController *chatVc = [TUICore callService:TUICore_TUIChatService method:TUICore_TUIChatService_GetChatViewControllerMethod param:param];
    
//    NSParameterAssert(chatVc);
//    [(UIViewController *)chatVc setTitle:cellModel.title?:cellModel.titleAttributeString.string];
//    [self.navigationController pushViewController:(UIViewController *)chatVc animated:YES];
    
    
}

// 点击查看更多跳转
- (void)onSelectMoreModule:(TUISearchResultModule)module results:(NSArray<TUISearchResultCellModel *> *)results
{
    TUISearchResultListController *vc = [[TUISearchResultListController alloc] initWithResults:results
                                                                                       keyword:self.searchBar.searchBar.text
                                                                                        module:module
                                                                                         param:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - viewmodel
// 根据section来确认模块的数据集
- (NSArray *)resultForSection:(NSInteger)section
{
    return [self resultForSection:section module:nil];
}

// 根据section来确认模块名称以及当前模块的数据集
- (NSArray *)resultForSection:(NSInteger)section module:(TUISearchResultModule *)module
{
    NSArray *keys = self.dataProvider.resultSet.allKeys;
    if (section >= keys.count) {
        return 0;
    }
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return  [obj1 intValue] < [obj2 intValue] ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    NSNumber *key = keys[section];
    if (module) {
        *module = (TUISearchResultModule)[key integerValue];
    }
    return [self.dataProvider.resultSet objectForKey:key];
}

#pragma mark - TUISearchBarDelegate
- (void)searchBarDidCancelClicked:(TUISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

//MARK: 搜索 (联系人、群组、聊天记录)
- (void)searchBar:(TUISearchBar *)searchBar searchText:(NSString *)key
{
    if(self.isHistoryBoo) {
        [self.dataProvider searchForKeyword:key forModules:TUISearchResultModuleAll param:nil];
    }else {
        [self.dataProvider searchForKeyword:key forModules:TUISearchResultModuleContact param:nil];
    }
    
}

- (void)addSearchTxtStr:(NSString *)str_str
{
    if(self.isHistoryBoo) {
        [self.dataProvider searchForKeyword:str_str forModules:TUISearchResultModuleAll param:nil];
    }else {
        [self.dataProvider searchForKeyword:str_str forModules:TUISearchResultModuleContact param:nil];
    }
}

//本函数实现了生成纯色背景的功能，从而配合 setBackgroundImage: forState: 来实现高亮时纯色按钮的点击反馈。
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
