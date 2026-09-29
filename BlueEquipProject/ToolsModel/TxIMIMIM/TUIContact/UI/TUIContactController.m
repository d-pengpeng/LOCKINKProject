//
//  TContactsController.m
//  TUIKit
//
//  Created by annidyfeng on 2019/3/25.
//  Copyright © 2019年 Tencent. All rights reserved.
//

#import "TUIContactController.h"
#import "TUIDefine.h"
#import "ReactiveObjC.h"
#import "TUIBlackListController.h"
#import "TUINewFriendViewController.h"
#import "TUIGroupConversationListController.h"
#import "TUIContactActionCell.h"


#define kContactCellReuseId @"ContactCellReuseId"
#define kContactActionCellReuseId @"ContactActionCellReuseId"

@interface TUIContactController () <UITableViewDelegate, UITableViewDataSource, V2TIMFriendshipListener>
@property NSArray<TUIContactActionCellData *> *firstGroupData;
@end

@implementation TUIContactController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *list = @[].mutableCopy;
    [list addObject:({
        TUIContactActionCellData *data = [[TUIContactActionCellData alloc] init];
        data.icon = [UIImage imageNamed:@"message_allImg2"];
        data.title = eLocalizedString(@"message_tile4");//TUIKitLocalizableString(TUIKitContactsNewFriends); // @"新的联系人";
        data.cselector = @selector(onAddNewFriend:);
        data;
    })];
//    [list addObject:({
//        TUIContactActionCellData *data = [[TUIContactActionCellData alloc] init];
//        data.icon = [UIImage imageNamed:TUIContactImagePath(@"public_group")];
//        data.title = TUIKitLocalizableString(TUIKitContactsGroupChats); // @"群聊";
//        data.cselector = @selector(onGroupConversation:);
//        data;
//    })];
    [list addObject:({
        TUIContactActionCellData *data = [[TUIContactActionCellData alloc] init];
        data.icon = [UIImage imageNamed:@"message_allImg3"];
        data.title =  eLocalizedString(@"message_tile5");//TUIKitLocalizableString(TUIKitContactsBlackList); // @"黑名单";
        data.cselector = @selector(onBlackList:);
        data;
    })];
    self.firstGroupData = [NSArray arrayWithArray:list];

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.frame = CGRectMake(0, 0, _window_width, _window_height);
    if(TARBARHEIGHT > 50) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-14-20-TARBARHEIGHT) style:UITableViewStylePlain];
    }else {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-14-38-TARBARHEIGHT) style:UITableViewStylePlain];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0);
    [_tableView setSectionIndexColor:[UIColor whiteColor]];
    [_tableView setBackgroundColor:self.view.backgroundColor];
    self.tableView.sectionHeaderTopPadding = 0;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = UIColor.clearColor;
    self.view.backgroundColor = UIColor.clearColor;
     
    //cell无数据时，不显示间隔线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:v];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0);
    [_tableView registerClass:[TUICommonContactCell class] forCellReuseIdentifier:kContactCellReuseId];
    [_tableView registerClass:[TUIContactActionCell class] forCellReuseIdentifier:kContactActionCellReuseId];
    
    [[V2TIMManager sharedInstance] addFriendListener:self];
    
    @weakify(self)
    [RACObserve(self.viewModel, isLoadFinished) subscribeNext:^(id finished) {
        @strongify(self)
        if ([(NSNumber *)finished boolValue]) {
            [self.tableView reloadData];
        }
    }];
    [RACObserve(self.viewModel, pendencyCnt) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        self.firstGroupData[0].readNum = [x integerValue];
        if([self.delelgte_ respondsToSelector:@selector(redNumUploadMehtod:)]) {
            [self.delelgte_ redNumUploadMehtod:[x integerValue]];
        }
    }];
}

- (void)uploadRedNumMehtod
{
    @weakify(self)
    [RACObserve(self.viewModel, pendencyCnt) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        self.firstGroupData[0].readNum = [x integerValue];
        if([self.delelgte_ respondsToSelector:@selector(redNumUploadMehtod:)]) {
            [self.delelgte_ redNumUploadMehtod:[x integerValue]];
        }
    }];
}

- (TUIContactViewDataProvider *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [TUIContactViewDataProvider new];
        [_viewModel loadContacts];
    }
    return _viewModel;
}

- (void)uploadUIUIUIUIMehtod
{
//    _tableView.frame = self.view.bounds;
    self.view.backgroundColor = UIColor.clearColor;
    _tableView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_tableView];
    
}

- (void)onFriendListChanged {
    [_viewModel loadContacts];
}

- (void)onFriendApplicationListChanged {
    [_viewModel loadFriendApplication];
}
#pragma mark - V2TIMFriendshipListener
- (void)onFriendApplicationListAdded:(NSArray<V2TIMFriendApplication *> *)applicationList {
    [self onFriendApplicationListChanged];
}

- (void)onFriendApplicationListDeleted:(NSArray *)userIDList {
    [self onFriendApplicationListChanged];
}

- (void)onFriendApplicationListRead {
    [self onFriendApplicationListChanged];
}

- (void)onFriendListAdded:(NSArray<V2TIMFriendInfo *>*)infoList {
    [self onFriendListChanged];
}

- (void)onFriendListDeleted:(NSArray*)userIDList {
    [self onFriendListChanged];
}

- (void)onFriendProfileChanged:(NSArray<V2TIMFriendInfo *> *)infoList {
    [self onFriendListChanged];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return self.viewModel.groupList.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstGroupData.count;
    } else {
        NSString *group = self.viewModel.groupList[section-1];
        NSArray *list = self.viewModel.dataDict[group];
        return list.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;

#define TEXT_TAG 1
    static NSString *headerViewId = @"ContactDrawerView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (!headerView)
    {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewId];
        headerView.backgroundColor = UIColor.clearColor;
        
        UIView *vvLL3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 33)];
        vvLL3.backgroundColor = UIColor.whiteColor;
        [headerView addSubview:vvLL3];
        
        UIView *vvLL = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 5)];
        vvLL.backgroundColor = RGB(243, 224, 251);//TController_Background_Color;
        [headerView addSubview:vvLL];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.tag = TEXT_TAG;
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.textColor = UIColor.blackColor;//RGB(0x80, 0x80, 0x80);
        [headerView addSubview:textLabel];
        textLabel.mm_fill().mm_left(12);
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    UILabel *label = [headerView viewWithTag:TEXT_TAG];
    label.text = self.viewModel.groupList[section-1];

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0;

    return 33;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray arrayWithObject:@""];
    [array addObjectsFromArray:self.viewModel.groupList];
    return array;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TUIContactActionCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactActionCellReuseId forIndexPath:indexPath];
        [cell fillWithData:self.firstGroupData[indexPath.row]];

        //可以在此处修改，也可以在对应cell的初始化中进行修改。用户可以灵活的根据自己的使用需求进行设置。
//        cell.changeColorWhenTouched = YES;
        cell.backgroundColor = UIColor.clearColor;
        cell.contentView.backgroundColor = UIColor.clearColor;
        return cell;
    } else {
        TUICommonContactCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactCellReuseId forIndexPath:indexPath];
        NSString *group = self.viewModel.groupList[indexPath.section-1];
        NSArray *list = self.viewModel.dataDict[group];
        TUICommonContactCellData *data = list[indexPath.row];
        data.cselector = @selector(onSelectFriend:);
        [cell fillWithData:data];

        //可以在此处修改，也可以在对应cell的初始化中进行修改。用户可以灵活的根据自己的使用需求进行设置。
        cell.changeColorWhenTouched = YES;
        cell.backgroundColor = UIColor.clearColor;
        cell.contentView.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark -
- (void)onSelectFriend:(TUICommonContactCell *)cell
{
    TUICommonContactCellData *model = cell.contactData;
    V2TIMFriendInfo *friendInf = model.friendProfile;
    
    NSString *nickK = friendInf.userFullInfo.nickName.length > 0 ? friendInf.userFullInfo.nickName:friendInf.userID;
    if(model.title.length>0) {
        nickK = model.title;
    }
    NSString *k_str = @"";
    NSString *faceUrlStr = @"";
    for (NSString *keySS in friendInf.friendCustomInfo.allKeys) {
        k_str = keySS;
    }
    if([k_str isEqualToString:@"Tag_SNS_Custom_avatarNew"]) {
        
        faceUrlStr = [[NSString alloc] initWithData:friendInf.friendCustomInfo[k_str] encoding:NSUTF8StringEncoding];
    }else {
        faceUrlStr = friendInf.userFullInfo.faceURL;
    }
    
    if([self.delelgte_ respondsToSelector:@selector(TUIContactCDelegateMethodType:friendName:faceUrl:userId:)]) {
        [self.delelgte_ TUIContactCDelegateMethodType:2 friendName:nickK faceUrl:faceUrlStr userId:friendInf.userID];
    }
}

- (void)onAddNewFriend:(TUICommonTableViewCell *)cell
{
    if([self.delelgte_ respondsToSelector:@selector(TUIContactCDelegateMethodType:friendName:faceUrl:userId:)]) {
        [self.delelgte_ TUIContactCDelegateMethodType:1 friendName:@"" faceUrl:@"" userId:@""];
    }
}

- (void)onGroupConversation:(TUICommonTableViewCell *)cell
{
    if([self.delelgte_ respondsToSelector:@selector(TUIContactCDelegateMethodType:friendName:faceUrl:userId:)]) {
        [self.delelgte_ TUIContactCDelegateMethodType:3 friendName:@"" faceUrl:@"" userId:@""];
    }
//    TUIGroupConversationListController *vc = TUIGroupConversationListController.new;
//    vc.title = TUIKitLocalizableString(TUIKitContactsGroupChats); // @"群聊";
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onBlackList:(TUICommonContactCell *)cell
{
    if([self.delelgte_ respondsToSelector:@selector(TUIContactCDelegateMethodType:friendName:faceUrl:userId:)]) {
        [self.delelgte_ TUIContactCDelegateMethodType:5 friendName:@"" faceUrl:@"" userId:@""];
    }
//    TUIBlackListController *vc = TUIBlackListController.new;
//    @weakify(self);
//    vc.didSelectCellBlock = ^(TUICommonContactCell * _Nonnull cell) {
//        @strongify(self);
//        [self onSelectFriend:cell];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addTUICommonContactCell:(TUICommonContactCell *)cell
{
    [self onSelectFriend:cell];
}

- (void)runSelector:(SEL)selector withObject:(id)object{
    if([self respondsToSelector:selector]){
        //因为 TCommonCell中写了 [vc performSelector:self.data.cselector withObject:self]，所以此处不管有无参数，和父类逻辑保持一致进行传参，防止意外情况
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, selector, object);
    }

}

@end
