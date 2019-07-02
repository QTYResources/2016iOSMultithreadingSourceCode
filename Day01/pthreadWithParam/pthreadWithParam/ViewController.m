//
//  ViewController.m
//  pthreadWithParam
//
//  Created by QinTuanye on 2019/7/2.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import <pthread/pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 学习新函数或方法的三要素
    // 1 函数的功能
    // 2 函数的参数
    // 3 函数的返回值
    
    // 第一个参数 线程编号的地址
    // 第二个参数 线程的属性
    // 第三个参数 线程要执行的函数void *  (*)  (void *)
    // int * 指向int类型的指针   void * 指向任何类型的指针    有点类似OC中的id
    // 第四个参数 要执行的函数的参数
    
    // 函数的返回值 int   0是成功   非0 是失败
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建子线程
    pthread_t pthread;  // 线程编号
    
    NSString *name = @"ls";
    
//    char *name = "zs";
    // __bridge 桥接
    // MRC中内存管理原则：谁申请，谁释放
    // ARC中会自动给OC对象，添加retain release autorelease
    // 把OC中的对象，传递给C语言的函数，要桥接
    int result = pthread_create(&pthread, NULL, demo, (__bridge void *)(name));
    
    NSLog(@"touchesBegan %@", [NSThread currentThread]);
    
    if (result == 0) {
        NSLog(@"成功");
    } else {
        NSLog(@"失败");
    }
}

void *demo(void *param) {
    NSString *name = (__bridge NSString *)(param);
    
    NSLog(@"hello %@ %@", name, [NSThread currentThread]);
    return NULL;
}

@end
