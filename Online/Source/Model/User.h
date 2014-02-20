//
//  User.h
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"

@interface User : JSONModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isBanned;
@property (nonatomic, assign) BOOL isSuicide;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *largeAvatar;

@end
