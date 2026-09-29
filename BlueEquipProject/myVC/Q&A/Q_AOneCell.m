//
//  Q_AOneCell.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/12.
//

#import "Q_AOneCell.h"
@interface Q_AOneCell ()

@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UIImageView *imgVV;
@property (nonatomic, strong) UIView *botmVV;
@end

@implementation Q_AOneCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"Q_AOneCell";
    Q_AOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[Q_AOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Q_AOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.botmVV = [HistoryRecordModel createViewUIUI];
        self.botmVV.layer.cornerRadius = 6;
        self.botmVV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.botmVV];
        [self.botmVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.bottom.equalTo(self.contentView);
            make.height.mas_greaterThanOrEqualTo(54);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
        }];
        
        UIView *vvv = [[UIView alloc] init];
        vvv.backgroundColor = RGBA(176, 51, 228, 0.12);
        [self.botmVV addSubview:vvv];
        [vvv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.botmVV);
        }];
        
        self.imgVV = [HistoryRecordModel createImgImgView];
        self.imgVV.image = [UIImage imageNamed:@"Q_AOne_normal"];
        [self.botmVV addSubview:self.imgVV];
        [self.imgVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.botmVV.mas_top).offset(15);
            make.right.equalTo(self.botmVV.mas_right).offset(-12);
            make.width.height.offset(24);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.oneLab.numberOfLines = 2;
        [self.botmVV addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.botmVV.mas_left).offset(12);
            make.top.equalTo(self.botmVV.mas_top);
            make.right.equalTo(self.imgVV.mas_left).offset(-70);
            make.height.offset(54);
        }];
        
        self.contLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.contLab.numberOfLines = 0;
        [self.botmVV addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.botmVV.mas_left).offset(12);
            make.top.equalTo(self.oneLab.mas_bottom);
            make.right.equalTo(self.botmVV.mas_right).offset(-12);
            make.bottom.equalTo(self.botmVV.mas_bottom).offset(-10);
        }];
        
    }
    return self;
}

- (void)addModelData:(Q_AOneModel *)model
{
    self.oneLab.text = model.name;
    if (model.isShow) {
        self.contLab.hidden = NO;
        self.imgVV.image = [UIImage imageNamed:@"Q_AOne_Select"];
        self.contLab.text = model.post_content;
    }else {
        self.imgVV.image = [UIImage imageNamed:@"Q_AOne_normal"];
        self.contLab.hidden = YES;
        self.contLab.text = @"";
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
