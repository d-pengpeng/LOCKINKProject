//
//  myConversationListCell.m
//  DragonTeethLive
//
//  Created by Edwin on 2022/10/24.
//

#import "myConversationListCell.h"

@interface myConversationListCell ()

@property (nonatomic, strong) UIView *oneV;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *twoLab;
@property (nonatomic, strong) UIImageView *headImgVV;
@property (nonatomic, strong) UIView *noReadVV;

@property (nonatomic, strong) UILabel *oneLab22;
@property (nonatomic, strong) UIButton *addBBBB;
@property (nonatomic, copy) NSString *user_idid;
@end
@implementation myConversationListCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"myConversationListCell";
    myConversationListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[myConversationListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myConversationListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.oneV = [HistoryRecordModel createViewUIUI];
        self.oneV.backgroundColor = UIColor.clearColor;
        self.oneV.layer.cornerRadius = 1;
        [self.contentView addSubview:self.oneV];
        [self.oneV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.right.bottom.equalTo(self.contentView);
        }];
        
        
        self.headImgVV = [HistoryRecordModel createImgImgView];
        self.headImgVV.layer.cornerRadius = 18;
        self.headImgVV.image = normal_placeHeadImg;
        [self.oneV addSubview:self.headImgVV];
        [self.headImgVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.oneV).offset(12);
            make.bottom.equalTo(self.oneV.mas_bottom).offset(-12);
//            make.width.height.offset(46);
            make.width.height.offset(36);
        }];
        
//        self.noReadVV = [[UIView alloc] initWithFrame:CGRectMake(46, 12, 12, 12)];
//        self.noReadVV.layer.cornerRadius = 6;
//        self.noReadVV.clipsToBounds = YES;
//        self.noReadVV.backgroundColor = UIColor.redColor;
//        [self.oneV addSubview:self.noReadVV];
//        self.noReadVV.hidden = YES;
//
//        self.oneLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
////        [self.oneLab setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//        [self.oneV addSubview:self.oneLab];
//        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.headImgVV.mas_right).offset(12);
//            make.right.equalTo(self.oneV.mas_right).offset(-12);
//            make.top.equalTo(self.headImgVV.mas_top);
//        }];
//
//        self.twoLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:13 textAlignment:NSTextAlignmentLeft];
//        [self.oneV addSubview:self.twoLab];
//        [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.headImgVV.mas_right).offset(12);
//            make.right.equalTo(self.oneV.mas_right).offset(-12);
//            make.bottom.equalTo(self.headImgVV.mas_bottom).offset(-1);
//        }];
        
        
        self.oneLab22 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:15 textAlignment:NSTextAlignmentLeft];
        [self.oneV addSubview:self.oneLab22];
        [self.oneLab22 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgVV.mas_right).offset(12);
            make.right.equalTo(self.oneV.mas_right).offset(-80);
            make.centerY.equalTo(self.headImgVV.mas_centerY);
        }];
        
        self.addBBBB = [HistoryRecordModel createImgBtn];
        self.addBBBB.backgroundColor = normalColors;
        [self.addBBBB setTitle:[NSString stringWithFormat:@"   %@   ", eLocalizedString(@"goodFriend_ttt")] forState:UIControlStateNormal];
        [self.addBBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.addBBBB.titleLabel.font = SYS_Font(10);
        [self.addBBBB addTarget:self action:@selector(sddFriendMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.oneV addSubview:self.addBBBB];
        [self.addBBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.oneV.mas_right).offset(-12);
            make.centerY.equalTo(self.oneV.mas_centerY);
            make.height.offset(24);
        }];
    }
    return self;
}
- (void)addmyHornHistoryCellDic:(V2TIMConversation *)model
{
    self.oneLab.text = model.showName;
    
    [self.headImgVV sd_setImageWithURL:[NSURL URLWithString:model.faceUrl] placeholderImage:normal_placeHeadImg];
    
    self.noReadVV.hidden = model.lastMessage.isRead;
    
    if(model.lastMessage.elemType == V2TIM_ELEM_TYPE_TEXT) {
        
        self.twoLab.text = model.lastMessage.textElem.text;
    }else if(model.lastMessage.elemType == V2TIM_ELEM_TYPE_IMAGE) {
        
        self.twoLab.text = @"图片";
    }
}

- (void)addmyHornAddFriendCellDic:(searchFriendAddModel *)model
{
    self.addBBBB.hidden = model.isFriend;
    self.user_idid = model.userID;
    self.oneLab22.text = model.nickName;
    [self.headImgVV sd_setImageWithURL:[NSURL URLWithString:model.faceURL] placeholderImage:normal_placeHeadImg];
}

- (void)sddFriendMethod
{
    if(self.delegate_ && [self.delegate_ respondsToSelector:@selector(myConversationListCellAddFriendUserId:)]) {
        [self.delegate_ myConversationListCellAddFriendUserId:self.user_idid];
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
