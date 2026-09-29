//
//  TUCustomPlaceCellCell.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/1.
//

#import "TUCustomPlaceCellCell.h"
#import "TUIDefine.h"

@interface TUCustomPlaceCellCell ()
@property (nonatomic, strong) UILabel *messageLabel;
@property TUCustomPlaceCellData *systemData;
@end

@implementation TUCustomPlaceCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = [UIColor d_systemGrayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.layer.cornerRadius = 3;
        [_messageLabel.layer setMasksToBounds:YES];
        [self.container addSubview:_messageLabel];;
    }
    return self;
}

- (void)fillWithData:(TUCustomPlaceCellData *)data;
{
    [super fillWithData:data];
    self.systemData = data;
    //set data
    self.messageLabel.text = self.isC2CBoo ? data.content:@"";
    self.messageLabel.textColor = data.contentColor;
    self.nameLabel.hidden = YES;
    self.avatarView.hidden = YES;
    self.retryView.hidden = YES;
    [self.indicator stopAnimating];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.container.mm_center();
    self.messageLabel.mm_fill();
}

@end
