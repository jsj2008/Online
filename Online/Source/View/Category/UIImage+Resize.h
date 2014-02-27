//
//  UIImage+Resize.h
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Resize)
//圆形头像
- (UIImage *)ellipseWithInset:(CGFloat)inset;
//高斯模糊
- (UIImage *)gaussianBlur;
//高度固定，等比缩放
- (UIImage *)fixedHeightScaleAndClipToFillSize:(CGSize)destSize;
//宽度固定，等比缩放
- (UIImage *)fixedWidthScaleAndClipToFillSize:(CGSize)destSize;
//截图
- (UIImage *)clipToFillSize:(CGSize)destSize;

- (UIImage *)cropImageInRect:(CGRect)rect;
- (UIImage *)scaleImageToSize:(CGSize)size;

- (UIImage *)colorImage:(UIColor *)color;

@end
