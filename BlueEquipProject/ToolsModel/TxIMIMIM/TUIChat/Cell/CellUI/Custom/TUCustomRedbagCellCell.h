//
//  TUCustomRedbagCellCell.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/18.
//

#import "TUIMessageCell.h"
#import "TRedbagMessageCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface TUCustomRedbagCellCell : TUIMessageCell

/**
 *  内容标签
 *  用于展示文本消息的内容。
 */
@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UIImageView *thumb;

@property (nonatomic, strong) UIImageView *thumb2;

@property (nonatomic, strong) UILabel *subContent;

@property (nonatomic, strong) UILabel *msgLab;

@property (nonatomic, strong) UIView *linVVVV;
@property (nonatomic, strong) UIView *spaceVVV;

/**
 *  文本消息单元数据源
 *  数据源内存放了文本消息的内容信息、消息字体、消息颜色、并存放了发送、接收两种状态下的不同字体颜色。
 */
@property TRedbagMessageCellData *textData;

/**
 *  填充数据
 *  根据 data 设置文本消息的数据。
 *
 *  @param  data    填充数据需要的数据源
 */
- (void)fillWithData:(TRedbagMessageCellData *)data;
@end

NS_ASSUME_NONNULL_END
