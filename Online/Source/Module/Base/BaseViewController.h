//
//  BaseViewController.h
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAPIClient+Online.h"
#import "MenuView.h"

@interface BaseViewController : UIViewController<MenuViewDelegate>

@property (nonatomic, strong) DOUAPIClient *httpClient;
@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, strong) MenuView *menuView;

@end