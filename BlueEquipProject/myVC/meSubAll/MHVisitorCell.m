//
//  MHVisitorCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import "MHVisitorCell.h"

@interface MHVisitorCell ()

@property (nonatomic, strong) NSIndexPath *indPPPx;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *xxxLab;
@property (nonatomic, strong) UIButton *focusBtn;
@end

@implementation MHVisitorCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHVisitorCell";
    MHVisitorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHVisitorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHVisitorCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *al_VV = [[UIView alloc] init];
        al_VV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:al_VV];
        [al_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
            make.height.offset(70);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.frame = CGRectMake(12, 8, 54, 54);
//        self.headImgV.image = [UIImage clipImgWithName:normal_placeHeadImg radius:6];
        self.headImgV.layer.cornerRadius = 27;
        [al_VV addSubview:self.headImgV];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.nickLab.text = eLocalizedString(@"me_allNames3");
        [al_VV addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.top.equalTo(self.headImgV.mas_top);
            make.height.offset(27);
            make.width.mas_lessThanOrEqualTo(100);
        }];
        
        self.timeLab = [HistoryRecordModel createLabLabTextColor:RGB(180, 180, 180) fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [al_VV addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nickLab.mas_right).offset(6);
            make.centerY.equalTo(self.nickLab.mas_centerY);
        }];
        
        self.xxxLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [al_VV addSubview:self.xxxLab];
        [self.xxxLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.top.equalTo(self.headImgV.mas_centerY);
            make.height.offset(27);
            make.right.equalTo(al_VV.mas_right).offset(-80);
        }];
        
        self.focusBtn = [[UIButton alloc] init];
        [self.focusBtn setTitle:eLocalizedString(@"attent_normal") forState:UIControlStateNormal];
        [self.focusBtn setTitle:eLocalizedString(@"attent_sel") forState:UIControlStateSelected];
        [self.focusBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.focusBtn setTitleColor:normalPurpleColors forState:UIControlStateSelected];
        self.focusBtn.titleLabel.font = SYS_Font(12);
        self.focusBtn.layer.cornerRadius = 12;
        self.focusBtn.backgroundColor = normalPurpleColors;
        self.focusBtn.layer.borderColor = normalPurpleColors.CGColor;
        self.focusBtn.layer.borderWidth = 1;
        [self.focusBtn addTarget:self action:@selector(focusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:self.focusBtn];
        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(al_VV.mas_centerY);
            make.right.equalTo(al_VV.mas_right).offset(-12);
            make.width.offset(54);
            make.height.offset(24);
        }];
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        [al_VV addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nickLab.mas_left);
            make.bottom.equalTo(al_VV.mas_bottom);
            make.right.equalTo(al_VV.mas_right).offset(12);
            make.height.offset(1);
        }];
        
    }
    return self;
    
}

- (void)focusBtnClick
{
    if([self.delegate_ respondsToSelector:@selector(MHVisitorCellDelegateMEthodRow:indeP:)]) {
        [self.delegate_ MHVisitorCellDelegateMEthodRow:1 indeP:self.indPPPx];
    }
}

- (void)addDataToModel:(MHVisitorModel *)modelM indeP:(NSIndexPath *)row typeN:(nonnull NSString *)typNum
{
//    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:modelM.profile] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if(image) {
//            self.headImgV.image = [UIImage clipImgWithName:image radius:6];
//        }else {
//            self.headImgV.image = [UIImage clipImgWithName:normal_placeHeadImg radius:6];
//        }
//    }];
    self.indPPPx = row;
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:modelM.profile] placeholderImage:normal_placeHeadImg];
    
    self.nickLab.text = modelM.nickName;
    self.timeLab.text = modelM.accessTime;
    if([typNum isEqualToString:@"2"]) {
        
        NSString *acce_str = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"me_allNames20_20"), modelM.accessCount, eLocalizedString(@"me_allNames21")];
        self.xxxLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:minIntStr(modelM.accessCount) All:acce_str nameFont:SYS_Font(12) allFont:SYS_Font(12) nameColor:normalColors allColor:GrayText102];
    }else {
        NSString *acce_str = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"me_allNames20"), modelM.accessCount, eLocalizedString(@"me_allNames21")];
        self.xxxLab.attributedText = [HistoryRecordModel AttributedStringTwoTogether:minIntStr(modelM.accessCount) All:acce_str nameFont:SYS_Font(12) allFont:SYS_Font(12) nameColor:normalColors allColor:GrayText102];
    }
    self.focusBtn.selected = modelM.isFollowed;
    if(modelM.isFollowed) {
        self.focusBtn.backgroundColor = UIColor.clearColor;
    }else {
        self.focusBtn.backgroundColor = normalPurpleColors;
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
