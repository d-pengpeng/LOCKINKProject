//
//  StarrySkyAnimate.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/20.
//

#import <UIKit/UIKit.h>
#define View_width self.frame.size.width
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@protocol StarrySkyAnimateDelegate <NSObject>

- (void)clickButtonAction:(NSInteger)index;

@end

@interface StarrySkyAnimate : UIView

@property (nonatomic, copy) void (^tapButtonBlock)(NSInteger buttonTag);
-(void)setCelestialName:(NSArray *)names;
@property (nonatomic, weak) id<StarrySkyAnimateDelegate> delegate;

@property (nonatomic, assign) int numYY;
@property (nonatomic, assign) BOOL isBoo;
@property (nonatomic, assign) CGPoint lastPointInSuperView;
@property (nonatomic, strong) NSMutableArray *arMut;
//@property (nonatomic, strong) NSMutableArray *arMutTwo;
@property (nonatomic, strong) NSArray *ar_twoAr;
@end
