//
//  ViewController.m
//  NSThreadDemo
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
    
    // 方式1
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
//    [thread start];
    
    // 方式2
//    [NSThread detachNewThreadSelector:@selector(demo) toTarget:self withObject:nil];

    // 方式3
//    [self performSelectorInBackground:@selector(demo) withObject:nil];
    
    // 方式4 参数
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo:) object:@"蒋卫生"];
//    [thread start];
    
    // 方式5
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"hello %@", [NSThread currentThread]);
    }];
    [thread start];
}

- (void)demo:(NSString *)name {
    NSLog(@"hello %@", name);
}

//- (void)demo {
//    NSLog(@"hello %@", [NSThread currentThread]);
//}
@end
