//
//  UIImage+Resize.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)ellipseWithInset:(CGFloat)inset
{
  return [self ellipseImage:self
                  withInset:inset
                borderWidth:0
                borderColor:[UIColor clearColor]];
}

- (UIImage *)ellipseImage:(UIImage *)image
                withInset:(CGFloat)inset
              borderWidth:(CGFloat)width
              borderColor:(UIColor *)color
{
  UIGraphicsBeginImageContext(image.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGRect rect = CGRectMake(inset,
                           inset,
                           image.size.width - inset * 2.0f,
                           image.size.height - inset * 2.0f);
  
  CGContextAddEllipseInRect(context, rect);
  CGContextClip(context);
  [image drawInRect:rect];
  
  if (width > 0) {
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, width);
    CGContextAddEllipseInRect(context, CGRectMake(inset + width / 2,
                                                  inset +  width / 2,
                                                  image.size.width - width - inset * 2.0f,
                                                  image.size.height - width - inset * 2.0f));
    
    CGContextStrokePath(context);
  }
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

- (UIImage *)gaussianBlur
{
  CIContext *context = [CIContext contextWithOptions:nil];
  CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
  
  CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
  [filter setValue:inputImage forKey:kCIInputImageKey];
  [filter setValue:[NSNumber numberWithFloat:30.0f] forKey:@"inputRadius"];
  CIImage *result = [filter valueForKey:kCIOutputImageKey];
  
  CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
  
  return [UIImage imageWithCGImage:cgImage];
}

- (UIImage *)fixedHeightScaleAndClipToFillSize:(CGSize)destSize

{
  CGFloat showWidth = destSize.width;
  CGFloat showHeight = destSize.height;
  CGFloat scaleWidth = 0;
  
  scaleWidth = ceilf(showHeight / self.size.height * self.size.width);
  
  //scale
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaleWidth, showHeight), NO, 0.0f);
  [self drawInRect:CGRectMake(0, 0, scaleWidth, showHeight)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  //clip
  CGRect cropRect;
  if (scaleWidth > showWidth) {
    CGFloat originX = ceilf((scaleWidth - showWidth) / 2);
    cropRect = CGRectMake(ceilf(originX * scaledImage.scale),
                          0,
                          ceilf(showWidth * scaledImage.scale),
                          ceilf(showHeight * scaledImage.scale));
  } else {
    CGFloat height = scaleWidth / showWidth * showHeight;
    cropRect = CGRectMake(0,
                          0,
                          ceilf(scaleWidth * scaledImage.scale),
                          ceilf(height * scaledImage.scale));
  }
  return [scaledImage cropImageInRect:cropRect];
}

- (UIImage *)fixedWidthScaleAndClipToFillSize:(CGSize)destSize
{
  CGFloat scaleHeight = 0;
  scaleHeight = destSize.width / self.size.width * self.size.height;
  //scale
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(destSize.width, scaleHeight), NO, 0.0f);
  [self drawInRect:CGRectMake(0, 0, destSize.width, scaleHeight)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  //clip
  CGRect cropRect = CGRectMake(0,
                               0,
                               ceilf(destSize.width * scaledImage.scale),
                               ceilf(destSize.height * scaledImage.scale));
  return [scaledImage cropImageInRect:cropRect];
}

- (UIImage *)clipToFillSize:(CGSize)destSize
{
  CGFloat width = self.size.width;
  CGFloat height = self.size.height;
  if (width < height) {
    height = width / destSize.width * destSize.height;
  } else {
    width = height / destSize.height * width;
  }
  CGRect cropRect = CGRectMake(0, 0, ceilf(width * self.scale), ceilf(height * self.scale));
  UIImage *clipedImage = [self cropImageInRect:cropRect];
  return clipedImage;
}

- (UIImage *)cropImageInRect:(CGRect)rect
{
  CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
  UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  return cropImage;
}

- (UIImage *)scaleImageToSize:(CGSize)size
{
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return scaledImage;
}

@end

