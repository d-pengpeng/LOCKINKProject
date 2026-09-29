//
//  TUCustomPlaceCellData.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/1.
//

#import "TUIMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TUCustomPlaceCellData : TUIMessageCellData
/**
 *  系统消息内容，例如“您撤回了一条消息。”
 */
@property (nonatomic, strong) NSString *content;

/**
 *  内容字体
 *  系统消息显示时的 UI 字体。
 */
@property UIFont *contentFont;

/**
 *  内容颜色
 *  系统消息显示时的 UI 颜色。
 */
@property UIColor *contentColor;
@end

NS_ASSUME_NONNULL_END
