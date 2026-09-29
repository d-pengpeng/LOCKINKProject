//
//  AESCipher.h
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import <Foundation/Foundation.h>

@interface AESCipher : NSObject

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);


+(NSString *)aesEncryptString:(NSString *)content key:(NSString *)key;
+(NSString *)aesDecryptString:(NSString *)content key:(NSString *)key;
+(NSData *)encryptAES:(NSString *)content key:(NSString *)key;
+(NSString *)converToNSString:(NSData *)data;
+(NSData *)decryptAESWithData:(NSData *)data key:(NSString *)key;
+(NSData *)dataWithHexString:(NSString *)hexString;

+ (NSData *)aes128ECBEncrypt:(NSString *)plainHex keyHex:(NSString *)keyHex;
+(NSData *)aes128ECBDecrypt:(NSString *)plainHex keyHex:(NSString *)keyHex;
+ (NSData *)dataFromHexString:(NSString *)hexString;
+ (NSString *)dataToHexString:(NSData *)data;
@end
