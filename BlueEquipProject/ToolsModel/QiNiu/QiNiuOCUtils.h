//
//  QiNiuOCUtils.h
//  AgentSa
//
//  Created by LYX on 2018/10/11.
//  Copyright © 2018年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface QiNiuOCUtils : NSObject

+(void)qnUploadWithImage:(UIImage *)image qnToken:(NSString *)token complatiom:(void (^)(NSString *postURL))successful completeFail:(void (^)(NSString *))fail progressHandler:(void (^)(float))progress;

+(void)qnUploadWithImageFilePath:(NSString *)filePath qnToken:(NSString *)token complatiom:(void (^)(NSString *postURL))successful completeFail:(void (^)(NSString *))fail progressHandler:(void (^)(float))progress;

+(void)qnUploadWithFile:(NSString *)filePath qnToken:(NSString *)token complatiom:(void (^)(NSString *postURL))successful completeFail:(void (^)(NSString *message))fail;

//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image;

//照片保存到相册
+(void)saveImage:(UIImage *)image;

@end
