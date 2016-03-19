//
//  JAClientManager.h
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OctoKit/OctoKit.h>

@interface JAClientManager : NSObject

@property (nonatomic, strong) OCTClient *client;

+ (JAClientManager*)defaultManager;

@end
