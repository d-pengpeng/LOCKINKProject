//
//  myGroupMemberController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/21.
//

#import "myGroupMemberController.h"
#import "TUIGroupMemberController.h"
#import "TUIGlobalization.h"
#import "myContactSelectController.h"

@interface myGroupMemberController ()<TGroupMemberControllerDelegagte>
@property (nonatomic, strong) TUIGroupMemberController *TUIGroupInfoC;
@end

@implementation myGroupMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"expertTitl_detail");
    
    self.TUIGroupInfoC = [[TUIGroupMemberController alloc] init];
    self.TUIGroupInfoC.groupId = self.chatId;
    self.TUIGroupInfoC.delegate = self;
    self.TUIGroupInfoC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    [self addChildViewController:self.TUIGroupInfoC];
    [self.view addSubview:self.TUIGroupInfoC.view];
    
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-42, TIMESTATUSHEIGHT+7, 30, 30)];
    [doneBtn setTitle:TUIKitLocalizableString(TUIKitGroupProfileManage) forState:UIControlStateNormal];
    [doneBtn setTitleColor:GrayTextColor forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [doneBtn addTarget:self action:@selector(onNext) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:doneBtn];
}

- (void)onNext
{
    [self.TUIGroupInfoC rightBarButtonClick];
}

- (void)groupMemberController:(TUIGroupMemberController *)controller didAddMembersInGroup:(NSString *)groupId hasMembers:(NSMutableArray *)members
{
    if(members.count >0) {
        NSMutableArray *idenMut = [NSMutableArray array];
        for (TUIGroupMemberCellData *modelLL in members) {
            [idenMut addObject:modelLL.identifier];
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 1;
        vc.groupArr = idenMut;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(NSString * _Nonnull nickNN, NSString * _Nonnull grouId) {
            [self.TUIGroupInfoC uploadUIUIUIUIMethod];
        };
    }
}

- (void)groupMemberController:(TUIGroupMemberController *)controller didDeleteMembersInGroup:(NSString *)groupId hasMembers:(NSMutableArray *)members
{
    if(members.count >1) {
        NSMutableArray *idenMut = [NSMutableArray array];
        for (TUIGroupMemberCellData *modelLL in members) {
            if(![[LYUserDefault userDefault].t_id isEqualToString:modelLL.identifier]) {
//                [idenMut addObject:modelLL.identifier];
                [idenMut addObject:modelLL];
            }
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 2;
        vc.groupArr = idenMut;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(NSString * _Nonnull nickNN, NSString * _Nonnull grouId) {
            [self.TUIGroupInfoC uploadUIUIUIUIMethod];
        };
    }
}

- (void)didCancelInGroupMemberController:(TUIGroupMemberController *)controller
{
    
}

@end
