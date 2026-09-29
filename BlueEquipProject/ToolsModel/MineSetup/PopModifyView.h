//
//  PopModifyView.h
//  DongGuanHome
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 seeday. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockCallBackSwitch)(UISwitch *sender);
typedef void(^BlockTextToModify)(NSString *name,NSString *phone);

typedef void(^BlockCloseToModify)(NSString *name);

@interface PopModifyView : UIView
{
    BOOL _isAddFamily;
    BOOL _isSingleCommit;
    BOOL _isShowPower;
    
    UIButton *closeBnt;
}
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *lab_title;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSString *titleStringPlaceHoder;
@property (nonatomic,strong) NSString *titleStringSureAction;
@property (nonatomic,strong) UITextField *textfield;
@property (nonatomic,strong) UITextField *textfield_phone;



@property (nonatomic,strong) UILabel *lab_name;
@property (nonatomic,strong) UILabel *lab_phone;
@property (nonatomic,strong) UISwitch *switchView;

@property (nonatomic,strong) UIButton *bnt_ok;
@property (nonatomic,strong) BlockTextToModify blockTextToModify;
@property (nonatomic,strong) BlockCallBackSwitch blockCallBackSwitch;
@property (nonatomic, strong) BlockCloseToModify BlockCloseToMod;
@property (nonatomic,assign) BOOL isAddFamily;

@property (nonatomic,assign) BOOL isShowPower;

@property (nonatomic,assign) BOOL isSingleCommit;

@property (nonatomic,assign) BOOL isSecureTextF; 

@property (nonatomic,strong) NSDictionary *is_sendValues;

-(void)setValueWithPower:(BOOL) isOn;

-(void)show;

-(void)removiewThealL;

@end
