//
//  PopBottomCell.m
//  DongGuanHome
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import "PopBottomCell.h"

@implementation PopBottomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        self.lab_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _window_width, 55)];
        self.lab_title.font = SYS_Font(15);
        self.lab_title.textColor = RGB(125, 125, 125);
        self.lab_title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lab_title];
        
        UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(15, 55-0.3, _window_width-15*2, 0.3)];
        viewLine.backgroundColor = RGB(200, 200, 200);
        [self.contentView addSubview:viewLine];
    
    }
    return self;
}



@end
