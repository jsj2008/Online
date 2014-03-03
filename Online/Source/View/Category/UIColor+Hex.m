//
//  UIColor+Hex.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor(Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
  return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16) / 255.0f
                         green:((hexValue & 0x00FF00) >> 8) / 255.0f
                          blue:(hexValue & 0x0000FF) / 255.0f
                         alpha:alpha];
}

+ (UIColor *)randomDarkColor
{
  int base = 56;
  int redValue = random() % base;
  int greenValue = random() % base;
  int blueValue = random() % base;
  return [UIColor colorWithRed:redValue / 255.0f
                         green:greenValue / 255.0f
                          blue:blueValue / 255.0f
                         alpha:1.0f];
}

+ (UIColor *)randomThinColor
{
  int base = 56;
  int redValue = random() % base + (255 - base);
  int greenValue = random() % base + (255 - base);
  int blueValue = random() % base + (255 - base);
  return [UIColor colorWithRed:redValue / 255.0f
                         green:greenValue / 255.0f
                          blue:blueValue / 255.0f
                         alpha:1.0f];
}

@end
