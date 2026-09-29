//
//  eBaseViewController.m
//  FireJob
//
//  Created by Edwin on 2023/10/20.
//

#import "eBaseViewController.h"
//#import "SVProgressHUD.h"

@interface eBaseViewController ()

@end

@implementation eBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = GroupBackColor;//[UIColor groupTableViewBackgroundColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    
    self.backImgV = [HistoryRecordModel createImgImgView];
    self.backImgV.frame = CGRectMake(0, 0, _window_width, _window_height);
    self.backImgV.image = [UIImage imageNamed:@"allBackImgs"];
    [self.view addSubview:self.backImgV];
    self.backImgV.hidden = YES;
    
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _window_width, NAVHEIGHT)];
    self.navView.backgroundColor = [UIColor whiteColor];
    self.navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.navView];
    
    self.headIII = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, NAVHEIGHT)];
    self.headIII.image = [UIImage imageNamed:@"expertTopImg"];
    [self.navView addSubview:self.headIII];
    self.headIII.hidden = YES;
    
    //标题
    self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(50, TIMESTATUSHEIGHT, _window_width-50*2, 40)];
    [self.titleName setFont:SYS_Font(17)];
    self.titleName.textColor=UIColor.blackColor;
    self.titleName.textAlignment=NSTextAlignmentCenter;
    [self.navView addSubview:self.titleName];
    
    
    self.backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBnt.frame = CGRectMake(10, TIMESTATUSHEIGHT+2, 40, 40);
    self.backBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:UIControlStateNormal];
    self.backBnt.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.backBnt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.backBnt];

    //底部线条
//    self.navLine = [[UIView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT-0.3, _window_width, 0.3)];
//    self.navLine.backgroundColor = GroupBackColor;
//    [self.navView addSubview:self.navLine];
    
  
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitUserInfoNotice) name:@"exitToLogin" object:nil];
    
}

- (void)setShowImgVV:(BOOL)showImgVV
{
    self.backImgV.hidden = !showImgVV;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)setHideBackBnt:(BOOL)hideBackBnt{
    self.backBnt.hidden = hideBackBnt;
    
}

-(void)setHideNavView:(BOOL)hideNavView {
    self.navView.hidden = hideNavView;
}


-(void)setRedNavView:(BOOL)redNavView {
    if (redNavView) {
        
        self.navView.backgroundColor = UIColor.clearColor;
        [self.backBnt setImage:[UIImage imageNamed:@"EventLiving_back"] forState:0];
        self.titleName.textColor= UIColor.whiteColor;
    }else {

        self.navView.backgroundColor = UIColor.whiteColor;
        [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:0];
        self.titleName.textColor = UIColor.blackColor;
    }
}


-(void)createNavLeftImage:(UIImage *)image {
    
    UIButton *leftBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBnt.frame = CGRectMake(-10, TIMESTATUSHEIGHT, 60, 40);
    leftBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [leftBnt setImage:image forState:UIControlStateNormal];
    leftBnt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    backItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBnt addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBnt];
    
}

-(void)createNavRightImage:(UIImage *)image {
    
    UIButton *rightImgBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightImgBnt.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    rightImgBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightImgBnt setImage:image forState:UIControlStateNormal];
    rightImgBnt.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    backItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightImgBnt addTarget:self action:@selector(rightImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightImgBnt];
    
}


-(void)createNavRightTitle:(NSString *)title {
    
    UIButton *rightBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBnt.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    rightBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBnt.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBnt setTitle:title forState:0];
    if ([title isEqualToString:eLocalizedString(@"home_set_Commit")]||[title isEqualToString:eLocalizedString(@"delete_name")]) {
        [rightBnt setTitleColor:UIColor.blackColor forState:0];
    }else {
        [rightBnt setTitleColor:UIColor.whiteColor forState:0];
    }
    [rightBnt addTarget:self action:@selector(rightTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBnt];
    
}

- (void)createNavLeftTitle:(NSString *)title
{
    UIButton *leftBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBnt.frame = CGRectMake(-10, TIMESTATUSHEIGHT, 60, 40);
    leftBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    leftBnt.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBnt setTitle:title forState:0];
    if([title isEqualToString:eLocalizedString(@"backP_back")]) {
        [leftBnt setTitleColor:UIColor.whiteColor forState:0];
    }else {
        [leftBnt setTitleColor:RGB(50, 50, 50) forState:0];
    }
    [leftBnt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBnt];
}


-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightTitleAction:(UIButton *)sender{
}

-(void)rightImageAction:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)leftAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)reloadDataWithCurrentView:(BOOL)isCurrent{
    NSLog(@"退出登录");
}



-(BOOL)pageLoadMore:(NSDictionary *)dict {
    
    if ([dict[@"obj"][@"current"] intValue] < [dict[@"obj"][@"pages"] intValue]) {
        return YES;
    }
    return NO;
}

#pragma mark----SVProgressHUD----

-(void)configHUD {
    
    //设置HUD的Style
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeBlack)];
//
//    //设置HUD和文本的颜色
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//
//    //设置HUD背景颜色
//    [SVProgressHUD setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
//
//    [SVProgressHUD setMaximumDismissTimeInterval:1];
//
//    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
//

    //设置提示框的边角弯曲半径
//    [SVProgressHUD setCornerRadius:5];

    
}

-(void)hideHUD {
    
//    [SVProgressHUD dismiss];
}

-(void)showLoading {
    [self configHUD];
    [self hideHUD];
//    [SVProgressHUD showWithStatus:@"请稍后"];
}


-(void)showInfoHUD:(NSString *)info {
    [self configHUD];
    [self hideHUD];
//    [SVProgressHUD showInfoWithStatus:info];
    
}

-(void)showSuccessHUD:(NSString *)success {
    [self configHUD];
    [self hideHUD];
//    [SVProgressHUD showSuccessWithStatus:success];
    
}


-(void)showHUD:(NSString *)title {
//    [SVProgressHUD showWithStatus:title];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)exitUserInfoNotice{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
