//
//  ViewController.m
//  ThreadAttribute
//
//  Created by QinTuanye on 2019/7/4.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 当线程结束之后，不能再次使用
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 新建状态
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    // 设置线程名称
    thread1.name = @"t1";
    // 线程的优先级
    thread1.threadPriority = 1.0;
    // 就绪状态
    [thread1 start];
    
    // 新建状态
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    thread2.name = @"t2";
    thread2.threadPriority = 0;
    // 就绪状态
    [thread2 start];
}

// 线程执行完成之后会自动销毁
- (void)demo {
    for (int i = 0; i < 20; i++) {
        NSLog(@"%d--%@", i, [NSThread currentThread]);
        // 判断当前线程是否是主线程
        if ([NSThread isMainThread]) {
            int m = 0;
            int n = 5 / m;
        }
        
//        [NSThread sleepForTimeInterval:2];
    }
}

@end
