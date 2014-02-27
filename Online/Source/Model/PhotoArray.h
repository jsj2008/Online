//
//  PhotoArray.h
//  Online
//
//  Created by liaojinxing on 14-2-27.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"
#import "Photo.h"
#import "Album.h"

@interface PhotoArray : JSONModel

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int start;
@property (nonatomic, assign) int total;
@property (nonatomic, strong) Album *album;
@property (nonatomic, strong) NSArray<Photo, ConvertOnDemand> *photos;

@end
