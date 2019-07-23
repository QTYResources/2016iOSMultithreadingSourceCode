//
//  HMDownloaderOperationManager.m
//  03-下载网络图片
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMDownloaderOperationManager.h"
//1 管理全局下载操作
//2 管理全局的缓存

@implementation HMDownloaderOperationManager
+ (instancetype)sharedManager {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}
//1 管理全局下载操作
- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *))finishedBlock {
    

}

@end
