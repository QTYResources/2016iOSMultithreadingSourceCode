//
//  ViewController.m
//  NSOperation
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
    // 抽象类 没有实现的类 用作父类，用来约束子类
    // NSOperation
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建操作
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
//    NSLog(@"%d", op.isFinished);
//    // start方法更新操作的状态 调用main方法
//    // 不会开启新线程
//    [op start]; // 不开启新线程
//    [op start];
//    [op start];
//    NSLog(@"%d", op.isFinished);
    
    // 创建操作
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
    // 队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 把操作添加到队列
    [queue addOperation:op];
}

- (void)demo {
    NSLog(@"hello %@", [NSThread currentThread]);
}

@end
