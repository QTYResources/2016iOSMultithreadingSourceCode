//
//  HMDownloaderOperation.m
//  02-自定义Operation
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMDownloaderOperation.h"
#import "NSString+Sandbox.h"
@implementation HMDownloaderOperation
+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *))finishedBlock {
    HMDownloaderOperation *op = [[HMDownloaderOperation alloc] init];
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    return op;
}

- (void)main {
    @autoreleasepool {
        //断言
        NSAssert(self.finishedBlock != nil, @"finishedBlock 不能为nil");
        
        //模拟网络延时
        [NSThread sleepForTimeInterval:2.0];
        //下载网络图片
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //缓存到沙盒中
        if (data) {
            [data writeToFile:[self.urlString appendCache] atomically:YES];
        }
        
        //判断是否被取消  取消正在执行的操作
        if (self.isCancelled) {
            return;
        }
        
        NSLog(@"下载图片 %@ %@",self.urlString,[NSThread currentThread]);

        //回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *img = [UIImage imageWithData:data];
            self.finishedBlock(img);
        }];

        
    }
}
@end
