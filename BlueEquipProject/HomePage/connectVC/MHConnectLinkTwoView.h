//
//  MHConnectLinkTwoView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^connectLinkTwoBlock)(NSString *hasToys, NSString *requireGender, NSString *requireGenderPreference, NSString *requireRolePreference);
@interface MHConnectLinkTwoView : UIView

@property (nonatomic, copy) connectLinkTwoBlock block_;

@property (nonatomic, copy) NSString *has_str1;
@property (nonatomic, copy) NSString *has_str2;
@property (nonatomic, copy) NSString *has_str3;
@property (nonatomic, copy) NSString *has_str4;

- (void)addConnectMethodUIUI:(NSInteger)typeM;
@end

NS_ASSUME_NONNULL_END
