//
//  TCommonFriendCellData.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/7.
//

#import "TUICommonContactCellData.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"

@implementation TUICommonContactCellData
{
    V2TIMFriendInfo *_friendProfile;
}

- (instancetype)initWithFriend:(V2TIMFriendInfo *)args {
    self = [super init];

    if (args.friendRemark.length) {
        _title = args.friendRemark;
    } else {
        _title = [args.userFullInfo showName];
    }

    _identifier = args.userID;
    if(args.friendCustomInfo.allKeys.count == 1) {
        
        NSString *k_str = @"";
        for (NSString *keySS in args.friendCustomInfo.allKeys) {
            k_str = keySS;
        }
        if([k_str isEqualToString:@"Tag_SNS_Custom_avatarNew"]) {
            
            NSString * str  =[[NSString alloc] initWithData:args.friendCustomInfo[k_str] encoding:NSUTF8StringEncoding];
            _avatarUrl = [NSURL URLWithString:str];
        }else {
            _avatarUrl = [NSURL URLWithString:args.userFullInfo.faceURL];
        }
    }else {
        _avatarUrl = [NSURL URLWithString:args.userFullInfo.faceURL];
    }
    _friendProfile = args;

    return self;
}

- (instancetype)initWithGroupInfo:(V2TIMGroupInfo *)args
{
    self = [super init];

    _title = args.groupName;
    _avatarImage = DefaultGroupAvatarImage;
    _avatarUrl = [NSURL URLWithString:args.faceURL];
    _identifier = args.groupID;

    return self;
}

- (NSComparisonResult)compare:(TUICommonContactCellData *)data
{
    return [self.title localizedCompare:data.title];
}

- (CGFloat)heightOfWidth:(CGFloat)width
{
    return 56;
}
@end
