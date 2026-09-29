//
//  MHEquipmentCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/21.
//

#import "MHEquipmentCell.h"
#import "UIView+Frame.h"

@interface MHEquipmentCell ()

@property (nonatomic, strong) UIView *oneV;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *twoLab;
@property (nonatomic, strong) UILabel *thrLab;
@property (nonatomic, strong) UIView *fouLab;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UIImageView *dcImgV;
@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, assign) NSInteger rowMM;
@end
@implementation MHEquipmentCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHEquipmentCell";
    MHEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHEquipmentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHEquipmentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.oneV = [[UIView alloc] init];
        self.oneV.clipsToBounds = YES;
        [self.contentView addSubview:self.oneV];
        [self.oneV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.height.offset(80);
        }];
        
        UIImageView *imgPlaceV = [HistoryRecordModel createImgImgView];
        imgPlaceV.image = [UIImage imageNamed:@"home_img2"];
        [self.oneV addSubview:imgPlaceV];
        [imgPlaceV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.oneV);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 30;
        [self.oneV addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneV.mas_left).offset(12);
            make.centerY.equalTo(self.oneV.mas_centerY);
            make.width.height.offset(60);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.oneV addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.top.equalTo(self.headImgV.mas_top);
            make.height.offset(30);
            make.right.equalTo(self.oneV.mas_right).offset(-80);
        }];
        
        self.twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.oneV addSubview:self.twoLab];
        [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
//            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.bottom.equalTo(self.headImgV.mas_bottom);
            make.height.offset(30);
        }];
        
        
        self.dcImgV = [HistoryRecordModel createImgImgView];
        self.dcImgV.backgroundColor = UIColor.clearColor;
        [self.oneV addSubview:self.dcImgV];
        [self.dcImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoLab.mas_right).offset(6);
            make.centerY.equalTo(self.twoLab.mas_centerY);
            make.width.offset(22);
            make.height.offset(12);
        }];
        
        UIView *el_v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 21, 12)];
        el_v1.backgroundColor = UIColor.clearColor;
        el_v1.layer.cornerRadius = 2;
        el_v1.clipsToBounds = YES;
        el_v1.layer.borderColor = RGB(12, 104, 13).CGColor;
        el_v1.layer.borderWidth = 1;
        [self.dcImgV addSubview:el_v1];
        
        UIView *el_v2 = [[UIView alloc] initWithFrame:CGRectMake(21, 4, 1, 4)];
        el_v2.backgroundColor = RGB(12, 104, 13);
        [self.dcImgV addSubview:el_v2];
        
        self.fouLab = [[UIView alloc] initWithFrame:CGRectMake(1.5, 1.5, 10, 9)];
        self.fouLab.backgroundColor = RGB(12, 104, 13);
        [self.dcImgV addSubview:self.fouLab];
        
        self.dcImgV.hidden = YES;
        self.fouLab.hidden = YES;
        self.twoLab.hidden = YES;
        
        self.thrLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.oneV addSubview:self.thrLab];
        [self.thrLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.bottom.equalTo(self.headImgV.mas_bottom);
        }];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        nexImgv.image = [UIImage imageNamed:@"home_next2"];
        [self.oneV addSubview:nexImgv];
        [nexImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.oneV.mas_right).offset(-12);
            make.centerY.equalTo(self.oneV.mas_centerY);
            make.width.height.offset(22);
        }];
        
     }
    return self;
}

- (void)addDataToDic:(MHEquipmentModel *)model row:(NSInteger)rowL
{
    if(model.id > 0) {
        
        self.oneV.hidden = NO;
        
        self.rowMM = rowL;
        self.deleBtn.hidden = !model.isShowDelete;
        
        self.oneLab.text = model.name;
//        if(model.isShowLinks) {
//            self.twoLab.text = eLocalizedString(@"home_nam3");
//        }else {
//            self.twoLab.text = eLocalizedString(@"home_nam1");
//        }
        
        self.twoLab.hidden = NO;
        self.dcImgV.hidden = NO;
        self.fouLab.hidden = NO;
        self.fouLab.width = [model.remainingCharge intValue]*0.18;
        
    //    self.fouLab.text = [NSString stringWithFormat:@"%@%@", model.electricity, @"%"];
        if([model.realName isEqualToString:kCharactName2] || [model.realName isEqualToString:kCharactName12]) {
            [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:app_placeAA2_img];
        }else {
            [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:app_placeAA1_img];
        }
        
    }else {
        self.oneV.hidden = YES;
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
