//
//  ViewController.m
//  ChildThreadMessageLoop
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
    
    // 开启一个子线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    [thread start];
    
    // 往子线程的消息循环中添加输入源
    [self performSelector:@selector(demo1) onThread:thread withObject:nil waitUntilDone:NO];
}

// 执行在子线程上的方法
- (void)demo {
    NSLog(@"I'm running");
    // 开启子线程的消息循环，如果开启，消息循环一直运行
    // 当消息循环中没有添加输入事件，消息循环会立即结束
//    [[NSRunLoop currentRunLoop] run];
    
    // 2秒钟之后消息循环结束
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    NSLog(@"end");
}

// 执行在子线程的消息循环中
- (void)demo1 {
    NSLog(@"I'm running on runloop");
}

@end
