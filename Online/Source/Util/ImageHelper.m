//
//  ImageHelper.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "ImageHelper.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"

@implementation ImageHelper

+ (void)configureAvatarImageView:(UIImageView *)avatarView
                    withImageURL:(NSString *)imageURL
{
  NSString *cachedKey = [NSString stringWithFormat:@"%@%@", @"EllipseAvatar:", imageURL];
  if (!imageURL) {
    UIImage *image = [[UIImage imageNamed:@"ic_avatar.png"] ellipseWithInset:0.0f];
    [avatarView setImage:image];
  }
  [ImageHelper setImageView:avatarView
              withCachedKey:cachedKey
              downloadBlock:^{
                [ImageHelper configureAvatarImageView:avatarView
                                         withImageURL:imageURL
                                            cachedKey:cachedKey];
              }];
}

+ (void)configureAvatarImageView:(UIImageView *)avatarView
                    withImageURL:(NSString *)imageURL
                       cachedKey:(NSString *)cachedKey
{
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[NSURL URLWithString:imageURL]
                   options:0
                  progress:NULL
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                   image = [image ellipseWithInset:0.0f];
                   [avatarView setImage:image];
                   [[SDImageCache sharedImageCache] storeImage:image forKey:cachedKey];
                 }];
}

+ (void)blurImageView:(UIImageView *)imageView
         withImageURL:(NSString *)imageURL
{
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[NSURL URLWithString:imageURL]
                   options:0
                  progress:NULL
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                   [imageView setImage:[image gaussianBlur]];
                 }];
}

+ (void)scaleWidthAndClipImageView:(UIImageView *)imageView
                      withImageURL:(NSString *)imageURL
                         showWidth:(CGFloat)showWidth
                        showHeight:(CGFloat)showHeight
{
  NSString *cachedKey = [NSString stringWithFormat:@"%@%@%@",
                         @"ScaleWidth", NSStringFromCGSize(CGSizeMake(showWidth, showHeight)), imageURL];
  [ImageHelper setImageView:imageView
              withCachedKey:cachedKey
              downloadBlock:^{
                [ImageHelper scaleWidthAndClipImageView:imageView
                                           withImageURL:imageURL
                                              showWidth:showWidth
                                             showHeight:showHeight
                                              cachedKey:cachedKey];
              }];
}

+ (void)scaleWidthAndClipImageView:(UIImageView *)imageView
                      withImageURL:(NSString *)imageURL
                         showWidth:(CGFloat)showWidth
                        showHeight:(CGFloat)showHeight
                         cachedKey:(NSString *)cachedKey
{
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[NSURL URLWithString:imageURL]
                   options:0
                  progress:NULL
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                   UIImage *scaledImage = [image fixedHeightScaleAndClipToFillSize:CGSizeMake(showWidth, showHeight)];
                   [imageView setImage:scaledImage];
                   [[SDImageCache sharedImageCache] storeImage:scaledImage forKey:cachedKey];
                 }];
}

+ (void)colorImageView:(UIImageView *)imageView
                 color:(UIColor *)color
          withImageURL:(NSString *)imageURL
      destionationSize:(CGSize)destSize
{
  NSString *cachedKey = [NSString stringWithFormat:@"%@%@%@",
                         @"ScaleColor", NSStringFromCGSize(destSize), imageURL];
  [ImageHelper setImageView:imageView
              withCachedKey:cachedKey
              downloadBlock:^{
                [ImageHelper colorImageView:imageView
                                      color:(UIColor *)color
                               withImageURL:imageURL
                           destionationSize:destSize
                                  cachedKey:cachedKey];
              }];
}

+ (void)colorImageView:(UIImageView *)imageView
                 color:(UIColor *)color
          withImageURL:(NSString *)imageURL
      destionationSize:(CGSize)destSize
             cachedKey:(NSString *)cachedKey

{
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[NSURL URLWithString:imageURL]
                   options:0
                  progress:NULL
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                   UIImage *scaledImage = [image fixedWidthScaleAndClipToFillSize:destSize];
                   UIImage *colorImage = [scaledImage colorImage:color];
                   [imageView setImage:colorImage];
                   [[SDImageCache sharedImageCache] storeImage:scaledImage forKey:cachedKey];
                 }];
}

//scale height
+ (void)scaleAndClipImageView:(UIImageView *)imageView
                 withImageURL:(NSString *)imageURL
             destionationSize:(CGSize)destSize
{
  NSString *cachedKey = [NSString stringWithFormat:@"%@%@%@",
                         @"ScaleHeight", NSStringFromCGSize(destSize), imageURL];
  [ImageHelper setImageView:imageView
              withCachedKey:cachedKey
              downloadBlock:^{
                [ImageHelper scaleAndClipImageView:imageView
                                      withImageURL:imageURL
                                  destionationSize:destSize
                                         cachedKey:cachedKey];
              }];
}

+ (void)scaleAndClipImageView:(UIImageView *)imageView
                 withImageURL:(NSString *)imageURL
             destionationSize:(CGSize)destSize
                    cachedKey:(NSString *)cachedKey
{
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[NSURL URLWithString:imageURL]
                   options:0
                  progress:NULL
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                   UIImage *scaledImage = [image fixedWidthScaleAndClipToFillSize:destSize];
                   [imageView setImage:scaledImage];
                   [[SDImageCache sharedImageCache] storeImage:scaledImage forKey:cachedKey];
                 }];
}

+ (void)clipImageView:(UIImageView *)imageView
         withImageURL:(NSString *)imageURL
             destSize:(CGSize)destSize
{
  NSString *cachedKey = [NSString stringWithFormat:@"%@%@", NSStringFromCGSize(destSize), imageURL];
  [ImageHelper setImageView:imageView
              withCachedKey:cachedKey
              downloadBlock:^{
                [ImageHelper clipImageView:imageView
                              withImageURL:imageURL
                                  destSize:destSize
                                 cachedKey:cachedKey];
              }];
}

+ (void)setImageView:(UIImageView *)imageView
       withCachedKey:(NSString *)cachedKey
       downloadBlock:(void (^)())block;
{
  SDImageCache *imageCache = [SDImageCache sharedImageCache];
  [imageCache queryDiskCacheForKey:cachedKey done:^(UIImage *image, SDImageCacheType cacheType) {
    if (!image) {
      block();
    } else {
      [imageView setImage:image];
    }
  }];
}

+ (void)clipImageView:(UIImageView *)imageView
         withImageURL:(NSString *)imageURL
             destSize:(CGSize)destSize
            cachedKey:(NSString *)cachedKey
{
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[NSURL URLWithString:imageURL]
                   options:0
                  progress:NULL
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                   UIImage *clipedImage = [image clipToFillSize:destSize];
                   [imageView setImage:clipedImage];
                   [[SDImageCache sharedImageCache] storeImage:clipedImage forKey:cachedKey];
                 }];
}

+ (CGFloat)itemImageHeightWithFixedWidth:(CGFloat)fixedWidth
                            originHeight:(CGFloat)originHeight
                             originWidth:(CGFloat)originWidth
{
  CGFloat height = MAXFLOAT;
  if (originWidth != 0 && originHeight != 0) {
    height = ceilf(fixedWidth / originWidth * originHeight);
  }
  CGFloat scaleHeight = ceilf(fixedWidth * 9 / 16);
  return MIN(height, scaleHeight);
}

+ (void)setImageView:(UIImageView *)imageView
             WithURL:(NSString *)url
           showWidth:(CGFloat)width
          showHeight:(CGFloat)height
{
  if (height == ceilf(width * 9 / 16)) {
    [ImageHelper scaleAndClipImageView:imageView
                          withImageURL:url
                      destionationSize:CGSizeMake(width, height)];
  } else {
    [imageView setImageWithURL:[NSURL URLWithString:url]];
  }
}

+ (CGFloat)scaleHeightWithFixedWidth:(CGFloat)fixedWidth
                         originWidth:(CGFloat)originWidth
                        originHeight:(CGFloat)originHeight
{
  if (originHeight != 0 && originWidth != 0) {
    return ceilf(fixedWidth / originWidth * originHeight);
  }
  return ceilf(fixedWidth * 9 / 16);
}

@end

