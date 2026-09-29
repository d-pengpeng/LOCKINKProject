//
//  TPatternMessageCellData.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/8.
//

#import "TUIMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPatternMessageCellData : TUIMessageCellData
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avator;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *recordId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *dayId;
@end

NS_ASSUME_NONNULL_END
