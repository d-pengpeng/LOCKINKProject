//
//  TRedbagMessageCellData.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/18.
//

#import "TRedbagMessageCellData.h"

@implementation TRedbagMessageCellData

- (instancetype)initWithDirection:(TMsgDirection)direction {
    self = [super initWithDirection:direction];
    if (self) {
        
        if (direction == MsgDirectionIncoming) {
            self.cellLayout = [TUIMessageCellLayout incommingTextMessageLayout222]; //c2c样式
        } else {
            self.cellLayout = [TUIMessageCellLayout outgoingTextMessageLayout222];//c2c样式
        }
        self.reuseId = TRedbagMessageCell_ReuseId;
    }
    return self;
}

- (CGSize)contentSize
{
    return TRedbagMessageCell_Container_Size;
}

@end
