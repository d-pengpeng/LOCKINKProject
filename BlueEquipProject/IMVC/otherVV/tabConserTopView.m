//
//  tabConserTopView.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/16.
//

#import "tabConserTopView.h"
#import "myContactListController.h"

@implementation tabConserTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = GroupBackColor;
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.frame = CGRectMake(0, 8, _window_width, 80);
        oneVV.layer.cornerRadius = 0;
        [self addSubview:oneVV];
        
        CGFloat w_w = _window_width/4;
        NSArray *namesArr = @[@"my_focus_focus", @"my_focus_focusFans", @"noNotice_all1", @"contact_ttt"];
        for (int i=0; i<namesArr.count; i++) {
            
            UIView *fouVV = [HistoryRecordModel createViewUIUI];
            fouVV.frame = CGRectMake(w_w*i, 10, w_w, 70);
            [oneVV addSubview:fouVV];
            
            UIImageView *imgV = [HistoryRecordModel createImgImgView];
            imgV.frame = CGRectMake(w_w/2-20, 0, 40, 40);
            imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d", @"message_imgs", i+1]];
            [fouVV addSubview:imgV];
            
            UILabel *allLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
            allLab.frame = CGRectMake(0, 40, w_w, 30);
            allLab.text = eLocalizedString(namesArr[i]);
            [fouVV addSubview:allLab];
            
            UIButton *alBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w_w, 70)];
            alBtn.tag = 3300+i;
            [alBtn addTarget:self action:@selector(alBtnMethodsMethod:) forControlEvents:UIControlEventTouchUpInside];
            [fouVV addSubview:alBtn];
        }
    }
    return self;
}

- (void)alBtnMethodsMethod:(UIButton *)btn
{
    if ([TOKEN length]>1) {
        UIViewController *vcM = [[FloatingWindowModel shareInstance] getCurrentViewController];
        switch (btn.tag) {
//            case 3300:
//            {
//                myFocusManagerController *vc = [[myFocusManagerController alloc] init];
//                [vcM.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 3301:
//            {
//                myFocusManagerController *vc = [[myFocusManagerController alloc] init];
//                vc.isFensiBoo = YES;
//                [vcM.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 3302:
//            {
//                myMessageListController *vc = [[myMessageListController alloc] init];
//                [vcM.navigationController pushViewController:vc animated:YES];
//            }
//                break;
            case 3303:
            {
                myContactListController *vc = [[myContactListController alloc] init];
                [vcM.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
