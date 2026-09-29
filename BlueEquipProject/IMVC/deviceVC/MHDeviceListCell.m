//
//  MHDeviceListCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import "MHDeviceListCell.h"

@interface MHDeviceListCell ()

@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UIButton *chosImage;
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation MHDeviceListCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHDeviceListCell";
    MHDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHDeviceListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHDeviceListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *placVV = [[UIView alloc] init];
        placVV.backgroundColor = RGBA(176, 51, 228, 0.15);
        [self.contentView addSubview:placVV];
        [placVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.left.right.bottom.equalTo(self.contentView);
            make.height.offset(64);
        }];
        
        self.imageV = [HistoryRecordModel createImgImgView];
        self.imageV.image = [UIImage imageNamed:@"role_imgs15"];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.width.height.offset(40);
        }];
        
        self.contLab = [[UILabel alloc] init];
        self.contLab.textColor = UIColor.blackColor;
        self.contLab.font = SYS_Font(16);
        [self.contentView addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(12);
            make.centerY.equalTo(self.imageV.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(80);
        }];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        nexImgv.image = [UIImage imageNamed:@"home_next2"];
        [self.contentView addSubview:nexImgv];
        [nexImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.imageV.mas_centerY);
            make.width.height.offset(14);
        }];
        
        self.chosImage = [[UIButton alloc] init];
        self.chosImage.clipsToBounds = YES;
        self.chosImage.backgroundColor = UIColor.redColor;
        self.chosImage.layer.cornerRadius = 8;
        [self.chosImage setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.chosImage.titleLabel.font = SYS_Font(12);
        self.chosImage.userInteractionEnabled = NO;
        [self.contentView addSubview:self.chosImage];
        [self.chosImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(nexImgv.mas_left).offset(-10);
            make.centerY.equalTo(self.imageV.mas_centerY);
            make.height.offset(16);
            make.width.mas_greaterThanOrEqualTo(16);
        }];
        self.chosImage.hidden = YES;
        
    }
    return self;
}

- (void)addModelToDataModel:(NSDictionary *)mode
{
    self.contLab.text = minStr(mode[@"deviceName"]);
    if([minStr(mode[@"unreadCount"]) intValue] > 0) {
        self.chosImage.hidden = NO;
        [self.chosImage setTitle:minStr(mode[@"unreadCount"]) forState:UIControlStateNormal];
    }else {
        self.chosImage.hidden = YES;
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
