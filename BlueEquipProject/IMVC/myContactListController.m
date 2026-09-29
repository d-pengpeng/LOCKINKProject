//
//  myContactListController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/23.
//

#import "myContactListController.h"
#import "TUIContactController.h"
#import "TUIKit.h"
#import "TUICommonModel.h"
#import "TUINaviBarIndicatorView.h"
#import "myNewFriendViewController.h"
#import "c2cChatDetailController.h"
#import "myGroupConversationListController.h"
#import "myBlackListController.h"

@interface myContactListController ()<TUIContactCDelegate>
@property (nonatomic, strong) TUIContactController *contactVC;
@property (nonatomic, strong) TUINaviBarIndicatorView *titleView;

@end

@implementation myContactListController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.contactVC uploadRedNumMehtod];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hideNavView = YES;
//    self.backImgV.image = [UIImage imageNamed:@"allBackImgsMsg"];
//    self.showImgVV = YES;
    
    self.contactVC = [[TUIContactController alloc] init];
    self.contactVC.delelgte_ = self;
    [self addChildViewController:self.contactVC];
//    if(TARBARHEIGHT > 50) {
//        self.contactVC.view.frame = CGRectMake(0, 10, _window_width, _window_height-NAVHEIGHT-14-20-TARBARHEIGHT);
//    }else {
//        self.contactVC.view.frame = CGRectMake(0, 10, _window_width, _window_height-NAVHEIGHT-14-38-TARBARHEIGHT);
//    }
    self.contactVC.view.frame = CGRectMake(0, 0, _window_width, _window_height);
    [self.view addSubview:self.contactVC.view];
    [self.contactVC uploadUIUIUIUIMehtod];
    [self.view addSubview:self.navView];
    self.contactVC.view.backgroundColor = UIColor.clearColor;
}

- (void)redNumUploadMehtod:(NSInteger)redNum
{
    if(self.block_) {
        self.block_(redNum);
    }
}

- (void)TUIContactCDelegateMethodType:(NSInteger)typeL friendName:(nonnull NSString *)friendNick faceUrl:(nonnull NSString *)face_url userId:(nonnull NSString *)userId
{
    if(typeL == 1) {
        myNewFriendViewController *vc = [[myNewFriendViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeL == 2) {
        
        if(![userId isEqualToString:[LYUserDefault userDefault].kefuId]) {
            c2cChatDetailController *vc = [[c2cChatDetailController alloc] init];
            vc.chatId = userId;
            vc.isShowSend = YES;
            vc.typeId = -1;
            vc.conversationID = [NSString stringWithFormat:@"c2c_%@", userId];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (typeL == 3) {
        
        myGroupConversationListController *vc = [[myGroupConversationListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeL == 5) {
        
        myBlackListController *vc = [[myBlackListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.black_ = ^(TUICommonContactCell * _Nonnull cell) {

            [self.contactVC addTUICommonContactCell:cell];
        };
    }
}


@end
