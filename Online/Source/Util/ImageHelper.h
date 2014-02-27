//
//  ImageHelper.h
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject


+ (void)configureAvatarImageView:(UIImageView *)avatarView
                    withImageURL:(NSString *)imageURL;

+ (void)blurImageView:(UIImageView *)imageView
         withImageURL:(NSString *)imageURL;

+ (void)scaleAndClipImageView:(UIImageView *)imageView
                 withImageURL:(NSString *)imageURL
             destionationSize:(CGSize)destSize;

+ (void)clipImageView:(UIImageView *)imageView
         withImageURL:(NSString *)imageURL
             destSize:(CGSize)destSize;

+ (CGFloat)itemImageHeightWithFixedWidth:(CGFloat)fixedWidth
                            originHeight:(CGFloat)originHeight
                             originWidth:(CGFloat)originWidth;

+ (CGFloat)scaleHeightWithFixedWidth:(CGFloat)fixedWidth
                         originWidth:(CGFloat)originWidth
                        originHeight:(CGFloat)originHeight;

+ (void)setImageView:(UIImageView *)imageView
             WithURL:(NSString *)url
           showWidth:(CGFloat)width
          showHeight:(CGFloat)height;

+ (void)scaleWidthAndClipImageView:(UIImageView *)imageView
                      withImageURL:(NSString *)imageURL
                         showWidth:(CGFloat)showWidth
                        showHeight:(CGFloat)showHeight;

+ (void)colorImageView:(UIImageView *)imageView
                 color:(UIColor *)color
          withImageURL:(NSString *)imageURL
      destionationSize:(CGSize)destSize;

@end
