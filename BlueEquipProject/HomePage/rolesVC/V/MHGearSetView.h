//
//  MHGearSetView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHGearSetVBlock)(NSString *strLL);
@interface MHGearSetView : UIScrollView

@property (nonatomic, assign) int minFont;
@property (nonatomic, assign) int maxFont;
@property (nonatomic, assign) int heihh_h;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, copy) MHGearSetVBlock block_;
@end

NS_ASSUME_NONNULL_END
