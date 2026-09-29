//
//  myGroupBXScanController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/27.
//

#import "myGroupBXScanController.h"
//#import <LBXScanNative.h>

@interface myGroupBXScanController ()

@end

@implementation myGroupBXScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleName.text = eLocalizedString(@"chat_al54");
    
    // 生成二维码
//    UIImageView *oneImgV5 = [HistoryRecordModel createImgImgView];
//    oneImgV5.frame = CGRectMake((_window_width-240)/2, (_window_height-240)/2, 240, 240);
//    oneImgV5.backgroundColor = UIColor.clearColor;
//    oneImgV5.image = [LBXScanNative createQRWithString:self.groupStr QRSize:CGSizeMake(240, 240)];
//    [self.view addSubview:oneImgV5];
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
