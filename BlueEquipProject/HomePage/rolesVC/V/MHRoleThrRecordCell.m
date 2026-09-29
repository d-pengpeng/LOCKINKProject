//
//  MHRoleThrRecordCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/20.
//

#import "MHRoleThrRecordCell.h"

@interface MHRoleThrRecordCell ()

@property (nonatomic, strong) NSIndexPath *indPPx;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *nameLab2;
@property (nonatomic, strong) UILabel *nameLab3;
@property (nonatomic, strong) UIButton *statusBtn;
@end

@implementation MHRoleThrRecordCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHRoleThrRecordCell";
    MHRoleThrRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHRoleThrRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHRoleThrRecordCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.headImg = [HistoryRecordModel createImgImgView];
        self.headImg.image = normal_placeHeadImg;
        self.headImg.layer.cornerRadius = 18;
        [self.contentView addSubview:self.headImg];
        [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.width.height.offset(36);
        }];
        
        self.nameLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).offset(10);
            make.top.equalTo(self.headImg.mas_top).offset(-5);
            make.height.offset(26);
            make.right.equalTo(self.contentView.mas_right).offset(-100);
        }];
        
        self.dateLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.dateLab];
        [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).offset(10);
            make.top.equalTo(self.nameLab.mas_bottom);
            make.height.offset(22);
            make.right.equalTo(self.contentView.mas_right).offset(-100);
        }];
        
        self.nameLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab2];
        [self.nameLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_left);
            make.top.equalTo(self.headImg.mas_bottom).offset(10);
            make.height.offset(30);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        self.nameLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.nameLab3.numberOfLines = 0;
        [self.contentView addSubview:self.nameLab3];
        [self.nameLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_left);
            make.top.equalTo(self.nameLab2.mas_bottom);
            make.height.mas_greaterThanOrEqualTo(30);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-18);
        }];
        
        self.statusBtn = [HistoryRecordModel createImgBtn];
        [self.statusBtn setTitle:@"" forState:UIControlStateNormal];
        [self.statusBtn setTitleColor:normalColors forState:UIControlStateNormal];
        self.statusBtn.titleLabel.font = SYS_Font(14);
        [self.statusBtn addTarget:self action:@selector(statusBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.statusBtn];
        [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.headImg.mas_centerY);
            make.width.offset(80);
            make.height.offset(36);
        }];
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        linVV.backgroundColor = RGB(243, 224, 251);
        [self.contentView addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.height.offset(8);
        }];
    }
    return self;
}

- (void)addDataToModel:(MHRoleThrRecordModel *)model indeP:(NSIndexPath *)indPP
{
    self.indPPx = indPP;
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.operatorProfile] placeholderImage:normal_placeHeadImg];
    
    self.nameLab.text = model.operatorNickName;
    self.dateLab.text = model.operationTime;
    self.nameLab2.text = [NSString stringWithFormat:@"%@ %d", eLocalizedString(@"role_setting2"), model.unlockRangeInKm];
    self.nameLab3.text = [NSString stringWithFormat:@"%@ %@", eLocalizedString(@"role_setting10"), model.location];
    if(model.status == 1) {
        [self.statusBtn setTitle:eLocalizedString(@"role_setting11") forState:UIControlStateNormal];
    }else if (model.status == 2) {
        [self.statusBtn setTitle:eLocalizedString(@"role_setting12") forState:UIControlStateNormal];
    }else {
        [self.statusBtn setTitle:eLocalizedString(@"role_setting7") forState:UIControlStateNormal];
    }
}

- (void)statusBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(roleThrRecordCDelegateRow:)]) {
        [self.delegate_ roleThrRecordCDelegateRow:self.indPPx];
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
