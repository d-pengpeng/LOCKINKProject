//
//  MHLibraryModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHLibraryModel : NSObject

@property (nonatomic, strong) UIImage *avator;
@property (nonatomic, copy) NSString *nameL;
@property (nonatomic, copy) NSString *nickN;
@property (nonatomic, copy) NSString *musicUrl;
@property (nonatomic, assign) int timeLL;

@property (nonatomic, assign) BOOL isShowSel;
@property (nonatomic, assign) BOOL isLove;
@property (nonatomic, copy) NSString *allLStr;
@end

NS_ASSUME_NONNULL_END
