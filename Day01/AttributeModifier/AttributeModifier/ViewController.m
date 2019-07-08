//
//  ViewController.m
//  AttributeModifier
//
//  Created by QinTuanye on 2019/7/8.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

// 属性修饰符
// retain mrc中使用
// strong arc中使用
// weak   只有arc下才能用weak
// assign arc和mrc都可以使用
// copy   arc和mrc都可以使用
// 1. 字符串为什么用copy
// 2. block作为属性的时候 为什么要用copy
// 3. delegate为什么用weak修饰
@property (nonatomic, copy) void (^myBlock)(void);
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Person *person;
@property (nonatomic, weak) Person *weakPerson;
@property (nonatomic, assign) Person *assignPerson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1. 字符串为什么用copy
//    NSMutableString *str = [NSMutableString string];
//    [str appendString:@"hello"];
//    self.name = [str copy];
//
//    [str appendString:@"zs"];
//
//    NSLog(@"%@", self.name);
    
    // 2. block为什么要用copy
    
    // 第一种 block    全局block __NSGlobalBlock__
//    void (^demo)(void) = ^ {
//        NSLog(@"aaa");
//    };
//    NSLog(@"%@", demo);
    
    // 第二种block   栈Block    __NSStackBlock__
//    int number = 5;
//    void (^demo)(void) = ^{
//        NSLog(@"aaa %d", number);
//    };
//    NSLog(@"%@", demo);
    
    // 第三种block   堆block   __NSMallocBlock__
//    int number = 5;
//    void (^demo)(void) = ^{
//        NSLog(@"aaa %d", number);
//    };
//    NSLog(@"%@", [demo copy]);
    
//    [self test];
//
//    self.myBlock();
//    self.myBlock();
    
    // 3. delegate为什么用weak修饰
//    self.person = [Person new];
//    self.person.delegate = self;
    
    // vc -->person-->delegate-->self(vc)
    
    // 4. weak和assign的区别
    self.weakPerson = [Person new];
    self.weakPerson.name = @"zs";
    NSLog(@"weakPerson %@", self.weakPerson.name);
    
    self.assignPerson = [Person new];
    self.assignPerson.name = @"ls";
    NSLog(@"assignPerson %@", self.assignPerson.name);
}

// 给block属性赋值
- (void)test {
    int n = 5;
    [self setMyBlock:^{
        NSLog(@"%d", n);
    }];
    
    NSLog(@"%@", self.myBlock);
}

@end
