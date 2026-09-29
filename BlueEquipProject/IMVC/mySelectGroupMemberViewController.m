//
//  mySelectGroupMemberViewController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/21.
//

#import "mySelectGroupMemberViewController.h"
#import "TUISelectGroupMemberViewController.h"

@interface mySelectGroupMemberViewController ()
@property (nonatomic, strong) TUISelectGroupMemberViewController *TUIGroupInfoC;
@property (nonatomic, strong) UIButton *doneBtn;
@end

@implementation mySelectGroupMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"expertTitl_detail");
    
    self.TUIGroupInfoC = [[TUISelectGroupMemberViewController alloc] init];
    self.TUIGroupInfoC.groupId = self.chatId;
    self.TUIGroupInfoC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    self.TUIGroupInfoC.optionalStyle = 1;
    [self addChildViewController:self.TUIGroupInfoC];
    [self.view addSubview:self.TUIGroupInfoC.view];
    self.TUIGroupInfoC.selectedFinished = ^(NSMutableArray<TUIUserModel *> * _Nonnull modelList) {
      
        
    };
    
    _doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-42, TIMESTATUSHEIGHT+7, 30, 30)];
    [_doneBtn setTitle:TUIKitLocalizableString(Done) forState:UIControlStateNormal];
    [_doneBtn setAlpha:0.5];
    [_doneBtn setTitleColor:[UIColor d_systemBlueColor] forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(onNext) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:_doneBtn];
}

- (void)onNext
{
    [self.TUIGroupInfoC onNextNew];
}



@end
