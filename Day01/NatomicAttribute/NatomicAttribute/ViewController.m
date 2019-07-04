//
//  ViewController.m
//  NatomicAttribute
//
//  Created by QinTuanye on 2019/7/4.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 总票数
@property (nonatomic, assign) int ticketsCount;

@property (nonatomic, strong) NSObject *obj;
// 原子属性是线性安全的 自旋锁
@property (nonatomic, copy) NSString *name;

@end

@implementation ViewController
// 当同时重写属性的setter和getter方法，不会自动生成_name成员变量

// 为属性生成对应的成员变量
@synthesize name = _name;

// 模拟原子属性
- (NSString *)name {
    return _name;
}

- (void)setName:(NSString *)name {
    @synchronized (self) {
        _name = name;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ticketsCount = 10;
    
    self.obj = [NSObject new];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 模拟买票窗口
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
    [thread1 start];
    
    // 模拟买票窗口
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
    [thread2 start];
}

// 线程是不安全的
// 模拟卖票的方法
- (void)sellTickets {
    
    while (YES) {
        // 模拟耗时
        [NSThread sleepForTimeInterval:1.0];
        // 任意一个对象内部都有一把锁
        // 加锁会影响程序的性能
        
        // 互斥锁
        // 线程同步
        @synchronized (self.obj) {
            // 判断还有没有票
            if (self.ticketsCount > 0) {
                self.ticketsCount = self.ticketsCount - 1;
                NSLog(@"剩余%d张票", self.ticketsCount);
            } else {
                NSLog(@"来晚了，票没了");
                break;
            }
        }
    }
}
//输出两次9
//t1   t=10
//t2   t=10
//t1   t=9   log
//t2   t=9   log

//输出8，9
//t2   t=9
//t1   t=8  log
//t2   log

@end
