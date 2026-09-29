//
//  MHEquipmenMeCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import "MHEquipmenMeCell.h"
#import "MHMeEquipmentModel.h"

@interface MHEquipmenMeCell ()

@property (nonatomic, strong) UIView *conVVV;
@property (nonatomic, strong) UILabel *timeLLLL;
@end
@implementation MHEquipmenMeCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHEquipmenMeCell";
    MHEquipmenMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHEquipmenMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHEquipmenMeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.conVVV = [HistoryRecordModel createViewUIUI];
        self.conVVV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.conVVV];
        [self.conVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.offset(52);
        }];
        
        UIView *IImV = [[UIView alloc] init];
        IImV.backgroundColor = RGBA(176, 51, 228, 0.5);
        [self.conVVV addSubview:IImV];
        [IImV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.conVVV);
        }];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        nexImgv.frame = CGRectMake(_window_width-24-22, 19, 14, 14);
        nexImgv.image = [UIImage imageNamed:@"home_next2"];
        [self.conVVV addSubview:nexImgv];
        
        UIImageView *nexImgv2 = [HistoryRecordModel createImgImgView];
        nexImgv2.frame = CGRectMake(10, 6, 40, 40);
        nexImgv2.image = [UIImage imageNamed:@"plaza_imgs6"];
        [self.conVVV addSubview:nexImgv2];
        
        self.timeLLLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.conVVV addSubview:self.timeLLLL];
        [self.timeLLLL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conVVV.mas_left).offset(62);
            make.top.bottom.equalTo(self.conVVV);
            make.right.equalTo(self.conVVV.mas_right).offset(-42);
        }];
        
    }
    return self;
    
}

- (void)addDataToModel:(NSDictionary *)dicMMMM
{
    MHMeEquipmentModel *model = [MHMeEquipmentModel mj_objectWithKeyValues:dicMMMM];
    self.timeLLLL.text = model.name;
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
