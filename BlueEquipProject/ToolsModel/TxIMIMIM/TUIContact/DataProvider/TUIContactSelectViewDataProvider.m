//
//  TContactSelectViewModel.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/8.
//

#import "TUIContactSelectViewDataProvider.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"
#import "TUICommonModel.h"
#import "NSString+TUIUtil.h"
#import "TUIGroupMemberCellData.h"

@interface TUIContactSelectViewDataProvider()
@property NSDictionary<NSString *, NSArray<TUICommonContactSelectCellData *> *> *dataDict;
@property NSArray *groupList;
@property BOOL isLoadFinished;
@end

@implementation TUIContactSelectViewDataProvider

- (void)loadContacts
{
    self.isLoadFinished = NO;
    if(self.isGroupBoo) {
        
        if(self.typeGroup > 1) {
            
            [self fillTwoNewList:self.groupArr];
            
        }else {
//            @weakify(self)
//            [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
//                @strongify(self)
//                NSMutableArray *arr = [NSMutableArray new];
//                for (V2TIMFriendInfo *fr in infoList) {
//                    if(self.typeGroup == 1) {
//
//                        if(![self.groupArr containsObject:fr.userID]) {
//                            [arr addObject:fr.userFullInfo];
//                        }
//                    }else {
//                        if([self.groupArr containsObject:fr.userID]) {
//                            [arr addObject:fr.userFullInfo];
//                        }
//                    }
//                }
//                [self fillList:arr];
//            } fail:nil];
//            @weakify(self)
//            [requestToolClass postNetworkWithUrl:request_group_addressBook andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
////                @strongify(self)
//                if([info isKindOfClass:[NSArray class]]) {
//                    NSMutableArray *arr = [NSMutableArray new];
//
//                    NSArray *infoList = info;
//                    for (NSDictionary *dicFF in infoList) {
//                        if(self.typeGroup == 1) {
//                            if(![self.groupArr containsObject:minStr(dicFF[@"id"])]) {
//                                [arr addObject:dicFF];
//                            }
//                        }else {
//                            if([self.groupArr containsObject:minStr(dicFF[@"id"])]) {
//                                [arr addObject:dicFF];
//                            }
//                        }
//                    }
//                    [self fillNewAlList:arr];
//                }
//            } fail:^(NSString * _Nonnull msg) {
//
//            }];
        }
    }else {
//        @weakify(self)
//        [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
//            @strongify(self)
//            NSMutableArray *arr = [NSMutableArray new];
//            for (V2TIMFriendInfo *fr in infoList) {
//
//                [arr addObject:fr.userFullInfo];
//            }
//            [self fillList:arr];
//        } fail:nil];
        
//        @weakify(self)
//        [requestToolClass postNetworkWithUrl:request_group_addressBook andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
////            @strongify(self)
//            if([info isKindOfClass:[NSArray class]]) {
//
//                NSArray *infoList = info;
//                [self fillNewAlList:infoList];
//            }
//        } fail:^(NSString * _Nonnull msg) {
//
//        }];
    }
}

- (void)fillNewAlList:(NSArray *)profiles
{
    NSMutableDictionary *dataDict = @{}.mutableCopy;
    NSMutableArray *groupList = @[].mutableCopy;
    NSMutableArray *nonameList = @[].mutableCopy;

    for (NSDictionary *profile in profiles) {
        TUICommonContactSelectCellData *data = [TUICommonContactSelectCellData new];
        data.title = minStr(profile[@"user_nickname"]);
//        if (profile.faceURL.length) {
            data.avatarUrl = [NSURL URLWithString:minStr(profile[@"avatar"])];
//        }
        data.identifier = minStr(profile[@"id"]);

        if (self.avaliableFilter && !self.avaliableFilter(data)) {
            continue;
        }
        if (self.disableFilter) {
            data.enabled = !self.disableFilter(data);
        }

        NSString *group = [[data.title firstPinYin] uppercaseString];
        if (group.length == 0 || !isalpha([group characterAtIndex:0])) {
            [nonameList addObject:data];
            continue;
        }
        NSMutableArray *list = [dataDict objectForKey:group];
        if (!list) {
            list = @[].mutableCopy;
            dataDict[group] = list;
            [groupList addObject:group];
        }
        [list addObject:data];
    }

    [groupList sortUsingSelector:@selector(localizedStandardCompare:)];
    if (nonameList.count) {
        [groupList addObject:@"#"];
        dataDict[@"#"] = nonameList;
    }
    for (NSMutableArray *list in [self.dataDict allValues]) {
        [list sortUsingSelector:@selector(compare:)];
    }

    self.groupList = groupList;
    self.dataDict = dataDict;
    self.isLoadFinished = YES;
}

- (void)setSourceIds:(NSArray<NSString *> *)ids
{
    if(!self.isGroupBoo) {
        [[V2TIMManager sharedInstance] getUsersInfo:ids succ:^(NSArray<V2TIMUserFullInfo *> *infoList) {
            [self fillList:infoList];
        } fail:nil];
    }
}
    
- (void)fillList:(NSArray<V2TIMUserFullInfo *> *)profiles
{
    NSMutableDictionary *dataDict = @{}.mutableCopy;
    NSMutableArray *groupList = @[].mutableCopy;
    NSMutableArray *nonameList = @[].mutableCopy;

    for (V2TIMUserFullInfo *profile in profiles) {
        TUICommonContactSelectCellData *data = [TUICommonContactSelectCellData new];
        data.title = [profile showName];
        if (profile.faceURL.length) {
            data.avatarUrl = [NSURL URLWithString:profile.faceURL];
        }
        data.identifier = profile.userID;

        if (self.avaliableFilter && !self.avaliableFilter(data)) {
            continue;
        }
        if (self.disableFilter) {
            data.enabled = !self.disableFilter(data);
        }

        NSString *group = [[data.title firstPinYin] uppercaseString];
        if (group.length == 0 || !isalpha([group characterAtIndex:0])) {
            [nonameList addObject:data];
            continue;
        }
        NSMutableArray *list = [dataDict objectForKey:group];
        if (!list) {
            list = @[].mutableCopy;
            dataDict[group] = list;
            [groupList addObject:group];
        }
        [list addObject:data];
    }

    [groupList sortUsingSelector:@selector(localizedStandardCompare:)];
    if (nonameList.count) {
        [groupList addObject:@"#"];
        dataDict[@"#"] = nonameList;
    }
    for (NSMutableArray *list in [self.dataDict allValues]) {
        [list sortUsingSelector:@selector(compare:)];
    }

    self.groupList = groupList;
    self.dataDict = dataDict;
    self.isLoadFinished = YES;
}

- (void)fillTwoNewList:(NSArray<TUIGroupMemberCellData *> *)profiles
{
    NSMutableDictionary *dataDict = @{}.mutableCopy;
    NSMutableArray *groupList = @[].mutableCopy;
    NSMutableArray *nonameList = @[].mutableCopy;

    for (TUIGroupMemberCellData *profile in profiles) {
        TUICommonContactSelectCellData *data = [TUICommonContactSelectCellData new];
        data.title = [profile name];
        if (profile.avatarUrl.length) {
            data.avatarUrl = [NSURL URLWithString:profile.avatarUrl];
        }
        data.identifier = profile.identifier;

        if (self.avaliableFilter && !self.avaliableFilter(data)) {
            continue;
        }
        if (self.disableFilter) {
            data.enabled = !self.disableFilter(data);
        }

        NSString *group = [[data.title firstPinYin] uppercaseString];
        if (group.length == 0 || !isalpha([group characterAtIndex:0])) {
            [nonameList addObject:data];
            continue;
        }
        NSMutableArray *list = [dataDict objectForKey:group];
        if (!list) {
            list = @[].mutableCopy;
            dataDict[group] = list;
            [groupList addObject:group];
        }
        [list addObject:data];
    }

    [groupList sortUsingSelector:@selector(localizedStandardCompare:)];
    if (nonameList.count) {
        [groupList addObject:@"#"];
        dataDict[@"#"] = nonameList;
    }
    for (NSMutableArray *list in [self.dataDict allValues]) {
        [list sortUsingSelector:@selector(compare:)];
    }

    self.groupList = groupList;
    self.dataDict = dataDict;
    self.isLoadFinished = YES;
}

@end
