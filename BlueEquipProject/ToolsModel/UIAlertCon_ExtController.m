//
//  UIAlertCon_ExtController.m
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/1/8.
//  Copyright © 2021 time. All rights reserved.
//

#import "UIAlertCon_ExtController.h"

@interface UIAlertCon_ExtController ()

@end

@implementation UIAlertCon_ExtController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ---- 查看微信号，手机号
+ (void)seeWeixinOrPhone:(NSString *)msg type:(UIAlertControllerStyle)style controller:(UIViewController *)VC delSel:(okSel)delAction oktittle:(NSString *)oktittle
{
    //UIAlertControllerStyleAlert
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:style];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消按钮
    }];
    
    //_titleTextColor attributedMessage
//    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:msg];
//    [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, msg.length)];
//    [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, msg.length)];

    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:oktittle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //普通按钮
        delAction(action);
    }];
    
    //添加按钮（按钮的排列与添加顺序一样，唯独取消按钮会一直在最下面）
    [alertControl addAction:cancelAction];//cancel
    [alertControl addAction:okAction];//ok
    
    //显示警报框
    [VC presentViewController:alertControl animated:YES completion:nil];
//    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"_titleTextColor"];
}

#pragma mark ---- 拍照或选择照片弹框
+ (void)alertViewChoosePictureOrCamera:(NSString *)msg type:(UIAlertControllerStyle)style controller:(UIViewController *)VC choosePicture:(okSel)choosePictureAction camera:(okSel)cameraAction
{
    //UIAlertControllerStyleAlert
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:style];
    
    
    UIAlertAction *cPicturection = [UIAlertAction actionWithTitle:@"图片选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //普通按钮
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"personSetDelContactNotification" object:@"1"];
        choosePictureAction(action);
    }];
    
    
    UIAlertAction *pzAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //取消按钮
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"personSetDelContactNotification" object:@"0"];
        cameraAction(action);
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消按钮
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"personSetDelContactNotification" object:@"0"];
    }];
    
    
    //添加按钮（按钮的排列与添加顺序一样，唯独取消按钮会一直在最下面）
    [alertControl addAction:cPicturection];//选择照片
    [alertControl addAction:pzAction];//拍照
    [alertControl addAction:cancelAction]; //取消
    
    //显示警报框
    [VC presentViewController:alertControl animated:YES completion:nil];
//    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"_titleTextColor"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
