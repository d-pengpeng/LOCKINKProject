//
//  MHLanguageCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHLanguageCell.h"

@interface MHLanguageCell ()

@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UIImageView *imgVV;
@end

@implementation MHLanguageCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHLanguageCell";
    MHLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHLanguageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHLanguageCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top);
            make.height.offset(48);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        self.imgVV = [HistoryRecordModel createImgImgView];
        [self.contentView addSubview:self.imgVV];
        [self.imgVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.contLab.mas_centerY);
            make.width.height.offset(14);
        }];
        
    }
    return self;
}

- (void)addModelData:(MHLanguageModel *)model
{
    self.contLab.text = model.name;
    if(model.isShow) {
        self.imgVV.image = [UIImage imageNamed:@"language_selImg"];
    }else {
        self.imgVV.image = [UIImage imageNamed:@"language_norlImg"];
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
