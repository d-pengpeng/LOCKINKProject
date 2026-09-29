//
//  SGAlertMenu.m
//  SGActionView
//
//  Created by Sagi on 13-9-4.
//  Copyright (c) 2013年 AzureLab. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SGAlertMenu.h"

#define kMAX_ALERT_MESSAGE_HEIGHT   300

@interface SGAlertMenu ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSMutableArray *actionButtons;
@property (nonatomic, strong) SGMenuActionHandler actionHandle;

@property (nonatomic, assign) BOOL isColors;
@end

@implementation SGAlertMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = nil;
        _messageLabel = nil;
        _actionButtons = [NSMutableArray array];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)buttonTitles, ...
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    if (self) {
        NSMutableArray *actionButtonTitles = [NSMutableArray array];
        if (buttonTitles) {
            [actionButtonTitles addObject:buttonTitles];
            id eachObj;
            va_list argumentList;
            va_start(argumentList, buttonTitles);
            while ((eachObj = va_arg(argumentList, id))) {
                [actionButtonTitles addObject:eachObj];
            }
            va_end(argumentList);
        }
        if (actionButtonTitles.count > 2) {
            [actionButtonTitles removeObjectsInRange:NSMakeRange(2, actionButtonTitles.count)];
        }
        [self setupWithTitle:title message:message actionTitles:actionButtonTitles];
    }
    return self;
}

- (void)setupWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles;
{
    self.backgroundColor = BaseMenuBackgroundColor(self.style);
    
    if (title) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = BaseMenuTextColor(self.style);
        _titleLabel.text = title;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    if (message) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = BaseMenuTextColor(self.style);
        _messageLabel.numberOfLines = 0;
        _messageLabel.text = message;
        [self addSubview:_messageLabel];
    }
    for (int i=0; i<actionTitles.count; i++) {
        NSString *title = actionTitles[i];
        SGButton *actionButton = [SGButton buttonWithType:UIButtonTypeSystem];
        actionButton.tag = i;
        actionButton.clipsToBounds = YES;
        actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [actionButton setTitle:title forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        if (actionTitles.count == 2) {
            if (i==0) {
                [actionButton setTitleColor:normalColors forState:UIControlStateNormal];
                actionButton.layer.cornerRadius = 4;
                actionButton.layer.borderColor = normalColors.CGColor;
                actionButton.layer.borderWidth = 1;
            }else if (i==1){
                [actionButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                actionButton.layer.cornerRadius = 4;
                actionButton.backgroundColor = normalColors;
            }
        }else{
            if (i==0) {
               [actionButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [actionButton setBackgroundImage:[UIImage imageNamed:@"mine_setting_sure"] forState:0];
            }
        }

        [self addSubview:actionButton];
        [self.actionButtons addObject:actionButton];
    }
}

- (id)initAttributedWithTitle:(NSString *)title message:(NSAttributedString *)message buttonTitles:(NSString *)buttonTitles, ...
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    if (self) {
        NSMutableArray *actionButtonTitles = [NSMutableArray array];
        if (buttonTitles) {
            [actionButtonTitles addObject:buttonTitles];
            id eachObj;
            va_list argumentList;
            va_start(argumentList, buttonTitles);
            while ((eachObj = va_arg(argumentList, id))) {
                [actionButtonTitles addObject:eachObj];
            }
            va_end(argumentList);
        }
        if (actionButtonTitles.count > 2) {
            [actionButtonTitles removeObjectsInRange:NSMakeRange(2, actionButtonTitles.count)];
        }
        self.isColors = YES;
        [self setupAttributedWithTitle:title message:message actionTitles:actionButtonTitles];
    }
    return self;
}

- (void)setupAttributedWithTitle:(NSString *)title message:(NSAttributedString *)message actionTitles:(NSArray *)actionTitles;
{
    self.backgroundColor = BaseMenuBackgroundColor(self.style);
    
    if (title) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = BaseMenuTextColor(self.style);
        _titleLabel.text = title;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    if (message) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = BaseMenuTextColor(self.style);
        _messageLabel.numberOfLines = 0;
        _messageLabel.attributedText = message;
        [self addSubview:_messageLabel];
    }
    for (int i=0; i<actionTitles.count; i++) {
        NSString *title = actionTitles[i];
        SGButton *actionButton = [SGButton buttonWithType:UIButtonTypeSystem];
        actionButton.tag = i;
        actionButton.clipsToBounds = YES;
        actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [actionButton setTitle:title forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (actionTitles.count == 2) {
            if (i==0) {
                [actionButton setTitleColor:GrayTextColor forState:UIControlStateNormal];
                actionButton.layer.cornerRadius = 6;
                actionButton.layer.borderColor = normalColors.CGColor;
                actionButton.layer.borderWidth = 1;
            }else if (i==1){
//                [actionButton setTitleColor:RGB(135, 57, 14) forState:UIControlStateNormal];
                [actionButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                actionButton.layer.cornerRadius = 6;
                actionButton.backgroundColor = normalColors;
            }
        }else{
            if (i==0) {
               [actionButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [actionButton setBackgroundImage:[UIImage imageNamed:@"mine_setting_sure"] forState:0];
            }
        }

        [self addSubview:actionButton];
        [self.actionButtons addObject:actionButton];
    }
}

- (void)setStyle:(SGActionViewStyle)style{
    _style = style;
    
    self.backgroundColor = BaseMenuBackgroundColor(style);
    self.titleLabel.textColor = BaseMenuTextColor(style);
    if (self.isColors) {
        
    }else {
        self.messageLabel.textColor = BaseMenuTextColor(style);
    }
    
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[SGButton class]]) {
//            [(SGButton*)view setTitleColor:BaseMenuActionTextColor(style) forState:UIControlStateNormal];
//        }
//    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    float height = 0;
    if (self.isColors) {
        
        float title_top_margin = self.messageLabel.attributedText ? 46 : 15;
        float message_top_margin = 0;
        float message_bottom_margin = self.messageLabel.attributedText ? 28.5 : 0;
        
        height += title_top_margin;
        
        if (self.titleLabel) {
            CGSize t = CGSizeMake(self.bounds.size.width -10*2, 50);
            CGSize tFit = [self.titleLabel sizeThatFits:t];
            self.titleLabel.frame = (CGRect){CGPointMake(10, height), CGSizeMake(self.bounds.size.width-10*2, t.height<tFit.height?t.height:tFit.height)};
            height += self.titleLabel.bounds.size.height + self.titleLabel.frame.origin.y;
        }
        height += message_top_margin;
        if (self.messageLabel) {
            CGSize s = CGSizeMake(self.bounds.size.width -20*2, 200);
            CGSize sFit = [self.messageLabel sizeThatFits:s];
    //        self.messageLabel.frame = (CGRect){CGPointMake(20, height), s};
            self.messageLabel.frame = CGRectMake(20, height, self.bounds.size.width -20*2, s.height<sFit.height?s.height:sFit.height);
            height += s.height<sFit.height?s.height:sFit.height;
        }
        height += message_bottom_margin;
        float btn_y = height;
        UIImage *image = [UIImage imageNamed:@"mine_setting_cancel"];
        for (int i=0; i<self.actionButtons.count; i++) {
            UIButton *button = self.actionButtons[i];
            //i * self.bounds.size.width / 2
            button.frame = (CGRect){CGPointMake(44.5+i * (image.size.width+28), btn_y), CGSizeMake(image.size.width, image.size.height)};//self.bounds.size.width / self.actionButtons.count
            if (i == 0) {
                height += image.size.height+22;
            }
        }

        self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, height)};
    }else {
        float title_top_margin = self.messageLabel.text ? 46 : 15;
        float message_top_margin = 0;
        float message_bottom_margin = self.messageLabel.text ? 28.5 : 0;
        
        height += title_top_margin;
        
        if (self.titleLabel) {
            CGSize t = CGSizeMake(self.bounds.size.width -10*2, 50);
            CGSize tFit = [self.titleLabel sizeThatFits:t];
            self.titleLabel.frame = (CGRect){CGPointMake(10, height), CGSizeMake(self.bounds.size.width-10*2, t.height<tFit.height?t.height:tFit.height)};
            height += self.titleLabel.bounds.size.height + self.titleLabel.frame.origin.y;
        }
        height += message_top_margin;
        if (self.messageLabel) {
            CGSize s = CGSizeMake(self.bounds.size.width -20*2, 200);
            CGSize sFit = [self.messageLabel sizeThatFits:s];
    //        self.messageLabel.frame = (CGRect){CGPointMake(20, height), s};
            self.messageLabel.frame = CGRectMake(20, height, self.bounds.size.width -20*2, s.height<sFit.height?s.height:sFit.height);
            height += s.height<sFit.height?s.height:sFit.height;
        }
        height += message_bottom_margin;
        float btn_y = height;
        UIImage *image = [UIImage imageNamed:@"mine_setting_cancel"];
        if(self.actionButtons.count==1) {
            for (int i=0; i<self.actionButtons.count; i++) {
                UIButton *button = self.actionButtons[i];
                if(i==0) {
                    button.frame = (CGRect){CGPointMake(self.bounds.size.width/2-image.size.width/2, btn_y), CGSizeMake(image.size.width, image.size.height)};
                }
                if (i == 0) {
                    height += image.size.height+22;
                }
            }
        }else {
            for (int i=0; i<self.actionButtons.count; i++) {
                UIButton *button = self.actionButtons[i];
                if(i==0) {
                    button.frame = (CGRect){CGPointMake(self.bounds.size.width/2-image.size.width-14, btn_y), CGSizeMake(image.size.width, image.size.height)};
                }else {
                    button.frame = (CGRect){CGPointMake(self.bounds.size.width/2+14, btn_y), CGSizeMake(image.size.width, image.size.height)};
                }
                if (i == 0) {
                    height += image.size.height+22;
                }
            }
        }

        self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, height)};
    }
}

#pragma mark - 

- (void)triggerSelectedAction:(SGMenuActionHandler)actionHandle;
{
    self.actionHandle = actionHandle;
}

- (void)tapAction:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]] && self.actionHandle) {
        NSInteger tag = [(UIButton*)sender tag];
        double delayInSeconds = 0.15;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.actionHandle(tag);
        });
    }
}

@end
