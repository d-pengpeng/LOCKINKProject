//
//  TUCustomPlaceCellData.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/1.
//

#import "TUCustomPlaceCellData.h"
#import "TUIDefine.h"
#import "NSString+TUIUtil.h"

@implementation TUCustomPlaceCellData
- (instancetype)initWithDirection:(TMsgDirection)direction
{
    self = [super initWithDirection:direction];
    if (self) {
        _contentFont = [UIFont systemFontOfSize:13];
        _contentColor = [UIColor d_systemGrayColor];
        self.cellLayout =  [TUIMessageCellLayout systemMessageLayout];
        self.reuseId = TCustomPlaceCell_ReuseId;
    }
    return self;
}

- (CGSize)contentSize
{
    CGSize size = [self.content textSizeIn:CGSizeMake(TSystemMessageCell_Text_Width_Max, MAXFLOAT) font:self.contentFont];
    size.height += 10;
    size.width += 16;
    return size;
}

- (CGFloat)heightOfWidth:(CGFloat)width
{
    return [self contentSize].height; //+ 16;
}

@end
