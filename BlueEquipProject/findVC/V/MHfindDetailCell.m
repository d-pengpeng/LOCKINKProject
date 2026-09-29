//
//  MHfindDetailCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHfindDetailCell.h"

@interface MHfindDetailCell ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *msgLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIImageView *loveImg;
@property (nonatomic, strong) UILabel *loveLab;
@property (nonatomic, strong) UIButton *huifuBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIView *linVVV;
@property (nonatomic, strong) NSIndexPath *indPP;
@end

@implementation MHfindDetailCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHfindDetailCell";
    MHfindDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHfindDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHfindDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.layer.cornerRadius = 20;
        self.headImgV.image = normal_placeHeadImg;
        [self.contentView addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(16);
            make.width.height.offset(40);
        }];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        self.nickLab.text = eLocalizedString(@"me_allNames3");
        [self.contentView addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.top.equalTo(self.headImgV.mas_top).offset(-3);
            make.height.offset(23);
            make.right.equalTo(self.contentView.mas_right).offset(-80);
        }];
        
        self.loveLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentRight];
        self.loveLab.text = @"0";
        [self.contentView addSubview:self.loveLab];
        [self.loveLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.nickLab.mas_centerY);
        }];
        
        self.loveImg = [HistoryRecordModel createImgImgView];
        self.loveImg.image = [UIImage imageNamed:@"find_loveImg"];
        [self.contentView addSubview:self.loveImg];
        [self.loveImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.loveLab.mas_left).offset(-4);
            make.centerY.equalTo(self.nickLab.mas_centerY);
            make.width.height.offset(16);
        }];
        
        UIButton *lovBBB = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-80, 10, 80, 32)];
        [lovBBB addTarget:self action:@selector(loveBtnMethodMM) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:lovBBB];
        
        
        self.msgLab = [HistoryRecordModel createLabLabTextColor:RGB(94, 94, 94) fontFloat:16 textAlignment:NSTextAlignmentLeft];
        self.msgLab.numberOfLines = 0;
        [self.contentView addSubview:self.msgLab];
        [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.top.equalTo(self.headImgV.mas_centerY).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-44);
            make.height.mas_greaterThanOrEqualTo(18);
        }];
        
        UIView *gapVV = [[UIView alloc] init];
        [self.contentView addSubview:gapVV];
        [gapVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.bottom.equalTo(self.headImgV);
            make.right.equalTo(self.loveImg.mas_left);
        }];
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [gapVV addGestureRecognizer:longPressGesture];
        
        
        self.timeLab = [HistoryRecordModel createLabLabTextColor:RGB(169, 169, 169) fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.top.equalTo(self.msgLab.mas_bottom);
            make.height.offset(32);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
        }];
        
        self.huifuBtn = [HistoryRecordModel createImgBtn];
        [self.huifuBtn setTitle:eLocalizedString(@"find_detail6") forState:UIControlStateNormal];
        [self.huifuBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        self.huifuBtn.titleLabel.font = SYS_Font(12);
        [self.huifuBtn addTarget:self action:@selector(huifuBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.huifuBtn];
        [self.huifuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLab.mas_right);
            make.centerY.equalTo(self.timeLab.mas_centerY);
            make.height.offset(32);
            make.width.mas_greaterThanOrEqualTo(40);
        }];
        
        self.deleteBtn = [HistoryRecordModel createImgBtn];
        [self.deleteBtn setTitle:eLocalizedString(@"find_detail7") forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:normalColors forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.font = SYS_Font(12);
        [self.deleteBtn addTarget:self action:@selector(deleteBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.timeLab.mas_centerY);
            make.height.offset(32);
            make.width.mas_greaterThanOrEqualTo(40);
        }];
        
        self.linVVV = [HistoryRecordModel createLineViewUIUI];
        [self.contentView addSubview:self.linVVV];
        [self.linVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.offset(1);
        }];
    }
    return self;
}

- (void)addDataToModel:(MHfindDetailModel *)model indeP:(NSIndexPath *)row
{
    self.indPP = row;
    
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
    self.nickLab.text = model.nickName;
    self.msgLab.text = model.content;
    self.timeLab.text = model.commentTime;
    
    self.loveLab.text = minIntStr(model.likesCount);

    self.deleteBtn.hidden = !model.allowDeleted;
    
    if(model.isLikes) {
        
        self.loveLab.textColor = RGB(239, 14, 14);
        self.loveImg.image = [UIImage imageNamed:@"find_loveSelImg"];
    }else {
        self.loveLab.textColor = GrayText102;
        self.loveImg.image = [UIImage imageNamed:@"find_loveImg"];
    }
    
    self.linVVV.hidden = model.subArr.count>0 ? YES:NO;
    
}

- (void)huifuBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(findDetailCellDelegateNum:indP:)]) {
        [self.delegate_ findDetailCellDelegateNum:1 indP:self.indPP];
    }
}

- (void)deleteBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(findDetailCellDelegateNum:indP:)]) {
        [self.delegate_ findDetailCellDelegateNum:2 indP:self.indPP];
    }
}

- (void)loveBtnMethodMM
{
    if([self.delegate_ respondsToSelector:@selector(findDetailCellDelegateNum:indP:)]) {
        [self.delegate_ findDetailCellDelegateNum:3 indP:self.indPP];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // 当手势开始时执行的代码
        if([self.delegate_ respondsToSelector:@selector(findDetailCellDelegateNum:indP:)]) {
            [self.delegate_ findDetailCellDelegateNum:4 indP:self.indPP];
        }
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
