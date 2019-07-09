//
//  ViewController.m
//  Barrier
//
//  Created by QinTuanye on 2019/7/9.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *photoList;

@end

@implementation ViewController

// 懒加载
- (NSMutableArray *)photoList {
    if (_photoList == nil) {
        _photoList = [NSMutableArray array];
    }
    return _photoList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 1; i <= 1000; i++) {
        [self downloadImage:i];
    }
}

// 模拟从网络上下载很多张图片，并且把下载完成的图片添加的mutableArray中
- (void)downloadImage:(int)index {
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("hm", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 模拟下载图片
        NSString *fileName = [NSString stringWithFormat:@"%02d.jpg", index % 10 + 1];
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        
        // 等待队列中所有的任务执行完成，才会执行barrier中的代码
        dispatch_barrier_async(queue, ^{
            [self.photoList addObject:img];
            NSLog(@"保存图片 %@  %@", fileName, [NSThread currentThread]);
        });
        
        NSLog(@"图片下载完成 %@  %@", fileName, [NSThread currentThread]);
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%zd", self.photoList.count);
}

@end
