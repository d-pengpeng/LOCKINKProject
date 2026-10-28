//
//  requestToolClass.m
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/1/28.
//  Copyright © 2021 time. All rights reserved.
//

#import "requestToolClass.h"
#import <AFNetworking.h>
#import <QCloudCOSXML/QCloudCOSXMLTransfer.h>
#import "MHBehaviorReporter.h"

static CGFloat const TIMEOUT = 60.f;
@implementation requestToolClass
static requestToolClass* kSingleObject = nil;

/** 单例类方法 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSingleObject = [[super allocWithZone:NULL] init];
    });
    
    return kSingleObject;
}

// 重写创建对象空间的方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    // 直接调用单例的创建方法
    return [self sharedInstance];
}

// 当前 App 版本号
+ (NSString *)appVersionString {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return version.length > 0 ? version : @"";
}

/**
 网络请求
 
 @param url 请求的接口名：例：home.gethot
 @param parameter 参数的字典
 @param successBlock 成功的回调
 @param failBlock 失败的回调  */
+ (void)postNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }

    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP POST] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ?: @{});
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session POST:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        
        [SVProgressHUD dismiss];
        if (jsonError) {
            NSString *extUrl86 = url ?: @"";
            NSDictionary *extDic86 = @{@"url": extUrl86, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic86];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl99 = url ?: @"";
                NSString *perfCode99 = number ?: @"";
                NSDictionary *perfDic99 = @{@"url": perfUrl99, @"code": perfCode99};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic99];
                NSString *errUrl100 = url ?: @"";
                NSString *errCode100 = number ?: @"";
                NSString *errMsg100 = strMessage ?: @"";
                NSDictionary *errDic100 = @{@"url": errUrl100, @"code": errCode100, @"message": errMsg100};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic100];
                if ([number intValue] == 403) {

                    [LYUserDefault clearLoginCache];
//                    [HistoryRecordModel deletAllDataPlist];
//                    [HistoryRecordModel deletAllDataPlayListPlist];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
//                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(strMessage.length > 0 ? strMessage : @"登陆已失效");
                }else if ([number intValue] == 500) {
                    failBlock(strMessage.length > 0 ? strMessage : @"服务器错误");
                }else if ([number intValue] == 50008) {
                    failBlock(strMessage.length > 0 ? strMessage : @"50008");
                }else if ([number intValue] == 60056) {
                    failBlock([NSString stringWithFormat:@"60056,%@", strMessage.length > 0 ? strMessage : @""]);
                }else {
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(strMessage.length > 0 ? strMessage : @"失败");
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[HTTP ERROR] %@ → %@ | detail: %@", requestUrl, error.localizedDescription, errorStr);
        // api_error 上报（网络层失败）
        [[MHBehaviorReporter shared] trackError:@"api_error"
                                            ext:@{@"url": url ?: @"",
                                                   @"code": @(error.code),
                                                   @"message": error.localizedDescription ?: @""}];
        failBlock(error.localizedDescription ?: @"失败");
    }];
}

+ (void)postRegisterLogNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }

    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP POST] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ?: @{});
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session POST:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        
        [SVProgressHUD dismiss];
        if (jsonError) {
            NSString *extUrl180 = url ?: @"";
            NSDictionary *extDic180 = @{@"url": extUrl180, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic180];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl193 = url ?: @"";
                NSString *perfCode193 = number ?: @"";
                NSDictionary *perfDic193 = @{@"url": perfUrl193, @"code": perfCode193};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic193];
                NSString *errUrl194 = url ?: @"";
                NSString *errCode194 = number ?: @"";
                NSString *errMsg194 = strMessage ?: @"";
                NSDictionary *errDic194 = @{@"url": errUrl194, @"code": errCode194, @"message": errMsg194};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic194];
                if ([number intValue] == 403) {

                    [LYUserDefault clearLoginCache];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"登陆已失效");
                }else {
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"失败");
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[HTTP ERROR] %@ → %@ | detail: %@", requestUrl, error.localizedDescription, errorStr);
        failBlock(@"失败");
    }];
}

+ (void)postNetworkHeadImageWithUrl:(NSString *)url typMehtod:(NSInteger)typeM andImageData:(NSArray *)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock
{
    NSLog(@"\n[COS UPLOAD] bucket=cos-lockink-1324404581 count=%ld typeM=%ld", (long)parameter.count, (long)typeM);
    NSMutableArray *arrList = [NSMutableArray array];
    for (int i=0; i<parameter.count; i++) {
        
        QCloudCOSXMLUploadObjectRequest* put = [QCloudCOSXMLUploadObjectRequest new];
        // 存储桶名称，由BucketName-Appid 组成，可以在COS控制台查看 https://console.cloud.tencent.com/cos5/bucket
        put.bucket = @"cos-lockink-1324404581";

        // 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "video/xxx/movie.mp4"
        if(typeM == 3) {
            
    //        put.object = @"video/lockink-1324404581/vedioName.mp4";
            NSDate *datenow = [NSDate date];
            put.object = [NSString stringWithFormat:@"vedioName_%ld.mp4",(long)[datenow timeIntervalSince1970]];
        }else if (typeM == 2) {
            
    //        put.object = @"video/lockink-1324404581/voiceName.m4a";
            NSDate *datenow = [NSDate date];
            put.object = [NSString stringWithFormat:@"voiceName_%ld.mp3",(long)[datenow timeIntervalSince1970]];
        }else {
            NSDate *datenow = [NSDate date];
            put.object = [NSString stringWithFormat:@"image%d_%ld.jpg", i, (long)[datenow timeIntervalSince1970]];
        }

        // 需要上传的对象内容。可以传入NSData*或者NSURL*类型的变量
    //    put.body = [@"My Example Content" dataUsingEncoding:NSUTF8StringEncoding];
        put.body = parameter[i];
        NSLog(@"[COS UPLOAD] → object=%@ dataSize=%lu", put.object, (unsigned long)[parameter[i] length]);
        // 监听上传进度
        [put setSendProcessBlock:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
            // bytesSent                   新增字节数
            // totalBytesSent              本次上传的总字节数
            // totalBytesExpectedToSend    本地上传的目标字节数
        }];

        // 监听上传结果
        [put setFinishBlock:^(QCloudUploadObjectResult *result, NSError *error) {
            if (error) {
                NSLog(@"[COS ERROR] object=%@ → %@", put.object, error.localizedDescription);
            } else {
                // 在上传结果 result.location 中获取上传文件的下载链接
                NSString * fileUrl = result.location;
                NSLog(@"[COS RESP] object=%@ → %@", put.object, fileUrl);
                [arrList addObject:fileUrl];
            }
            if(arrList.count == parameter.count) {
                successBlock(200, arrList, @"");
            }
        }];
        [[QCloudCOSTransferMangerService defaultCOSTransferManager] UploadObject:put];
    }

    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
//    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
//    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    session.requestSerializer.timeoutInterval = TIMEOUT;
//    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
//    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    [session POST:requestUrl parameters:@{} headers:@{@"token":TOKEN?TOKEN:@""} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        //上传文件参数
//        if(typeM == 3) {
//
//            for (int i=0; i<parameter.count; i++) {
//
//                NSData *dataImg = parameter[i];
//                [formData appendPartWithFileData:dataImg name:@"files" fileName: [NSString stringWithFormat:@"%@.mp4", @"vedioName"] mimeType:@"mp4/mp3/wmr/m4a"];
//            }
//        }else if (typeM == 2) {
//
//            for (int i=0; i<parameter.count; i++) {
//
//                NSData *dataImg = parameter[i];
//                [formData appendPartWithFileData:dataImg name:@"files" fileName: [NSString stringWithFormat:@"%@.m4a", @"voiceName"] mimeType:@"amr/mp3/wmr/m4a"];
//            }
//        }else {
//            for (int i=0; i<parameter.count; i++) {
//
//                NSData *dataImg = parameter[i];
//                [formData appendPartWithFileData:dataImg name:@"files" fileName:@"userHeader.png" mimeType:@"image/jpeg"];
//            }
//        }
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSError *jsonError;
//        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
//
//        if (jsonError) {
//            failBlock(@"失败");
//        }else {
//            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
//            if([number intValue] == 200)
//            {
//                id datainfo = [resultDict valueForKey:@"data"];
//                int code = [number intValue];
//                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
//                successBlock(code, datainfo,strMessage);
//
//            }else{
//                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
//                if ([number intValue] == 403) {
//                    [LYUserDefault clearLoginCache];
////                    [HistoryRecordModel deletAllDataPlist];
////                    [HistoryRecordModel deletAllDataPlayListPlist];
//                    [LYUserDefault saveIsLoginBoo:NO];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
////                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
//                    [SVProgressHUD showErrorWithStatus:strMessage];
//                    failBlock(@"登陆已失效");
//                }else {
//                    failBlock(@"失败");
//                }
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failBlock(@"失败");
//    }];
}

+ (void)postNetworkRecordVoiceWithUrl:(NSString *)url typMehtod:(NSData *)dataVoice andImageData:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *headersDic = @{@"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP POST multipart] %@\n[headers] %@\n[voiceDataSize] %lu\n[params] %@", requestUrl, headersDic, (unsigned long)dataVoice.length, parameter ?: @{});

    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session POST:requestUrl parameters:parameter headers:headersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        //上传文件参数
        [formData appendPartWithFileData:dataVoice name:@"file" fileName: [NSString stringWithFormat:@"%@.m4a", @"voiceName"] mimeType:@"amr/mp3/wmr/m4a"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);

        [SVProgressHUD dismiss];
        if (jsonError) {
            NSString *extUrl380 = url ?: @"";
            NSDictionary *extDic380 = @{@"url": extUrl380, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic380];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl393 = url ?: @"";
                NSString *perfCode393 = number ?: @"";
                NSDictionary *perfDic393 = @{@"url": perfUrl393, @"code": perfCode393};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic393];
                NSString *errUrl394 = url ?: @"";
                NSString *errCode394 = number ?: @"";
                NSString *errMsg394 = strMessage ?: @"";
                NSDictionary *errDic394 = @{@"url": errUrl394, @"code": errCode394, @"message": errMsg394};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic394];
                [SVProgressHUD showErrorWithStatus:strMessage];
                failBlock(@"失败");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[HTTP ERROR] %@ → %@", requestUrl, error.localizedDescription);
        [SVProgressHUD showErrorWithStatus:@"Error 500"];
        failBlock(@"500");
    }];
}



+ (void)postNetworkWithUrlPayPD:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }

    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP POST] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ?: @{});
    
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session POST:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        
        if (jsonError) {
            NSString *extUrl448 = url ?: @"";
            NSDictionary *extDic448 = @{@"url": extUrl448, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic448];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl461 = url ?: @"";
                NSString *perfCode461 = number ?: @"";
                NSDictionary *perfDic461 = @{@"url": perfUrl461, @"code": perfCode461};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic461];
                NSString *errUrl462 = url ?: @"";
                NSString *errCode462 = number ?: @"";
                NSString *errMsg462 = strMessage ?: @"";
                NSDictionary *errDic462 = @{@"url": errUrl462, @"code": errCode462, @"message": errMsg462};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic462];
                if ([number intValue] == 403) {

                    [LYUserDefault clearLoginCache];
//                    [HistoryRecordModel deletAllDataPlist];
//                    [HistoryRecordModel deletAllDataPlayListPlist];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
//                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"登陆已失效");
                }else {
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"失败");
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[HTTP ERROR] %@ → %@ | detail: %@", requestUrl, error.localizedDescription, errorStr);
        failBlock(@"失败");
    }];
}

+ (void)postNetworkImageVideoWithUrl:(NSString *)url andParameter:(nullable id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }
    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP POST] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ?: @{});
    
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session POST:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);

        if (jsonError) {
            NSString *extUrl525 = url ?: @"";
            NSDictionary *extDic525 = @{@"url": extUrl525, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic525];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl538 = url ?: @"";
                NSString *perfCode538 = number ?: @"";
                NSDictionary *perfDic538 = @{@"url": perfUrl538, @"code": perfCode538};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic538];
                NSString *errUrl539 = url ?: @"";
                NSString *errCode539 = number ?: @"";
                NSString *errMsg539 = strMessage ?: @"";
                NSDictionary *errDic539 = @{@"url": errUrl539, @"code": errCode539, @"message": errMsg539};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic539];
                if ([number intValue] == 403) {
                    [LYUserDefault clearLoginCache];
//                    [HistoryRecordModel deletAllDataPlist];
//                    [HistoryRecordModel deletAllDataPlayListPlist];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
//                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"登陆已失效");
                }else {
                    failBlock(@"失败");
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[HTTP ERROR] %@ → %@ | detail: %@", requestUrl, error.localizedDescription, errorStr);
        failBlock(@"失败");
    }];
}

+ (void)getNOMsgNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }
    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP GET] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ?: @{});
    
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session GET:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        [SVProgressHUD dismiss];
        if (jsonError) {
            NSString *extUrl599 = url ?: @"";
            NSDictionary *extDic599 = @{@"url": extUrl599, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic599];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
             
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl613 = url ?: @"";
                NSString *perfCode613 = number ?: @"";
                NSDictionary *perfDic613 = @{@"url": perfUrl613, @"code": perfCode613};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic613];
                NSString *errUrl614 = url ?: @"";
                NSString *errCode614 = number ?: @"";
                NSString *errMsg614 = strMessage ?: @"";
                NSDictionary *errDic614 = @{@"url": errUrl614, @"code": errCode614, @"message": errMsg614};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic614];
                failBlock(@"失败1");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[HTTP ERROR] %@ → %@", requestUrl, error.localizedDescription);
        [SVProgressHUD dismiss];
     
        failBlock(@"失败1");
    }];
    
}

+ (void)getNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }
    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP GET] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ? pDic : @{});
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session GET:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        
        [SVProgressHUD dismiss];
        if (jsonError) {
            NSString *extUrl662 = url ?: @"";
            NSDictionary *extDic662 = @{@"url": extUrl662, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic662];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl675 = url ?: @"";
                NSString *perfCode675 = number ?: @"";
                NSDictionary *perfDic675 = @{@"url": perfUrl675, @"code": perfCode675};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic675];
                NSString *errUrl676 = url ?: @"";
                NSString *errCode676 = number ?: @"";
                NSString *errMsg676 = strMessage ?: @"";
                NSDictionary *errDic676 = @{@"url": errUrl676, @"code": errCode676, @"message": errMsg676};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic676];
                if ([number intValue] == 403) {
                    [LYUserDefault clearLoginCache];
//                    [HistoryRecordModel deletAllDataPlist];
//                    [HistoryRecordModel deletAllDataPlayListPlist];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
//                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"登陆已失效");
                }else if ([number intValue] == 10) {
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"设备已被其他账号绑定");
                }else {
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"失败1");
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[HTTP ERROR] %@ → %@ | detail: %@", requestUrl, error.localizedDescription, errorStr);
        failBlock(@"失败1");
    }];
    
}

+ (void)getNetworkTwoWithUrl:(NSString *)url isShow:(BOOL)isShow success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }
    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = @{};
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP GET] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic);
    
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session GET:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        
//        NSData *strData = responseObject;
//        NSString *resultDict =  [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        if (isShow) {
            [SVProgressHUD dismiss];
        }
        
        if (jsonError) {
            NSString *extUrl749 = url ?: @"";
            NSDictionary *extDic749 = @{@"url": extUrl749, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic749];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl762 = url ?: @"";
                NSString *perfCode762 = number ?: @"";
                NSDictionary *perfDic762 = @{@"url": perfUrl762, @"code": perfCode762};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic762];
                NSString *errUrl763 = url ?: @"";
                NSString *errCode763 = number ?: @"";
                NSString *errMsg763 = strMessage ?: @"";
                NSDictionary *errDic763 = @{@"url": errUrl763, @"code": errCode763, @"message": errMsg763};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic763];
                if ([number intValue] == 403) {
                    [LYUserDefault clearLoginCache];
//                    [HistoryRecordModel deletAllDataPlist];
//                    [HistoryRecordModel deletAllDataPlayListPlist];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
//                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"登陆已失效");
                }else if ([number intValue] == 10) {
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"设备已被其他账号绑定");
                }else {
//                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"失败1");
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShow) {
            [SVProgressHUD dismiss];
        }
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"[HTTP ERROR] %@ → %@ | detail: %@", requestUrl, error.localizedDescription, errorStr);
        failBlock(@"失败1");
    }];
    
}

+ (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (void)getStopLivingNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingFormat:@"%@",url];
    [session.requestSerializer setValue:TOKEN?TOKEN:@"" forHTTPHeaderField:@"token"];//设置请求体
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }
    [session.requestSerializer setValue:lang_new forHTTPHeaderField:@"Accept-Language"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = TIMEOUT;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *pDic = parameter;
    NSDictionary *headersDic = @{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@"", @"appVersion":[self appVersionString]};
    NSLog(@"\n[HTTP GET] %@\n[headers] %@\n[params] %@", requestUrl, headersDic, pDic ?: @{});
    NSTimeInterval reqStart = [[NSDate date] timeIntervalSince1970];
    [session GET:requestUrl parameters:pDic headers:headersDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval costMs = ([[NSDate date] timeIntervalSince1970] - reqStart) * 1000;
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"[HTTP RESP] %@ → %@", requestUrl, resultDict);
        [SVProgressHUD dismiss];
        if (jsonError) {
            NSString *extUrl835 = url ?: @"";
            NSDictionary *extDic835 = @{@"url": extUrl835, @"code": @(-1), @"message": @"JSON parse error"};
            [[MHBehaviorReporter shared] trackError:@"api_error" ext:extDic835];
            failBlock(@"失败");
        }else {
            NSString *number = [NSString stringWithFormat:@"%@", resultDict[@"code"]];
            if([number intValue] == 200)
            {
                id datainfo = [resultDict valueForKey:@"data"];
                int code = [number intValue];
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                successBlock(code, datainfo,strMessage);

            }else{
                NSString *strMessage = [NSString stringWithFormat:@"%@", resultDict[@"message"]];
                NSString *perfUrl848 = url ?: @"";
                NSString *perfCode848 = number ?: @"";
                NSDictionary *perfDic848 = @{@"url": perfUrl848, @"code": perfCode848};
                [[MHBehaviorReporter shared] trackPerf:@"api_perf" costMs:(NSInteger)costMs ext:perfDic848];
                NSString *errUrl849 = url ?: @"";
                NSString *errCode849 = number ?: @"";
                NSString *errMsg849 = strMessage ?: @"";
                NSDictionary *errDic849 = @{@"url": errUrl849, @"code": errCode849, @"message": errMsg849};
                [[MHBehaviorReporter shared] trackError:@"api_error" ext:errDic849];
                failBlock(@"失败1");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[HTTP ERROR] %@ → %@", requestUrl, error.localizedDescription);
        [SVProgressHUD dismiss];
        failBlock(@"失败1");
    }];
    
}

@end
