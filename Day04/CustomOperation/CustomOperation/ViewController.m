//
//  ViewController.m
//  CustomOperation
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "HMDownloaderOperation.h"

@interface ViewController ()
//全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController
//懒加载
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 2;
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i<20; i++) {
        HMDownloaderOperation *op = [HMDownloaderOperation downloaderOperationWithURLString:@"abc.jpg" finishedBlock:^(UIImage *img) {
            //图片下载完成更新UI
            NSLog(@"更新UI %d  %@",i,[NSThread currentThread]);
        }];
        
        [self.queue addOperation:op];
        
    }
    
    
    //演示断言
    //    HMDownloaderOperation *op = [HMDownloaderOperation downloaderOperationWithURLString:@"abc.jpg" finishedBlock:nil];
    //    [self.queue addOperation:op];
    
    
    //    //自定义操作
    //    HMDownloaderOperation *op = [[HMDownloaderOperation alloc] init];
    //    op.urlString = @"xxx.jpg";
    //    //无法传递参数
    ////    [op setCompletionBlock:^{
    ////
    ////        NSLog(@"给控件赋值");
    ////    }];
    //
    //    [op setFinishedBlock:^(UIImage *img) {
    //        NSLog(@"给控件赋值 %@",img);
    //    }];
    //
    //    [self.queue addOperation:op];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //设置所有操作的canceled属性为yes
    [self.queue cancelAllOperations];
    NSLog(@"取消");
}

@end

