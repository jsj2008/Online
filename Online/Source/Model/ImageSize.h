//
//  ImageSize.h
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"

@protocol ImageSize
@end

@interface ImageSize : JSONModel

@property (nonatomic, strong) NSArray *large;
@property (nonatomic, strong) NSArray *cover;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSArray *thumb;
@property (nonatomic, strong) NSArray *icon;

@end
