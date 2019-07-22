//
//  ViewController.m
//  DelayedAndOnceExecution
//
//  Created by QinTuanye on 2019/7/9.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1. 延迟执行
//    dispatch_time_t when,   延迟执行多长时间，精确到纳秒
//    dispatch_queue_t queue, 队列
//    dispatch_block_t block, 任务
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"task");
//    });
    
    // 2. 一次性执行
//    for (int i = 0; i < 20000; i++) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            NSLog(@"hello %@", [NSThread currentThread]);
//        });
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 当前线程上执行
        // 一次性执行的原理，判断静态的全局变量的值，默认是0，如果执行完成后，设置为-1
        // once内部会判断变量的值，如果是0才执行
        static dispatch_once_t onceToken;
        NSLog(@"%zd", onceToken);
        dispatch_once(&onceToken, ^{
            NSLog(@"hello %@", [NSThread currentThread]);
        });
        NSLog(@"%zd", onceToken);
    });
}

@end
