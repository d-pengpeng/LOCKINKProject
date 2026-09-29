//
//  TCommonContactCell.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/5.
//

#import "TUICommonContactCell.h"
#import "TUICommonModel.h"
#import "TUICommonContactCellData.h"
#import "TUIDefine.h"

@interface TUICommonContactCell()
@property TUICommonContactCellData *contactData;
@end

@implementation TUICommonContactCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.avatarView = [[UIImageView alloc] initWithImage:DefaultAvatarImage];
//        self.avatarView.frame = CGRectMake(12, 10, 60, 60);
        [self.contentView addSubview:self.avatarView];
        self.avatarView.mm_width(44).mm_height(44).mm__centerY(28).mm_left(12);
//        if ([TUIConfig defaultConfig].avatarType == TAvatarTypeRounded) {
            self.avatarView.layer.masksToBounds = YES;
            self.avatarView.layer.cornerRadius = 22;
//        } else if ([TUIConfig defaultConfig].avatarType == TAvatarTypeRadiusCorner) {
//            self.avatarView.layer.masksToBounds = YES;
//            self.avatarView.layer.cornerRadius = [TUIConfig defaultConfig].avatarCornerRadius;
//        }
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = SYS_Font(16);
        self.titleLabel.textColor = UIColor.blackColor;//[UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark];
        self.titleLabel.mm_left(self.avatarView.mm_maxX+12).mm_height(20).mm__centerY(self.avatarView.mm_centerY).mm_flexToRight(0);

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

        self.changeColorWhenTouched = YES;
        //[self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    return self;
}

- (void)fillWithData:(TUICommonContactCellData *)contactData
{
    [super fillWithData:contactData];
    self.contactData = contactData;

    self.titleLabel.text = contactData.title;
    
    if ([contactData.identifier containsString:@"@"]) {
        // 群组, 则将群组默认头像修改成上次使用的头像
        NSString *key = [NSString stringWithFormat:@"TUIConversationLastGroupMember_%@", contactData.identifier];
        NSInteger member = [NSUserDefaults.standardUserDefaults integerForKey:key];
        UIImage *avatar = [TUIGroupAvatar getCacheAvatarForGroup:contactData.identifier number:(UInt32)member];
        if (avatar) {
            self.avatarView.image = avatar;
        }else {
            [self.avatarView sd_setImageWithURL:contactData.avatarUrl placeholderImage:contactData.avatarImage?:normal_placeHeadImg];
//            self.avatarView.image = contactData.avatarImage?:normal_placeHeadImg; //DefaultAvatarImage
        }
    }else {
        [self.avatarView sd_setImageWithURL:contactData.avatarUrl placeholderImage:contactData.avatarImage?:normal_placeHeadImg];
    }
}

@end

@interface IUContactView : UIView
@property(nonatomic, strong) UIView *view;
@end

@implementation IUContactView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [self addSubview:self.view];
    }
    return self;
}
@end
