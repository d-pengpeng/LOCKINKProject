//
//  TUCustomGiftCellCell.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/11/25.
//

#import "TUIMessageCell.h"
#import "TUCustomGiftCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface TUCustomGiftCellCell : TUIMessageCell

/**
 *  内容标签
 *  用于展示文本消息的内容。
 */
@property (nonatomic, strong) UILabel *content;

/**
 *  文本消息单元数据源
 *  数据源内存放了文本消息的内容信息、消息字体、消息颜色、并存放了发送、接收两种状态下的不同字体颜色。
 */
@property TUCustomGiftCellData *textData;

/**
 *  填充数据
 *  根据 data 设置文本消息的数据。
 *
 *  @param  data    填充数据需要的数据源
 */
- (void)fillWithData:(TUCustomGiftCellData *)data;
@end

NS_ASSUME_NONNULL_END
