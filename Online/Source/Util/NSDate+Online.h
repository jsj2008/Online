//
//  NSDate+Online.h
//  Online
//
//  Created by liaojinxing on 14-2-27.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Online)

- (NSString *)dateToString;
+ (NSDate *)stringToDate:(NSString *)string;
+ (NSString *)dateStringOnlineStyleString:(NSString *)source;

@end
