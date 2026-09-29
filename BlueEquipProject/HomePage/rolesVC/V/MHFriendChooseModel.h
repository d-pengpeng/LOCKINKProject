//
//  MHFriendChooseModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFriendChooseModel : NSObject

@property (nonatomic, copy) NSString *nickName;
@property(nonatomic, copy) NSString *faceURL;
@property(nonatomic, copy) NSString *userId;
@property (nonatomic, assign) BOOL isSelBoo;
@end

NS_ASSUME_NONNULL_END
