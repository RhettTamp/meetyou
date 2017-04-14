//
//  UMTUploadPhotoView.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMTUploadPhotoViewDelegate <NSObject>

- (void)imageTaped:(UIImageView *)imageView index:(NSInteger)index;

@end

typedef void(^uploadPhotoButtonClickedBlock)(void);

@interface UMTUploadPhotoView : UIView

@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,weak) id<UMTUploadPhotoViewDelegate> delegate;
@property (nonatomic,copy) uploadPhotoButtonClickedBlock buttonClickedblock;
- (void)addImage:(UIImage *)imge index:(NSInteger)index;
- (void)deleteImageView:(NSInteger)index imageCount:(NSInteger)imgCount;
- (void)changeImage:(UIImage *)image index:(NSInteger)index;

@end
