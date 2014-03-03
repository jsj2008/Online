//
//  User.m
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "User.h"

@implementation User

+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:
          @{
            @"name": @"name",
            @"is_banned": @"isBanned",
            @"is_suicide": @"isSuicide",
            @"avatar": @"avatar",
            @"uid": @"uid",
            @"alt": @"alt",
            @"id": @"userID",
            @"large_avatar": @"largeAvatar"
            }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
  return YES;
}

@end
