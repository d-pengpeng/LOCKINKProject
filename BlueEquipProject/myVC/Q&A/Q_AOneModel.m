//
//  Q_AOneModel.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/12.
//

#import "Q_AOneModel.h"

@implementation Q_AOneModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.name = [NSString stringWithFormat:@"%@",dict[@"question"]];
        self.post_content = [NSString stringWithFormat:@"%@",dict[@"answer"]];
    }
    return self;
}

+ (instancetype)addModelFromDictionary:(NSDictionary *)dict
{
    
    return [[Q_AOneModel alloc] initWithDictionary:dict];
    
}
@end
