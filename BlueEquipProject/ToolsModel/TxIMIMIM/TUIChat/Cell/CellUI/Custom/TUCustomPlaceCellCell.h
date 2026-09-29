//
//  TUCustomPlaceCellCell.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/1.
//

#import "TUIMessageCell.h"
#import "TUCustomPlaceCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface TUCustomPlaceCellCell : TUIMessageCell


@property (readonly) UILabel *messageLabel;

@property (readonly) TUCustomPlaceCellData *systemData;
/**
 *  填充数据
 *  根据 data 设置系统消息的数据
 *
 *  @param data 填充数据需要的数据源
 */
- (void)fillWithData:(TUCustomPlaceCellData *)data;
@end

NS_ASSUME_NONNULL_END
