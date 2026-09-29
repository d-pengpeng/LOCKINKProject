//
//  MHAddPlaylistCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/2.
//

#import "MHAddPlaylistCell.h"
@interface MHAddPlaylistCell ()

@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *twoLab;
@property (nonatomic, strong) UIImageView *selImgV;
@end
@implementation MHAddPlaylistCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHAddPlaylistCell";
    MHAddPlaylistCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHAddPlaylistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHAddPlaylistCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.selImgV = [HistoryRecordModel createImgImgView];
        [self.contentView addSubview:self.selImgV];
        [self.selImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(8);
            make.width.height.offset(42);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selImgV.mas_right).offset(8);
            make.top.equalTo(self.selImgV.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.offset(22);
        }];
        
        self.twoLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.twoLab];
        [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selImgV.mas_right).offset(8);
            make.top.equalTo(self.oneLab.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.offset(20);
        }];
    }
    return self;
}

- (void)addDataToDic:(MHLibraryModel *)model
{
    NSArray *arrM = [model.nameL componentsSeparatedByString:@"**"];
    if(arrM.count>0) {
        self.selImgV.image = [UIImage imageNamed:@"playlist_imgs13"];
        NSArray *arrMSub = [minStr(arrM[0]) componentsSeparatedByString:@"-&-"];
        self.oneLab.text = minStr(arrMSub[1]);
        self.twoLab.text = [NSString stringWithFormat:@"%d Songs", (int)arrM.count-1];
    }else {
        self.selImgV.image = [UIImage imageNamed:@"playlist_imgs13"];
        self.oneLab.text = model.nameL.length>0 ? model.nameL:@"name";
        self.twoLab.text = @"0 Songs";
    }
}

- (void)addMusicDataToDic:(MHLibraryModel *)model
{
    self.selImgV.image = [UIImage imageNamed:@"playlist_imgs13"];
    self.oneLab.text = minStr(model.nameL);
    self.twoLab.text = minStr(model.nickN);
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
