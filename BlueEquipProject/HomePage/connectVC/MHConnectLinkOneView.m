//
//  MHConnectLinkOneView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/4.
//

#import "MHConnectLinkOneView.h"

@implementation MHConnectLinkOneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        NSArray *namAr = @[@"center_all5", @"center_all6", @"center_all7", @"center_all8", @"center_all9", @"center_all10"];
        NSArray *imgAr = @[@"center_img4", @"center_img5", @"center_img6", @"center_img7", @"center_img8", @"center_img9"];
        for (int i=0; i<namAr.count; i++) {
            
            UIButton *btnsAA = [HistoryRecordModel createImgBtn];
            [btnsAA setBackgroundImage:[UIImage imageNamed:imgAr[i]] forState:UIControlStateNormal];
            btnsAA.tag = 1500+i;
            [btnsAA addTarget:self action:@selector(btnsNameMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnsAA];
            
            UILabel *oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
            oneLab.text = eLocalizedString(namAr[i]);
            
            [btnsAA addSubview:oneLab];
            
            UILabel *oneLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:10 textAlignment:NSTextAlignmentCenter];
            oneLab2.text = eLocalizedString(@"center_all4");
            [btnsAA addSubview:oneLab2];
            
            switch (i) {
                case 0:
                {
                    btnsAA.frame = CGRectMake(12, 0, (self.width-32)/2, 92);
                    oneLab.font = SYS_Font(20);
                    oneLab.frame = CGRectMake((self.width-32)/2-100, 26, 100, 26);
                    oneLab2.frame = CGRectMake((self.width-32)/2-100, 54, 100, 14);
                }
                    break;
                case 1:
                {
                    btnsAA.frame = CGRectMake(12+8+(self.width-32)/2, 0, (self.width-32)/2, 92);
                    oneLab.font = SYS_Font(20);
                    oneLab.frame = CGRectMake((self.width-32)/2-100, 26, 100, 26);
                    oneLab2.frame = CGRectMake((self.width-32)/2-100, 54, 100, 14);
                }
                    break;
                    
                default:
                {
                    CGFloat w_wh = (self.width-16)/4;
                    btnsAA.frame = CGRectMake(12+w_wh*(i-2), 101, w_wh-8, 85);
                    oneLab2.font = SYS_Font(6);
                    oneLab.frame = CGRectMake(0, 46, w_wh-8, 20);
                    oneLab2.frame = CGRectMake(0, 66, w_wh-8, 14);
                }
                    break;
            }
        }
    }
    return self;
}

- (void)btnsNameMethod:(UIButton *)btn
{
    if(self.block_) {
        self.block_(btn.tag-1500);
    }
}

@end
