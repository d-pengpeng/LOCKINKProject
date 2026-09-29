//
//  muteGroupListCell.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/9.
//

#import "muteGroupListCell.h"
#import "TUIDarkModel.h"
#import "TUIDefine.h"
@implementation muteGroupListCell
{
    UIImageView *_userImg;
    UILabel *_nameLabel;
    TUIUserModel *_userModel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = TCell_Nomal;
        _userImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_userImg];
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_nameLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)fillWithDataModel:(TUIUserModel *)model
{
    _userModel = model;
    [_userImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:TUICoreImagePath(@"default_c2c_head")]];
    _nameLabel.text = model.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _userImg.mm_width(32).mm_height(32).mm_left(12).mm__centerY(self.mm_h / 2);
    _nameLabel.mm_height(self.mm_h).mm_left(_userImg.mm_maxX + 12).mm_flexToRight(0);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
