//
//  MHConnectLinkOneView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^connectLinkOneBlock)(NSInteger num);
@interface MHConnectLinkOneView : UIView

@property (nonatomic, copy) connectLinkOneBlock block_;
@end

NS_ASSUME_NONNULL_END
