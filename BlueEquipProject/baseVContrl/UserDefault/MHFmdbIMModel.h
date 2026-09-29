//
//  MHFmdbIMModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHFmdbIMModelBLock)(int tyNum);
@interface MHFmdbIMModel : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, copy) MHFmdbIMModelBLock block_;

@end

NS_ASSUME_NONNULL_END
