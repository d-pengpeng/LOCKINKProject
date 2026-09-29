//
//  TUICommonTextCell.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/5.
//

#import "TUICommonTextCell.h"
#import "TUIDefine.h"

@implementation TUICommonTextCellData
- (instancetype)init {
    self = [super init];

    return self;
}

@end

@interface TUICommonTextCell()
@property TUICommonTextCellData *textData;
@end

@implementation TUICommonTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])
    {
        _keyLabel = self.textLabel;
        _keyLabel.textColor = [UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark];
        
        _valueLabel = self.detailTextLabel;
        _valueLabel.textColor = [UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.changeColorWhenTouched = YES;
        
        _imgHH = [HistoryRecordModel createImgImgView];
        _imgHH.image = normal_placeHeadImg;
        [self.contentView addSubview:_imgHH];
        [_imgHH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.offset(42);
        }];
        _imgHH.hidden = YES;
    }
    return self;
}


- (void)fillWithData:(TUICommonTextCellData *)textData
{
    [super fillWithData:textData];

    self.textData = textData;
    RAC(_keyLabel, text) = [RACObserve(textData, key) takeUntil:self.rac_prepareForReuseSignal];
    RAC(_valueLabel, text) = [RACObserve(textData, value) takeUntil:self.rac_prepareForReuseSignal];

    if(textData.typeMM == 1) {
        _imgHH.hidden = NO;
        _imgHH.image = [UIImage imageNamed:@"chat_imgs9"];
        _imgHH.layer.cornerRadius = 0;
        [_imgHH mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(22);
        }];
    }else if(textData.typeMM == 2) {
        _valueLabel.text = @"";
        _imgHH.hidden = NO;
        _imgHH.layer.cornerRadius = 21;
        [_imgHH mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(42);
        }];
        [_imgHH sd_setImageWithURL:[NSURL URLWithString:minStr(textData.value)] placeholderImage:normal_placeHeadImg];
    }else {
        _imgHH.hidden = YES;
    }
    self.typeMM = textData.typeMM >= 0 ? textData.typeMM:10;
    if (textData.showAccessory) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
