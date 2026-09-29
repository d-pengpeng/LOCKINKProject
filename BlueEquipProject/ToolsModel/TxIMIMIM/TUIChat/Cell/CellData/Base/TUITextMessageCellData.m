//
//  TUITextMessageCellData.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/21.
//

#import "TUITextMessageCellData.h"
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

@interface TUITextMessageCellData()
@property CGSize textSize;
@property CGPoint textOrigin;

@end

@implementation TUITextMessageCellData

- (instancetype)initWithDirection:(TMsgDirection)direction
{
    self = [super initWithDirection:direction];
    if (self) {
        if (direction == MsgDirectionIncoming) {
            _textColor = [[self class] incommingTextColor];
            _textFont = [[self class] incommingTextFont];
            self.cellLayout = [TUIMessageCellLayout incommingTextMessageLayout222]; //c2c样式
        } else {
            _textColor = [[self class] outgoingTextColor];
            _textFont = [[self class] outgoingTextFont];
            self.cellLayout = [TUIMessageCellLayout outgoingTextMessageLayout222];//c2c样式
        }
        self.reuseId = TTextMessageCell_ReuseId;//标记
    }
    return self;
}

- (CGSize)contentSize
{
    CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake(TTextMessageCell_Text_Width_Max, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGSize size = CGSizeMake(CGFLOAT_CEIL(rect.size.width), CGFLOAT_CEIL(rect.size.height));
    self.textSize = size;
    self.textOrigin = CGPointMake(self.cellLayout.bubbleInsets.left, self.cellLayout.bubbleInsets.top+self.bubbleTop);
    size.height += self.cellLayout.bubbleInsets.top+self.cellLayout.bubbleInsets.bottom;
    size.width += self.cellLayout.bubbleInsets.left+self.cellLayout.bubbleInsets.right;

    if (self.direction == MsgDirectionIncoming) {
        size.height = MAX(size.height, [TUIBubbleMessageCellData incommingBubble].size.height);
    } else {
        size.height = MAX(size.height, [TUIBubbleMessageCellData outgoingBubble].size.height);
    }

    
//    CGFloat nick_l = [HistoryRecordModel jiSuanWith:self.name font:14];
//    NSMutableAttributedString *aString;
//    NSString *nameLLLL = [NSString stringWithFormat:@"%@: ", self.name];
//    aString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",self.name,self.attributedString]];
//
//    [aString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(0, nameLLLL.length)];
//    [aString addAttribute:NSForegroundColorAttributeName value:GrayTextColor range:NSMakeRange(nameLLLL.length, self.attributedString.length)];
//    self.attributedString = aString;
    
    
    
    
//    CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake(TTextMessageCell_Text_Width_Max, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//    CGSize size = CGSizeMake(CGFLOAT_CEIL(rect.size.width), CGFLOAT_CEIL(rect.size.height));
//    self.textSize = size;
//    self.textOrigin = CGPointMake(self.cellLayout.messageInsets.left, self.cellLayout.messageInsets.top);
//
//    size.height += self.cellLayout.messageInsets.top+self.cellLayout.messageInsets.bottom;
//    size.width += self.cellLayout.messageInsets.left+self.cellLayout.messageInsets.right;


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
    
    NSString *nameLLLL = @"";//[NSString stringWithFormat:@"%@: ", self.name];
    NSString *text = [NSString stringWithFormat:@"%@%@",nameLLLL,textlll];
    
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
//        [attributeString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, attributeString.length)];
        if (self.direction == MsgDirectionIncoming) {
            [attributeString addAttribute:NSForegroundColorAttributeName value:GrayTextColor range:NSMakeRange(0, attributeString.length)];
        }else {
            [attributeString addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, attributeString.length)];
        }
    }else {
        if (self.direction == MsgDirectionIncoming) {
            [attributeString addAttribute:NSForegroundColorAttributeName value:GrayTextColor range:NSMakeRange(0, attributeString.length)];
        }else {
            [attributeString addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(0, attributeString.length)];
        }
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


    [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];


    [attributeString addAttribute:NSForegroundColorAttributeName value:RGB(44, 156, 237)  range:NSMakeRange(0, nameLLLL.length)];
    return attributeString;
}

static UIColor *sOutgoingTextColor;

+ (UIColor *)outgoingTextColor
{
    if (!sOutgoingTextColor) {
        sOutgoingTextColor = TText_Color;//[UIColor d_colorWithColorLight:TText_Color dark:TText_OutMessage_Color_Dark];
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
        sOutgoingTextFont = [UIFont systemFontOfSize:16];
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
        sIncommingTextColor = TText_Color;//[UIColor d_colorWithColorLight:TText_Color dark:TText_Color_Dark];
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
        sIncommingTextFont = [UIFont systemFontOfSize:16];
    }
    return sIncommingTextFont;
}

+ (void)setIncommingTextFont:(UIFont *)incommingTextFont
{
    sIncommingTextFont = incommingTextFont;
}
@end
