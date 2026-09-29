//
//  MHBlacklistCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/7.
//

#import "MHBlacklistCell.h"

@interface MHBlacklistCell ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *timeLab;
@end
@implementation MHBlacklistCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHBlacklistCell";
    MHBlacklistCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHBlacklistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHBlacklistCell"];
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
            make.height.offset(80);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 24;
        [oneMM addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneMM.mas_left).offset(12);
            make.centerY.equalTo(oneMM.mas_centerY);
            make.width.height.offset(48);
        }];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        self.nickLab.font = [UIFont systemFontOfSize:16 weight:0.3];
        [oneMM addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.top.equalTo(self.headImgV.mas_top).offset(2);
            make.right.equalTo(oneMM.mas_right).offset(-80);
        }];
        
        self.timeLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [oneMM addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(12);
            make.bottom.equalTo(self.headImgV.mas_bottom);
        }];
        
        UIButton *btnbntSS = [HistoryRecordModel createImgBtn];
        btnbntSS.backgroundColor = normalPurpleColors;
        btnbntSS.layer.cornerRadius = 4;
        [btnbntSS setTitle:eLocalizedString(@"my_about23") forState:UIControlStateNormal];
        [btnbntSS setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btnbntSS.titleLabel.font = SYS_Font(12);
        [btnbntSS addTarget:self action:@selector(btnMethodUIUIU) forControlEvents:UIControlEventTouchUpInside];
        [oneMM addSubview:btnbntSS];
        [btnbntSS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneMM.mas_right).offset(-12);
            make.centerY.equalTo(oneMM.mas_centerY);
            make.height.offset(24);
            make.width.offset(52);
        }];
    }
    return self;
}

- (void)btnMethodUIUIU
{
    if([self.delegate_ respondsToSelector:@selector(blackListDelegateIndePP:)]) {
        [self.delegate_ blackListDelegateIndePP:self.indPPPPl];
    }
}

- (void)addDataToDic:(NSDictionary *)dicMMdat
{
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:minStr(dicMMdat[@"profile"])] placeholderImage:normal_placeHeadImg];
    self.nickLab.text = minStr(dicMMdat[@"nickName"]);
    self.timeLab.text = minStr(dicMMdat[@"blockTime"]);
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
