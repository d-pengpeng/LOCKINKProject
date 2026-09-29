//
//  groupLivingMemebersView.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^groupLivingMemebersVBLock)(NSInteger numL);
@interface groupLivingMemebersView : UIView

@property (nonatomic, strong) UIScrollView *oneVV;
@property (nonatomic, strong) UIPageControl *pageCC;
@property (nonatomic, copy) groupLivingMemebersVBLock block_;
- (void)addMemebersArr:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
