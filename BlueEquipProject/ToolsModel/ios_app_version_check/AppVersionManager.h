
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppVersionManager : NSObject

+ (void)checkAppStoreVersionWithAppId:(NSString *)appId;

@end

NS_ASSUME_NONNULL_END
