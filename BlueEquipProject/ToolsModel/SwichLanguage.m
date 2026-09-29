//
//  SwichLanguage.m
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2020/12/28.
//  Copyright © 2020 time. All rights reserved.
//

#import "SwichLanguage.h"

static NSString *LocalLanguageKey = @"SwitchLanguage";

static SwichLanguage *shareTool = nil;

@interface SwichLanguage()

@property(nonatomic,strong)NSBundle *bundle;
@property(nonatomic,copy)NSString *language;

@end

@implementation SwichLanguage

+(id)shareInstance {
    @synchronized (self) {
        if (shareTool == nil) {
            shareTool = [[SwichLanguage alloc]init];
        }
    }
    return shareTool;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    if (shareTool == nil) {
        shareTool = [super allocWithZone:zone];
    }
    return shareTool;
}

-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table {
    if (self.bundle) {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    return NSLocalizedStringFromTable(key, table, @"");
}

//获取当前语言
-(NSString *)userLanguage{

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];

    NSString *language = [def valueForKey:LocalLanguageKey];

    if(!language) {
        NSArray *preferredLanguages = [NSLocale preferredLanguages];

        if(preferredLanguages.count > 0) {
            language = preferredLanguages[0];
            if ([language hasPrefix:@"zh"]) {
                language = @"zh-Hans";
            }else {
                language = @"en";
            }
        }else {
            language = @"en";
        }
        return language;
    }else {
        return language;
    }
}

//设置语言
-(void)setUserlanguage:(NSString *)language {

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currLanguage = [userDefaults valueForKey:LocalLanguageKey];
    
    if(!currLanguage) {
        NSArray *preferredLanguages = [NSLocale preferredLanguages];

        if(preferredLanguages.count > 0) {
            currLanguage = preferredLanguages[0];

            if ([currLanguage hasPrefix:@"en"]) {

                currLanguage = @"en";
            }else if ([currLanguage hasPrefix:@"zh"]) {
                
                currLanguage = @"zh-Hans";
            }else currLanguage = @"en";
        }else {
            currLanguage = @"en";
        }
  
        if(language.length > 0) {
            currLanguage = language;
            [userDefaults setValue:currLanguage forKey:LocalLanguageKey];
            [userDefaults synchronize];
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
        
        self.bundle = [NSBundle bundleWithPath:path];
        
    }else {
        if(language.length > 0) {
            if ([currLanguage isEqualToString:language]) {

                return;
            }
            
            currLanguage = language;

            [userDefaults setValue:currLanguage forKey:LocalLanguageKey];

            [userDefaults synchronize];

            NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
            
            self.bundle = [NSBundle bundleWithPath:path];
        }else {

            NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
            
            self.bundle = [NSBundle bundleWithPath:path];
        }
    }
}

@end
