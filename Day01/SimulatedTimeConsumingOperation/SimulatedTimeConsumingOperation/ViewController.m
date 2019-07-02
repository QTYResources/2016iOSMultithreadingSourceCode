//
//  ViewController.m
//  SimulatedTimeConsumingOperation
//
//  Created by QinTuanye on 2019/7/2.
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
    // 界面卡死
//    [self demo];
    
    [self performSelectorInBackground:@selector(demo) withObject:nil];
}

// 1 循环的速度是非常非常快
// 2 操作内存的栈空间，速度非常快
// 3 操作内存的堆空间， 速度有点慢
// 4 循环非常消耗cpu资源
// 5 I/O操作 速度非常慢

- (void)demo {
    NSLog(@"begin");
    for (int i = 0; i < 10000000; i++) {
//        int n = i;
//        NSString *str = @"hello";   // 存储在常量区
//        NSString *str = [NSString stringWithFormat:@"hello %d", i];
        NSLog(@"%d", i);
    }
    NSLog(@"end");
}
@end
