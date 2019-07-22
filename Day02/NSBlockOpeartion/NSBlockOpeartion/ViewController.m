//
//  ViewController.m
//  NSBlockOpeartion
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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self demo4];
    [self demo5];
}

// 演示start
- (void)demo1 {
    // 创建操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hello %@", [NSThread currentThread]);
    }];
    // 更新op的状态，执行main方法
    [op start]; // 不会开新线程
}

// 把操作添加到队列
- (void)demo2 {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 创建操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hello %@", [NSThread currentThread]);
    }];
    // 把操作添加到队列中
    [queue addOperation:op];
}

- (void)demo3 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        NSLog(@"hello %@", [NSThread currentThread]);
    }];
}

// 全局队列
- (void)demo4 {
    // 并发队列，异步执行
    for (int i = 0; i < 10; i++) {
        [self.queue addOperationWithBlock:^{
            NSLog(@"hello %d %@", i, [NSThread currentThread]);
        }];
    }
}

// 操作的completionBlock
- (void)demo5 {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hello %@", [NSThread currentThread]);
    }];
    
    // 操作完成之后执行
    [op setCompletionBlock:^{
        NSLog(@"end %@", [NSThread currentThread]);
    }];
    
    [self.queue addOperation:op];
}

@end
