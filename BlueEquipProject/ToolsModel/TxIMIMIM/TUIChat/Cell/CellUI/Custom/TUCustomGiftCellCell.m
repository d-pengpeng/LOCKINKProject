//
//  TUCustomGiftCellCell.m
//  DragonTeethLive
//
//  Created by Edwin on 2021/11/25.
//

#import "TUCustomGiftCellCell.h"
#import "TUIFaceView.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"

@implementation TUCustomGiftCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
//        [self.bubbleView addSubview:_content];
        [self.contentView addSubview:_content];
    }
    return self;
}



- (void)fillWithData:(TUCustomGiftCellData *)data;
{
    //set data
    [super fillWithTwoData:data];
    self.textData = data;
    self.content.attributedText = data.attributedString;
//    self.content.textColor = data.textColor;
    
    if (data.backContBoo) {
        self.content.backgroundColor = data.backContColor;
        self.backgroundColor = data.backContColor;
    }else {
        self.content.backgroundColor = UIColor.clearColor;
        self.backgroundColor = UIColor.clearColor;
    }
    
}

- (void)highlightWhenMatchKeyword:(NSString *)keyword
{
    // 子类重写高亮文本效果
    TUCustomGiftCellData *data = (TUCustomGiftCellData *)self.data;
    if (data.highlightKeyword == nil) {
        return;
    }
    
    NSRange range = [data.attributedString.string rangeOfString:data.highlightKeyword];
    if (range.location == NSNotFound) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:data.attributedString];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    self.content.attributedText = attr;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.content.frame = (CGRect){.origin = self.textData.textOrigin, .size = self.textData.textSize};
}

@end
