//
//  SwichLanguage.h
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2020/12/28.
//  Copyright © 2020 time. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwichLanguage : NSObject

+(id)shareInstance;
 

-(NSString *)userLanguage;//获取应用当前语言

-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

-(void)setUserlanguage:(NSString *)language;//设置当前语言
@end

NS_ASSUME_NONNULL_END
