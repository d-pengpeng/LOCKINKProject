//
//  YBWebViewController.m
//  live1v1
//
//  Created by IOS1 on 2019/3/30.
//  Copyright © 2019 IOS1. All rights reserved.
//

#import "YBWebViewController.h"
#import <WebKit/WebKit.h>
@interface YBWebViewController ()<WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *WKWebView;
@property (nonatomic,strong) CALayer *progresslayer;

@end

@implementation YBWebViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLine.hidden = YES;
//    if (self.isShowTop) {
//        self.navView.backgroundColor = UIColor.clearColor;
//
//        self.WKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//        self.WKWebView.navigationDelegate = self;
//        [self.view addSubview:self.WKWebView];
//        self.progresslayer = [[CALayer alloc]init];
//        self.progresslayer.frame = CGRectMake(0, 0, _window_width*0.1, 2);
//        self.progresslayer.backgroundColor = normalColors.CGColor;
//        [self.WKWebView.layer addSublayer:self.progresslayer];
//    }else {
        self.WKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44+TIMESTATUSHEIGHT, _window_width, _window_height-(44+TIMESTATUSHEIGHT))];
        self.WKWebView.navigationDelegate = self;
        [self.view addSubview:self.WKWebView];
        self.progresslayer = [[CALayer alloc]init];
        self.progresslayer.frame = CGRectMake(0, 0, _window_width*0.1, 2);
        self.progresslayer.backgroundColor = normalColors.CGColor;
        [self.WKWebView.layer addSublayer:self.progresslayer];
//    }
    [self.WKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.WKWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

    [self.WKWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urls]]];
     

}
// 观察者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progresslayer.opacity = 1;
        float floatNum = [[change objectForKey:@"new"] floatValue];
        self.progresslayer.frame = CGRectMake(0, 0, _window_width*floatNum, 2);
        if (floatNum == 1) {
            
            __weak __typeof(self)weakSelf = self;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.progresslayer.opacity = 0;
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
        
    }else if ([keyPath isEqualToString:@"title"]){//网页title
        if (object == self.WKWebView){
            self.titleName.text = self.WKWebView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *url = navigationAction.request.URL.absoluteString;
    if (navigationAction.targetFrame.isMainFrame) {
        NSLog(@"target is main ... %@",url);
        if (navigationAction.sourceFrame.mainFrame) {
            NSLog(@"source is main...%@",url);
            //是原始url 放行
            if ([_urls isEqualToString:url]) {
                decisionHandler(WKNavigationActionPolicyAllow);
                NSLog(@"放行bbbbbbbbbbbbbbbbb...%@",url);
                return;
            }
//            if ([url hasPrefix:@"copy://"]) {
//                NSString *results = [url substringFromIndex:7];
//                UIPasteboard *paste = [UIPasteboard generalPasteboard];
//                paste.string = results;
//                [MBProgressHUD showError:YZMsg(@"复制成功")];
//                decisionHandler(WKNavigationActionPolicyCancel);
//
//                return;
//            }
//             if ([url containsString:@"phonelive://pay"]) {
//                 RechargeViewController *coins = [[RechargeViewController alloc]init];
//                 [self.navigationController pushViewController:coins animated:YES];
//                 decisionHandler(WKNavigationActionPolicyCancel);
//
//                return;
//            }
            
        } else {
            NSLog(@"source is not main...%@",url);
        }
    } else {
        NSLog(@"target is not main ... %@",url);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"在发送请求之前：%@",navigationAction.request.URL.absoluteString);
}


-(void)dealloc{
    NSLog(@"WKWebView dealloc------------");
    [self.WKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.WKWebView removeObserver:self forKeyPath:@"title"];

}
- (void)doReturn{
//    if (_isGuide) {
//        UIApplication *app =[UIApplication sharedApplication];
//        AppDelegate *app2 = (AppDelegate *)app.delegate;
//        UINavigationController *nav;
//        if ([Config getOwnID]) {
//            nav = [[UINavigationController alloc]initWithRootViewController:[[ZYTabBarController alloc]init]];
//        }else{
//            nav = [[UINavigationController alloc]initWithRootViewController:[[PhoneLoginVC alloc]init]];
//        }
//        app2.window.rootViewController = nav;
//
//    }else{
        if ([_WKWebView canGoBack]) {
            [_WKWebView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
//    }
}
////分享
//- (void)rightBtnClick{
//    if (!shareImage) {
//        [MBProgressHUD showMessage:@""];
//        [YBToolClass postNetworkWithUrl:@"Agent.getCode" andParameter:nil success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//            if (code == 0) {
//                NSDictionary *infoDic = [info firstObject];
//                shareImgView *shareV = [[NSBundle mainBundle] loadNibNamed:@"shareImgView" owner:nil options:nil].lastObject;
//                shareV.iconImgV.image = [PublicObj getAppIcon];
//                shareV.appNameL.text = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"];
//                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[Config getavatarThumb]]]];
//                shareV.userIcon.image = img;
//                shareV.userIconSmall.image = img;
//                shareV.userNameL.text = [Config getOwnNicename];
//                shareV.userIDL.text = [NSString stringWithFormat:@"ID:%@",[Config getOwnID]];
//                shareV.codeImgV.image = [self creatCodeImage:minstr([infoDic valueForKey:@"href"])];
//                shareV.invitationL.text = minstr([infoDic valueForKey:@"code"]);
//                [shareV layoutIfNeeded];
//                shareImage = [self getImage:shareV];
//                [self showShareView];
//            }else{
//                [MBProgressHUD hideHUD];
//                [MBProgressHUD showError:msg];
//            }
//        } fail:^{
//            [MBProgressHUD hideHUD];
//        }];
//    }else{
//        [self showShareView];
//    }
//}
//- (void)showShareView{
//    [MBProgressHUD hideHUD];
//    if (!shareView) {
//        shareView = [[fenXiangView alloc]initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//        [shareView GetDIc:@{@"id":@"fenxiao",@"image":shareImage}];
//        [self.view addSubview:shareView];
//    }else{
//        [shareView show];
//    }
//    
//}
//- (UIImage *)creatCodeImage:(NSString *)url{
//    //创建过滤器
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    //过滤器恢复默认
//    [filter setDefaults];
//    //将NSString格式转化成NSData格式
//    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    [filter setValue:data forKeyPath:@"inputMessage"];
//    //获取二维码过滤器生成的二维码
//    CIImage *image = [filter outputImage];
//    return [self createNonInterpolatedUIImageFormCIImage:image withSize:190];//重绘二维码,使其显示清晰
//    
//}
///**
// * 根据CIImage生成指定大小的UIImage
// *
// * @param image CIImage
// * @param size 图片宽度
// */
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
//{
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//    // 1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    // 2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//}
//- (UIImage *)getImage:(UIView *)shareView
//
//{
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(shareView.frame.size.width,shareView.frame.size.height ), NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
//    
//    [shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    //      renderInContext呈现接受者及其子范围到指定的上下文
//    
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
//    
//    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
//    
//    //     UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
//    
//    return viewImage;
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
