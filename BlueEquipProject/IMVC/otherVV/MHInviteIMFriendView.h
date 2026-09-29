//
//  MHInviteIMFriendView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^InviteIMFriendVBLock)(BOOL isBBoo, NSDictionary *dicMM);
@interface MHInviteIMFriendView : UIView

@property (nonatomic, copy) InviteIMFriendVBLock block_;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *twoLab;
@property (nonatomic, strong) UILabel *thrLab;
@property (nonatomic, strong) UIButton *lefBtn;
@property (nonatomic, strong) UIButton *rigBtn;
@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, strong) NSDictionary *al_dic;
@property (nonatomic, assign) NSInteger tyyM;
@property (nonatomic, copy) NSString *dayid;
@property (nonatomic, assign) BOOL isZhuanYiBo;
@property (nonatomic, assign) BOOL isRRRR;
- (void)addUUIUType:(BOOL)isBoo recordIId:(NSString *)id_id;

- (void)addUUIUTypeTwo:(BOOL)isBoo recordIId:(NSString *)id_id;
@end

NS_ASSUME_NONNULL_END
