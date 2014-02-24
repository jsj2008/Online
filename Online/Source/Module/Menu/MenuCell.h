//
//  MenuCell.h
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "MenuView.h"

@interface MenuCell : UITableViewCell

@property (nonatomic, strong) MenuView *menuView;
- (void)configureViewWithMenuType:(MenuType)menuType;

@end
