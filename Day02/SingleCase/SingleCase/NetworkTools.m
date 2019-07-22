//
//  NetworkTools.m
//  SingleCase
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+ (instancetype)sharedNetworkTools {
    static id instance = nil;
    // 线程同步，保证线程安全
    @synchronized (self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

+ (instancetype)sharedNetworkToolsOnce {
    static id instance = nil;
    
    // dispatch_once 线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

@end
