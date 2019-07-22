//
//  ViewController.m
//  MaxNumberOfConcurrent
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
        // 设置最大并发数（并不是线程数)
        _queue.maxConcurrentOperationCount = 2;
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 20; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"%d %@", i, [NSThread currentThread]);
        }];
    }
}

// 取消所有操作 当前正在执行的操作会执行完毕，取消后续的所有操作
- (IBAction)cancel:(id)sender {
    [self.queue cancelAllOperations];
    NSLog(@"取消");
}

// 暂停操作 当前正在执行的操作，会执行完毕，后续的操作会暂停
- (IBAction)suspend:(id)sender {
    self.queue.suspended = YES;
    NSLog(@"暂停");
}

// 继续操作
- (IBAction)resume:(id)sender {
    self.queue.suspended = NO;
    NSLog(@"继续");
}

// 当操作执行完毕，会从队列中移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 队列中的操作数
    NSLog(@"%zd", self.queue.operationCount);
}

@end
