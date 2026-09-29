//
//  TPatternMessageCellData.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/8.
//

#import "TPatternMessageCellData.h"

@implementation TPatternMessageCellData
- (instancetype)initWithDirection:(TMsgDirection)direction {
    self = [super initWithDirection:direction];
    if (self) {
        
        if (direction == MsgDirectionIncoming) {
            self.cellLayout = [TUIMessageCellLayout incommingTextMessageLayout222]; //c2c样式
        } else {
            self.cellLayout = [TUIMessageCellLayout outgoingTextMessageLayout222];//c2c样式
        }
        self.reuseId = TPatternMessageCell_ReuseId;
    }
    return self;
}

- (CGSize)contentSize
{
    return TPatternMessageCell_Container_Size;
}

@end
