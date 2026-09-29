//
//  MHConnectJSVView.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHConnectJSVVBlock)(BOOL isboo);
@interface MHConnectJSVView : UIView

@property (nonatomic, copy) MHConnectJSVVBlock block_;
- (void)addDicMethod:(NSDictionary *)dicM;
@end

NS_ASSUME_NONNULL_END
