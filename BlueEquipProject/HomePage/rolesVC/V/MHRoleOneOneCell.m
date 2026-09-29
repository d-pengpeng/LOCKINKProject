//
//  MHRoleOneOneCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "MHRoleOneOneCell.h"

@interface MHRoleOneOneCell ()

@property (nonatomic, strong) UIView *contVVVV;
@property (nonatomic, strong) UIImageView *lefImgV;
@property (nonatomic, strong) UILabel *nameLab;
@end

@implementation MHRoleOneOneCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHRoleOneOneCell";
    MHRoleOneOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHRoleOneOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHRoleOneOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.contVVVV = [HistoryRecordModel createViewUIUI];
        self.contVVVV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.contVVVV];
        [self.contVVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.offset(38);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
        }];
       
        self.placVV = [[UIView alloc] init];
        self.placVV.backgroundColor = RGBA(176, 51, 228, 0.5);
        [self.contVVVV addSubview:self.placVV];
        [self.placVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contVVVV);
        }];
        
        self.lefImgV = [HistoryRecordModel createImgImgView];
        [self.contVVVV addSubview:self.lefImgV];
        [self.lefImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contVVVV.mas_left).offset(12);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
            make.width.height.offset(20);
        }];
        
        self.nameLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contVVVV addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_right).offset(10);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
        }];
        
        self.nexImgv = [HistoryRecordModel createImgImgView];
        self.nexImgv.image = [UIImage imageNamed:@"home_next2"];
        [self.contVVVV addSubview:self.nexImgv];
        [self.nexImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contVVVV.mas_right).offset(-12);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
            make.width.height.offset(14);
        }];
    }
    return self;
}

- (void)addModelToDataModel:(NSDictionary *)nameSt choseName:(NSInteger)chosN
{
    self.lefImgV.image = [UIImage imageNamed:nameSt[@"img"]];
    self.nameLab.text = nameSt[@"name"];
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
