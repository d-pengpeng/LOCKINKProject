#import "TUIJoinGroupMessageCellData.h"

@implementation TUIJoinGroupMessageCellData

- (instancetype)initWithDirection:(TMsgDirection)direction
{
    self = [super initWithDirection:direction];
    if (self) {
        self.userNameList = [NSMutableArray array];
        self.userIDList = [NSMutableArray array];
        self.reuseId = TJoinGroupMessageCell_ReuseId;
    }
    return self;
}

//- (CGSize)contentSize
//{
//    return CGSizeMake(TTextMessageCell_Text_Width_Maxtwo, 60);
//}

@end
