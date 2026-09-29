//
//  MHApplyVoteListCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/29.
//

#import "MHApplyVoteListCell.h"

@interface MHApplyVoteListCell ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *msgLab;

@end

@implementation MHApplyVoteListCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHApplyVoteListCell";
    MHApplyVoteListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHApplyVoteListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHApplyVoteListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 20;
        self.headImgV.image = normal_placeHeadImg;
        [self.contentView addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(9);
            make.width.height.offset(40);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-9);
        }];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.nickLab.text = eLocalizedString(@"me_allNames3");
        [self.contentView addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-120);
        }];
        
        self.msgLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentRight];
        self.msgLab.numberOfLines = 0;
        [self.contentView addSubview:self.msgLab];
        [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.width.offset(100);
        }];
        
    }
    return self;
}

- (void)addDataToModel:(NSDictionary *)model
{
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:minStr(model[@"profile"])] placeholderImage:normal_placeHeadImg];
    self.nickLab.text = model[@"nickName"];
    self.msgLab.text = model[@"createTime"];
    
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
