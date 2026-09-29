//
//  myGroupConversationListController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/16.
//

#import "myGroupConversationListController.h"
#import "TUIGroupConversationListController.h"

@interface myGroupConversationListController ()<TUIGroupConversationListCDelegate>
@property (nonatomic, strong) TUIGroupConversationListController *TUINewFriendViewC;
@end

@implementation myGroupConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleName.text = eLocalizedString(@"contact_friend2");
    
    self.TUINewFriendViewC = [[TUIGroupConversationListController alloc] init];
    self.TUINewFriendViewC.delegate_ = self;
    [self addChildViewController:self.TUINewFriendViewC];
    self.TUINewFriendViewC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    [self.view addSubview:self.TUINewFriendViewC.view];
    [self.TUINewFriendViewC uploadUIUIUIUIMehtod];
    
    
    [self.view addSubview:self.navView];
}

- (void)addTUIGroupConversationListCDelegateIndexGroupId:(NSString *)groupId name:(NSString *)name
{
    [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:name hostId:groupId];
}

@end
