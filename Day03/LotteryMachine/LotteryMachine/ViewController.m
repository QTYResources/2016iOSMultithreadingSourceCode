//
//  ViewController.m
//  LotteryMachine
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

// 全局队列
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

// 懒加载
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

// 点击开始执行
- (IBAction)start:(UIButton *)sender {
    // 当队列中有操作的时候，不添加操作
    
    if (self.queue.operationCount == 0) {
        // 异步执行，添加操作
        self.queue.suspended = NO;
        [self.queue addOperationWithBlock:^{
            [self random];
        }];
        [self.startButton setTitle:@"暂停" forState:UIControlStateNormal];
    } else if (!self.queue.isSuspended) {
        // 正在执行的时候，暂停
        // 先把当前的操作执行完毕，z暂停后续的操作
        self.queue.suspended = YES;
        [self.startButton setTitle:@"继续" forState:UIControlStateNormal];
    }
}

// 随机生成3个数字，显示到label上
- (void)random {
    while (!self.queue.isSuspended) {
        [NSThread sleepForTimeInterval:0.05];
        // 生成随机数 [0, 10) 0-9
        int num1 = arc4random_uniform(10);
        int num2 = arc4random_uniform(10);
        int num3 = arc4random_uniform(10);
        
        // 回到主线程上更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 给label赋值
            self.lbl1.text = [NSString stringWithFormat:@"%d", num1];
            self.lbl2.text = [NSString stringWithFormat:@"%d", num2];
            self.lbl3.text = [NSString stringWithFormat:@"%d", num3];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%zd", self.queue.operationCount);
}

@end
