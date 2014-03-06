//
//  DOUAPIClient+Online.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "DOUAPIClient+Online.h"
#import "AppConstant.h"
#import "OnlineAccount.h"

@implementation DOUAPIClient(Online)

+ (DOUAPIClient *)createHttpClient
{
  DOUAPIClient *client = [[DOUAPIClient alloc] initWithBaseURL:kAPIBaseURL];
  [client setBodyParameterJSONEncodingEnabled:NO];
  [DOUAPIClient setNetworkActivityIndicatorEnable:YES];
  return client;
}

- (void)getHotOnlinesByCast:(NSString *)cast
                      start:(int)start
                      count:(int)count
                  succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                     failed:(DOUAPIRequestFailErrorBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSString *finalPath;
  if ([cast isEqualToString:@"guess"]) {
    OnlineAccount *account = [OnlineAccount currentAccount];
    if (nil == account) {
      return;
    }
    finalPath = [NSString stringWithFormat:@"v2/online/people_onlines/%@/guesses", account.userUUID];
  } else {
    finalPath = [NSString stringWithFormat:@"v2/onlines"];
  }
  
  NSMutableDictionary *parameter = [[NSMutableDictionary alloc]initWithCapacity:3];
  [parameter setObject:cast forKey:@"cate"];
  [parameter setValue:[NSNumber numberWithInt:count] forKey:@"count"];
  [parameter setObject:[NSNumber numberWithInt:start] forKey:@"start"];
  
  [self getPath:finalPath parameters:parameter success:^(NSString *string) {
    NSError* err = nil;
    OnlineArray *array = [[OnlineArray alloc] initWithString:string error:&err];
    if (succeeded && err == nil) {
      succeeded(array);
    }
  } failure:^(DOUError *error) {
    if (failed) {
      failed(error);
    }
  }];
}

- (void)getDailyHotOnlinesWithStart:(int)start
                              count:(int)count
                          succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                             failed:(DOUAPIRequestFailErrorBlock)failed
{
  [self getHotOnlinesByCast:@"day" start:start count:count succeeded:succeeded failed:failed];
}

- (void)getWeeklyHotOnlinesWithStart:(int)start
                               count:(int)count
                           succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                              failed:(DOUAPIRequestFailErrorBlock)failed
{
  [self getHotOnlinesByCast:@"week" start:start count:count succeeded:succeeded failed:failed];
}

- (void)getLatestHotOnlinesWithStart:(int)start
                               count:(int)count
                           succeeded:(void (^)(OnlineArray *onlineArray))succeeded
                              failed:(DOUAPIRequestFailErrorBlock)failed
{
  [self getHotOnlinesByCast:@"latest" start:start count:count succeeded:succeeded failed:failed];
}


- (void)getOnlineWithID:(int)onlineID
              succeeded:(void (^)(Online *online))succeeded
                 failed:(DOUAPIRequestFailErrorBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSString *finalPath = [NSString stringWithFormat:@"v2/online/%d", onlineID];
  
  [self getPath:finalPath parameters:nil success:^(NSString *string) {
    NSError* err = nil;
    Online *online = [[Online alloc] initWithString:string error:&err];
    if (succeeded && err == nil) {
      succeeded(online);
    }
  } failure:^(DOUError *error) {
    if (failed) {
      failed(error);
    }
  }];
}


- (void)getPhotosOfAlbumID:(NSString *)albumID
                     start:(int)start
                     count:(int)count
                 succeeded:(void (^)(PhotoArray *photoArray))succeeded
                    failed:(DOUAPIRequestFailErrorBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSString *finalPath = [NSString stringWithFormat:@"v2/album/%@/photos", albumID];
  
  NSMutableDictionary *parameter = [[NSMutableDictionary alloc]initWithCapacity:3];
  [parameter setValue:[NSNumber numberWithInt:count] forKey:@"count"];
  [parameter setObject:[NSNumber numberWithInt:start] forKey:@"start"];
  
  [self getPath:finalPath parameters:parameter success:^(NSString *string) {
    NSError* err = nil;
    PhotoArray *array = [[PhotoArray alloc] initWithString:string error:&err];
    if (succeeded && err == nil) {
      succeeded(array);
    }
  } failure:^(DOUError *error) {
    if (failed) {
      failed(error);
    }
  }];

}

- (void)getUserByID:(NSString *)userID
          succeeded:(void (^)(User *user))succeeded
             failed:(DOUAPIRequestFailErrorBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSString *finalPath = [NSString stringWithFormat:@"v2/user/%@", userID];
  
  [self getPath:finalPath parameters:nil success:^(NSString *string) {
    NSError* err = nil;
    User *user = [[User alloc] initWithString:string error:&err];
    if (succeeded && err == nil) {
      succeeded(user);
    }
  } failure:^(DOUError *error) {
    if (failed) {
      failed(error);
    }
  }];
}

@end
