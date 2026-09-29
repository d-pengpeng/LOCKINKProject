//
//  WIFIListViewCell.m
//  MachineGlory
//
//  Created by Edwin on 2021/8/21.
//  Copyright © 2021 time. All rights reserved.
//

#import "WIFIListViewCell.h"
@interface WIFIListViewCell ()

@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UIImageView *chosImage;
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation WIFIListViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"WIFIListViewCell";
    WIFIListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[WIFIListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WIFIListViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.imageV = [HistoryRecordModel createImgImgView];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(38);
            make.top.equalTo(self.contentView.mas_top).offset(9);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-9);
            make.width.height.offset(38);
        }];
        
        self.contLab = [[UILabel alloc] init];
        self.contLab.textColor = UIColor.whiteColor;
        self.contLab.font = SYS_Font(14);
        [self.contentView addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(12);
            make.centerY.equalTo(self.imageV.mas_centerY);
        }];
        
        self.chosImage = [[UIImageView alloc] init];
        self.chosImage.clipsToBounds = YES;
        [self.contentView addSubview:self.chosImage];
        [self.chosImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-38);
            make.centerY.equalTo(self.contLab.mas_centerY);
            make.width.height.offset(18);
        }];
    }
    return self;
}

- (void)addModelToDataModel:(NSString *)nameSt choseName:(nonnull NSString *)chosN
{
    if ([chosN intValue] == 2) {
        self.chosImage.image = [UIImage imageNamed:@"selSelect_img"];
    }else {
        self.chosImage.image = nil;
    }
    self.contLab.text = nameSt;
    self.imageV.image = [UIImage imageNamed:@"mode_placeAA-03Img"];
//    if([self.readNNam isEqualToString:kCharactName2]) {
//        self.imageV.image = app_placeAA2_img;
//    }else {
//        self.imageV.image = app_placeAA1_img;
//    }
    
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
