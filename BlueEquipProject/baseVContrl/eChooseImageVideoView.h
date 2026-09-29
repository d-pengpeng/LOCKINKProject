//
//  eChooseImageVideoView.h
//  yunbaolive
//
//  Created by Edwin on 2020/10/14.
//  Copyright © 2020 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class eChooseImageVideoConfig;

@protocol eChooseImageVideoVDelegate <NSObject>

@optional
- (void)eChooseImageVideoDelete:(NSInteger)num;
- (void)eChooseImageVideoUrl:(NSURL *)url;

- (void)eChooseImagessArr:(NSArray *)arr inpNum:(NSInteger)num;
- (void)pickPhotosChoose:(NSInteger)typeN;
@end

@interface eChooseImageVideoView : UIView

@property (nonatomic, weak) UINavigationController *navigationController;

@property (nonatomic, copy) void(^viewHeightChanged)(CGFloat height);
@property (nonatomic, assign) id<eChooseImageVideoVDelegate> delegate_;
@property (nonatomic, assign) NSInteger typeNN;
- (instancetype)initWithFrame:(CGRect)frame config:(eChooseImageVideoConfig *)config;
- (void)refreshPhotoOrVideoArray:(NSArray *)array isVideo:(BOOL)boo;

- (NSArray *)getPhotos;
@end

@interface eChooseImageVideoConfig : NSObject

@property (nonatomic, assign) CGSize itemSize; //每张图片的缩略图尺寸 默认CGSizeMake(60, 60);
@property (nonatomic, assign) UIEdgeInsets sectionInset; //距离上下左右的边距 默认UIEdgeInsetsMake(10, 10, 10, 10);
@property (nonatomic, assign) CGFloat minimumLineSpacing; //最小行高 默认10.0f;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; //最小列宽 默认10.0f;
@property (nonatomic, assign) NSInteger photosMaxCount; //最多选择照片张数 默认9张

@end

NS_ASSUME_NONNULL_END
