//
//  UIColor+Hex.h
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)randomDarkColor;
+ (UIColor *)randomThinColor;

@end
