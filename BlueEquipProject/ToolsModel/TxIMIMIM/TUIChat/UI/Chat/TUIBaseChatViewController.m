//
//  TUIBaseChatViewController.m
//  UIKit
//
//  Created by annidyfeng on 2019/5/21.
//

#import "TUIBaseChatViewController.h"
#import <AFNetworking.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "ReactiveObjC.h"
#import "TUIMessageController.h"
#import "TUIImageMessageCellData.h"
#import "TUIVideoMessageCellData.h"
#import "TUIFileMessageCellData.h"
#import "TUIVoiceMessageCellData.h"
#import "TUITextMessageCellData.h"
#import "TUIFaceMessageCellData.h"
#import "TUISystemMessageCellData.h"
#import "TUIDefine.h"
#import "TUIMessageMultiChooseView.h"
#import "TUIMessageSearchController.h"
#import "TUIChatDataProvider.h"
#import "TUIMessageDataProvider.h"
#import "TUICameraViewController.h"
#import "TUITool.h"
#import "TUICore.h"
#import "TUIDefine.h"
#import "NSDictionary+TUISafe.h"

@interface TUIBaseChatViewController () <TUIMessageControllerDelegate, TInputControllerDelegate, UIImagePickerControllerDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate, TUIMessageMultiChooseViewDelegate, TUIChatDataProviderForwardDelegate, TUICameraViewControllerDelegate, TUINotificationProtocol>
@property (nonatomic, strong) TUIMessageMultiChooseView *multiChooseView;
@property (nonatomic, assign) BOOL responseKeyboard;
// @{@"serviceID" : serviceID, @"title" : @"视频通话", @"image" : image}
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *resgisterParam;
@property (nonatomic, strong) TUIChatDataProvider *dataProvider;

@property (nonatomic, weak) UIViewController *forwardConversationSelectVC;
@property (nonatomic) NSArray<TUIMessageCellData *> *forwardSelectUIMsgs;
@property (nonatomic) BOOL isMergeForward;

@end

@implementation TUIBaseChatViewController

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [TUIBaseChatViewController createCachePath];

        if (NSClassFromString(@"TUIKitLive")) {
            self.isEnableLive = YES;
        }
        self.isEnableVideoCall= YES;
        self.isEnableAudioCall= YES;
        self.isEnableLink = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor d_colorWithColorLight:TController_Background_Color dark:TController_Background_Color];//[UIColor d_colorWithColorLight:TController_Background_Color dark:TController_Background_Color_Dark];

    //message
    if (self.locateMessage) {
        TUIMessageSearchController *vc = [[TUIMessageSearchController alloc] init];
        vc.hightlightKeyword = self.highlightKeyword;
        vc.locateMessage = self.locateMessage;
        _messageController = vc;
        
    }else {
        _messageController = [[TUIMessageController alloc] init];
    }
    _messageController.delegate = self;
    [_messageController setConversation:self.conversationData];
    _messageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TTextView_Height - Bottom_SafeHeight);
    [self addChildViewController:_messageController];
    [self.view addSubview:_messageController.view];

    //input
    _inputController = [[TUIInputController alloc] init];
    _inputController.delegate = self;
    @weakify(self)
    [RACObserve(self, moreMenus) subscribeNext:^(NSArray *x) {
        @strongify(self)
        [self.inputController.moreView setData:x];
    }];
    _inputController.view.frame = CGRectMake(0, self.view.frame.size.height - TTextView_Height - Bottom_SafeHeight, self.view.frame.size.width, TTextView_Height + Bottom_SafeHeight);
    _inputController.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _inputController.inputBar.inputTextView.text = self.conversationData.draftText;
    [self addChildViewController:_inputController];
    [self.view addSubview:_inputController.view];
    
    // data provider
    self.dataProvider = [[TUIChatDataProvider alloc] init];
    self.dataProvider.forwardDelegate = self;
    
    // 注册会话选择完成监听
    [TUICore registerEvent:TUICore_TUIConversationNotify subKey:TUICore_TUIConversationNotify_SelectConversationSubKey object:self];
}

- (void)uploadFFFFrame
{
    _inputController.view.frame = CGRectMake(0, self.view.frame.size.height - TTextView_Height - Bottom_SafeHeight, self.view.frame.size.width, TTextView_Height + Bottom_SafeHeight);
    [self addChildViewController:_inputController];
    [self.view addSubview:_inputController.view];
}

- (void)dealloc {    
    [TUICore unRegisterEventByObject:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.responseKeyboard = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.responseKeyboard = NO;
    [self openMultiChooseBoard:NO];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
        [self saveDraft];
    }
}

#pragma mark - Public Methods

- (void)sendMessage:(TUIMessageCellData *)message
{
    [self guardAndSendMessage:message];
}

#pragma mark - 聊天门卫（发送前校验）

- (void)guardAndSendMessage:(TUIMessageCellData *)message
{
    // 群聊门卫接口暂不支持，直接发送
    if (self.conversationData.groupID.length > 0) {
        [self.messageController sendMessage:message];
        return;
    }
    NSDictionary *params = [self guardParamsForMessage:message];
    if (params == nil) {
        [self.messageController sendMessage:message];
        return;
    }
    NSData *imageData = [self guardImageDataForMessage:message];

    @weakify(self);
    [self guardPostWithData:params imageData:imageData completion:^(NSDictionary *data) {
        @strongify(self);
        NSLog(@"[Guard] completion data=%@", data);
        if (![data isKindOfClass:[NSDictionary class]] || data[@"allow"] == nil) {
            // 异常响应按放行处理
            NSLog(@"[Guard] 异常响应，放行发送");
            [self.messageController sendMessage:message];
            return;
        }
        //[self.messageController sendMessage:message];
        BOOL allow = [data[@"allow"] boolValue];
        BOOL violation = [data[@"violation"] boolValue];
        NSLog(@"[Guard] allow=%d violation=%d", allow, violation);
        if (!allow) {
            // 拦截：不发送，toast 展示后台配置的原因文案
            NSString *reason = [NSString stringWithFormat:@"%@", data[@"reason"]];
            NSLog(@"[Guard] 拦截，reason=%@", reason);
            if (reason.length > 0 && ![reason isEqualToString:@"(null)"]) {
                [SVProgressHUD showInfoWithStatus:reason];
            }
            return;
        }
        if (violation) {
            // 内容违规（allow 仍为 true），提示用户确认是否发送
            [self guardShowViolationAlert:^{
                [self.messageController sendMessage:message];
            }];
            return;
        }
        [self.messageController sendMessage:message];
    } fail:^{
        @strongify(self);
        NSLog(@"[Guard] 请求失败，放行发送");
        // 接口请求失败按放行处理，服务端回调闸口仍会兜底拦截
        [self.messageController sendMessage:message];
    }];
}

/// 门卫 multipart 请求，参考 requestToolClass 中 postNetworkRecordVoiceWithUrl 的写法
/// data 为参数字典（会序列化为 JSON 字符串作为 data part），imageData 为可选图片文件
- (void)guardPostWithData:(NSDictionary *)data
                imageData:(NSData *)imageData
               completion:(void (^)(NSDictionary *data))completion
                     fail:(void (^)(void))fail
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString *token = TOKEN ? TOKEN : @"";
    [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    session.requestSerializer.timeoutInterval = 15;
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang = [langStr hasPrefix:@"zh"] ? @"zh" : @"en";

    // data part：参数字典序列化为 JSON 字符串
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&jsonError];
    if (!jsonData) {
        if (fail) fail();
        return;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSString *requestUrl = [INTERFACEADDRESS stringByAppendingString:request_im_beforeSendCheck];
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [session POST:requestUrl
       parameters:nil
          headers:@{@"token": token, @"Accept-Language": lang}
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFormData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] name:@"data"];
        if (imageData.length > 0) {
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:@"guard_image.jpg"
                                    mimeType:@"image/jpeg"];
        }
    } progress:nil
          success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSLog(@"[Guard] responseObject=%@", responseObject);
        // 响应为 NSData，手动解析 JSON
        if (![responseObject isKindOfClass:[NSData class]]) {
            NSLog(@"[Guard] 响应非 NSData 类型，类型=%@", [responseObject class]);
            if (completion) completion(nil);
            return;
        }
        NSError *parseError;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&parseError];
        NSLog(@"[Guard] resultDict=%@ parseError=%@", resultDict, parseError);
        NSDictionary *respData = [resultDict isKindOfClass:[NSDictionary class]] ? resultDict[@"data"] : nil;
        if (completion) completion(respData);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"[Guard] 请求失败 error=%@", error);
        if (fail) fail();
    }];
}

/// 违规内容提示弹窗，用户确认后执行 sendBlock
- (void)guardShowViolationAlert:(void (^)(void))sendBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:eLocalizedString(@"anti_fraud_title")
                                                                   message:eLocalizedString(@"violation_content_tip")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:eLocalizedString(@"cancel") style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:eLocalizedString(@"send_anyway") style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        if (sendBlock) sendBlock();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

/// 构造门卫请求参数字典；返回 nil 表示无需校验（直接放行）
- (NSDictionary *)guardParamsForMessage:(TUIMessageCellData *)message
{
    NSString *toUserId = self.conversationData.userID;
    if (toUserId.length == 0) {
        return nil;
    }
    V2TIMMessage *imMsg = message.innerMessage;
    NSString *msgType = [self guardMsgTypeForMessage:message];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"toUserId"] = @([toUserId longLongValue]);
    dict[@"msgType"] = msgType;
    // 文本消息必填 msgContent，用于违规词检测，最长 10000 字符
    if ([msgType isEqualToString:@"text"]) {
        NSString *text = [(TUITextMessageCellData *)message content];
        // 文本内容为空时无需检测，直接放行
        if (text.length == 0) {
            return nil;
        }
        if (text.length > 10000) {
            text = [text substringToIndex:10000];
        }
        dict[@"msgContent"] = text;
    }
    if ([msgType isEqualToString:@"custom"]) {
        NSString *businessId = [self guardBusinessIdForMessage:imMsg];
        if (businessId.length > 0) {
            dict[@"businessId"] = businessId;
        }
    }
    return dict;
}

/// 获取图片消息的图片数据，用于二维码检测（仅 msgType=image）
- (NSData *)guardImageDataForMessage:(TUIMessageCellData *)message
{
    if (![message isKindOfClass:[TUIImageMessageCellData class]]) {
        return nil;
    }
    TUIImageMessageCellData *imageData = (TUIImageMessageCellData *)message;
    UIImage *image = imageData.originImage ?: imageData.thumbImage;
    // 新发图片只设置了 path，需要从本地路径加载
    if (!image && imageData.path.length > 0) {
        image = [UIImage imageWithContentsOfFile:imageData.path];
    }
    if (!image) {
        return nil;
    }
    return UIImageJPEGRepresentation(image, 0.8);
}

/// 通过 CellData 类型判断消息类型
- (NSString *)guardMsgTypeForMessage:(TUIMessageCellData *)cellData
{
    if ([cellData isKindOfClass:[TUITextMessageCellData class]])  return @"text";
    if ([cellData isKindOfClass:[TUIImageMessageCellData class]]) return @"image";
    if ([cellData isKindOfClass:[TUIVideoMessageCellData class]]) return @"video";
    if ([cellData isKindOfClass:[TUIVoiceMessageCellData class]]) return @"voice";
    if ([cellData isKindOfClass:[TUIFaceMessageCellData class]])  return @"face";
    if ([cellData isKindOfClass:[TUIFileMessageCellData class]])  return @"file";
    // 自定义消息（红包、礼物、链接、位置、直播等）均按 custom 处理
    if ([cellData.innerMessage.customElem.data length] > 0)        return @"custom";
    return @"other";
}

- (NSString *)guardBusinessIdForMessage:(V2TIMMessage *)imMsg
{
    NSData *customData = imMsg.customElem.data;
    if (customData.length == 0) {
        return nil;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:customData options:0 error:nil];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSString *businessId = [NSString stringWithFormat:@"%@", dict[@"businessID"]];
        if (businessId.length > 0 && ![businessId isEqualToString:@"(null)"]) {
            return businessId;
        }
    }
    return nil;
}

/// 同步门卫校验，仅用于转发等后台线程场景（回调在主线程，后台线程等待不会死锁）
- (BOOL)guardCheckSynchronously:(TUIMessageCellData *)message reason:(NSString **)reason
{
    if (self.conversationData.groupID.length > 0) {
        return YES;
    }
    NSDictionary *params = [self guardParamsForMessage:message];
    if (params == nil) {
        return YES;
    }
    NSData *imageData = [self guardImageDataForMessage:message];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block BOOL allowResult = YES;
    __block NSString *reasonResult = nil;

    [self guardPostWithData:params imageData:imageData completion:^(NSDictionary *data) {
        if ([data isKindOfClass:[NSDictionary class]] && data[@"allow"] != nil) {
            allowResult = [data[@"allow"] boolValue];
            if (!allowResult) {
                reasonResult = [NSString stringWithFormat:@"%@", data[@"reason"]];
            } else if ([data[@"violation"] boolValue]) {
                // 转发场景下内容违规直接跳过，不发送
                allowResult = NO;
                reasonResult = eLocalizedString(@"violation_skip_tip");
            }
        }
        dispatch_semaphore_signal(semaphore);
    } fail:^{
        // 请求失败按放行处理
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)));

    if (reason && reasonResult.length > 0 && ![reasonResult isEqualToString:@"(null)"]) {
        *reason = reasonResult;
    }
    return allowResult;
}

- (void)saveDraft
{
    [TUIChatDataProvider saveDraftWithConversationID:self.conversationData.conversationID
                                              Text:self.inputController.inputBar.inputTextView.text];
}

#pragma mark - Getters & Setters

- (void)setConversationData:(TUIChatConversationModel *)conversationData {
    _conversationData = conversationData;
    self.resgisterParam = [NSMutableArray array];
    _moreMenus = ({
        // TUIKit 组件内部自定义按钮
        NSMutableArray<TUIInputMoreCellData *> *moreMenus = [TUIChatDataProvider moreMenuCellDataArray:conversationData.groupID userID:conversationData.userID isNeedVideoCall:self.isEnableVideoCall isNeedAudioCall:self.isEnableAudioCall isNeedGroupLive:self.isEnableLive isNeedLink:self.isEnableLink];
        
        NSMutableArray *highMenus = [NSMutableArray array];
        NSMutableArray *nomalMenus = [NSMutableArray array];
        NSMutableArray *lowMenus = [NSMutableArray array];
        NSMutableArray *lowestMenus = [NSMutableArray array];
        
        // 获取 TUIKit 组件外部注册的 more cell
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:onRegisterMoreCell:)]) {
            MoreCellPriority priority;
            NSArray <TUIInputMoreCellData *> *dataList = [self.delegate chatController:self onRegisterMoreCell:&priority];
            if (dataList.count > 0) {
                if (priority == MoreCellPriority_High) {
                    [highMenus addObjectsFromArray:dataList];
                } else if (priority == MoreCellPriority_Nomal) {
                    [nomalMenus addObjectsFromArray:dataList];
                } else if (priority == MoreCellPriority_Low) {
                    [lowMenus addObjectsFromArray:dataList];
                }  else if (priority == MoreCellPriority_Lowest) {
                    [lowestMenus addObjectsFromArray:dataList];
                }
            }
        }
        
        [moreMenus addObjectsFromArray:highMenus];
        [moreMenus addObjectsFromArray:nomalMenus];
        [moreMenus addObjectsFromArray:lowMenus];
        [moreMenus addObjectsFromArray:lowestMenus];
        moreMenus;
    });
    
}

#pragma mark - TUICore

- (void)onNotifyEvent:(NSString *)key subKey:(NSString *)subKey object:(id)anObject param:(NSDictionary *)param {
    if ([key isEqualToString:TUICore_TUIConversationNotify]
        && [subKey isEqualToString:TUICore_TUIConversationNotify_SelectConversationSubKey]
        && self.forwardConversationSelectVC == anObject) {
        NSArray<NSDictionary *> *selectList = param[TUICore_TUIConversationNotify_SelectConversationSubKey_ConversationListKey];
        
        NSMutableArray<TUIChatConversationModel *> *targetList = [NSMutableArray arrayWithCapacity:selectList.count];
        for (NSDictionary *selectItem in selectList) {
            TUIChatConversationModel *model = [TUIChatConversationModel new];
            model.title = selectItem[TUICore_TUIConversationNotify_SelectConversationSubKey_ItemTitleKey];
            model.userID = selectItem[TUICore_TUIConversationNotify_SelectConversationSubKey_ItemUserIDKey];
            model.groupID = selectItem[TUICore_TUIConversationNotify_SelectConversationSubKey_ItemGroupIDKey];
            model.conversationID = selectItem[TUICore_TUIConversationNotify_SelectConversationSubKey_ItemConversationIDKey];
            [targetList addObject:model];
        }
        
        [self forwardMessages:self.forwardSelectUIMsgs toTargets:targetList merge:self.isMergeForward];
        self.forwardSelectUIMsgs = nil;
    }
}

#pragma mark - TInputControllerDelegate
- (void)inputController:(TUIInputController *)inputController didChangeHeight:(CGFloat)height
{
    if (!self.responseKeyboard) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(chatControllerInputCHeight:)]) {
        [self.delegate chatControllerInputCHeight:height];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect msgFrame = self.messageController.view.frame;
        msgFrame.size.height = self.view.frame.size.height - height;
        self.messageController.view.frame = msgFrame;

        CGRect inputFrame = self.inputController.view.frame;
        inputFrame.origin.y = msgFrame.origin.y + msgFrame.size.height;
        inputFrame.size.height = height;
        self.inputController.view.frame = inputFrame;
        [self.messageController scrollToBottom:NO];
    } completion:nil];
}

- (void)inputController:(TUIInputController *)inputController didSendMessage:(TUIMessageCellData *)msg
{
    [self guardAndSendMessage:msg];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:didSendMessage:)]) {
//        [self.delegate chatController:self didSendMessage:msg];
//    }
}

- (void)inputController:(TUIInputController *)inputController didSendCustomMessage:(NSString *)msg
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:didSendCustomMessage:)]) {
        [self.delegate chatController:self didSendCustomMessage:msg];
    }
}

- (void)inputControllerDidInputAt:(TUIInputController *)inputController
{
    // 交给 GroupChatVC 去处理
}

- (void)inputController:(TUIInputController *)inputController didDeleteAt:(NSString *)atText
{
    // 交给 GroupChatVC 去处理
}

- (void)inputController:(TUIInputController *)inputController didSelectMoreCell:(TUIInputMoreCell *)cell
{
    cell.disableDefaultSelectAction = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:onSelectMoreCell:)]) {
        [self.delegate chatController:self onSelectMoreCell:cell];
    }
    
    if (cell.disableDefaultSelectAction) {
        return;
    }
    if (cell.data == [TUIInputMoreCellData photoData]) {
        [self selectPhotoForSend];
    }
    else if (cell.data == [TUIInputMoreCellData videoData]) {
//        [self takeVideoForSend]; //录像
    }
    else if (cell.data == [TUIInputMoreCellData fileData]) {
//        [self selectFileForSend];
    }
    else if (cell.data == [TUIInputMoreCellData pictureData]) {
        [self takePictureForSend];
    }
}

#pragma mark - TUIMessageControllerDelegate
- (void)didTapInMessageController:(TUIMessageController *)controller
{
    [self.inputController reset];
    [[NSNotificationCenter defaultCenter] postNotificationName:klivingInputClearNote object:nil];
}

- (BOOL)messageController:(TUIMessageController *)controller willShowMenuInCell:(TUIMessageCell *)cell
{
    if([self.inputController.inputBar.inputTextView isFirstResponder]){
        self.inputController.inputBar.inputTextView.overrideNextResponder = cell;
        return YES;
    }
    return NO;
}

- (TUIMessageCellData *)messageController:(TUIMessageController *)controller onNewMessage:(V2TIMMessage *)data
{
    if ((data.elemType == V2TIM_ELEM_TYPE_TEXT)||(data.elemType == V2TIM_ELEM_TYPE_CUSTOM)) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:onNewMessage:)]) {
            return [self.delegate chatController:self onNewMessage:data];
        }
    }
    return nil;
}

- (TUIMessageCell *)messageController:(TUIMessageController *)controller onShowMessageData:(TUIMessageCellData *)data
{
    if ([self.delegate respondsToSelector:@selector(chatController:onShowMessageData:)]) {
        return [self.delegate chatController:self onShowMessageData:data];
    }
    return nil;
}

- (void)messageController:(TUIMessageController *)controller willDisplayCell:(TUIMessageCell *)cell withData:(TUIMessageCellData *)cellData {
    if ([self.delegate respondsToSelector:@selector(chatController:willDisplayCell:withData:)]) {
        [self.delegate chatController:self willDisplayCell:cell withData:cellData];
    }
}

- (void)messageController:(TUIMessageController *)controller onSelectMessageAvatar:(TUIMessageCell *)cell
{
    if (cell.messageData.identifier == nil)
        return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:onSelectMessageAvatar:)]) {
        [self.delegate chatController:self onSelectMessageAvatar:cell];
    }
}

- (void)clickPatternMessageContent:(TUIMessageCell *)cell Type:(NSInteger)typeN
{
    if (cell.messageData.identifier == nil)
        return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickPatternMessageContent:Type:)]) {
        [self.delegate clickPatternMessageContent:cell Type:typeN];
    }
}

- (void)messageController:(TUIMessageController *)controller onSelectMessageContent:(TUIMessageCell *)cell
{
    cell.disableDefaultSelectAction = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:onSelectMessageContent:)]) {
        [self.delegate chatController:self onSelectMessageContent:cell];
    }
    if (cell.disableDefaultSelectAction) {
        return;
    }
}

- (void)messageController:(TUIMessageController *)controller onSelectMessageMenu:(NSInteger)menuType withData:(TUIMessageCellData *)data
{
    [self onSelectMessageMenu:menuType withData:data];
}

- (void)didHideMenuInMessageController:(TUIMessageController *)controller
{
    self.inputController.inputBar.inputTextView.overrideNextResponder = nil;
}

#pragma mark - UIImagePickerController & UIDocumentPickerViewController
- (void)selectPhotoForSend
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)takePictureForSend
{
    TUICameraViewController *vc = [[TUICameraViewController alloc] init];
    vc.type = TUICameraMediaTypePhoto;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)takeVideoForSend
{
    TUICameraViewController *vc = [[TUICameraViewController alloc] init];
    vc.type = TUICameraMediaTypeVideo;
    vc.videoMinimumDuration = 1.5;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectFileForSend
{
    UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypeData] inMode:UIDocumentPickerModeOpen];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 快速点的时候会回调多次
    @weakify(self)
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:YES completion:^{
        @strongify(self)
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageOrientation imageOrientation = image.imageOrientation;
            if(imageOrientation != UIImageOrientationUp)
            {
                CGFloat aspectRatio = MIN ( 1920 / image.size.width, 1920 / image.size.height );
                CGFloat aspectWidth = image.size.width * aspectRatio;
                CGFloat aspectHeight = image.size.height * aspectRatio;

                UIGraphicsBeginImageContext(CGSizeMake(aspectWidth, aspectHeight));
                [image drawInRect:CGRectMake(0, 0, aspectWidth, aspectHeight)];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }

            NSData *data = UIImageJPEGRepresentation(image, 0.75);
            NSString *path = [TUIKit_Image_Path stringByAppendingString:[TUITool genImageName:nil]];
            [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            
            TUIImageMessageCellData *uiImage = [[TUIImageMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
            uiImage.path = path;
            uiImage.length = data.length;
            [self sendMessage:uiImage];

            if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:didSendMessage:)]) {
                [self.delegate chatController:self didSendMessage:uiImage];
            }
        }
        else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
            if (url) {
                [self transcodeIfNeed:url];
                return;
            }
            
            // 在某些情况下，UIImagePickerControllerMediaURL 可能为空，使用 UIImagePickerControllerPHAsset
            PHAsset *asset = nil;
            if (@available(iOS 11.0, *)) {
                asset = [info objectForKey:UIImagePickerControllerPHAsset];
            }
            if (asset) {
                [self originURLWithAsset:asset completion:^(BOOL success, NSURL *URL) {
                    if (success) {
                        [self transcodeIfNeed:URL];
                        return;
                    }
                }];
                return;
            }
            
            // 在 ios 12 的情况下，UIImagePickerControllerMediaURL 及 UIImagePickerControllerPHAsset 可能为空，需要使用其他方式获取视频文件原始路径
            url = [info objectForKey:UIImagePickerControllerReferenceURL];
            if (url) {
                [self originURLWithRefrenceURL:url completion:^(BOOL success, NSURL *URL) {
                    if (success) {
                        [self transcodeIfNeed:URL];
                    }
                }];
                return;
            }
            
            // 其他，不支持
            [self.view makeToast:@"not support this video"];
        }
    }];
}

// 根据 UIImagePickerControllerReferenceURL 获取原始文件路径
- (void)originURLWithRefrenceURL:(NSURL *)URL completion:(void(^)(BOOL success, NSURL *URL))completion
{
    if (completion == nil) {
        return;
    }
    NSDictionary *queryInfo = [self dictionaryWithURLQuery:URL.query];
    NSString *fileName = @"temp.mp4";
    if ([queryInfo.allKeys containsObject:@"id"] && [queryInfo.allKeys containsObject:@"ext"]) {
        fileName = [NSString stringWithFormat:@"%@.%@", queryInfo[@"id"], [queryInfo[@"ext"] lowercaseString]];
    }
    NSString* tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:fileName];
    if ([NSFileManager.defaultManager isDeletableFileAtPath:filePath]) {
        [NSFileManager.defaultManager removeItemAtPath:filePath error:nil];
    }
    NSURL *newUrl = [NSURL fileURLWithPath:filePath];
    ALAssetsLibrary *assetLibrary= [[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:URL resultBlock:^(ALAsset *asset) {
        if (asset == nil) {
            completion(NO, nil);
            return;
        }
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];//this is NSData may be what you want
        BOOL flag = [NSFileManager.defaultManager createFileAtPath:filePath contents:data attributes:nil];
        completion(flag, newUrl);
    } failureBlock:^(NSError *err) {
        completion(NO, nil);
    }];
}

- (void)originURLWithAsset:(PHAsset *)asset completion:(void(^)(BOOL success, NSURL *URL))completion
{
    if (completion == nil) {
        return;
    }
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            completion(NO, nil);
            return;
        }
        
        NSArray<PHAssetResource *> *resources = [PHAssetResource assetResourcesForAsset:asset];
        if (resources.count == 0) {
            completion(NO, nil);
            return;
        }
        
        PHAssetResourceRequestOptions *options = [[PHAssetResourceRequestOptions alloc] init];
        options.networkAccessAllowed = NO;
        __block BOOL invoked = NO;
        [PHAssetResourceManager.defaultManager requestDataForAssetResource:resources.firstObject options:options dataReceivedHandler:^(NSData * _Nonnull data) {
            // 此处会有重复回调的问题
            if (invoked) {
                return;
            }
            invoked = YES;
            if (data == nil) {
                completion(NO, nil);
                return;
            }
            NSString *fileName = @"temp.mp4";
            NSString* tempPath = NSTemporaryDirectory();
            NSString *filePath = [tempPath stringByAppendingPathComponent:fileName];
            if ([NSFileManager.defaultManager isDeletableFileAtPath:filePath]) {
                [NSFileManager.defaultManager removeItemAtPath:filePath error:nil];
            }
            NSURL *newUrl = [NSURL fileURLWithPath:filePath];
            BOOL flag = [NSFileManager.defaultManager createFileAtPath:filePath contents:data attributes:nil];
            completion(flag, newUrl);
        } completionHandler:^(NSError * _Nullable error) {
            completion(NO, nil);
        }];
    }];
}

// 获取 NSURL 查询字符串信息
- (NSDictionary *)dictionaryWithURLQuery:(NSString *)query
{
    NSArray *components = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *item in components) {
        NSArray *subs = [item componentsSeparatedByString:@"="];
        if (subs.count == 2) {
            [dict setObject:subs.lastObject forKey:subs.firstObject];
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];;
}

// 转码
- (void)transcodeIfNeed:(NSURL *)url
{
    if ([url.pathExtension.lowercaseString isEqualToString:@"mp4"]) {
        // mp4 直接发送
        [self sendVideoWithUrl:url];
    } else {
        // 非 mp4 文件 => mp4 文件
        NSString* tempPath = NSTemporaryDirectory();
        NSURL *urlName = [url URLByDeletingPathExtension];
        NSURL *newUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@%@.mp4", tempPath,[urlName.lastPathComponent stringByRemovingPercentEncoding]]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:newUrl.path]){
            NSError *error;
            BOOL success = [fileManager removeItemAtPath:newUrl.path error:&error];
            if (!success || error) {
                NSAssert1(NO, @"removeItemFail: %@", error.localizedDescription);
                return;
            }
        }
        // mov to mp4
        AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        exportSession.outputURL = newUrl;
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status])
            {
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"Export session failed");
                    break;
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"Export canceled");
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    //Video conversion finished
                    NSLog(@"Successful!");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self sendVideoWithUrl:newUrl];
                    });
                }
                    break;
                default:
                    break;
            }
        }];
    }
}

- (void)sendVideoWithUrl:(NSURL*)url {
    [TUITool dispatchMainAsync:^{
        TUIVideoMessageCellData *uiVideo = [TUIMessageDataProvider getVideoCellDataWithURL:url];
        [self sendMessage:uiVideo];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:didSendMessage:)]) {
            [self.delegate chatController:self didSendMessage:uiVideo];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    [url startAccessingSecurityScopedResource];
    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] init];
    NSError *error;
    @weakify(self)
    [coordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
        @strongify(self)
        NSData *fileData = [NSData dataWithContentsOfURL:url];
        NSString *fileName = [url lastPathComponent];
        NSString *filePath = [TUIKit_File_Path stringByAppendingString:fileName];
        if ([NSFileManager.defaultManager fileExistsAtPath:filePath]) {
            // 存在同名文件，对文件名进行递增
            int i = 0;
            NSArray *arrayM = [NSFileManager.defaultManager subpathsAtPath:TUIKit_File_Path];
            for (NSString *sub in arrayM) {
                if ([sub.pathExtension isEqualToString:fileName.pathExtension] &&
                    [sub.stringByDeletingPathExtension containsString:fileName.stringByDeletingPathExtension]) {
                    i++;
                }
            }
            if (i) {
                fileName = [fileName stringByReplacingOccurrencesOfString:fileName.stringByDeletingPathExtension withString:[NSString stringWithFormat:@"%@(%d)", fileName.stringByDeletingPathExtension, i]];
                filePath = [TUIKit_File_Path stringByAppendingString:fileName];
            }
        }
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:nil];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            unsigned long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
            TUIFileMessageCellData *uiFile = [[TUIFileMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
            uiFile.path = filePath;
            uiFile.fileName = fileName;
            uiFile.length = (int)fileSize;
            uiFile.uploadProgress = 0;
            [self sendMessage:uiFile];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:didSendMessage:)]) {
                [self.delegate chatController:self didSendMessage:uiFile];
            }
        }
    }];
    [url stopAccessingSecurityScopedResource];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TUICameraViewControllerDelegate
- (void)cameraViewController:(TUICameraViewController *)controller didFinishPickingMediaWithVideoURL:(NSURL *)url {
    [self transcodeIfNeed:url];
}

- (void)cameraViewController:(TUICameraViewController *)controller didFinishPickingMediaWithImage:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.75);
    NSString *path = [TUIKit_Image_Path stringByAppendingString:[TUITool genImageName:nil]];
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    
    TUIImageMessageCellData *uiImage = [[TUIImageMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    uiImage.path = path;
    uiImage.length = data.length;
    [self sendMessage:uiImage];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:didSendMessage:)]) {
        [self.delegate chatController:self didSendMessage:uiImage];
    }
}

- (void)cameraViewControllerDidCancel:(TUICameraViewController *)controller {
}

#pragma mark - UIImagePickerControllerDelegate

#pragma mark - TUIChatDataProviderForwardDelegate
- (NSString *)dataProvider:(TUIChatDataProvider *)dataProvider mergeForwardTitleWithMyName:(NSString *)name {
    return [self forwardTitleWithMyName:name];
}

- (NSString *)dataProvider:(TUIChatDataProvider *)dataProvider mergeForwardMsgAbstactForMessage:(V2TIMMessage *)message {
    
    NSString *display = @"";
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatController:onGetMessageAbstact:)]) {
        return [self.delegate chatController:self onGetMessageAbstact:message];
    }
    return display;
}

#pragma mark - 消息菜单操作: 多选 & 转发
- (void)onSelectMessageMenu:(NSInteger)menuType withData:(TUIMessageCellData *)data {
    if (menuType == 0) {
        // 多选: 打开多选面板
        [self openMultiChooseBoard:YES];
    } else if (menuType == 1) {
        // 转发
        if (data == nil) {
            return;
        }
        
        NSMutableArray *uiMsgs = [NSMutableArray arrayWithArray:@[data]];
        [self prepareForwardMessages:uiMsgs];
        
    }
}

// 打开、关闭 多选面板
- (void)openMultiChooseBoard:(BOOL)open
{
    [self.view endEditing:YES];
    
    if (_multiChooseView) {
        [_multiChooseView removeFromSuperview];
    }
    
    if (open) {
        _multiChooseView = [[TUIMessageMultiChooseView alloc] init];
        _multiChooseView.frame = self.view.bounds;
        _multiChooseView.delegate = self;
        _multiChooseView.titleLabel.text = self.conversationData.title;
        if (@available(iOS 12.0, *)) {
            if (@available(iOS 13.0, *)) {
                // > ios 12
                [UIApplication.sharedApplication.keyWindow addSubview:_multiChooseView];
            } else {
                // ios = 12
                UIView *view = self.navigationController.view;
                if (view == nil) {
                    view = self.view;
                }
                [view addSubview:_multiChooseView];
            }
        } else {
            // < ios 12
            [UIApplication.sharedApplication.keyWindow addSubview:_multiChooseView];
        }
    } else {
        [self.messageController enableMultiSelectedMode:NO];
    }
}

- (void)messageMultiChooseViewOnCancelClicked:(TUIMessageMultiChooseView *)multiChooseView
{
    [self openMultiChooseBoard:NO];
    [self.messageController enableMultiSelectedMode:NO];
}

- (void)messageMultiChooseViewOnRelayClicked:(TUIMessageMultiChooseView *)multiChooseView
{
    NSArray *uiMsgs = [self.messageController multiSelectedResult:TUIMultiResultOptionAll];
    [self prepareForwardMessages:uiMsgs];
}

- (void)messageMultiChooseViewOnDeleteClicked:(TUIMessageMultiChooseView *)multiChooseView
{
    NSArray *uiMsgs = [self.messageController multiSelectedResult:TUIMultiResultOptionAll];
    if (uiMsgs.count == 0) {
        [TUITool makeToast:TUIKitLocalizableString(TUIKitRelayNoMessageTips)];
        return;
    }
    
    // 删除
    [self.messageController deleteMessages:uiMsgs];
}

// 准备转发消息
- (void)prepareForwardMessages:(NSArray<TUIMessageCellData *> *)uiMsgs
{
    if (uiMsgs.count == 0) {
        [TUITool makeToast:TUIKitLocalizableString(TUIKitRelayNoMessageTips)];
        return;
    }
    
    // 不支持的消息类型
    BOOL hasUnsupportMsg = NO;
    for (TUIMessageCellData *data in uiMsgs) {
        if (data.status != Msg_Status_Succ) {
            hasUnsupportMsg = YES;
            break;
        }
    }
    
    if (hasUnsupportMsg) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:TUIKitLocalizableString(TUIKitRelayUnsupportForward) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(Confirm) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    // 转发视图发起
    __weak typeof(self) weakSelf = self;
    void(^chooseTarget)(BOOL) = ^(BOOL mergeForward) {
        UIViewController * vc = (UIViewController *)[TUICore callService:TUICore_TUIConversationService method:TUICore_TUIConversationService_GetConversationSelectControllerMethod param:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:(UIViewController *)vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        weakSelf.forwardConversationSelectVC = (UIViewController *)vc;
        weakSelf.forwardSelectUIMsgs = uiMsgs;
        weakSelf.isMergeForward = mergeForward;
        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    
    UIAlertController *tipsVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 逐条转发
    [tipsVc addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitRelayOneByOneForward) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (uiMsgs.count <= 30) {
            chooseTarget(NO);
            return;
        }
        // 转发消息过多，暂不支持逐条转发
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:TUIKitLocalizableString(TUIKitRelayOneByOnyOverLimit) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(Cancel) style:UIAlertActionStyleDefault handler:nil]];
        [vc addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitRelayCombineForwad) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            chooseTarget(YES);
        }]];
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }]];
    // 合并转发
    [tipsVc addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(TUIKitRelayCombineForwad) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        chooseTarget(YES);
    }]];
    [tipsVc addAction:[UIAlertAction actionWithTitle:TUIKitLocalizableString(Cancel) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:tipsVc animated:YES completion:nil];
}

// 转发消息到目标会话
- (void)forwardMessages:(NSArray<TUIMessageCellData *> *)uiMsgs
              toTargets:(NSArray<TUIChatConversationModel *> *)targets
                  merge:(BOOL)merge
{
    if (uiMsgs.count == 0 || targets.count == 0) {
        return ;
    }
    
    @weakify(self);
    [self.dataProvider getForwardMessageWithCellDatas:uiMsgs
                                            toTargets:targets
                                                Merge:merge
                                          ResultBlock:^(TUIChatConversationModel * _Nonnull targetConversation, NSArray<V2TIMMessage *> * _Nonnull msgs) {
        @strongify(self);
        
        TUIChatConversationModel *convCellData = targetConversation;
        NSTimeInterval timeInterval = convCellData.groupID.length?0.09:0.05;
        
        // 发送到当前聊天窗口
        if ([convCellData.conversationID isEqualToString:self.conversationData.conversationID]) {
            for (V2TIMMessage *imMsg in msgs) {
                TUIMessageCellData *uiMsg = nil;
                if (imMsg.elemType == V2TIM_ELEM_TYPE_CUSTOM) {
                    uiMsg = [self messageController:self.messageController onNewMessage:imMsg];
                }
                if (uiMsg == nil) {
                    uiMsg = [TUIMessageDataProvider getCellData:imMsg];
                }
                uiMsg.innerMessage = imMsg;
                // 转发同样先过门卫接口
                NSString *blockReason = nil;
                BOOL allowSend = [self guardCheckSynchronously:uiMsg reason:&blockReason];
                if (allowSend) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 下面的函数涉及到 UI 的刷新，要放在主线程操作
                        [self.messageController sendMessage:uiMsg];
                    });
                    // 此处做延时是因为需要保证批量逐条转发时，能够保证接收端的顺序一致
                    [NSThread sleepForTimeInterval:timeInterval];
                } else {
                    // 拦截：不发送，toast 展示原因文案
                    if (blockReason.length > 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD showInfoWithStatus:blockReason];
                        });
                    }
                }
            }
            return;
        }
        
        // 发送到其他聊天
        for (V2TIMMessage *message in msgs) {
            
            [TUIMessageDataProvider sendMessage:message
                                 toConversation:convCellData
                                 isSendPushInfo:YES
                               isOnlineUserOnly:NO
                                       priority:V2TIM_PRIORITY_NORMAL
                                       Progress:nil
                                      SuccBlock:^{
                // 发送到其他聊天的消息需要广播消息发送状态，方便进入对应聊天后刷新消息状态
                [NSNotificationCenter.defaultCenter postNotificationName:TUIKitNotification_onMessageStatusChanged object:message.msgID];
            } FailBlock:^(int code, NSString *desc) {
                [NSNotificationCenter.defaultCenter postNotificationName:TUIKitNotification_onMessageStatusChanged object:message.msgID];
            }];
            
            // 此处做延时是因为需要保证批量逐条转发时，能够保证接收端的顺序一致
            [NSThread sleepForTimeInterval:timeInterval];
        }
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@", desc);
        NSAssert(NO, desc);
    }];
}

- (NSString *)forwardTitleWithMyName:(NSString *)nameStr {
    return @"";
}

#pragma mark - Privete Methods
+ (void)createCachePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:TUIKit_Image_Path]){
        [fileManager createDirectoryAtPath:TUIKit_Image_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:TUIKit_Video_Path]){
        [fileManager createDirectoryAtPath:TUIKit_Video_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:TUIKit_Voice_Path]){
        [fileManager createDirectoryAtPath:TUIKit_Voice_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:TUIKit_File_Path]){
        [fileManager createDirectoryAtPath:TUIKit_File_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:TUIKit_DB_Path]){
        [fileManager createDirectoryAtPath:TUIKit_DB_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
