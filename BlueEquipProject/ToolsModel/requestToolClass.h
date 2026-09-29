//
//  requestToolClass.h
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/1/28.
//  Copyright © 2021 time. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^networkSuccessBlock)(int code,id info,NSString *msg);
typedef void (^networkFailBlock)(NSString *msg);

@interface requestToolClass : NSObject

+ (instancetype)sharedInstance;

/**
 网络请求成功的回调
 */
@property(nonatomic,copy)networkSuccessBlock successB;
/**
 网络请求失败的回调
 */
@property(nonatomic,copy)networkFailBlock failB;

/**
 网络请求

 @param url 请求的接口名：例：home.gethot
 @param parameter 参数的字典
 @param successBlock 成功的回调
 @param failBlock 失败的回调
 */
+ (void)postNetworkWithUrl:(NSString *)url andParameter:(nullable id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)postRegisterLogNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock; //注册使用

+ (void)postNetworkImageVideoWithUrl:(NSString *)url andParameter:(nullable id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)getNetworkWithUrl:(NSString *)url andParameter:(nullable id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)getNetworkTwoWithUrl:(NSString *)url isShow:(BOOL)isShow success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)postNetworkWithUrlPayPD:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)getStopLivingNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)postNetworkHeadImageWithUrl:(NSString *)url typMehtod:(NSInteger)typeM andImageData:(NSArray *)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)postNetworkRecordVoiceWithUrl:(NSString *)url typMehtod:(NSData *)dataVoice andImageData:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;

+ (void)getNOMsgNetworkWithUrl:(NSString *)url andParameter:(id)parameter success:(networkSuccessBlock)successBlock fail:(networkFailBlock)failBlock;
@end

NS_ASSUME_NONNULL_END
