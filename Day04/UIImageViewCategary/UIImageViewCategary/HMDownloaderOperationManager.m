//
//  HMDownloaderOperationManager.m
//  03-下载网络图片
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMDownloaderOperationManager.h"
#import "HMDownloaderOperation.h"
#import "NSString+Sandbox.h"
//1 管理全局下载操作
//2 管理全局的缓存
@interface HMDownloaderOperationManager ()
@property (nonatomic, strong) NSOperationQueue *queue;
//下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *operationCache;
//图片缓存池
@property (nonatomic, strong) NSCache *imageCache;
@end

@implementation HMDownloaderOperationManager
//懒加载
- (NSOperationQueue *)queue {
    if(_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
- (NSMutableDictionary *)operationCache {
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _operationCache;
}
- (NSCache *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc] init];
        //
        _imageCache.countLimit = 50;
    }
    return _imageCache;
}

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
    //断言
    NSAssert(finishedBlock != nil, @"finishedBlock不能为nil");
    
    //如果下载操作已经存在 返回
    if (self.operationCache[urlString]) {
        return;
    }
    
    //判断图片是否有缓存
    if ([self checkImageCache:urlString]) {
        //如果图片有缓存，直接调用回调
        finishedBlock([self.imageCache objectForKey:urlString]);
        return;
    }
    
    //下载图片
    HMDownloaderOperation *op = [HMDownloaderOperation downloaderOperationWithURLString:urlString finishedBlock:^(UIImage *img) {
        //回调
        finishedBlock(img);
        //缓存图片
        [self.imageCache setObject:img forKey:urlString];
        
        //下载完成，移除缓存的操作
        [self.operationCache removeObjectForKey:urlString];
    }];
    
    [self.queue addOperation:op];
    //缓存下载操作
    self.operationCache[urlString] = op;
}

//2 取消操作
- (void)cancelOperation:(NSString *)urlString {
    if (!urlString) {
        return;
    }
    //取消操作
    [self.operationCache[urlString] cancel];
    //从缓存池删除操作
    [self.operationCache removeObjectForKey:urlString];
}


//3 检查是否有缓存(内存和沙盒缓存)
- (BOOL)checkImageCache:(NSString *)urlString {
    //检查内存缓存
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"从内存加载图片");
        return YES;
    }
    //检查沙盒缓存
    UIImage *img = [UIImage imageWithContentsOfFile:[urlString appendCache]];
    if (img) {
        //保存到内存中
        [self.imageCache setObject:img forKey:urlString];
        NSLog(@"从沙盒加载图片");

        return YES;
    }
    return NO;
}
@end
