//
//  ViewController.m
//  AutoReleasePool
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
    for (int i = 0; i < 100000000; i++) {
        @autoreleasepool {
            NSString *str = [NSString stringWithFormat:@"hello %d", i];
        }
    }
    NSLog(@"end");
}


@end
