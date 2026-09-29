//
//  TUCustomPatternCellCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/8.
//

#import "TUIMessageCell.h"
#import "TPatternMessageCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface TUCustomPatternCellCell : TUIMessageCell
/**
 *  内容标签
 *  用于展示文本消息的内容。
 */

@property (nonatomic, strong) UIImageView *thumb;

@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *twoLab;
@property (nonatomic, strong) UIImageView *headImgV;
/**
 *  文本消息单元数据源
 *  数据源内存放了文本消息的内容信息、消息字体、消息颜色、并存放了发送、接收两种状态下的不同字体颜色。
 */
@property TPatternMessageCellData *textData;

/**
 *  填充数据
 *  根据 data 设置文本消息的数据。
 *
 *  @param  data    填充数据需要的数据源
 */
- (void)fillWithData:(TPatternMessageCellData *)data;
@end

NS_ASSUME_NONNULL_END
