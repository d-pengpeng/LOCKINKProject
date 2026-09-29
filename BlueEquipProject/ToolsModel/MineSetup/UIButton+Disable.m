//
//  UIButton+Disable.m
//  GatherJobs
//
//  Created by YangLin on 15/9/22.
//  Copyright (c) 2015年 JuPin. All rights reserved.
//

#import "UIButton+Disable.h"
#import "UIImage+Color.h"
#import "UIColor+Transform.h"

@implementation UIButton (Disable)


- (void)disable
{
    [self setEnabled:NO];
    [self setBackgroundImage:[UIImage createImageWithColor:[UIColor getColor:@"e0e0e0"]] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor getColor:@"b8b8b8"] forState:UIControlStateDisabled];
}
- (void)enable
{
    [self setEnabled:YES];
}
@end
