//
//  MHPlaceVCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/5.
//

#import "MHPlaceVCell.h"

@implementation MHPlaceVCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHPlaceVCell";
    MHPlaceVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHPlaceVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHPlaceVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *oneMM = [[UIView alloc] init];
        oneMM.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:oneMM];
        [oneMM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
            make.height.offset(90);
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
