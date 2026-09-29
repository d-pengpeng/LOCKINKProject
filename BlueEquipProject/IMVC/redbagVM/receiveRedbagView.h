//
//  receiveRedbagView.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^receiveRedbagVBlock)(NSInteger numL, NSString *moneyStr, NSDictionary *alDDic);
@interface receiveRedbagView : UIView

@property (nonatomic, copy) receiveRedbagVBlock block_;
@property (nonatomic, copy) NSString *redId;
@property (nonatomic, copy) NSString *remarkStr;
@property (nonatomic, strong) NSDictionary *allDic;
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, assign) NSInteger typeLLM;
- (void)addUIUIUIType:(NSInteger)typeL;
- (void)requestMethodUrl:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
