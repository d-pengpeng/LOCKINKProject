//
//  TUCustomRedbagCellCell.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/18.
//

#import "TUCustomRedbagCellCell.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"

@implementation TUCustomRedbagCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.container.backgroundColor = UIColor.clearColor;
        
        _thumb = [[UIImageView alloc] init];
        _thumb.layer.cornerRadius = 5.0;
        [_thumb.layer setMasksToBounds:YES];
        _thumb.contentMode = UIViewContentModeScaleAspectFill;
        _thumb.backgroundColor = [UIColor clearColor];
        [self.container addSubview:_thumb];
        _thumb.mm_fill();
        _thumb.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        _thumb2 = [[UIImageView alloc] init];
        _thumb2.layer.cornerRadius = 5.0;
        [_thumb2.layer setMasksToBounds:YES];
        _thumb2.contentMode = UIViewContentModeScaleAspectFill;
        _thumb2.backgroundColor = [UIColor whiteColor];
        [self.container addSubview:_thumb2];
        
        _content = [[UILabel alloc] init];
        _content.textColor = RGB(255, 239, 201);
        _content.font = [UIFont systemFontOfSize:12];
        [self.container addSubview:_content];
        
        _subContent = [[UILabel alloc] init];
        _subContent.textColor = RGB(255, 239, 201);
        _subContent.font = [UIFont systemFontOfSize:12];
        [self.container addSubview:_subContent];
        
        _msgLab = [[UILabel alloc] init];
        _msgLab.textColor = UIColor.whiteColor;
        _msgLab.font = [UIFont systemFontOfSize:16];
        [self.container addSubview:_msgLab];
        
        _linVVVV = [[UIView alloc] init];
        _linVVVV.backgroundColor = RGB(253, 171, 87);
        [self.container addSubview:_linVVVV];
        
        _spaceVVV = [[UIView alloc] init];
        _spaceVVV.backgroundColor = RGBA(255, 255, 255, 0.5);
        [self.container addSubview:_spaceVVV];
    }
    return self;
}

- (void)fillWithData:(TRedbagMessageCellData *)data;
{
    //set data
    [super fillWithData:data];
    
    self.textData = data;
    self.content.text = data.content;

    self.content.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
    
    CGSize sizFF = [data contentSize];
    _content.frame = CGRectMake(10, sizFF.height-23, sizFF.width-20, 23);
    
    _thumb2.frame = CGRectMake(14, 10, 32, 40);
    
    _thumb2.image = [UIImage imageNamed:@"redbag_imgs2"];
    
    _linVVVV.frame = CGRectMake(14, 56, sizFF.width-30, 1);
    
    _subContent.text = @"";
    if(data.direction == MsgDirectionIncoming) {
//        _msgLab.frame = CGRectMake(56, 10, sizFF.width-70, 22);
//        _subContent.frame = CGRectMake(56, 32, sizFF.width-70, 17);
//        _subContent.text = eLocalizedString(@"chat_al31");
        _msgLab.frame = CGRectMake(56, 10, sizFF.width-70, 40);
        _thumb.image = [UIImage imageNamed:@"redbag_imgs1_1"];
    }else {
        _msgLab.frame = CGRectMake(56, 10, sizFF.width-70, 40);
        _thumb.image = [UIImage imageNamed:@"redbag_imgs1"];
    }
    
    _msgLab.text = data.content;
    
    _content.text = eLocalizedString(@"chat_all1");
    
//    _spaceVVV.frame = CGRectMake(0, 0, sizFF.width, sizFF.height);
   
}

@end
