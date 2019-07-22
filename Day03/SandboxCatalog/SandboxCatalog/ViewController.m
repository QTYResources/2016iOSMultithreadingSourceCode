//
//  ViewController.m
//  SandboxCatalog
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Sandbox.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = @"http://www.baidu.com/images/01.jpg";
    
    NSLog(@"%@",[path appendDocument]);
    
    //    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    //获取路径中的最后一部分
    //    NSString *fileName = [path lastPathComponent];
    //
    //    NSLog(@"%@", [cache stringByAppendingPathComponent:fileName]);
    
}



@end
