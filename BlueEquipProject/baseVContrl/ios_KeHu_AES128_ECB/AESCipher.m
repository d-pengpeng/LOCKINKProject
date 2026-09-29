//
//  AESCipher.m
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import "AESCipher.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation AESCipher

NSString const *kInitVector = @"0123456789abcdef";
size_t const kKeySize = kCCKeySizeAES128;

NSData * cipherOperation(NSData *contentData, NSData *keyData, CCOperation operation) {
    NSUInteger dataLength = contentData.length;
    
    void const *initVectorBytes = [kInitVector dataUsingEncoding:NSUTF8StringEncoding].bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;
    
    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyBytes,
                                          kKeySize,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}
NSString * aesEncryptString(NSString *content, NSString *key) {
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = aesEncryptData(contentData, keyData);
    return [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

NSString * aesDecryptString(NSString *content, NSString *key) {
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedData = aesDecryptData(contentData, keyData);
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    
}

NSData * aesEncryptData(NSData *contentData, NSData *keyData) {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize * 8, kKeySize];
    NSCAssert(keyData.length == kKeySize, hint);
    return cipherOperation(contentData, keyData, kCCEncrypt);
}

NSData * aesDecryptData(NSData *contentData, NSData *keyData) {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize * 8, kKeySize];
    NSCAssert(keyData.length == kKeySize, hint);
    return cipherOperation(contentData, keyData, kCCDecrypt);
}
+(NSString *)aesEncryptString:(NSString *)content key:(NSString *)key
{
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = aesEncryptData(contentData, keyData);
    return [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

}
+(NSString *)aesDecryptString:(NSString *)content key:(NSString *)key
{
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedData = aesDecryptData(contentData, keyData);
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];

}
//加密
+(NSData *)encryptAES:(NSString *)content key:(NSString *)key {
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    NSString const *kInitVector = @"0123456789ABCDEF";
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(
    kCCEncrypt,//kCCEncrypt 代表加密 kCCDecrypt代表解密
    kCCAlgorithmAES,//加密算法
    kCCOptionPKCS7Padding | kCCOptionECBMode,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding，iOS只有CBC和ECB模式，如果想使用ECB模式，可以这样编写  kCCOptionPKCS7Padding | kCCOptionECBMode
    keyPtr,//公钥
    kCCKeySizeAES128,//密钥长度128
    initVector.bytes,//偏移字符串
    contentData.bytes,//编码内容
    dataLength,//数据长度
    encryptedBytes,//加密输出缓冲区
    encryptSize,//加密输出缓冲区大小
    &actualOutSize);//实际输出大小
    if (cryptStatus == kCCSuccess) {
    // 返回编码后的数据
    return [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
    }
    free(encryptedBytes);
    return nil;
}
//格式化字符串
+(NSString *)converToNSString:(NSData *)data
{
    const unsigned char * szBuffer = [data bytes];
    if (!szBuffer) {
        return nil;
    }
    NSMutableString * strTemp = [NSMutableString stringWithCapacity:[data length]*2];
    NSUInteger dataLength = [data length];
    for (NSInteger i = 0; i < dataLength; i++) {
        [strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[i]];
    }
    NSString * result = [NSString stringWithString:strTemp];

    return result;
}
// 解密
+(NSData *)decryptAESWithData:(NSData *)data key:(NSString *)key{
 char keyPtr[kCCKeySizeAES128 + 1];
 bzero(keyPtr, sizeof(keyPtr));
 [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
 NSUInteger dataLength = [data length];
 size_t bufferSize = dataLength + kCCBlockSizeAES128;
 void *buffer = malloc(bufferSize);
 size_t numBytesDecrypted = 0;
 NSString *const kInitVector = @"0123456789ABCDEF"; //16位偏移，CBC模式才有
 NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
 //字段含义在上面加密已经解释过了，这里不做赘述
 CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, initVector.bytes, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);

 if(cryptStatus == kCCSuccess){
     return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
 }

 free(buffer);

 return nil;

}
//格式化字符串转16进制
+(NSData *)dataWithHexString:(NSString *)hexString {
    NSMutableData *data = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0', '\0', '\0'};
    int i = 0;
    while (i < [hexString length]) {
        char c = [hexString characterAtIndex:i++];
        if (isspace(c)) continue;
        byte_chars[0] = c;
        byte_chars[1] = [hexString characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return [data copy];
}
+ (NSData *)aes128ECBEncrypt:(NSString *)plainHex keyHex:(NSString *)keyHex {
    // 1. 将十六进制字符串转换为 NSData
    NSData *plainData = [self dataFromHexString:plainHex];
    NSData *keyData = [self dataFromHexString:keyHex];
    
    // 2. 验证输入长度
    if (plainData.length != kCCBlockSizeAES128 || keyData.length != kCCKeySizeAES128) {
        NSLog(@"输入长度错误");
        return nil;
    }
    
    // 3. 执行 AES-128 ECB 加密
    size_t bufferSize = plainData.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(
        kCCEncrypt,
        kCCAlgorithmAES128,
        kCCOptionECBMode, // ECB 模式 + 默认 PKCS7 填充
        keyData.bytes,
        kCCKeySizeAES128,
        NULL, // ECB 不需要 IV
        plainData.bytes,
        plainData.length,
        buffer,
        bufferSize,
        &numBytesEncrypted
    );
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

// 十六进制字符串 -> NSData 精确转换
+ (NSData *)dataFromHexString:(NSString *)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *data = [NSMutableData data];
    for (NSUInteger i = 0; i < hexString.length; i += 2) {
        NSString *byteStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner *scanner = [NSScanner scannerWithString:byteStr];
        unsigned int byte;
        [scanner scanHexInt:&byte];
        [data appendBytes:&byte length:1];
    }
    return data;
}

// NSData -> 十六进制字符串
+ (NSString *)dataToHexString:(NSData *)data {
    const unsigned char *bytes = data.bytes;
    NSMutableString *hex = [NSMutableString new];
    for (NSInteger i = 0; i < data.length; i++) {
        [hex appendFormat:@"%02X", bytes[i]];
    }
    return hex;
}
+(NSData *)aes128ECBDecrypt:(NSString *)plainHex keyHex:(NSString *)keyHex {
    // 1. 将十六进制字符串转换为 NSData
    NSData *plainData = [AESCipher dataFromHexString:plainHex];
    NSData *keyData = [AESCipher dataFromHexString:keyHex];
    
    // 2. 验证输入长度
    if (plainData.length != kCCBlockSizeAES128 || keyData.length != kCCKeySizeAES128) {
        NSLog(@"输入长度错误");
        return nil;
    }
    
    // 3. 执行 AES-128 ECB 加密
    size_t bufferSize = plainData.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(
        kCCDecrypt,
        kCCAlgorithmAES128,
        kCCOptionECBMode, // ECB 模式 + 默认 PKCS7 填充
        keyData.bytes,
        kCCKeySizeAES128,
        NULL, // ECB 不需要 IV
        plainData.bytes,
        plainData.length,
        buffer,
        bufferSize,
        &numBytesEncrypted
    );
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end

