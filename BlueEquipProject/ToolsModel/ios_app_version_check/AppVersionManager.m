
#import "AppVersionManager.h"
#import "mandatoryUpdateView.h"

@implementation AppVersionManager

+ (void)checkAppStoreVersionWithAppId:(NSString *)appId {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [SVProgressHUD show];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"版本检查失败: %@", error.localizedDescription);
            [SVProgressHUD dismiss];
            return;
        }
        
        NSError *jsonError;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"JSON解析失败: %@", jsonError.localizedDescription);
            [SVProgressHUD dismiss];
            return;
        }
        
        NSArray *results = responseDict[@"results"];
        if (results.count > 0) {
            NSDictionary *appInfo = results.firstObject;
            NSString *appStoreVersion = minStr(appInfo[@"version"]);
            NSString *releaseNotes = @"";
            if ([appInfo.allKeys containsObject:@"releaseNotes"]) {
                releaseNotes = appInfo[@"releaseNotes"];
            }
            NSString *trackViewUrl = minStr(appInfo[@"trackViewUrl"]);
            [SVProgressHUD dismiss];
            // 获取当前应用版本
            NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            
            // 比较版本
            if ([self compareVersion:appStoreVersion withVersion:currentVersion] == NSOrderedDescending) {
                // 主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showUpdateAlertWithVersion:appStoreVersion releaseNotes:releaseNotes trackViewUrl:trackViewUrl];
                });
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"version_msg")];
                });
            }
        }else {
            [SVProgressHUD dismiss];
        }
        
    }];
    
    [task resume];
}

+ (void)silentCheckAppStoreVersionWithAppId:(NSString *)appId {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"静默版本检查失败: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError || !responseDict) {
            NSLog(@"静默版本检查JSON解析失败");
            return;
        }
        
        NSArray *results = responseDict[@"results"];
        if (results.count > 0) {
            NSDictionary *appInfo = results.firstObject;
            NSString *appStoreVersion = minStr(appInfo[@"version"]);
            NSString *releaseNotes = @"";
            if ([appInfo.allKeys containsObject:@"releaseNotes"]) {
                releaseNotes = appInfo[@"releaseNotes"];
            }
            NSString *trackViewUrl = minStr(appInfo[@"trackViewUrl"]);
            NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            
            // 仅在有新版本时弹窗，无新版本不做任何提示
            if ([self compareVersion:appStoreVersion withVersion:currentVersion] == NSOrderedDescending) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showUpdateAlertWithVersion:appStoreVersion releaseNotes:releaseNotes trackViewUrl:trackViewUrl];
                });
            }
        }
    }];
    
    [task resume];
}

+ (NSComparisonResult)compareVersion:(NSString *)version1 withVersion:(NSString *)version2 {
    return [version1 compare:version2 options:NSNumericSearch];
}

+ (void)showUpdateAlertWithVersion:(NSString *)version releaseNotes:(NSString *)releaseNotes trackViewUrl:(NSString *)trackViewUrl {
    
    UIViewController *rootVC = [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.rootViewController;
    mandatoryUpdateView *vc = [[mandatoryUpdateView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [rootVC.view addSubview:vc];
    
    NSDictionary *info = @{@"downloadUrl": trackViewUrl, @"code":version, @"content":releaseNotes};
    [vc addUIUIUIUI:info];
    
}

@end
