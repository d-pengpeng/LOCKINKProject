//
//  MHSystemMsgTwoCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/18.
//

#import "MHSystemMsgTwoCell.h"

@interface MHSystemMsgTwoCell ()

@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation MHSystemMsgTwoCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHSystemMsgTwoCell";
    MHSystemMsgTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHSystemMsgTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHSystemMsgTwoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        
        self.imageV = [HistoryRecordModel createImgImgView];
        self.imageV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.height.mas_greaterThanOrEqualTo(40);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        UIView *imgVV = [[UIView alloc] init];
        imgVV.backgroundColor = RGBA(176, 51, 228, 0.1);
        [self.imageV addSubview:imgVV];
        [imgVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.imageV);
        }];
        
        self.contLab = [[UILabel alloc] init];
        self.contLab.textColor = UIColor.blackColor;
        self.contLab.font = SYS_Font(14);
        self.contLab.numberOfLines = 0;
        [self.imageV addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_left).offset(12);
            make.top.equalTo(self.imageV.mas_top).offset(13);
            make.right.equalTo(self.imageV.mas_right).offset(-12);
            make.bottom.equalTo(self.imageV.mas_bottom).offset(-13);
        }];
        
        
    }
    return self;
}

- (void)addModelToDataModel:(NSString *)mode
{
    self.contLab.text = mode;
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
