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
    [session POST:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        
//        NSData *strData = responseObject;
//        NSString *resultDict =  [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        
//        NSLog(@"-结果-%@", resultDict);
        
        [SVProgressHUD dismiss];
        if (jsonError) {
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
                if ([number intValue] == 403) {

                    [LYUserDefault clearLoginCache];
//                    [HistoryRecordModel deletAllDataPlist];
//                    [HistoryRecordModel deletAllDataPlayListPlist];
                    [LYUserDefault saveIsLoginBoo:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
//                    [SVProgressHUD showErrorWithStatus:eLocalizedString(@"please_login")];
                    [SVProgressHUD showErrorWithStatus:strMessage];
                    failBlock(@"登陆已失效");
                }else if ([number intValue] == 500) {
                    failBlock(strMessage);
                }else if ([number intValue] == 50008) {
                    failBlock(@"50008");
                }else if ([number intValue] == 60056) {
                    failBlock([NSString stringWithFormat:@"60056,%@", strMessage]);
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
        NSLog(@"-报错-%@", errorStr);
        failBlock(@"失败");
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
    [session POST:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        
//        NSLog(@"-结果-%@", resultDict);
        
        [SVProgressHUD dismiss];
        if (jsonError) {
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
        NSLog(@"-报错-%@", errorStr);
        failBlock(@"失败");
    }];
}

+ (void)postNetworkHeadImageWithUrl:(NSString *)url typMehtod:(NSInteger)typeM andImageData:(NSArray *)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock
{
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
        // 监听上传进度
        [put setSendProcessBlock:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
            // bytesSent                   新增字节数
            // totalBytesSent              本次上传的总字节数
            // totalBytesExpectedToSend    本地上传的目标字节数
        }];

        // 监听上传结果
        [put setFinishBlock:^(QCloudUploadObjectResult *result, NSError *error) {
            // 在上传结果 result.location 中获取上传文件的下载链接
            NSString * fileUrl = result.location;
            [arrList addObject:fileUrl];
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

    [session POST:requestUrl parameters:parameter headers:@{@"token":TOKEN?TOKEN:@""} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        //上传文件参数
        [formData appendPartWithFileData:dataVoice name:@"file" fileName: [NSString stringWithFormat:@"%@.m4a", @"voiceName"] mimeType:@"amr/mp3/wmr/m4a"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];

        [SVProgressHUD dismiss];
        if (jsonError) {
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
                [SVProgressHUD showErrorWithStatus:strMessage];
                failBlock(@"失败");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    
    [session POST:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"-结果-%@", resultDict);
        
        if (jsonError) {
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
        NSLog(@"-报错-%@", errorStr);
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
    
    [session POST:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];

        if (jsonError) {
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
        NSLog(@"-报错-%@", errorStr);
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
    
    [session GET:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        [SVProgressHUD dismiss];
        if (jsonError) {
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
             
                failBlock(@"失败1");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    [session GET:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        
//        NSData *strData = responseObject;
//        NSString *resultDict =  [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        
//        NSLog(@"-结果-%@", resultDict);
        
        [SVProgressHUD dismiss];
        if (jsonError) {
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
        NSLog(@"-报错-%@", errorStr);
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
    
    [session GET:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        
//        NSData *strData = responseObject;
//        NSString *resultDict =  [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        
        NSLog(@"-结果-%@", resultDict);
        if (isShow) {
            [SVProgressHUD dismiss];
        }
        
        if (jsonError) {
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
        NSLog(@"-报错-%@", errorStr);
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
    [session GET:requestUrl parameters:pDic headers:@{@"Accept-Language":lang_new, @"token":TOKEN?TOKEN:@""} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        [SVProgressHUD dismiss];
        if (jsonError) {
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
                failBlock(@"失败1");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        failBlock(@"失败1");
    }];
    
}

@end
