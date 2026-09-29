//
//  QiNiuUpload.m
//  Greens
//
//  Created by lyx on 2020/4/22.
//  Copyright © 2020 lyx. All rights reserved.
//

#import "QiNiuUpload.h"
#import <UIKit/UIKit.h>
#import "QiNiuOCUtils.h"

@implementation QiNiuUpload

+(void)uploadToQiNiu:(UIImage *)image loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString *url))complete {
    
    if (loading) {
        [SVProgressHUD show];
    }
    [requestToolClass postNetworkImageVideoWithUrl:request_Member_getQiniuToken andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *dicToken = info;
        [LYUserDefault saveUserQiNiuDomain:[NSString stringWithFormat:@"%@", dicToken[@"domain"]]];
        [QiNiuOCUtils qnUploadWithImage:image qnToken:[NSString stringWithFormat:@"%@", dicToken[@"token"]] complatiom:^(NSString *postURL) {
            NSLog(@"七牛key = %@",postURL);
            complete(postURL);
        } completeFail:^(NSString *error) {
            if (error.length > 0) {
                [SVProgressHUD showErrorWithStatus:error];
            }
            complete(@"");
        } progressHandler:^(float precent) {
            NSLog(@"上传进度= %lf",precent);
        }];
    } fail:^(NSString * _Nonnull msg) {
        complete(@"");
    }];
}

+(void)uploadTwoToQiNiu:(UIImage *)image loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString *url))complete {
    
    if (loading) {
        [SVProgressHUD show];
    }
    [requestToolClass postNetworkImageVideoWithUrl:request_Member_getQiniuToken andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *dicToken = info;
        [LYUserDefault saveUserQiNiuDomain:[NSString stringWithFormat:@"%@", dicToken[@"domain"]]];

        [QiNiuOCUtils qnUploadWithImage:image qnToken:[NSString stringWithFormat:@"%@", dicToken[@"token"]] complatiom:^(NSString *postURL) {
            NSLog(@"七牛key = %@",postURL);
            complete(postURL);
        } completeFail:^(NSString *error) {
           
            if (error.length > 0) {
                [SVProgressHUD showErrorWithStatus:error];
            }
            complete(@"");
        } progressHandler:^(float precent) {
            NSLog(@"上传进度= %lf",precent);
        }];
    } fail:^(NSString * _Nonnull msg) {
        complete(@"");
    }];
}

+ (void)uploadVideoToQiNiu:(NSString *)VideoPath loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString * _Nonnull))complete
{
    [requestToolClass postNetworkWithUrl:request_Member_getQiniuToken andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *dicToken = info;
        [LYUserDefault saveUserQiNiuDomain:[NSString stringWithFormat:@"%@", dicToken[@"domain"]]];
        
        [QiNiuOCUtils qnUploadWithImageFilePath:VideoPath qnToken:[NSString stringWithFormat:@"%@", dicToken[@"token"]] complatiom:^(NSString *postURL) {
            NSLog(@"七牛key = %@",postURL);
            complete(postURL);
        } completeFail:^(NSString *error) {
            if (error.length > 0) {
                [SVProgressHUD showErrorWithStatus:error];
            }
            complete(@"");
        } progressHandler:^(float precent) {
            NSLog(@"上传进度= %lf",precent);
        }];
    } fail:^(NSString * _Nonnull msg) {
        complete(@"");
    }];
}

+ (void)uploadFileToQiNiu:(NSString *)filePath loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString * _Nonnull))complete
{
    
    [requestToolClass postNetworkWithUrl:request_Member_getQiniuToken andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        NSDictionary *dicToken = info;
        [LYUserDefault saveUserQiNiuDomain:[NSString stringWithFormat:@"%@", dicToken[@"domain"]]];
        
        [QiNiuOCUtils qnUploadWithFile:filePath qnToken:[NSString stringWithFormat:@"%@", dicToken[@"token"]] complatiom:^(NSString *postURL) {
            NSLog(@"七牛key = %@",postURL);
            complete(postURL);
        } completeFail:^(NSString *message) {
            if (message.length > 0) {
                [SVProgressHUD showErrorWithStatus:message];
            }
            complete(@"");
        }];
    } fail:^(NSString * _Nonnull msg) {
        complete(@"");
    }];
}



@end
