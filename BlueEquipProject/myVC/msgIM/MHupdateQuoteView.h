//
//  MHupdateQuoteView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^updateQuteBLock)(NSString *strLL);
@interface MHupdateQuoteView : UIView

@property (nonatomic, copy) updateQuteBLock block_;
@property (nonatomic, strong) UILabel *titLab;
@property (nonatomic, strong) UITextView *textVV;
@end

NS_ASSUME_NONNULL_END
