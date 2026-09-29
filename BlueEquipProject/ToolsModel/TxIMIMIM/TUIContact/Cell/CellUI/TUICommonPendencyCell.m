//
//  TCommonPendencyCell.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/7.
//

#import "TUICommonPendencyCell.h"
#import "TUIDefine.h"

@implementation TUICommonPendencyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.contentView.backgroundColor = UIColor.clearColor;
    self.accessoryView.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
    self.avatarView = [[UIImageView alloc] initWithImage:DefaultAvatarImage];
    [self.contentView addSubview:self.avatarView];
//    self.avatarView.mm_width(70).mm_height(70).mm__centerY(43).mm_left(12);
    self.avatarView.mm_width(42).mm_height(42).mm__centerY(27).mm_left(12);
//    if ([TUIConfig defaultConfig].avatarType == TAvatarTypeRounded) {
        self.avatarView.layer.masksToBounds = YES;
        self.avatarView.layer.cornerRadius = self.avatarView.frame.size.height / 2;
//    } else if ([TUIConfig defaultConfig].avatarType == TAvatarTypeRadiusCorner) {
//        self.avatarView.layer.masksToBounds = YES;
//        self.avatarView.layer.cornerRadius = [TUIConfig defaultConfig].avatarCornerRadius;
//    }


    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor = UIColor.blackColor;//[UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark];
    self.titleLabel.mm_left(self.avatarView.mm_maxX+12).mm_top(6).mm_height(22).mm_width(120);

//    self.addSourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    [self.contentView addSubview:self.addSourceLabel];
//    self.addSourceLabel.textColor = [UIColor d_systemGrayColor];
//    self.addSourceLabel.font = [UIFont systemFontOfSize:15];
////    self.addSourceLabel.mm_left(self.titleLabel.mm_x).mm_top(self.titleLabel.mm_maxY+6).mm_height(15).mm_width(120);
//    self.addSourceLabel.mm_left(self.titleLabel.mm_x).mm_top(self.titleLabel.mm_maxY).mm_height(1).mm_width(120);

    self.addWordingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.addWordingLabel];
    self.addWordingLabel.textColor = GrayTextColor;
    self.addWordingLabel.font = [UIFont systemFontOfSize:12];
    self.addWordingLabel.mm_left(self.titleLabel.mm_x).mm_top(self.titleLabel.mm_maxY+1).mm_height(15).mm_width(180);

    self.agreeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.agreeButton setTitleColor:normalColors forState:UIControlStateNormal];
//    self.accessoryView = self.agreeButton;
    self.agreeButton.clipsToBounds = YES;
    self.agreeButton.layer.cornerRadius = 4;
    [self.contentView addSubview:self.agreeButton];
    [self.agreeButton addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12);
//        make.top.bottom.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(60);
        make.height.offset(26);
    }];
    
//    self.rufButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.rufButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.rufButton.clipsToBounds = YES;
//    self.rufButton.layer.cornerRadius = 4;
//    self.rufButton.backgroundColor = normalColors;
//    [self.contentView addSubview:self.rufButton];
//    [self.rufButton addTarget:self action:@selector(agreeRefClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.rufButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).offset(-12);
////        make.top.bottom.equalTo(self.contentView);
//        make.centerY.equalTo(self.contentView.mas_centerY);
//        make.width.offset(60);
//        make.height.offset(26);
//    }];
    
    self.addSourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addSourceLabel.textColor = GrayTextColor;
    self.addSourceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.addSourceLabel];
    [self.addSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.addSourceLabel.hidden = YES;

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillWithData:(TUICommonPendencyCellData *)pendencyData
{
    [super fillWithData:pendencyData];

    self.pendencyData = pendencyData;
    self.titleLabel.text = pendencyData.title;
//    self.addSourceLabel.text = pendencyData.addSource;
//    self.addWordingLabel.text = pendencyData.addWording;
    self.addWordingLabel.text = [HistoryRecordModel getTimeFromTimestamp:[NSString stringWithFormat:@"%llu", pendencyData.application.addTime]];
    self.avatarView.image = normal_placeHeadImg;
    if (pendencyData.avatarUrl) {
         [self.avatarView sd_setImageWithURL:pendencyData.avatarUrl placeholderImage:normal_placeHeadImg];
    }
    self.addSourceLabel.hidden = YES;
    if(pendencyData.application.type==2) {
        self.agreeButton.hidden = YES;
        self.addSourceLabel.hidden = NO;
        self.addSourceLabel.text = eLocalizedString(@"message_friend2");
    }else {
        self.agreeButton.hidden = NO;
        if (pendencyData.isAccepted) {
            [self.agreeButton setTitleColor:GrayText forState:UIControlStateNormal];
            [self.agreeButton setTitle:eLocalizedString(@"message_friend1_1") forState:UIControlStateNormal];
            self.agreeButton.enabled = NO;
            self.agreeButton.layer.borderColor = [UIColor clearColor].CGColor;
        } else {
            [self.agreeButton setTitleColor:normalColors forState:UIControlStateNormal];
            [self.agreeButton setTitle:eLocalizedString(@"message_friend1") forState:UIControlStateNormal];
            self.agreeButton.enabled = YES;
            self.agreeButton.layer.borderColor = normalColors.CGColor;
            self.agreeButton.layer.borderWidth = 1;
        }
    }
    
//    self.agreeButton.mm_sizeToFit().mm_width(self.agreeButton.mm_w+20);
}

- (void)agreeClick
{
    if (self.pendencyData.cbuttonSelector) {
        UIViewController *vc = self.mm_viewController;
        if ([vc respondsToSelector:self.pendencyData.cbuttonSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [vc performSelector:self.pendencyData.cbuttonSelector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

- (void)agreeRefClick
{
//    [self.pendencyData reject];
    if (self.pendencyData.cbuttonSelector) {
        UIViewController *vc = self.mm_viewController;
        if ([vc respondsToSelector:self.pendencyData.cbuttonSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [vc performSelector:self.pendencyData.cbuttonSelector withObject:self];
#pragma clang diagnostic pop
        }
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ((touch.view == self.agreeButton)) {
        return NO;
    }
    return YES;
}
@end
