//
//  DOUAlbum.m
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "Album.h"

@implementation Album

+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:
          @{
            @"author": @"author",
            @"updated": @"updated",
            @"reply_limit": @"replyLimit",
            @"icon": @"icon",
            @"image": @"image",
            @"sizes": @"sizes",
            @"recs_count": @"recsCount",
            @"need_watermark": @"needWatermark",
            @"alt": @"alt",
            @"id": @"ID",
            @"size": @"imageCount",
            @"thumb": @"thumb",
            @"created": @"created",
            @"privacy": @"created",
            @"cover": @"cover",
            @"photo_order": @"photoOrder",
            @"title": @"title",
            @"like_count": @"likeCount",
            @"desc": @"desc",
            }];
}

@end
