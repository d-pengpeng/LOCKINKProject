//
//  eBaseViewController.h
//  FireJob
//
//  Created by Edwin on 2023/10/20.
//

#import <UIKit/UIKit.h>

@interface eBaseViewController : UIViewController

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UILabel *titleName;
@property (nonatomic,strong) UIButton *backBnt;
@property (nonatomic,strong) UIView *navLine;
@property (nonatomic,strong) UIImageView *headIII;
@property (nonatomic,strong) UIImageView *backImgV;
@property (nonatomic,assign) BOOL hideBackBnt;
@property (nonatomic,assign) BOOL hideNavView;
@property (nonatomic,assign) BOOL redNavView;
@property (nonatomic,assign) BOOL showImgVV;

@property (nonatomic,assign) NSInteger page;

-(void)leftAction:(UIButton *)sender;
-(void)backAction:(UIButton *)sender;
-(void)rightTitleAction:(UIButton *)sender;
-(void)rightImageAction:(UIButton *)sender;
-(void)createNavRightImage:(UIImage *)image;
-(void)createNavLeftImage:(UIImage *)image;
-(void)createNavRightTitle:(NSString *)title;
-(void)createNavLeftTitle:(NSString *)title;
-(void)reloadDataWithCurrentView:(BOOL)isCurrent;

/**是否加载更多数据*/
-(BOOL)pageLoadMore:(NSDictionary *)dict;

//
-(void)showHUD:(NSString *)title;
-(void)showLoading;
-(void)showInfoHUD:(NSString *)info;
-(void)hideHUD;
-(void)showSuccessHUD:(NSString *)success;


@end
