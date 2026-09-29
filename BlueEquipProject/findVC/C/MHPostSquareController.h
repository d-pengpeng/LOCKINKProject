//
//  MHPostSquareController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/8.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol postTopicContrDelegate <NSObject>

- (void)postTopicContrDelegateMethod;

@end
@interface MHPostSquareController : eBaseViewController

@property (nonatomic, assign) id<postTopicContrDelegate> delegate_;
@property (nonatomic, assign) BOOL isRoleGongTouBoo;
@property (nonatomic, strong) NSArray *reqestDicAr;
@property (nonatomic, copy) NSString *frequency;
@property (nonatomic, copy) NSString *shockMinute;
@property (nonatomic, strong) UIViewController *selfUpVC;
@end

NS_ASSUME_NONNULL_END
