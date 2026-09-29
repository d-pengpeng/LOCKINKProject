//
//  MHSearLocationCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/4/3.
//

#import "MHSearLocationCell.h"

@interface MHSearLocationCell ()

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *nameLab2;
@property (nonatomic, strong) UILabel *nameLab3;
@end

@implementation MHSearLocationCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHSearLocationCell";
    MHSearLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHSearLocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHSearLocationCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        self.nameLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.offset(22);
        }];
        
        self.nameLab2 = [HistoryRecordModel createLabLabTextColor:RGB(169, 169, 169) fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab2];
        [self.nameLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.nameLab.mas_bottom);
            make.height.offset(20);
        }];
        
        self.nameLab3 = [HistoryRecordModel createLabLabTextColor:RGB(169, 169, 169) fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLab3];
        [self.nameLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLab2.mas_right).offset(2);
            make.top.equalTo(self.nameLab.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.mas_greaterThanOrEqualTo(20);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        [self.contentView addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.offset(1);
        }];
    }
    return self;
}

- (void)addTwoModelToDataModel:(MKMapItem *)model coor:(CLLocationCoordinate2D)coor
{
    self.nameLab.text = model.name;
    self.nameLab2.text = [NSString stringWithFormat:@"%.f m | ", [HistoryRecordModel distanceBetweenOrderByLat1:model.placemark.location.coordinate.latitude Lat2:coor.latitude Long1:model.placemark.location.coordinate.longitude Long2:coor.longitude]];
    self.nameLab3.text = [NSString stringWithFormat:@"%@%@%@", model.placemark.administrativeArea?model.placemark.administrativeArea:@"", model.placemark.locality?model.placemark.locality:@"", model.placemark.thoroughfare?model.placemark.thoroughfare:@""];
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
