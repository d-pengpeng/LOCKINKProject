//
//  MHMsgIMOneCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/5.
//

#import "MHMsgIMOneCell.h"

@interface MHMsgIMOneCell ()

@property (nonatomic, strong) UILabel *contLab;
@property (nonatomic, strong) UILabel *contLab2;
@property (nonatomic, strong) UILabel *contLab3;
@property (nonatomic, strong) UILabel *contLab4;
@property (nonatomic, strong) UILabel *contLab5;
@property (nonatomic, strong) UIImageView *chosImage;
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation MHMsgIMOneCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHMsgIMOneCell";
    MHMsgIMOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHMsgIMOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHMsgIMOneCell"];
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
            make.height.offset(84);
        }];
        
        self.imageV = [HistoryRecordModel createImgImgView];
        self.imageV.frame = CGRectMake(16, 16, 52, 52);
        self.imageV.image = normal_placeHeadImg;
//        self.imageV.transform = CGAffineTransformMakeRotation(M_PI_2/2);
        self.imageV.layer.cornerRadius = 26;
        [oneMM addSubview:self.imageV];
        
        
        self.contLab = [[UILabel alloc] init];
        self.contLab.textColor = UIColor.blackColor;
        self.contLab.font = SYS_Font(16);
        [oneMM addSubview:self.contLab];
        [self.contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(10);
            make.top.equalTo(self.imageV.mas_top);
            make.height.offset(26);
            make.width.mas_lessThanOrEqualTo(60);
        }];
      
        self.contLab2 = [[UILabel alloc] init];
        self.contLab2.textColor = RGB(180, 180, 180);
        self.contLab2.font = SYS_Font(12);
        [oneMM addSubview:self.contLab2];
        [self.contLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contLab.mas_right).offset(10);
            make.centerY.equalTo(self.contLab.mas_centerY);
        }];
        
        self.contLab3 = [[UILabel alloc] init];
        self.contLab3.textColor = UIColor.blackColor;
        self.contLab3.font = SYS_Font(12);
        [oneMM addSubview:self.contLab3];
        [self.contLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageV.mas_right).offset(10);
            make.top.equalTo(self.contLab.mas_bottom).offset(10);
            make.height.offset(22);
        }];
        
        self.contLab4 = [[UILabel alloc] init];
        self.contLab4.textColor = normalPurpleColors;
        self.contLab4.font = SYS_Font(12);
        [oneMM addSubview:self.contLab4];
        [self.contLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contLab3.mas_left);
            make.top.equalTo(self.contLab3.mas_bottom);
            make.height.offset(22);
        }];
        self.contLab4.hidden = YES;
        
        self.chosImage = [HistoryRecordModel createImgImgView];
        self.chosImage.layer.cornerRadius = 8;
//        self.chosImage.backgroundColor = GroupBackColor;
        [oneMM addSubview:self.chosImage];
        [self.chosImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneMM.mas_right).offset(-12);
            make.centerY.equalTo(oneMM.mas_centerY);
            make.width.height.offset(50);
        }];
        
        self.contLab5 = [[UILabel alloc] init];
        self.contLab5.textColor = RGB(180, 180, 180);
        self.contLab5.font = SYS_Font(12);
        self.contLab5.numberOfLines = 2;
        self.contLab5.textAlignment = NSTextAlignmentRight;
        [oneMM addSubview:self.contLab5];
        [self.contLab5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneMM.mas_right).offset(-12);
            make.centerY.equalTo(oneMM.mas_centerY);
            make.height.offset(50);
            make.width.offset(80);
        }];
        self.contLab5.hidden = YES;
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        [oneMM addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneMM.mas_left).offset(82);
            make.bottom.equalTo(oneMM.mas_bottom);
            make.right.equalTo(oneMM.mas_right).offset(-12);
            make.height.offset(1);
        }];
    }
    return self;
}

- (void)addModelToDataModel:(MHSystemMsgModel *)model
{
    if(model.comment.length > 0) {
        
        [self.contLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_top).offset(-9);
        }];
        [self.contLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contLab.mas_bottom).offset(0);
        }];
        self.contLab4.hidden = NO;
        self.contLab4.text = model.comment;
    }else {
        [self.contLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_top);
        }];
        [self.contLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contLab.mas_bottom).offset(10);
        }];
        self.contLab4.hidden = YES;
    }
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.fromProfile] placeholderImage:normal_placeHeadImg];
    self.contLab.text = model.fromNickName;
    self.contLab2.text = model.createTime;
    self.contLab3.text = model.content;
    
//    1. IMAGE(图片) 、VIDEO(视频)、AUDIO(音频)、TEXT(纯文本)
    [self.chosImage removeAllSubviews];
    
    if([model.activityMediaType isEqualToString:@"IMAGE"] || [model.activityMediaType isEqualToString:@"VIDEO"]) {
        self.contLab5.hidden = YES;
        self.chosImage.hidden = NO;
        
        if([model.activityMediaType isEqualToString:@"VIDEO"]) {

            [self.chosImage sd_setImageWithURL:[NSURL URLWithString:minStr(model.videoCover)]];
//            UIImageView *vidMM = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
//            vidMM.image = [UIImage imageNamed:@"topic_postTopic_video2"];
//            [self.chosImage addSubview:vidMM];
            
        }else {
            NSArray *arMM = [model.activityContent componentsSeparatedByString:@","];
            [self.chosImage sd_setImageWithURL:[NSURL URLWithString:minStr(arMM[0])]];
        }
        
    }else if([model.activityMediaType isEqualToString:@"AUDIO"]) {
        self.contLab5.hidden = NO;
        self.chosImage.hidden = YES;
        
        self.contLab5.textColor = normalPurpleColors;
        self.contLab5.text = eLocalizedString(@"plaza_all6");
    }else if([model.activityMediaType isEqualToString:@"TEXT"]) {
        self.contLab5.hidden = NO;
        self.chosImage.hidden = YES;
        
        self.contLab5.textColor = RGB(180, 180, 180);
        self.contLab5.text = model.activityContent;
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
