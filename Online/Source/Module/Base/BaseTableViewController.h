//
//  BaseTableViewController.h
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseViewController.h"
#import "YAUIKit.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YARefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableSet *shownIndexes;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
