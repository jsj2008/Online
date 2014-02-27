//
//  DOUPhoto.h
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"
#import "ImageSize.h"

@protocol Photo
@end

@interface Photo : JSONModel

@property (nonatomic, strong) User *author;
@property (nonatomic, assign) int albumId;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) int recsCount;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, assign) int ID;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *prevPhoto;
@property (nonatomic, assign) int position;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *privacy;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *large;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, assign) int commentsCount;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *nextPhoto;
@property (nonatomic, strong) ImageSize *sizes;

@end
