//
//  ViewController.m
//  MainQueue
//
//  Created by QinTuanye on 2019/7/8.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self demo1];
//    [self demo2];
    [self demo3];
}

// 1. 主队列，异步执行      主线程，顺序执行
// 主队列的特点：先执行完主线程上的代码，才会执行主队列中的任务
- (void)demo1 {
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"hello %d %@", i, [NSThread currentThread]);
        });
    }
}

// 2. 主队列，同步执行  ----    主线程上执行才会死锁
// 同步执行：会等着第一个任务执行完成，才会继续往后执行
- (void)demo2 {
    NSLog(@"begin");
    for (int i = 0; i < 10; i++) {
        // 死锁
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"hello %d %@", i, [NSThread currentThread]);
        });
    }
    NSLog(@"end");
}

// 3 解决死锁的问题
- (void)demo3 {
    NSLog(@"begin");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10; i++) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"hello %d %@", i, [NSThread currentThread]);
            });
        }
    });
}

@end
