//
//  mySearchFriendViewController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/3/24.
//

#import "mySearchFriendViewController.h"
#import "TUISearchViewController.h"
#import "myGroupChatController.h"
#import "c2cChatController.h"
#import "mySearchAddViewController.h"

@interface mySearchFriendViewController ()<TUISearchViewCDelegate, UITextFieldDelegate>

@property (nonatomic, strong) TUISearchViewController *TUISearchViewC;
@property (nonatomic, strong) UITextField *input_textF;
@end

@implementation mySearchFriendViewController

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
    self.hideBackBnt = YES;
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.input_textF = [[UITextField alloc] initWithFrame:CGRectMake(12, NAVHEIGHT-34, _window_width-90, 32)];
    self.input_textF.backgroundColor = RGB(243, 224, 251);
    self.input_textF.layer.cornerRadius = 16;
    self.input_textF.font = SYS_Font(14);
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:eLocalizedString(@"message_tile11") attributes: @{NSForegroundColorAttributeName:GrayText, NSFontAttributeName:self.input_textF.font}];
    self.input_textF.attributedPlaceholder = attrString4;
    self.input_textF.delegate = self;
    self.input_textF.textColor = UIColor.blackColor;
    self.input_textF.returnKeyType = UIReturnKeySearch;
    self.input_textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.input_textF addTarget:self action:@selector(textFieldShouldChangeMethod:) forControlEvents:UIControlEventEditingChanged];
    [self.navView addSubview:self.input_textF];
    
    UIButton *rImgBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    rImgBnt.frame = CGRectMake(_window_width-78, NAVHEIGHT-34, 78, 32);
    [rImgBnt setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
    [rImgBnt setTitleColor:RGB(176, 51, 228) forState:UIControlStateNormal];
    rImgBnt.titleLabel.font = SYS_Font(14);
    [rImgBnt addTarget:self action:@selector(rImgSearchBnt) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rImgBnt];
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 32)];
    leftV.backgroundColor = UIColor.clearColor;
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7, 18, 18)];
    leftIcon.image = [UIImage imageNamed:@"searchImgs_2"];
    [leftV addSubview:leftIcon];
    self.input_textF.leftView = leftV;
    self.input_textF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *twoVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, 88)];
    twoVV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:twoVV];
    
    UIImageView *twoIMV = [HistoryRecordModel createImgImgView];
    twoIMV.frame = CGRectMake(12, 27, 34, 34);
    twoIMV.layer.cornerRadius = 17;
    twoIMV.image = [UIImage imageNamed:@"message_allImg22"];
    [twoVV addSubview:twoIMV];
    
    UILabel *twoLL = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    twoLL.frame = CGRectMake(58, 27, _window_width-70, 34);
    twoLL.text = eLocalizedString(@"message_tile12");
    [twoVV addSubview:twoLL];
    
    UIView *linTwoV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 10)];
    linTwoV.backgroundColor = RGB(243, 224, 251);
    [twoVV addSubview:linTwoV];
    
    UIView *linTwoV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 78, _window_width, 10)];
    linTwoV2.backgroundColor = RGB(243, 224, 251);
    [twoVV addSubview:linTwoV2];
    
    UIButton *clickTwoB = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, _window_width, 68)];
    [clickTwoB addTarget:self action:@selector(clickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [twoVV addSubview:clickTwoB];
    
    self.TUISearchViewC = [[TUISearchViewController alloc] init];
    self.TUISearchViewC.delegate_ = self;
    self.TUISearchViewC.isHistoryBoo = YES;
    [self addChildViewController:self.TUISearchViewC];
    self.TUISearchViewC.view.frame = CGRectMake(0, NAVHEIGHT+88, _window_width, _window_height-NAVHEIGHT-88);
    [self.view addSubview:self.TUISearchViewC.view];
    
    [self.input_textF becomeFirstResponder];
    
    [self.view addSubview:self.navView];
}

- (void)clickBtnMethod
{
    mySearchAddViewController *vc = [[mySearchAddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rImgSearchBnt
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldShouldChangeMethod:(UITextField *)textF
{
    NSString *st_sear = textF.text.length>0 ? textF.text:@"";
    [self.TUISearchViewC addSearchTxtStr:st_sear];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)selectTUISearchViewCCLickModel:(V2TIMFriendInfo *)model
{
    NSString *nick_str = model.userFullInfo.nickName.length>0 ? model.userFullInfo.nickName:model.userFullInfo.userID;
    [[FloatingWindowModel shareInstance] switchChatDetailControlNick:nick_str hostId:model.userFullInfo.userID];
}

- (void)TUISearchViewCSelectRow:(TUIChatConversationModel *)conData highlightKeyword:(NSString *)highlightKeyword imgMMMessage:(V2TIMMessage *)locateMessage
{
    if(conData.groupID.length > 0) {
        myGroupChatController *vc = [[myGroupChatController alloc] init];
        vc.isHistoryBoo = YES;
        vc.showName = conData.title;
        vc.locateMessage = locateMessage;
        vc.conversationData = conData;
        vc.highlightKeyword = highlightKeyword;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(conData.userID.length > 0) {
        c2cChatController *vc = [[c2cChatController alloc] init];
        vc.isHistoryBoo = YES;
        vc.showName = conData.title;
        vc.locateMessage = locateMessage;
        vc.conversationData = conData;
        vc.highlightKeyword = highlightKeyword;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)TUISearchViewCSelectGroupid:(NSString *)groupId name:(NSString *)nameT isBOO:(BOOL)isBoo
{
    if(groupId.length > 0) {
        if(isBoo) {
            [[FloatingWindowModel shareInstance] switchGroupChatDetailControlNick:nameT hostId:groupId];
        }else {
            [[FloatingWindowModel shareInstance] switchChatDetailControlNick:nameT hostId:groupId];
        }
    }
}

@end
