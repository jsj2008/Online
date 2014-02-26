//
//  OnlineDetailHeaderView.h
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "Online.h"

@interface OnlineDetailHeaderView : UIView

@property (nonatomic, strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *participateButton;
@property (nonatomic, strong) IBOutlet NSMutableArray *onlineUsers;

- (void)configureWithOnline:(Online *)online;

@end
