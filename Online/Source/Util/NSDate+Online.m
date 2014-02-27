//
//  NSDate+Online.m
//  Online
//
//  Created by liaojinxing on 14-2-27.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "NSDate+Online.h"

@implementation NSDate (Online)

- (NSString *)dateToString
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"M月d日"];
  
  return [formatter stringFromDate:self];
}

+ (NSDate *)stringToDate:(NSString *)string
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *date = [dateFormat dateFromString:string];
  return date;
}

+ (NSString *)dateStringOnlineStyleString:(NSString *)source
{
  NSDate *date = [[self class] stringToDate:source];
  return [date dateToString];
}

@end
