//
//  MHDeviceListMsgCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import "MHDeviceListMsgCell.h"

@interface MHDeviceListMsgCell ()

@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UILabel *contLab2;
@property (nonatomic, strong) UILabel *contLab3;
@property (nonatomic, strong) UILabel *contLab4;
@property (nonatomic, strong) UIButton *chosImage;
@property (nonatomic, strong) UIButton *chosImage2;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSIndexPath *indPP;
@end

@implementation MHDeviceListMsgCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHDeviceListMsgCell";
    MHDeviceListMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHDeviceListMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHDeviceListMsgCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.imageV = [HistoryRecordModel createImgImgView];
        self.imageV.image = normal_placeHeadImg;
        self.imageV.layer.cornerRadius = 23;
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.width.height.offset(46);
        }];
        
        self.contLab = [[UILabel alloc] init];
        self.contLab.textColor = UIColor.blackColor;
        self.contLab.font = SYS_Font(14);
        [self.contentView addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(12);
            make.top.equalTo(self.imageV.mas_top);
            make.height.offset(23);
            make.right.equalTo(self.contentView.mas_right).offset(-120);
        }];
        
        self.contLab2 = [[UILabel alloc] init];
        self.contLab2.textColor = GrayText102;
        self.contLab2.font = SYS_Font(12);
        [self.contentView addSubview:self.contLab2];
        [self.contLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(12);
            make.top.equalTo(self.imageV.mas_centerY);
            make.height.offset(23);
            make.right.equalTo(self.contentView.mas_right).offset(-120);
        }];
        
        self.contLab3 = [[UILabel alloc] init];
        self.contLab3.textColor = GrayText102;
        self.contLab3.font = SYS_Font(12);
        self.contLab3.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.contLab3];
        [self.contLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_top);
            make.height.offset(23);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        self.contLab4 = [[UILabel alloc] init];
        self.contLab4.textColor = GrayText102;
        self.contLab4.font = SYS_Font(12);
        self.contLab4.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.contLab4];
        [self.contLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_centerY);
            make.height.offset(23);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        self.contLab4.hidden = YES;
        
        
        
        self.chosImage = [[UIButton alloc] init];
        self.chosImage.clipsToBounds = YES;
        self.chosImage.backgroundColor = normalColors;
        self.chosImage.layer.cornerRadius = 4;
        [self.chosImage setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.chosImage.titleLabel.font = SYS_Font(12);
        [self.chosImage setTitle:eLocalizedString(@"message_tile6") forState:UIControlStateNormal];
        [self.chosImage addTarget:self action:@selector(choseImgBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.chosImage];
        [self.chosImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.contLab2.mas_centerY);
            make.height.offset(24);
            make.width.offset(44);
        }];

        
        self.chosImage2 = [[UIButton alloc] init];
        self.chosImage2.clipsToBounds = YES;
        self.chosImage2.backgroundColor = UIColor.clearColor;
        self.chosImage2.layer.cornerRadius = 4;
        [self.chosImage2 setTitleColor:normalColors forState:UIControlStateNormal];
        self.chosImage2.titleLabel.font = SYS_Font(12);
        [self.chosImage2 setTitle:eLocalizedString(@"message_tile7") forState:UIControlStateNormal];
        self.chosImage2.layer.borderColor = normalColors.CGColor;
        self.chosImage2.layer.borderWidth = 1;
        [self.chosImage2 addTarget:self action:@selector(choseImgBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.chosImage2];
        [self.chosImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.chosImage.mas_left).offset(-12);
            make.centerY.equalTo(self.contLab2.mas_centerY);
            make.height.offset(24);
            make.width.offset(44);
        }];

        
    }
    return self;
}

- (void)addModelToDataModel:(MHDeviceListMsgModel *)mode indPP:(nonnull NSIndexPath *)indPP
{
    self.indPP = indPP;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:mode.fromProfile] placeholderImage:normal_placeHeadImg];
    self.contLab.text = mode.fromNickName;
    self.contLab2.text = mode.content;
    self.contLab3.text = mode.createTime;
    switch (mode.status) {
        case 1:
        {
            self.chosImage.hidden = NO;
            self.chosImage2.hidden = NO;
            self.contLab4.hidden = YES;
        }
            break;
        case 2:
        {
            self.chosImage.hidden = YES;
            self.chosImage2.hidden = YES;
            self.contLab4.hidden = NO;
            self.contLab4.text = eLocalizedString(@"message_tile8");
        }
            break;
        case 3:
        {
            self.chosImage.hidden = YES;
            self.chosImage2.hidden = YES;
            self.contLab4.hidden = NO;
            self.contLab4.text = eLocalizedString(@"message_tile9");
        }
            break;

        default:
        {
            self.chosImage.hidden = YES;
            self.chosImage2.hidden = YES;
            self.contLab4.hidden = YES;
        }
            break;
    }
}

- (void)choseImgBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(MHDeviceListMsgCellDelegateType:indPM:)]) {
        [self.delegate_ MHDeviceListMsgCellDelegateType:1 indPM:self.indPP];
    }
}

- (void)choseImgBtnMethodTwo
{
    if([self.delegate_ respondsToSelector:@selector(MHDeviceListMsgCellDelegateType:indPM:)]) {
        [self.delegate_ MHDeviceListMsgCellDelegateType:2 indPM:self.indPP];
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
