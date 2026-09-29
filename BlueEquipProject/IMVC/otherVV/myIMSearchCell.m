//
//  myIMSearchCell.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/28.
//

#import "myIMSearchCell.h"
#import "TUICommonModel.h"
@interface myIMSearchCell ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *oneLab2;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, assign) NSInteger inTypN;
@end
@implementation myIMSearchCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"myIMSearchCell";
    myIMSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[myIMSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myIMSearchCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.image = normal_placeHeadImg;
        self.headImgV.layer.cornerRadius = 5;
        [self.contentView addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.width.height.offset(48);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
        }];
        
        self.addBtn = [HistoryRecordModel createImgBtn];
        self.addBtn.layer.cornerRadius = 13;
        self.addBtn.layer.borderColor = RGB(227, 172, 114).CGColor;
        self.addBtn.layer.borderWidth = 1;
        [self.addBtn setTitleColor:RGB(227, 172, 114) forState:UIControlStateNormal];
        self.addBtn.titleLabel.font = SYS_Font(14);
        [self.addBtn addTarget:self action:@selector(addBtnMetodUIUI) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addBtn];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.headImgV.mas_centerY);
            make.height.offset(26);
            make.width.offset(72);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.right.equalTo(self.addBtn.mas_left).offset(-10);
        }];
        
        self.oneLab2 = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:12 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.oneLab2];
        [self.oneLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.right.equalTo(self.addBtn.mas_left).offset(-10);
        }];
        
        UIView *linVV = [HistoryRecordModel createLineViewUIUI];
        [self.contentView addSubview:linVV];
        [linVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneLab.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.height.offset(1);
        }];
    }
    return self;
}

- (void)addModelToDataMode:(myIMSearchModel *)model lisC2CBoo:(BOOL)isBBoo indexP:(NSInteger)rowNN
{
    self.inTypN = rowNN;
    
    if(isBBoo) {
        self.oneLab2.hidden = NO;
        
        [self.addBtn setTitle:model.is_follow ? eLocalizedString(@"sliding_chats"):eLocalizedString(@"my_focus_focus") forState:UIControlStateNormal];
        
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgV.mas_top);
            make.bottom.equalTo(self.headImgV.mas_centerY);
        }];
        
        [self.oneLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgV.mas_centerY);
            make.bottom.equalTo(self.headImgV.mas_bottom);
        }];
        
        self.oneLab.text = minStr(model.user_nickname);
        self.oneLab2.text = [NSString stringWithFormat:@"%@%@", eLocalizedString(@"my_focus_focusNumber"), [HistoryRecordModel getNumbersChangeWWW:model.attention]];
        
        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:normal_placeHeadImg];
    }else {
        [self.addBtn setTitle:eLocalizedString(@"contact_friend13") forState:UIControlStateNormal];
        self.addBtn.hidden = model.is_join;
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.headImgV);
        }];
        
        self.oneLab.text = [NSString stringWithFormat:@"%@(%d)", model.name, model.num];
        self.oneLab2.hidden = YES;
        
        if(model.img.length>0) {
            [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:normal_placeHeadImg];
        }else {
            [TUIGroupAvatar getCacheGroupAvatar:model.groupid callback:^(UIImage *avatar) {
                if (avatar != nil) { //已缓存群组头像
                    self.headImgV.image = avatar;
                } else { //未缓存群组头像
//                    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:normal_placeHeadImg];
                    [TUIGroupAvatar fetchGroupAvatars:model.groupid placeholder:normal_placeHeadImg callback:^(BOOL success, UIImage *image, NSString *groupID) {
                        if ([groupID isEqualToString:model.groupid]) {
                            // 需要判断下，防止复用问题
//                            [self.headImgV sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:image];
                            self.headImgV.image = image;
                        }
                    }];
                }
            }];
        }
    }
}

- (void)addBtnMetodUIUI
{
    if([self.delegate_ respondsToSelector:@selector(myIMSearchCellDDetgateNrwo:)]) {
        [self.delegate_ myIMSearchCellDDetgateNrwo:self.inTypN];
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
