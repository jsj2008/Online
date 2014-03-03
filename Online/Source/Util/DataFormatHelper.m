//
//  DataFormatHelper.m
//  Online
//
//  Created by liaojinxing on 14-3-3.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "DataFormatHelper.h"

@implementation DataFormatHelper
+ (BOOL)validateEmail:(NSString *)email
{
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber
{
  NSRange rng = [phoneNumber rangeOfString:@"1[358][0-9]{9}+" options:NSRegularExpressionSearch];
  return NSNotFound != rng.location;
}

+ (NSString *)numberToAlphabet:(int)number
{
  NSString *string = [NSString stringWithFormat:@"%c", number+65];
  return string;
}

@end
