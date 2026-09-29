//
//  MHToggleAccountCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/5.
//

#import "MHToggleAccountCell.h"

@implementation MHToggleAccountCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHToggleAccountCell";
    MHToggleAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHToggleAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHToggleAccountCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *oneMM = [HistoryRecordModel createViewUIUI];
        oneMM.backgroundColor = RGB(245, 245, 245);
        oneMM.layer.cornerRadius = 6;
        [self.contentView addSubview:oneMM];
        [oneMM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.offset(60);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 20;
        [oneMM addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(oneMM).offset(10);
            make.width.height.offset(40);
        }];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [oneMM addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.right.equalTo(oneMM.mas_right).offset(-38);
        }];
        
        self.selImgV = [HistoryRecordModel createImgImgView];
        self.selImgV.image = [UIImage imageNamed:@"friend_normalImg"];
        [oneMM addSubview:self.selImgV];
        [self.selImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneMM.mas_right).offset(-10);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.width.height.offset(18);
        }];
    }
    return self;
}

- (void)addDataToDic:(MHToggleAccountModel *)model
{
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:minStr(model.profile)] placeholderImage:normal_placeHeadImg];
    self.nickLab.text = model.nickName;
    if(model.isShhh) {
        self.selImgV.image = [UIImage imageNamed:@"friend_selImg"];
    }else {
        self.selImgV.image = [UIImage imageNamed:@"friend_normalImg"];
    }
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
