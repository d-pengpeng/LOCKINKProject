//
//  MHPrivacyProtectionVView.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/12/4.
//

#import "MHPrivacyProtectionVView.h"
#import "MHAboutSubController.h"

@interface MHPrivacyProtectionVView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@end
@implementation MHPrivacyProtectionVView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UIView *deletVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        deletVV.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self addSubview:deletVV];
        
        CGFloat x_lef = (self.width-300)/2;
        CGFloat y_lef = (self.height-400)/2;
        UIView *oneVVV = [HistoryRecordModel createViewUIUI];
        oneVVV.frame = CGRectMake(x_lef, y_lef, 300, 400);
        [self addSubview:oneVVV];
        
        UILabel *titLL = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:18 textAlignment:NSTextAlignmentCenter];
        titLL.frame = CGRectMake(0, 10, oneVVV.width, 60);
        titLL.text = eLocalizedString(@"login_privary1");
        [oneVVV addSubview:titLL];
        
        NSString *urlsTTTT = eLocalizedString(@"login_privary2");
//        NSLog(@"%lu ---  %lu ---- %lu", eLocalizedString(@"login_privary2").length, eLocalizedString(@"login_privary3").length, eLocalizedString(@"login_privary4").length);
//        106 ---  74 ---- 6    383 ---  267 ---- 16
        NSInteger one_num2 = eLocalizedString(@"login_privary3").length;
        NSInteger one_num3 = eLocalizedString(@"login_privary4").length;
        NSInteger one_num4 = eLocalizedString(@"login_privary5").length;
        NSInteger one_num5 = eLocalizedString(@"login_privary4_5").length;
        
        self.textView = [[UITextView alloc] init];
        self.textView.frame = CGRectMake(30, 70, 300-60, oneVVV.height-70-110);
        self.textView.editable = false;
//        self.textView.scrollEnabled = false;
        self.textView.backgroundColor = UIColor.whiteColor;
        self.textView.delegate = self;
        [oneVVV addSubview:self.textView];
        //设置段落样式
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = 4.0;//段内行间距
        paragraphStyle.paragraphSpacing = 8.0;//段落间距
        paragraphStyle.firstLineHeadIndent = 20.0;//段首行缩进
        self.textView.linkTextAttributes = @{NSForegroundColorAttributeName:normalColors};
        NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] initWithString:urlsTTTT];
        [mutAttString addAttributes:@{
            NSForegroundColorAttributeName:GrayTextColor,
            NSParagraphStyleAttributeName:paragraphStyle,
            NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, mutAttString.length)];
        [mutAttString addAttributes:@{
            NSLinkAttributeName:eLocalizedString(@"login_privary3"),
//                                      NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
//                                      NSUnderlineColorAttributeName:[UIColor greenColor],
                                      } range:NSMakeRange(one_num2, one_num3)];

        [mutAttString addAttributes:@{
                                      NSLinkAttributeName:eLocalizedString(@"login_privary4"),
                                      } range:NSMakeRange(one_num2+one_num3+one_num5, one_num4)];
        self.textView.attributedText = mutAttString;
        
        
        UIButton *sureBBB = [HistoryRecordModel createImgBtn];
        sureBBB.frame = CGRectMake(30, oneVVV.height-90, oneVVV.width-60, 40);
        sureBBB.backgroundColor = normalColors;
        sureBBB.layer.cornerRadius = 8;
        [sureBBB setTitle:eLocalizedString(@"login_privary6") forState:UIControlStateNormal];
        [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sureBBB.titleLabel.font = SYS_Font(17);
        [sureBBB addTarget:self action:@selector(sureBBtmehtod) forControlEvents:UIControlEventTouchUpInside];
        [oneVVV addSubview:sureBBB];
        
        UIButton *sureBBB2 = [HistoryRecordModel createImgBtn];
        sureBBB2.frame = CGRectMake(30, oneVVV.height-45, oneVVV.width-60, 40);
        [sureBBB2 setTitle:eLocalizedString(@"login_privary7") forState:UIControlStateNormal];
        [sureBBB2 setTitleColor:GrayTextColor forState:UIControlStateNormal];
        sureBBB2.titleLabel.font = SYS_Font(15);
        [sureBBB2 addTarget:self action:@selector(sureBBtmehtodTTTwo) forControlEvents:UIControlEventTouchUpInside];
        [oneVVV addSubview:sureBBB2];
        
    }
    return self;
}

- (void)sureBBtmehtod
{
    if(self.block_) {
        self.block_(1);
    }
}

- (void)sureBBtmehtodTTTwo
{
    exit(0);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSInteger one_num2 = eLocalizedString(@"login_privary3").length;
    
    UIViewController *selfVC = [[FloatingWindowModel shareInstance] getCurrentViewController];
    if(characterRange.location == one_num2) {
        if(self.block_) {
            self.block_(2);
        }
        MHAboutSubController *vc = [[MHAboutSubController alloc] init];
        vc.typeNN = 0;
        vc.guide_id = [LYUserDefault userDefault].privacyPolicyUrl;
        [selfVC.navigationController pushViewController:vc animated:YES];
        
    }else {
        if(self.block_) {
            self.block_(3);
        }
        MHAboutSubController *vc = [[MHAboutSubController alloc] init];
        vc.typeNN = 1;
        vc.guide_id = [LYUserDefault userDefault].userAgreementUrl;
        [selfVC.navigationController pushViewController:vc animated:YES];
    }
    return NO;
}

@end
