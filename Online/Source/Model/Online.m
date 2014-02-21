//
//  DOUOnline.m
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "Online.h"

@implementation Online

+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:
          @{
            @"album_id": @"albumID",
            @"image": @"image",
            @"recs_count": @"recsCount",
            @"owner": @"user",
            @"alt": @"alt",
            @"id": @"ID",
            @"thumb": @"thumb",
            @"title": @"title",
            @"tags": @"tags",
            @"related_url": @"relatedUrl",
            @"liked_count": @"likeCount",
            @"cascade_invite": @"cascadeInvite",
            @"desc": @"desc",
            @"photo_count": @"photoCount",
            @"participant_count": @"participantCount",
            @"shuo_topic": @"shuoTopic",
            @"begin_time": @"beginTime",
            @"icon": @"icon",
            @"created": @"created",
            @"cover": @"cover",
            @"end_time": @"endTime",
            @"group_id": @"groupID"
            }];
}

@end
