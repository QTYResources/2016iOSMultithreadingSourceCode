//
//  ViewController.m
//  InterprocessCommunication
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 全局队列
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

// 懒加载
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.queue addOperationWithBlock:^{
        // 异步下载图片
        NSLog(@"异步下载图片");
        
        // 获取a当前队列
        [NSOperationQueue currentQueue];
        
        // 进程间通信，回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI");
        }];
    }];
}


@end
