//
//  MHManualOperationSubOneView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/21.
//

#import "MHManualOperationSubOneView.h"

@implementation MHManualOperationSubOneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        UIView *placeVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        placeVV.backgroundColor = RGBA(0, 0, 0, 0.2);
        [self addSubview:placeVV];
        
        UIScrollView *scrollVVVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        scrollVVVV.showsVerticalScrollIndicator = NO;
        scrollVVVV.showsHorizontalScrollIndicator = NO;
        scrollVVVV.bounces = NO;
        [self addSubview:scrollVVVV];
        
        scrollVVVV.contentSize = CGSizeMake(self.width, 460);
        
        UILabel *titLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        titLab.frame = CGRectMake(20, 0, self.width-40, 76);
        titLab.text = eLocalizedString(@"two_nams1");
        titLab.numberOfLines = 0;
        [scrollVVVV addSubview:titLab];
        
        for (int i=0; i<10; i++) {
            
            UIButton *two_imgV = [HistoryRecordModel createImgBtn];
            two_imgV.tag = 200+i;
            [two_imgV setBackgroundImage:[UIImage imageNamed:@"center_img16"] forState:UIControlStateNormal];
            [two_imgV setBackgroundImage:[UIImage imageNamed:@"center_img15"] forState:UIControlStateSelected];
            [two_imgV addTarget:self action:@selector(twoBtnMethodUITag:) forControlEvents:UIControlEventTouchUpInside];
            [scrollVVVV addSubview:two_imgV];
            
            UILabel *two_lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:16 textAlignment:NSTextAlignmentCenter];
            NSString *str_nam = [NSString stringWithFormat:@"two_nams%d", i+2];
            two_lab.text = eLocalizedString(str_nam);
            two_lab.tag = 300+i;
            [two_imgV addSubview:two_lab];
            
            switch (i) {
                case 0:
                {
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(scrollVVVV.mas_centerX).offset(10);
                        make.top.equalTo(titLab.mas_bottom);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 1:
                {
                
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(scrollVVVV.mas_centerX).offset(-10);
                        make.top.equalTo(titLab.mas_bottom).offset(20);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 2:
                {
          
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(scrollVVVV.mas_centerX).offset(0);
                        make.top.equalTo(titLab.mas_bottom).offset(50);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 3:
                {
           
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(scrollVVVV.mas_centerX).offset(-29);
                        make.top.equalTo(titLab.mas_bottom).offset(70);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 4:
                {
            
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(scrollVVVV.mas_centerX).offset(20);
                        make.top.equalTo(titLab.mas_bottom).offset(100);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 5:
                {
             
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(scrollVVVV.mas_centerX).offset(10);
                        make.top.equalTo(titLab.mas_bottom).offset(120);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 6:
                {
                
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(scrollVVVV.mas_centerX).offset(15);
                        make.top.equalTo(titLab.mas_bottom).offset(170);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 7:
                {
                   
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(scrollVVVV.mas_centerX).offset(-8);
                        make.top.equalTo(titLab.mas_bottom).offset(220);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 8:
                {
                
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(scrollVVVV.mas_centerX).offset(10);
                        make.top.equalTo(titLab.mas_bottom).offset(220);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                case 9:
                {
                   
                    [two_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(scrollVVVV.mas_centerX).offset(-40);
                        make.top.equalTo(titLab.mas_bottom).offset(270);
                        make.height.offset(36);
                        make.width.mas_greaterThanOrEqualTo(100);
                    }];
                    
                    [two_lab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(two_imgV.mas_left).offset(10);
                        make.right.equalTo(two_imgV.mas_right).offset(-10);
                        make.top.bottom.equalTo(two_imgV);
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    return self;
}

- (void)twoBtnMethodUITag:(UIButton *)btn
{
    btn.selected = YES;
    
    NSString *tag_str = @"";
    for (int i=0; i<10; i++) {
        
        UIButton *tag_btn = [self viewWithTag:200+i];
        UILabel *tag_Lab2 = [self viewWithTag:300+i];
        if (btn.tag == tag_btn.tag) {
            tag_str = @"";
            if (self.arrList.count > i) {
                NSDictionary *dicM = self.arrList[i];
                tag_str = minStr(dicM[@"name"]);
            }
            tag_Lab2.textColor = UIColor.whiteColor;
        }else {
            tag_btn.selected = NO;
            tag_Lab2.textColor = normalColors;
        }
//        if (tag_btn.selected == YES) {
//            tag_str = tag_str.length>0 ? [NSString stringWithFormat:@"%@,%d", tag_str, i+1]:minIntStr(i+1);
//        }
    }
    
    if (self.block_) {
        self.block_(tag_str);
    }
}

- (void)addMEthodArr
{
    for (int i=0; i<10; i++) {
        
        UIButton *tag_btn = [self viewWithTag:200+i];
        UILabel *tag_Lab = [self viewWithTag:300+i];
        if (self.arrList.count > i) {
            
            tag_btn.hidden = NO;
            NSDictionary *dicM = self.arrList[i];
            tag_Lab.text = minStr(dicM[@"name"]);
        }else {
            tag_btn.hidden = YES;
        }
    }
}

@end




@interface MHManualOperationSubOneView_lin ()

@property (nonatomic, strong) UIView *oneVVV;
@end

@implementation MHManualOperationSubOneView_lin

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.oneVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.oneVVV.backgroundColor = UIColor.clearColor;
        self.oneVVV.clipsToBounds = YES;
        [self addSubview:self.oneVVV];
        
        int ww_xx = self.width/14+1;
        for (int i=0; i<ww_xx; i++) {
            
            UIImageView *topIMgV = [HistoryRecordModel createImgImgView];
            topIMgV.frame = CGRectMake(i*14, self.height-16, 10, 10);
            topIMgV.image = [UIImage imageNamed:@"playBX_Imgs1"];
            topIMgV.tag = 1600+i;
            [self.oneVVV addSubview:topIMgV];
            
            UIImageView *topIMgV2 = [HistoryRecordModel createImgImgView];
            topIMgV2.frame = CGRectMake(i*14, self.height-12, 10, 4);
            topIMgV2.image = [UIImage imageNamed:@"playBX_Imgs2"];
            topIMgV2.tag = 2600+i;
            [self.oneVVV addSubview:topIMgV2];
        }
        
    }
    return self;
}

//if (messsageTimer == nil) {
//    messsageTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(uploadUIUIUIUMethod) userInfo:nil repeats:YES];
//}

- (void)addArrToMethodArr:(NSArray *)arr sel:(int)rowL
{
    int ww_xx = self.width/14+1;
    
    for (int i=0; i<ww_xx; i++) {
        
        UIImageView *topIMgV = [self.oneVVV viewWithTag:1600+i];
        UIImageView *topIMgV2 = [self.oneVVV viewWithTag:2600+i];
        if (arr.count>i) {
            
            NSString *mm = minStr(arr[rowL+i]);
            CGFloat hh_sub = self.height-16-[mm floatValue]*(self.height-16)/100;
            
            topIMgV.y = hh_sub;
            topIMgV2.y = hh_sub+12;
            topIMgV2.height = self.height-hh_sub-12;
        }
    }
    
    
//    int ww_xx = self.width/14;
//    if (arr.count-rowL >= ww_xx) {
//     
//        [self.oneVVV removeAllSubviews];
//        for (int i=0; i<ww_xx; i++) {
//            
//            NSString *mm = minStr(arr[rowL+i]);
//            CGFloat hh_sub = [mm floatValue]*(self.height-16)/100 + 16;
//            
//            UIImageView *smalImg = [HistoryRecordModel createImgImgView];
//            smalImg.frame = CGRectMake(i*14, self.height-hh_sub, 10, 10);
//            smalImg.image = [UIImage imageNamed:@""];
//            [self.oneVVV addSubview:smalImg];
//            
//            UIImageView *smalImg2 = [HistoryRecordModel createImgImgView];
//            smalImg2.frame = CGRectMake(i*14, self.height-[mm floatValue]+12, 10, hh_sub-12);
//            smalImg2.image = [UIImage imageNamed:@""];
//            [self.oneVVV addSubview:smalImg2];
//        }
//    }else {
//        if (rowL==0) {
//            [self.oneVVV removeAllSubviews];
//            for (int i=0; i<arr.count; i++) {
//                
//                NSString *mm = arr[i];
//                CGFloat hh_sub = [mm floatValue]*(self.height-16)/100 + 16;
//                
//                UIImageView *smalImg = [HistoryRecordModel createImgImgView];
//                smalImg.frame = CGRectMake(i*14, self.height-hh_sub, 10, 10);
//                smalImg.image = [UIImage imageNamed:@""];
//                [self.oneVVV addSubview:smalImg];
//                
//                UIImageView *smalImg2 = [HistoryRecordModel createImgImgView];
//                smalImg2.frame = CGRectMake(i*14, self.height-[mm floatValue]+12, 10, hh_sub-12);
//                smalImg2.image = [UIImage imageNamed:@""];
//                [self.oneVVV addSubview:smalImg2];
//            }
//        }
//    }
}

@end
