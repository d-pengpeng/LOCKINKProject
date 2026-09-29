//
//  TUCustomGiftCellData.m
//  DragonTeethLive
//
//  Created by Edwin on 2021/11/25.
//

#import "TUCustomGiftCellData.h"
#import "TUIFaceView.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"

#ifndef CGFLOAT_CEIL
#ifdef CGFLOAT_IS_DOUBLE
#define CGFLOAT_CEIL(value) ceil(value)
#else
#define CGFLOAT_CEIL(value) ceilf(value)
#endif
#endif

@interface TUCustomGiftCellData()
@property CGSize textSize;
@property CGPoint textOrigin;

@end

@implementation TUCustomGiftCellData
- (instancetype)initWithDirectionTwo:(TMsgDirection)direction
{
    self = [super initWithDirectionTwo:direction];
    if (self) {
        if (direction == MsgDirectionIncoming) {
            _textColor = [[self class] incommingTextColor];
            _textFont = [[self class] incommingTextFont];
            self.cellLayout = [TUIMessageCellLayout incommingTextMessageLayout];
        } else {
            _textColor = [[self class] outgoingTextColor];
            _textFont = [[self class] outgoingTextFont];
            self.cellLayout = [TUIMessageCellLayout incommingTextMessageLayout];
        }
        self.reuseId = TCustomGiftCell_ReuseId;
    }
    return self;
}

- (CGSize)contentSize
{
    
    CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake(TTextMessageCell_Text_Width_Maxtwo, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGSize size = CGSizeMake(CGFLOAT_CEIL(rect.size.width), CGFLOAT_CEIL(rect.size.height));
    self.textSize = size;
    self.textOrigin = CGPointMake(self.cellLayout.messageInsets.left, self.cellLayout.messageInsets.top);
    
    size.height += self.cellLayout.messageInsets.top+self.cellLayout.messageInsets.bottom;
    size.width += self.cellLayout.messageInsets.left+self.cellLayout.messageInsets.right;

    return size;
}

- (NSAttributedString *)attributedString
{
    if (!_attributedString) {
        
        _attributedString = [self formatMessageString:_content];
    }
    return _attributedString;
}

- (NSAttributedString *)formatMessageString:(NSString *)textlll
{
    UIImageView *guard_icon = [UIImageView new];
    UIImageView *expL_icon = [UIImageView new];
    if ([self.is_guard intValue] == 100) {
        
    }else {
        
        if (![self.is_room boolValue]) {
            if ([self.is_guard boolValue]) {
                
                [guard_icon sd_setImageWithURL:[NSURL URLWithString:self.guard_icon]];
            }
            [expL_icon sd_setImageWithURL:[NSURL URLWithString:self.exp_icon]];
        }
    }

    NSString *nameLLLL = [NSString stringWithFormat:@" %@ ", self.name];
    if (self.name.length > 0) {
        nameLLLL = [NSString stringWithFormat:@" %@: ", self.name];
    }
    NSString *text = [NSString stringWithFormat:@"%@%@", nameLLLL, textlll];
    
    //先判断text是否存在
    if (text == nil || text.length == 0) {
        NSLog(@"TTextMessageCell formatMessageString failed , current text is nil");
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    if([TUIConfig defaultConfig].faceGroups.count == 0){
        [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];
        return attributeString;
    }
    if (self.textColor) {
        [attributeString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, attributeString.length)];
    }else {
        [attributeString addAttribute:NSForegroundColorAttributeName value:GrayTextColor range:NSMakeRange(0, attributeString.length)];
    }

    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情

    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
        return attributeString;
    }

    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];

    TUIFaceGroup *group = [TUIConfig defaultConfig].faceGroups[0];

    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];

        for (TUIFaceCellData *face in group.faces) {
            if ([face.name isEqualToString:subStr]) {
                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [[TUIImageCache sharedInstance] getFaceFromCache:face.path];
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -(self.textFont.lineHeight-self.textFont.pointSize)/2, self.textFont.pointSize, self.textFont.pointSize);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                break;
            }
        }
    }

    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }

    if ([self.is_guard intValue] == 100) {
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(0, nameLLLL.length)];
    }else {
        if ([self.is_room boolValue]) {
            
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            attach.image = [UIImage imageNamed:@"hostIconSmall"];
            attach.bounds = CGRectMake(0, -2, 32, 14);
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            //将图片插入到合适的位置
            [attributeString insertAttributedString:attachString atIndex:0];
            
            [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(1, nameLLLL.length)];
        }else {
            if (expL_icon.image != nil) {
                
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                attach.image = expL_icon.image;
                attach.bounds = CGRectMake(0, -2, 32, 14);
                NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                //将图片插入到合适的位置
                [attributeString insertAttributedString:attachString atIndex:0];
                
                if ([self.is_guard boolValue]) {
                    if (guard_icon.image != nil) {
                        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                        attach.image = guard_icon.image;
                        attach.bounds = CGRectMake(0, -3, 20, 16);
                        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                        //将图片插入到合适的位置
                        [attributeString insertAttributedString:attachString atIndex:0];
                        [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(2, nameLLLL.length)];
                    }else {
                        
                        NSData *guard_imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.guard_icon]];
                        
                        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                        attach.image = [UIImage imageWithData:guard_imgdata];
                        attach.bounds = CGRectMake(0, -3, 20, 16);
                        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                        //将图片插入到合适的位置
                        [attributeString insertAttributedString:attachString atIndex:0];
                        
                        [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(2, nameLLLL.length)];
                    }
                }else {
                    [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(1, nameLLLL.length)];
                }
            }else {
                
                if ((self.exp_icon.length > 0)&&![self.exp_icon isEqualToString:@"null"]) {
                    
                    NSData *exp_imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.exp_icon]];
                    
                    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                    attach.image = [UIImage imageWithData:exp_imgdata];
                    attach.bounds = CGRectMake(0, -2, 32, 14);
                    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                    //将图片插入到合适的位置
                    [attributeString insertAttributedString:attachString atIndex:0];
                    
                    if ([self.is_guard boolValue]) {
                        if (guard_icon.image != nil) {
                            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                            attach.image = guard_icon.image;
                            attach.bounds = CGRectMake(0, -3, 20, 16);
                            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                            //将图片插入到合适的位置
                            [attributeString insertAttributedString:attachString atIndex:0];
                            [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(2, nameLLLL.length)];
                        }else {
                            
                            NSData *guard_imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.guard_icon]];
                            
                            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                            attach.image = [UIImage imageWithData:guard_imgdata];
                            attach.bounds = CGRectMake(0, -3, 20, 16);
                            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                            //将图片插入到合适的位置
                            [attributeString insertAttributedString:attachString atIndex:0];
                            
                            [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(2, nameLLLL.length)];
                        }
                    }else {
                        [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(1, nameLLLL.length)];
                    }
                }else {
                    
                    if ([self.is_guard boolValue]) {
                        if (guard_icon.image != nil) {
                            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                            attach.image = guard_icon.image;
                            attach.bounds = CGRectMake(0, -3, 20, 16);
                            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                            //将图片插入到合适的位置
                            [attributeString insertAttributedString:attachString atIndex:0];
                            [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(1, nameLLLL.length)];
                        }else {
                            
                            NSData *guard_imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.guard_icon]];
                            
                            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                            attach.image = [UIImage imageWithData:guard_imgdata];
                            attach.bounds = CGRectMake(0, -3, 20, 16);
                            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
                            //将图片插入到合适的位置
                            [attributeString insertAttributedString:attachString atIndex:0];
                            
                            [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(1, nameLLLL.length)];
                        }
                    }else {
                        [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(0, nameLLLL.length)];
                    }
                }
            }
        }
    }
    [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];
    
    return attributeString;
}

static UIColor *sOutgoingTextColor;

+ (UIColor *)outgoingTextColor
{
    if (!sOutgoingTextColor) {
        sOutgoingTextColor = [UIColor d_colorWithColorLight:TText_Color dark:TText_Color];//[UIColor d_colorWithColorLight:TText_Color dark:TText_OutMessage_Color_Dark];
    }
    return sOutgoingTextColor;
}

+ (void)setOutgoingTextColor:(UIColor *)outgoingTextColor
{
    sOutgoingTextColor = outgoingTextColor;
}

static UIFont *sOutgoingTextFont;

+ (UIFont *)outgoingTextFont
{
    if (!sOutgoingTextFont) {
        sOutgoingTextFont = [UIFont systemFontOfSize:14];
    }
    return sOutgoingTextFont;
}

+ (void)setOutgoingTextFont:(UIFont *)outgoingTextFont
{
    sOutgoingTextFont = outgoingTextFont;
}

static UIColor *sIncommingTextColor;

+ (UIColor *)incommingTextColor
{
    if (!sIncommingTextColor) {
        sIncommingTextColor = [UIColor d_colorWithColorLight:TText_Color dark:TText_Color];//[UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark];
    }
    return sIncommingTextColor;
}

+ (void)setIncommingTextColor:(UIColor *)incommingTextColor
{
    sIncommingTextColor = incommingTextColor;
}

static UIFont *sIncommingTextFont;

+ (UIFont *)incommingTextFont
{
    if (!sIncommingTextFont) {
        sIncommingTextFont = [UIFont systemFontOfSize:14];
    }
    return sIncommingTextFont;
}

+ (void)setIncommingTextFont:(UIFont *)incommingTextFont
{
    sIncommingTextFont = incommingTextFont;
}

@end
