//
//  OnlineDetailCell.h
//  Online
//
//  Created by liaojinxing on 14-2-27.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "Photo.h"

@interface OnlineDetailCell : UITableViewCell

- (void)configureWithPhoto:(Photo *)photo;
+ (CGFloat)heightWithPhoto:(Photo *)photo;

@end
