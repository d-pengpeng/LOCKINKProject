//
//  MHToggleAccountAddCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/7.
//

#import "MHToggleAccountAddCell.h"

@implementation MHToggleAccountAddCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHToggleAccountAddCell";
    MHToggleAccountAddCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHToggleAccountAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHToggleAccountAddCell"];
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
        self.nickLab.text = eLocalizedString(@"my_about26");
        [oneMM addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.right.equalTo(oneMM.mas_right).offset(-38);
        }];
    }
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

@end
