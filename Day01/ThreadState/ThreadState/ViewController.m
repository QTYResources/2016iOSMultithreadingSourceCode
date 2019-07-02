//
//  ViewController.m
//  ThreadState
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
    
    // 新建状态
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    // 就绪状态
    [thread start];
}

- (void)demo {
    for (int i = 0; i < 20; i++) {
        NSLog(@"%d", i);
        
        if (i == 5) {
            // 阻塞状态
            [NSThread sleepForTimeInterval:3];
        }
        
        if (i == 10) {
            // 线程退出    死亡状态
            [NSThread exit];
        }
    }
}

@end
