//
//  TUCustomPatternCellCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/8.
//

#import "TUCustomPatternCellCell.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"

@implementation TUCustomPatternCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.container.backgroundColor = UIColor.clearColor;
        
        _thumb = [[UIImageView alloc] init];
        _thumb.layer.cornerRadius = 5.0;
        [_thumb.layer setMasksToBounds:YES];
        _thumb.contentMode = UIViewContentModeScaleAspectFill;
        _thumb.backgroundColor = [UIColor clearColor];
        [self.container addSubview:_thumb];
        _thumb.mm_fill();
        _thumb.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        UIView *allVVV = [HistoryRecordModel createViewUIUI];
        allVVV.backgroundColor = UIColor.clearColor;
        [self.container addSubview:allVVV];
        [allVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.container.mas_left).offset(0);
            make.top.equalTo(self.container.mas_top);
            make.right.equalTo(self.container.mas_right).offset(0);
            make.height.offset(72);
        }];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.image = [UIImage imageNamed:@"mode_placeAA-03Img"];
        self.headImgV.layer.cornerRadius = 24;
        [allVVV addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(allVVV.mas_left).offset(12);
            make.bottom.equalTo(allVVV.mas_bottom).offset(-12);
            make.width.offset(48);
            make.height.offset(48);
        }];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [allVVV addSubview:self.oneLab];
        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.top.equalTo(self.headImgV.mas_top);
            make.right.equalTo(allVVV.mas_right).offset(-60);
            make.height.offset(24);
        }];
        
        self.twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        self.twoLab.numberOfLines = 2;
        [allVVV addSubview:self.twoLab];
        [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.bottom.equalTo(self.headImgV.mas_bottom);
            make.right.equalTo(allVVV.mas_right).offset(-60);
            make.height.mas_greaterThanOrEqualTo(24);
        }];
        
        UILabel *nexLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
        nexLab.text = @">";
        [allVVV addSubview:nexLab];
        [nexLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(allVVV.mas_right).offset(-26);
            make.top.equalTo(self.headImgV.mas_top).offset(4);
            make.width.height.offset(14);
        }];
    }
    return self;
}

- (void)fillWithData:(TPatternMessageCellData *)data;
{
    [super fillWithData:data];
    
    self.textData = data;
    self.backgroundColor = UIColor.clearColor;

    self.oneLab.text = data.nickName;
    
    if([data.type intValue] > 3) {
        if([data.dayId intValue] > 0) {
            if(data.direction == MsgDirectionIncoming) {
                self.twoLab.text = [NSString stringWithFormat:@"%@%@ %@", data.dayId, eLocalizedString(@"role_name14"), eLocalizedString(@"chat_all23")];
            }else {
                self.twoLab.text = [NSString stringWithFormat:@"%@%@ %@", data.dayId, eLocalizedString(@"role_name14"), eLocalizedString(@"chat_all22")];
            }
        }else {
            if(data.direction == MsgDirectionIncoming) {
                self.twoLab.text = [NSString stringWithFormat:@"%@ %@", eLocalizedString(@"role_setting38"), eLocalizedString(@"chat_all23")];
            }else {
                self.twoLab.text = [NSString stringWithFormat:@"%@ %@", eLocalizedString(@"role_setting38"), eLocalizedString(@"chat_all22")];
            }
        }
    }else {
        if([data.type isEqualToString:@"1"]) {
            if(data.direction == MsgDirectionIncoming) {
                self.twoLab.text = eLocalizedString(@"chat_all20");
            }else {
                self.twoLab.text = eLocalizedString(@"chat_all20_20");
            }
        }else {
            if(data.direction == MsgDirectionIncoming) {
                self.twoLab.text = eLocalizedString(@"chat_all21");
            }else {
                self.twoLab.text = eLocalizedString(@"chat_all21_21");
            }
        }
    }
    
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:data.content] placeholderImage:[UIImage imageNamed:@"mode_placeAA-03Img"]];
    
    if(data.direction == MsgDirectionIncoming) {

        _thumb.image = [UIImage imageNamed:@"message_bubbleImg"];
    }else {
        _thumb.image = [UIImage imageNamed:@"message_bubbleSelImg"];
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
