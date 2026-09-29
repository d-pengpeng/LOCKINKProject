//
//  MHBoXingModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHBoXingModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) BOOL isPlayBoo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *feel;
@property (nonatomic, copy) NSString *time;
@end

NS_ASSUME_NONNULL_END
