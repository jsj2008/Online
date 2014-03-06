//
//  MenuView.h
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MenuType) {
  kTodayHotOnline = 0,
  kWeekHotOnline,
  kLatestOnline,
  kProfile,
};

@protocol MenuViewDelegate <NSObject>

- (void)presentMenuViewController;

@end

@interface MenuView : UIView

@property (nonatomic, weak) id<MenuViewDelegate> delegate;
- (void)configureWithMenuType:(MenuType)menuType;

@end
