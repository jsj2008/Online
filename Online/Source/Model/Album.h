//
//  DOUAlbum.h
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"
#import "ImageSize.h"

@interface Album : JSONModel

@property (nonatomic, strong) User *author;
@property (nonatomic, strong) NSString *updated;
@property (nonatomic, assign) BOOL replyLimit;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) ImageSize *sizes;
@property (nonatomic, assign) int recsCount;
@property (nonatomic, assign) BOOL needWatermark;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) int imageCount;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *privacy;
@property (nonatomic, strong) NSString *photoOrder;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, strong) NSString *desc;

@end
