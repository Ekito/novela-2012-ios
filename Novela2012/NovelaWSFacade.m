//
//  NovelaWSFacade.m
//  Novela2012
//
//  Created by Mélanie Bessagnet on 28/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import "NovelaWSFacade.h"
#import "AFNetworking.h"

@implementation NovelaWSFacade

+ (NovelaWSFacade *)sharedNovelaWSFacade
{
    static NovelaWSFacade *_sharedObject = nil;
    
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[NovelaWSFacade alloc] init];
    });
    
    return _sharedObject;
}

- (id)init {
    self = [super init];
	if(self) {
        
    }
    return self;
}

- (void)addLocation:(NovelaLocation *)location completion:(void (^)(BOOL finished))block
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    NSString *isStart = location.isStart ? @"true" : @"false";
    NSLog(@"isStart %@", isStart);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:location.latitude, @"lat", location.longitude, @"lon", location.userId, @"userId", isStart, @"isStart",  nil];
    [client postPath:ADD_LOCATION_PATH parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"addLocation response: %d - [%@]", operation.response.statusCode, responseObject);
        
        if (block) {
            block(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request %d", operation.response.statusCode);
        NSLog(@"error: %@", operation.error);
    }];
}

- (void)centerMapOnLocation:(NovelaLocation *)location completion:(void (^)(BOOL finished))block
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:location.latitude, @"lat", location.longitude, @"lon", location.userId, @"userId", location.zoom, @"zoom", nil];
    [client postPath:CENTER_MAP_PATH parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"centerMapOnLocation response: %d - [%@]", operation.response.statusCode, responseObject);
        
        if (block) {
            block(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", operation.error);
    }];
}

@end
