//
//  UIAlertCon_ExtController.h
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/1/8.
//  Copyright © 2021 time. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^okSel)(UIAlertAction *okSel);
typedef void(^ruleSel)(UIAlertAction *ruleSel);

@interface UIAlertCon_ExtController : UIViewController

//照片选择
+ (void)alertViewChoosePictureOrCamera:(NSString *)msg type:(UIAlertControllerStyle)style controller:(UIViewController *)VC choosePicture:(okSel)choosePictureAction camera:(okSel)cameraAction;

+ (void)seeWeixinOrPhone:(NSString *)msg type:(UIAlertControllerStyle)style controller:(UIViewController *)VC delSel:(okSel)delAction oktittle:(NSString *)oktittle;

@end

NS_ASSUME_NONNULL_END
