//
//  OnlineCell.h
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "Online.h"

@interface OnlineCell : UITableViewCell

- (void)configureWithOnline:(Online *)online;
@property (nonatomic, strong) UIView *mainView;

@end
