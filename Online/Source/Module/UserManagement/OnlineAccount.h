//
//  OnlineAccount.h
//  Online
//
//  Created by liaojinxing on 14-3-3.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "DOUBasicAccount.h"
#import "DOUOAuth.h"
#import "User.h"

@interface OnlineAccount : DOUBasicAccount

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) DOUOAuth *oauth;

- (id)initWithUser:(User *)user oauth:(DOUOAuth *)oauth;
+ (OnlineAccount *)currentAccount;
+ (BOOL)isLogin;

@end
