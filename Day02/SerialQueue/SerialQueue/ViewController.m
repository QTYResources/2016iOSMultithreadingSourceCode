//
//  ViewController.m
//  SerialQueue
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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self demo1];
    [self demo2];
}

// 1 串行队列，同步执行   不开新线程，任务是按x顺序执行
- (void)demo1 {
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("hm", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"hello %d %@", i, [NSThread currentThread]);
        });
    }
}

// 2 串行队列，异步执行   开启新线程（一个），任务是有序执行
- (void)demo2 {
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("hm", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"hello %d %@", i, [NSThread currentThread]);
        });
    }
}

@end
