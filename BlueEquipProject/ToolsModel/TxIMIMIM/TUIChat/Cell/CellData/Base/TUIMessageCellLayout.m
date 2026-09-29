//
//  TUIMessageCellLayout.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/21.
//

#import "TUIMessageCellLayout.h"
#import "TUIDefine.h"

@implementation TUIMessageCellLayout

- (instancetype)init:(BOOL)isIncomming c2cChat:(BOOL)isChat
{
    self = [super init];
    if (self) {
        if (isChat) {
            self.avatarSize = CGSizeMake(40, 40);
            if (isIncomming) {
                self.avatarInsets = (UIEdgeInsets){
                    .left = 8,
                    .top = 3,
                    .bottom = 1,
                };
                self.messageInsets = (UIEdgeInsets){
                    .top = 3,
                    .bottom = 1,
                    .left = 8,
                    
                };
            } else {
                self.avatarInsets = (UIEdgeInsets){
                    .right = 8,
                    .top = 3,
                    .bottom = 1,
                };
                self.messageInsets = (UIEdgeInsets){
                    .top = 3,
                    .bottom = 1,
                    .right = 8,
                };
            }
        }else {
            self.avatarSize = CGSizeMake(10, 10);
            if (isIncomming) {
                self.avatarInsets = (UIEdgeInsets){
                    .left = 8,
                    .top = 3,
                    .bottom = 1,
                };
                self.messageInsets = (UIEdgeInsets){
                    .top = 3,
                    .bottom = 1,
                    .left = 8,
                };
            } else {
                self.avatarInsets = (UIEdgeInsets){
                    .right = 8,
                    .top = 3,
                    .bottom = 1,
                    .left =8,
                };
                self.messageInsets = (UIEdgeInsets){
                    .top = 3,
                    .bottom = 1,
                    .right = 8,
                    .left = 8,
                };
            }
        }
        
    }
    return self;
}

static TUIMessageCellLayout *sIncommingMessageLayout;
static TUIMessageCellLayout *sIncommingMessageLayoutTwo;

+ (TUIMessageCellLayout *)incommingMessageLayout
{
    if (!sIncommingMessageLayout) {
        sIncommingMessageLayout = [[TUIMessageCellLayout alloc] init:YES c2cChat:YES];
    }
    return sIncommingMessageLayout;
}

static TUIMessageCellLayout *sOutgoingMessageLayout;

+ (TUIMessageCellLayout *)outgoingMessageLayout
{
    if (!sOutgoingMessageLayout) {
        sOutgoingMessageLayout = [[TUIMessageCellLayout alloc] init:NO  c2cChat:YES];
    }
    return sOutgoingMessageLayout;
}

+ (TUIMessageCellLayout *)incommingMessageLayoutTwo
{
    if (!sIncommingMessageLayoutTwo) {
        sIncommingMessageLayoutTwo = [[TUIMessageCellLayout alloc] init:YES c2cChat:NO];
    }
    return sIncommingMessageLayoutTwo;
}

+ (TUIMessageCellLayout *)outgoingMessageLayoutTwo
{
    if (!sOutgoingMessageLayout) {
        sOutgoingMessageLayout = [[TUIMessageCellLayout alloc] init:NO  c2cChat:NO];
    }
    return sOutgoingMessageLayout;
}

#pragma Text CellLayout

static TUIMessageCellLayout *sIncommingTextMessageLayout;
static TUIMessageCellLayout *sIncommingTextMessageLayout222;

+ (TUIMessageCellLayout *)incommingTextMessageLayout
{
    if (!sIncommingTextMessageLayout) {
        sIncommingTextMessageLayout = [[TUIMessageCellLayout alloc] init:YES c2cChat:NO];
//        sIncommingTextMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 14, .bottom = 16, .left = 16, .right = 16};
        sIncommingTextMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 1, .bottom = 1, .left = 16, .right = 16};
    }
    return sIncommingTextMessageLayout;
}

static TUIMessageCellLayout *sOutgingTextMessageLayout;

+ (TUIMessageCellLayout *)outgoingTextMessageLayout
{
    if (!sOutgingTextMessageLayout) {
        sOutgingTextMessageLayout = [[TUIMessageCellLayout alloc] init:NO c2cChat:NO];
        sOutgingTextMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 1, .bottom = 1, .left = 16, .right = 16};
    }
    return sOutgingTextMessageLayout;
}

+ (TUIMessageCellLayout *)incommingTextMessageLayout222
{
    if (!sIncommingTextMessageLayout222) {
        sIncommingTextMessageLayout222 = [[TUIMessageCellLayout alloc] init:YES c2cChat:YES];
        sIncommingTextMessageLayout222.bubbleInsets = (UIEdgeInsets){.top = 14, .bottom = 16, .left = 16, .right = 16};
    }
    return sIncommingTextMessageLayout222;
}

/**
 *  获取文本消息（发送）布局
 */
+ (TUIMessageCellLayout *)outgoingTextMessageLayout222
{
    if (!sOutgingTextMessageLayout) {
        sOutgingTextMessageLayout = [[TUIMessageCellLayout alloc] init:NO c2cChat:YES];
        sOutgingTextMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 14, .bottom = 16, .left = 16, .right = 16};
    }
    return sOutgingTextMessageLayout;
}


#pragma Voice CellLayout

static TUIMessageCellLayout *sIncommingVoiceMessageLayout;

+ (TUIMessageCellLayout *)incommingVoiceMessageLayout
{
    if (!sIncommingVoiceMessageLayout) {
        sIncommingVoiceMessageLayout = [[TUIMessageCellLayout alloc] init:YES c2cChat:YES];
        sIncommingVoiceMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 14, .bottom = 20, .left = 19, .right = 22};
//        sIncommingVoiceMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 1, .bottom = 1, .left = 19, .right = 22};
    }
    return sIncommingVoiceMessageLayout;
}

static TUIMessageCellLayout *sOutgingVoiceMessageLayout;

+ (TUIMessageCellLayout *)outgoingVoiceMessageLayout
{
    if (!sOutgingVoiceMessageLayout) {
        sOutgingVoiceMessageLayout = [[TUIMessageCellLayout alloc] init:NO c2cChat:YES];
        sOutgingVoiceMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 14, .bottom = 20, .left = 22, .right = 20};
//        sOutgingVoiceMessageLayout.bubbleInsets = (UIEdgeInsets){.top = 1, .bottom = 1, .left = 22, .right = 20};
    }
    return sOutgingVoiceMessageLayout;
}

#pragma System CellLayout

static TUIMessageCellLayout *sSystemMessageLayout;

+ (TUIMessageCellLayout *)systemMessageLayout
{
    if (!sSystemMessageLayout) {
        sSystemMessageLayout = [[TUIMessageCellLayout alloc] init:YES c2cChat:YES];
        sSystemMessageLayout.messageInsets = (UIEdgeInsets){.top = 5, .bottom = 5};
    }
    return sSystemMessageLayout;
}

@end
