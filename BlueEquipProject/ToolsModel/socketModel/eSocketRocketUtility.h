//
//  eSocketRocketUtility.h
//  yunbaolive
//
//  东莞梦幻网络科技有限公司 注 on 2020/8/18.
//  Copyright © 2020 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface eSocketRocketUtility : NSObject

@property (nonatomic, copy) NSString *urlSSt;

+ (instancetype)sharedInstance;

- (BOOL)getSocketCloseBoo;
-(void)SRWebSocketOpenWithURLString:(NSString *)urlString;
- (void)SRWebSocketClose;
-(void)SRWebSocketSendJsonDic:(NSDictionary *)jsonDic;
@end

NS_ASSUME_NONNULL_END
