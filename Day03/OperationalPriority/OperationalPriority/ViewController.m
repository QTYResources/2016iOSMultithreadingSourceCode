//
//  ViewController.m
//  OperationalPriority
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

// 懒加载
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 操作1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"op1 %d", i);
        }
    }];
    // 设置优先级最高
    op1.qualityOfService = NSQualityOfServiceUserInteractive;
    [self.queue addOperation:op1];
    
    // 等操作完成，执行 执行在子线程上
    [op1 setCompletionBlock:^{
        NSLog(@"======= op1 执行完成 ======== %@", [NSThread currentThread]);
    }];
    
    // 操作2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"op2 %d", i);
        }
    }];
    // 设置优先级最低
    op2.qualityOfService = NSQualityOfServiceBackground;
    [self.queue addOperation:op2];
}


@end
