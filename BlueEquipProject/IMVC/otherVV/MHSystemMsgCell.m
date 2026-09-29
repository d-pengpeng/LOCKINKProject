//
//  MHSystemMsgCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/18.
//

#import "MHSystemMsgCell.h"

@interface MHSystemMsgCell ()

@property (nonatomic, strong) UILabel *contLab;
@end

@implementation MHSystemMsgCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHSystemMsgCell";
    MHSystemMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHSystemMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHSystemMsgCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.contLab = [[UILabel alloc] init];
        self.contLab.textColor = RGB(94, 94, 94);
        self.contLab.font = SYS_Font(14);
        self.contLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_greaterThanOrEqualTo(14);
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
