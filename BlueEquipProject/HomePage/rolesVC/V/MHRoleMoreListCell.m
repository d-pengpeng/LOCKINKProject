//
//  MHRoleMoreListCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "MHRoleMoreListCell.h"

@interface MHRoleMoreListCell ()

@property (nonatomic, strong) UIImageView *lefImgV;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *nameLab2;
@property (nonatomic, strong) UILabel *nameLab3;
@end

@implementation MHRoleMoreListCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHRoleMoreListCell";
    MHRoleMoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHRoleMoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHRoleMoreListCell"];
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
        self.lefImgV.image = normal_placeHeadImg;
        self.lefImgV.layer.cornerRadius = 21;
        [self.contentView addSubview:self.lefImgV];
        [self.lefImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(14);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
            make.width.height.offset(42);
        }];
        
        self.nameLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_right).offset(12);
            make.top.equalTo(self.lefImgV.mas_top);
            make.width.offset(150);
            make.height.offset(20);
        }];
        
        self.nameLab2 = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.nameLab2];
        [self.nameLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.nameLab.mas_centerY);
        }];
        
        self.nameLab3 = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab3];
        [self.nameLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.lefImgV.mas_bottom);
        }];
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        [self.contentView addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(66);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.offset(1);
        }];
    }
    return self;
}

- (void)addModelToDataModel:(MHRoleMoreListModel *)model {
    
    [self.lefImgV sd_setImageWithURL:[NSURL URLWithString:model.operatorProfile] placeholderImage:normal_placeHeadImg];
    
    self.nameLab.text = model.operatorNickName;
    self.nameLab2.text = model.operationTime;
    self.nameLab3.text = model.location;
}

- (void)addModelToDataModelTwo:(MHRoleMoreListModel *)model
{
    [self.lefImgV sd_setImageWithURL:[NSURL URLWithString:model.operatorProfile] placeholderImage:normal_placeHeadImg];
    
    self.nameLab.text = model.operatorNickName;
    self.nameLab2.text = model.operationTime;
    self.nameLab3.text = model.content;
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
