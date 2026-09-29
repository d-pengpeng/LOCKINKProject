//
//  MHfocusCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import "MHfocusCell.h"

@interface MHfocusCell ()

@property (nonatomic, assign) NSInteger indPPPx;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UIButton *focusBtn;
@end

@implementation MHfocusCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHfocusCell";
    MHfocusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHfocusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHfocusCell"];
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
        
        UIButton *clicBBBB = [[UIButton alloc] initWithFrame:CGRectMake(12, 8, 54, 54)];
        [clicBBBB addTarget:self action:@selector(clickBBBtnmEthod) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:clicBBBB];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.nickLab.text = eLocalizedString(@"me_allNames3");
        [al_VV addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.width.mas_lessThanOrEqualTo(100);
        }];
        
        self.focusBtn = [[UIButton alloc] init];
        [self.focusBtn setTitle:eLocalizedString(@"plaza_all1") forState:UIControlStateNormal];
        [self.focusBtn setTitle:eLocalizedString(@"plaza_all1_1") forState:UIControlStateSelected];
        [self.focusBtn setTitleColor:normalPurpleColors forState:UIControlStateNormal];
        self.focusBtn.titleLabel.font = SYS_Font(12);
        self.focusBtn.layer.cornerRadius = 12;
        self.focusBtn.backgroundColor = UIColor.clearColor;
        self.focusBtn.layer.borderColor = normalPurpleColors.CGColor;
        self.focusBtn.layer.borderWidth = 1;
        [self.focusBtn addTarget:self action:@selector(focusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:self.focusBtn];
        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(al_VV.mas_centerY);
            make.right.equalTo(al_VV.mas_right).offset(-12);
            make.width.offset(80);
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
    if([self.delegate_ respondsToSelector:@selector(MHfocusCellDelegateMEthodRow:)]) {
        [self.delegate_ MHfocusCellDelegateMEthodRow:self.indPPPx];
    }
}

- (void)clickBBBtnmEthod
{
    if([self.delegate_ respondsToSelector:@selector(MHfocusCellDelegateMEthodClickAvatorRow:)]) {
        [self.delegate_ MHfocusCellDelegateMEthodClickAvatorRow:self.indPPPx];
    }
}

- (void)addDataToModel:(MHVisitorModel *)modelM indeP:(NSInteger)row
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
    self.focusBtn.selected = YES;
}

- (void)addDataToFensiModel:(MHVisitorModel *)modelM indeP:(NSInteger)row
{
    self.indPPPx = row;
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:modelM.profile] placeholderImage:normal_placeHeadImg];
    self.nickLab.text = modelM.nickName;
    self.focusBtn.selected = modelM.isFollowed;
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
