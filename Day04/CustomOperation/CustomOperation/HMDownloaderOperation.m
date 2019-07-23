//
//  HMDownloaderOperation.m
//  02-自定义Operation
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMDownloaderOperation.h"

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

        //判断是否被取消  取消正在执行的操作
        if (self.isCancelled) {
            return;
        }
        
        
        NSLog(@"下载图片 %@ %@",self.urlString,[NSThread currentThread]);

        
        
        //UIImage
    
        //假设图片下载完成
        //回到主线程更新UI
//        if (self.finishedBlock) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.finishedBlock(self.urlString);
            }];
//        }
        
    }
}
@end
