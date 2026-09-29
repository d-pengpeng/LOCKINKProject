//
//  MHManualOperationSubOneView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHManualOperationSubOneVBlock)(NSString *strLLM);
@interface MHManualOperationSubOneView : UIView

@property (nonatomic, copy) MHManualOperationSubOneVBlock block_;
@property (nonatomic, strong) NSArray *arrList;

- (void)addMEthodArr;

@end

@interface MHManualOperationSubOneView_lin : UIView

- (void)addArrToMethodArr:(NSArray *)arr sel:(int)rowL;
@end

NS_ASSUME_NONNULL_END
