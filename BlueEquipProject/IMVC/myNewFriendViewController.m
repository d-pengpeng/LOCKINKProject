//
//  myNewFriendViewController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/23.
//

#import "myNewFriendViewController.h"
#import "TUINewFriendViewController.h"
#import "c2cChatDetailController.h"
#import "MHOthrMyController.h"

@interface myNewFriendViewController ()<TUINewFriendViewCDelegate>
@property (nonatomic, strong) TUINewFriendViewController *TUINewFriendViewC;

@end

@implementation myNewFriendViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.titleName.text = eLocalizedString(@"message_tile12");
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:0];
    self.titleName.textColor = UIColor.blackColor;
    
    self.TUINewFriendViewC = [[TUINewFriendViewController alloc] init];
    self.TUINewFriendViewC.delegate_ = self;
    [self addChildViewController:self.TUINewFriendViewC];
    self.TUINewFriendViewC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    [self.view addSubview:self.TUINewFriendViewC.view];
    [self.TUINewFriendViewC addUIUIUIUIUpload];
    [self.view addSubview:self.navView];
}

- (void)TUINewFriendViewCDelegateMethodTyp:(TUICommonPendencyCellData *)model
{
    c2cChatDetailController *vc = [[c2cChatDetailController alloc] init];
    vc.chatId = model.application.userID;
    vc.isShowSend = YES;
    vc.typeId = -1;
    vc.conversationID = [NSString stringWithFormat:@"c2c_%@", model.application.userID];
    [self.navigationController pushViewController:vc animated:YES];
   
}

- (void)TUINewFriendViewCDelegateMethodTypTwoSpace:(TUICommonPendencyCellData *)model
{
    MHOthrMyController *vc = [[MHOthrMyController alloc] init];
    vc.otherId = minStr(model.application.userID);
    [self.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^{
        
    };
}


@end
