//
//  DataFormatHelper.h
//  Online
//
//  Created by liaojinxing on 14-3-3.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFormatHelper : NSObject

+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber;
+ (NSString *)numberToAlphabet:(int)number;

@end
