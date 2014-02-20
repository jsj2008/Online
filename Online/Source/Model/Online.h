//
//  DOUOnline.h
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"

@protocol Online
@end

@interface Online : JSONModel

@property (nonatomic, strong) NSString *albumID;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) int recsCount;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *relatedUrl;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, assign) BOOL cascadeInvite;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) int photoCount;
@property (nonatomic, assign) int participantCount;
@property (nonatomic, strong) NSString *shuoTopic;
@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *groupID;

@end
