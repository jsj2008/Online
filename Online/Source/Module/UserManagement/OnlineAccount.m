//
//  OnlineAccount.m
//  Online
//
//  Created by liaojinxing on 14-3-3.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineAccount.h"
#import "DOUAccountManager.h"

@implementation OnlineAccount

#pragma mark - init

- (id)initWithUser:(User *)user oauth:(DOUOAuth *)oauth
{
  if (user == nil || user.uid == nil) {
    return nil;
  }
  self = [super initWithUserUUID:user.uid];
  if (self) {
    _user = user;
    if (oauth.dictionary) {
      _oauth = [DOUOAuth objectWithDictionary:oauth.dictionary];
    }
  }
  return self;
}

+ (OnlineAccount *)currentAccount
{
  return (OnlineAccount *)[[DOUAccountManager sharedInstance] currentActiveAccount];
}

+ (BOOL)isLogin
{
  OnlineAccount *account = [OnlineAccount currentAccount];
  return (account != nil);
}

@end