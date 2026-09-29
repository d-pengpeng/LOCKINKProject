//
//  MHrankingTwoCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/12.
//

#import "MHrankingTwoCell.h"

@interface MHrankingTwoCell ()

@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLa;
@property (nonatomic, strong) UILabel *timeLa;
@property (nonatomic, strong) UIImageView *lockImgV;
@end

@implementation MHrankingTwoCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHrankingTwoCell";
    MHrankingTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHrankingTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHrankingTwoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.numLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.numLab];
        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.bottom.equalTo(self.contentView);
            make.width.offset(30);
            make.height.offset(58);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 20;
        [self.contentView addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLab.mas_right);
            make.centerY.equalTo(self.numLab.mas_centerY);
            make.width.height.offset(40);
        }];
        
        self.nickLa = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.nickLa.text = eLocalizedString(@"me_allNames3");
        [self.contentView addSubview:self.nickLa];
        [self.nickLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.centerY.equalTo(self.numLab.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-84);
        }];
        
        self.timeLa = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.timeLa];
        [self.timeLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.numLab.mas_centerY);
        }];
        
        _lockImgV = [HistoryRecordModel createImgImgView];
        _lockImgV.image = [UIImage imageNamed:@"lockImgs1"];
        [self.contentView addSubview:_lockImgV];
        [self.lockImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLa.mas_left).offset(-3);
            make.centerY.equalTo(self.numLab.mas_centerY);
            make.width.offset(9);
            make.height.offset(14);
        }];
        
    }
    return self;
}

- (void)addDataToModel:(MHrankingUserModel *)model row:(NSInteger)row
{
    self.numLab.text = [NSString stringWithFormat:@"%ld", row+4];
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
    
    self.nickLa.text = model.nickName;
    self.timeLa.text = model.duration;
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
