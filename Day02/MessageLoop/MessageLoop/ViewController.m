//
//  ViewController.m
//  MessageLoop
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
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(demo) userInfo:nil repeats:YES];
    
    // 把定时器添加到当前线程消息循环中
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // 消息循环是在一个指定的模式下运行的 默认的模式NSDefaultRunLoopMode，设置的输入事件也需要指定一个模式，消息循环的模式必须和输入事件的模式匹配才会执行
    
    // UITrackingRunLoopMode    当滚动scrollView的时候，消息循环的模式自动改变
}

- (void)demo {
    // 输出当前消息循环的模式
    NSLog(@"hello %@", [NSRunLoop currentRunLoop].currentMode);
}
@end
