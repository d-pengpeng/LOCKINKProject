//
//  QiNiuOCUtils.m
//  AgentSa
//
//  Created by LYX on 2018/10/11.
//  Copyright © 2018年 Frank. All rights reserved.
//

#import "QiNiuOCUtils.h"
#import "QiniuSDK.h"

@implementation QiNiuOCUtils

+(void)qnUploadWithImage:(UIImage *)image qnToken:(NSString *)token complatiom:(void (^)(NSString *postURL))successful completeFail:(void (^)(NSString *))fail progressHandler:(void (^)(float))progress{
    
    //得到选择后沙盒中图片的完整路径
    NSString *filePath = [QiNiuOCUtils getImagePath:image];

    QNUploadManager *manager = [[QNUploadManager alloc] init];//@"image/png"
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        progress(percent);
//        NSLog(@"percent == %.2f", percent);
    }params:nil checkCrc:NO cancellationSignal:nil];
    [manager putFile:filePath key:[filePath lastPathComponent] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        if (info.ok) {
            if (resp[@"key"]) {
                successful(resp[@"key"]);
            }
        }else {
            if (info.error) {
                fail(info.error.localizedDescription);
            }
        }
        
    } option:opt];//uploadOption
    
}


+(void)qnUploadWithImageFilePath:(NSString *)filePath qnToken:(NSString *)token complatiom:(void (^)(NSString *postURL))successful completeFail:(void (^)(NSString *))fail progressHandler:(void (^)(float))progress {
    
    QNUploadManager *manager = [[QNUploadManager alloc] init];//@"image/png"
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        progress(percent);

    }params:nil checkCrc:NO cancellationSignal:nil];
    [manager putFile:filePath key:[filePath lastPathComponent] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (info.ok) {
            if (resp[@"key"]) {
                successful(resp[@"key"]);
            }
        }else {
            if (info.error) {
                fail(info.error.localizedDescription);
            }
        }
        
    } option:opt];//uploadOption
    
//    NSError *error;
//    QNFileRecorder *file = [QNFileRecorder fileRecorderWithFolder:filePath error:&error];
//    if (error) {
//        NSLog(@"断点续传读取记录失败 = %@",error.localizedDescription);
//    }
    
    //得到选择后沙盒中图片的完整路径
//        NSString *filePath = filePath;
        
    //    self.token = @"123123";
//        QNUploadManager *manager = [[QNUploadManager alloc] init];//@"image/png"
//        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
//            progress(percent);
//    //        NSLog(@"percent == %.2f", percent);
//        }params:nil checkCrc:NO cancellationSignal:nil];
//        [manager putFile:filePath key:[filePath lastPathComponent] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//    //        NSLog(@"info ===== %@", info);
//    //        NSLog(@"resp ===== %@", resp);
//
//            if (info.ok) {
//                if (resp[@"key"]) {
//                    successful(resp[@"key"]);
//                }
//            }else {
//                if (info.error) {
//                    if (info.statusCode == -4) {
//                        fail(@"文件上传错误或不存在");
//                    }else{
//                      fail(info.error.localizedDescription);
//                    }
//                }else {
//                    fail(@"未知错误");
//                }
//            }
//            
//        } option:opt];//uploadOption
    
}


+(void)qnUploadWithFile:(NSString *)filePath qnToken:(NSString *)token complatiom:(void (^)(NSString *postURL))successful completeFail:(void (^)(NSString *message))fail {

    NSError *error;
    QNFileRecorder *file = [QNFileRecorder fileRecorderWithFolder:filePath error:&error];
    if (error) {
        NSLog(@"断点续传读取记录失败 = %@",error.localizedDescription);
    }
    //check error
    QNUploadManager *manager = [[QNUploadManager alloc] initWithRecorder:file];
    QNUploadOption *opt = [[QNUploadOption alloc]initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    } params:nil checkCrc:NO cancellationSignal:nil];
    
    [manager putFile:filePath key:[filePath lastPathComponent] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        if (info.ok) {
            if (resp[@"key"]) {
                successful(resp[@"key"]);
            }
        }else {
            if (info.error) {
                NSLog(@"七牛上传失败 = %@",info.error.localizedDescription);
            }
        }
        
    } option:opt];
    
}



//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image {
    
    NSString *filePath = nil;
    NSData *data = nil;
    
    //压缩图片
//    Image = [QiNiuOCUtils fixOrientation:Image];
    data = UIImageJPEGRepresentation(Image, 1.0);
    
//    if (UIImagePNGRepresentation(Image) == nil) {
//        data = UIImageJPEGRepresentation(Image, 1.0);
//    } else {
//        data = UIImagePNGRepresentation(Image);
//    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
//    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    uuidString = [uuidString stringByReplacingOccurrencesOfRegex:@"-" withString:@""];
    
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png",uuidString];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    //保存图片到沙盒
//    BOOL isSuccess = [fileManager createFileAtPath:filePath contents:data attributes:nil];
    BOOL isSuccess = [data writeToFile:filePath atomically:true];
    NSLog(@"文件保存：%@", (isSuccess ? @"成功" : @"失败"));
    
    return filePath;
    
}


+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+(void)saveImage:(UIImage *)image {
    
    //参数1:图片对象
    //参数2:成功方法绑定的target
    //参数3:成功后调用方法
    //参数4:需要传递信息(成功后调用方法的参数)
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}


@end
