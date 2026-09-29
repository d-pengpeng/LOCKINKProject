//
//  MHToggleAccountModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHToggleAccountModel : NSObject

@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, assign) BOOL isShhh;
@end

NS_ASSUME_NONNULL_END
