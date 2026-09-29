//
//  receiveRedbagCell.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import "receiveRedbagCell.h"

@interface receiveRedbagCell ()
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *oneLab2;
@property (nonatomic, strong) UILabel *oneLab3;
@property (nonatomic, strong) UILabel *oneLab4;
@property (nonatomic, strong) UIImageView *crowImgV;
@end
@implementation receiveRedbagCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"receiveRedbagCell";
    receiveRedbagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[receiveRedbagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"receiveRedbagCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 20;
        [self.contentView addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.width.height.offset(40);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.top.equalTo(self.headImgV.mas_top);
            make.height.offset(20);
        }];
        
        self.oneLab2 = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.oneLab2];
        [self.oneLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.top.equalTo(self.headImgV.mas_centerY);
            make.height.offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-90);
        }];
        
        self.oneLab3 = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.oneLab3];
        [self.oneLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.oneLab.mas_centerY);
        }];
        
        self.oneLab4 = [HistoryRecordModel createLabLabTextColor:RGB(227, 172, 114) fontFloat:14 textAlignment:NSTextAlignmentRight];
        self.oneLab4.text = eLocalizedString(@"chat_al45");
        [self.contentView addSubview:self.oneLab4];
        [self.oneLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.oneLab2.mas_centerY);
        }];
        
        self.crowImgV = [HistoryRecordModel createImgImgView];
        self.crowImgV.image = [UIImage imageNamed:@"redbagIMgs5"];
        [self.contentView addSubview:self.crowImgV];
        [self.crowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.oneLab4.mas_left).offset(-3);
            make.centerY.equalTo(self.oneLab4.mas_centerY);
            make.width.offset(19);
            make.height.offset(14);
        }];
        
        UIView *linV = [HistoryRecordModel createLineViewUIUI];
        [self.contentView addSubview:linV];
        [linV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.contentView.mas_top);
            make.height.offset(1);
        }];
        
    }
    return self;
}

- (void)addDataModel:(receiveRedbagModel *)model
{
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:normal_placeHeadImg];
    self.oneLab.text = model.user_nickname;
    self.oneLab2.text = model.addtime;
    self.oneLab3.text = [NSString stringWithFormat:@"%@%@", model.amount, eLocalizedString(@"home_one")];
    if(model.isCrown) {
        self.oneLab4.hidden = NO;
        self.crowImgV.hidden = NO;
    }else {
        self.oneLab4.hidden = YES;
        self.crowImgV.hidden = YES;
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
