//
//  JAClientManager.m
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import "JAClientManager.h"

@implementation JAClientManager

+ (JAClientManager*)defaultManager {
    
    static JAClientManager *defaultManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        defaultManager = [[self alloc] init];
    });
    
    return defaultManager;
}

- (OCTClient *)client
{
    if (!_client) {
        
        OCTUser *user = [OCTUser userWithRawLogin:@"adlerj" server:OCTServer.dotComServer];
        _client = [OCTClient unauthenticatedClientWithUser:user];
    }
    
    return _client;
}

@end
