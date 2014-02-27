//
//  DOUPhoto.m
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "Photo.h"

@implementation Photo

+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:
          @{
            @"author": @"author",
            @"album_id": @"albumId",
            @"sizes": @"sizes",
            @"recs_count": @"recsCount",
            @"alt": @"alt",
            @"album_title": @"albumTitle",
            @"id": @"ID",
            @"icon": @"icon",
            @"prev_photo": @"prevPhoto",
            @"position": @"position",
            @"thumb": @"thumb",
            @"created": @"created",
            @"privacy": @"created",
            @"cover": @"cover",
            @"large": @"large",
            @"liked_count": @"likeCount",
            @"comments_count": @"commentsCount",
            @"desc": @"desc",
            @"next_photo": @"nextPhoto"
            }];
}

@end
