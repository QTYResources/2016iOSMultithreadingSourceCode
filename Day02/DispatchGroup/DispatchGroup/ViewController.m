//
//  ViewController.m
//  DispatchGroup
//
//  Created by QinTuanye on 2019/7/22.
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

// 下载三首歌曲，当歌曲都下载完毕 通知用户
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self demo1];
    [self demo2];
}

// 调度组内部的原理
- (void)demo2 {
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    // 创建队列
    dispatch_queue_t queue = dispatch_queue_create("hm", DISPATCH_QUEUE_CONCURRENT);
    
    // 任务一
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"任务1");
        dispatch_group_leave(group);
    });
    
    // 任务2
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"任务2");
        dispatch_group_leave(group);
    });
    
    // 任务3
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"任务3");
        dispatch_group_leave(group);
    });
    
    // 等待组中的任务都执行完毕后，才会执行
    dispatch_group_notify(group, queue, ^{
        NSLog(@"over");
    });
    
    // 等待组中的任务都执行完毕，才会执行后续的代码
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"hello ");
}

// 演示调度组的基本使用
- (void)demo1 {
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 下载第一首歌曲
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第一个歌曲");
    });
    
    // 下载第二首歌曲
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第二个歌曲");
        [NSThread sleepForTimeInterval:2.0];
    });
    
    // 下载第三首歌曲
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第三个歌曲");
    });
    
    // 当三个异步任务都执行完毕，才执行
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"over %@", [NSThread currentThread]);
    });
}

@end
