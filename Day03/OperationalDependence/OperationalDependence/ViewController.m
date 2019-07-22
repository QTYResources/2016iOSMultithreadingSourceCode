//
//  ViewController.m
//  OperationalDependence
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 下载 - 解压 - 升级完成
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"解压");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"升级完成");
    }];
    
    // 设置操作间的依赖
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    // 错误，会发生循环依赖，什么都不执行
//    [op1 addDependency:op3];
    
    // 操作添加到队列中
    [self.queue addOperations:@[op1, op2] waitUntilFinished:NO];
    [[NSOperationQueue mainQueue] addOperation:op3];
}


@end
