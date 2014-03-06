//
//  DOUAPIClient+Online.h
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "DOUAPIClient.h"
#import "OnlineArray.h"
#import "PhotoArray.h"
#import "User.h"

@interface DOUAPIClient (Online)

+ (DOUAPIClient *)createHttpClient;

- (void)getHotOnlinesByCast:(NSString *)cast
                      start:(int)start
                      count:(int)count
                  succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                     failed:(DOUAPIRequestFailErrorBlock)failed;

- (void)getDailyHotOnlinesWithStart:(int)start
                              count:(int)count
                          succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                             failed:(DOUAPIRequestFailErrorBlock)failed;

- (void)getWeeklyHotOnlinesWithStart:(int)start
                               count:(int)count
                           succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                              failed:(DOUAPIRequestFailErrorBlock)failed;

- (void)getLatestHotOnlinesWithStart:(int)start
                               count:(int)count
                           succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                              failed:(DOUAPIRequestFailErrorBlock)failed;

- (void)getGuessOnlinesWithUserID:(NSString *)userID
                            start:(int)start
                            count:(int)count
                        succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                           failed:(DOUAPIRequestFailErrorBlock)failed;

- (void)getOnlineWithID:(int)onlineID
              succeeded:(void (^)(Online *online))succeeded
                 failed:(DOUAPIRequestFailErrorBlock)failed;


- (void)getPhotosOfAlbumID:(NSString *)albumID
                     start:(int)start
                     count:(int)count
                 succeeded:(void (^)(PhotoArray *photoArray))succeeded
                    failed:(DOUAPIRequestFailErrorBlock)failed;

- (void)getUserByID:(NSString *)userID
          succeeded:(void (^)(User *user))succeeded
             failed:(DOUAPIRequestFailErrorBlock)failed;


@end
