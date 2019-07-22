//
//  ViewController.m
//  SingleCase
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NetworkTools *t1 = [NetworkTools sharedNetworkToolsOnce];
//
//    NetworkTools *t2 = [NetworkTools sharedNetworkToolsOnce];
//
//    NSLog(@"%@", t1);
//    NSLog(@"%@", t2);
    
    [self demo1];
    [self demo2];
}

// 获取加锁， 创建的时间
- (void)demo1 {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100000000; i++) {
        [NetworkTools sharedNetworkTools];
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"加锁：%f", end - start);
}

// 获取once，创建的时间
- (void)demo2 {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100000000; i++) {
        [NetworkTools sharedNetworkToolsOnce];
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"once：%f", end - start);
}

@end
