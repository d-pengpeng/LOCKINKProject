//
//  Q_AOneModel.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Q_AOneModel : NSObject

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *post_content;

+ (instancetype)addModelFromDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
