//
//  QiNiuUpload.h
//  Greens
//
//  Created by lyx on 2020/4/22.
//  Copyright © 2020 lyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QiNiuUpload : NSObject

+(void)uploadToQiNiu:(UIImage *)image loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString *url))complete;

+(void)uploadVideoToQiNiu:(NSString *)VideoPath loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString *url))complete;

+ (void)uploadFileToQiNiu:(NSString *)filePath loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString * _Nonnull))complete;

+(void)uploadTwoToQiNiu:(UIImage *)image loading:(BOOL)loading resetSize:(BOOL)resetSize complete:(void (^)(NSString *url))complete;
@end

NS_ASSUME_NONNULL_END
