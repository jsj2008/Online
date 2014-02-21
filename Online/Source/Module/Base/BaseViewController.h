//
//  BaseViewController.h
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAPIClient+Online.h"


@interface BaseViewController : UIViewController

@property (nonatomic, strong) DOUAPIClient *httpClient;
@property (nonatomic, strong) UIView *bodyView;

@end