//
//  MHFriendChooseCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/20.
//

#import "MHFriendChooseCell.h"

@interface MHFriendChooseCell ()

@property (nonatomic, strong) UIImageView *lefImgV;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nameLab;
@end

@implementation MHFriendChooseCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHFriendChooseCell";
    MHFriendChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHFriendChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHFriendChooseCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.lefImgV = [HistoryRecordModel createImgImgView];
        self.lefImgV.image = [UIImage imageNamed:@"friend_normalImg"];
        [self.contentView addSubview:self.lefImgV];
        [self.lefImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-24);
            make.width.height.offset(18);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.image = normal_placeHeadImg;
        [self.contentView addSubview:self.headImgV];
        self.headImgV.layer.cornerRadius = 16;
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.offset(32);
        }];
        
        self.nameLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        [self.contentView addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.offset(1);
        }];
    }
    return self;
}

- (void)addModelToDataModel:(MHFriendChooseModel *)model {
    
    if(model.isSelBoo) {
        self.lefImgV.image = [UIImage imageNamed:@"friend_selImg"];
    }else {
        self.lefImgV.image = [UIImage imageNamed:@"friend_normalImg"];
    }
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.faceURL] placeholderImage:normal_placeHeadImg];
    self.nameLab.text = model.nickName;
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
