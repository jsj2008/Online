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

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super init];
  if(self != nil) {
    self.name = [coder decodeObjectForKey:@"name"];
    self.avatar = [coder decodeObjectForKey:@"avatar"];
    self.uid = [coder decodeObjectForKey:@"uid"];
    self.userID = [coder decodeObjectForKey:@"userID"];
    self.largeAvatar = [coder decodeObjectForKey:@"largeAvatar"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:self.name forKey:@"name"];
  [coder encodeObject:self.avatar forKey:@"avatar"];
  [coder encodeObject:self.uid forKey:@"uid"];
  [coder encodeObject:self.userID forKey:@"userID"];
  [coder encodeObject:self.largeAvatar forKey:@"largeAvatar"];
}

@end
