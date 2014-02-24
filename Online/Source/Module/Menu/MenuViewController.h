//
//  MenuViewController.h
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "MenuView.h"

@protocol MenuSelectDelegate <NSObject>

- (void)selectMenuType:(MenuType)menuType;

@end

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<MenuSelectDelegate> delegate;

@end
