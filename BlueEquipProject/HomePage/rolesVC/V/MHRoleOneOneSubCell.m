//
//  MHRoleOneOneSubCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/18.
//

#import "MHRoleOneOneSubCell.h"

@interface MHRoleOneOneSubCell ()

@property (nonatomic, strong) UIView *contVVVV;
@property (nonatomic, strong) UILabel *timeLab;
@end

@implementation MHRoleOneOneSubCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHRoleOneOneSubCell";
    MHRoleOneOneSubCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHRoleOneOneSubCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHRoleOneOneSubCell"];
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
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.offset(48);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
       
        self.placVV = [[UIView alloc] init];
        self.placVV.backgroundColor = RGBA(176, 51, 228, 0.5);
        [self.contVVVV addSubview:self.placVV];
        [self.placVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contVVVV);
        }];
        
        // UI two
        self.timeLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contVVVV addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contVVVV.mas_left).offset(12);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
        }];
        
        UIView *shiyBtn = [[UIView alloc] init];
        shiyBtn.clipsToBounds = YES;
        shiyBtn.layer.cornerRadius = 14;
        shiyBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        shiyBtn.layer.borderWidth = 1;
        [self.contVVVV addSubview:shiyBtn];
        [shiyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contVVVV.mas_right).offset(-30);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
            make.height.offset(28);
        }];
        
        UILabel *shiYLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        shiYLab.text = eLocalizedString(@"role_name20");
        [shiyBtn addSubview:shiYLab];
        [shiYLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shiyBtn.mas_left).offset(8);
            make.top.bottom.equalTo(shiyBtn);
            make.right.equalTo(shiyBtn.mas_right).offset(-8);
        }];
        
        UIView *sslOne = [HistoryRecordModel createViewUIUI];
        sslOne.backgroundColor = UIColor.blackColor;
        [self.contVVVV addSubview:sslOne];
        [sslOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contVVVV.mas_left).offset(-10);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
            make.width.height.offset(20);
        }];
        
        UIView *sslOne2 = [HistoryRecordModel createViewUIUI];
        sslOne2.backgroundColor = UIColor.blackColor;
        [self.contVVVV addSubview:sslOne2];
        [sslOne2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contVVVV.mas_right).offset(10);
            make.centerY.equalTo(self.contVVVV.mas_centerY);
            make.width.height.offset(20);
        }];
        
        UIImageView *delelImgV = [HistoryRecordModel createImgImgView];
        delelImgV.image = [UIImage imageNamed:@"deleteImg_white"];
        [self.contVVVV addSubview:delelImgV];
        [delelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contVVVV.mas_right).offset(-5);
            make.top.equalTo(self.contVVVV.mas_top).offset(5);
            make.width.height.offset(14);
        }];
        
        UIButton *deleBBtn = [[UIButton alloc] init];
        [deleBBtn addTarget:self action:@selector(dleeBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contVVVV addSubview:deleBBtn];
        [deleBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.contVVVV);
            make.width.offset(30);
        }];
        
    }
    return self;
}

- (void)addModelToDataModel:(NSDictionary *)nameSt choseName:(NSInteger)chosN
{
    self.timeLab.text = nameSt[@"time"];
}

- (void)dleeBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(roleOneModesDelegateRow:)]) {
        [self.delegate_ roleOneModesDelegateRow:self.rowMML];
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
