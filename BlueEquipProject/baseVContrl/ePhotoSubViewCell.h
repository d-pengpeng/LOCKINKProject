//
//  ePhotoSubViewCell.h
//  yunbaolive
//
//  东莞梦幻网络科技有限公司 注 on 2020/10/14.
//  Copyright © 2020 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFResultVideo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ePhotoSubViewCellDelegate <NSObject>

- (void)cellDidDeleteClcik:(NSInteger)inpNum;

@end
@interface ePhotoSubViewCell : UICollectionViewCell

@property (weak, nonatomic) id<ePhotoSubViewCellDelegate> delegate;
@property (weak, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic) LFResultVideo *model;
@property (assign, nonatomic) NSInteger numP;
@end

NS_ASSUME_NONNULL_END
