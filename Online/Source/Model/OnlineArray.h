//
//  DOUOnlineArray.h
//  Online
//
//  Created by liaojinxing on 14-2-20.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "JSONModel.h"
#import "Online.h"

@interface OnlineArray : JSONModel

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int start;
@property (nonatomic, assign) int total;
@property (nonatomic, strong) NSArray<Online, ConvertOnDemand> *onlines;

@end
