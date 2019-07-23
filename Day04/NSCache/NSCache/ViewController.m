//
//  ViewController.m
//  NSCache
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSCacheDelegate>
@property (nonatomic, strong) NSCache *cache;
@end

@implementation ViewController
- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        //缓存中总共可以存储多少条
        _cache.countLimit = 5;
    }
    return _cache;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置NSCache的代理
    self.cache.delegate = self;
    
    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
        NSLog(@"添加 %@",[NSString stringWithFormat:@"hello %d",i]);
    }
    
    //输出缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
    
}
//将要从NSCache中移除一项的时候执行
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"从缓存中移除  %@",obj);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    //当收到内存警告，调用removeAllObjects 之后，无法再次往缓存中添加数据
    [self.cache removeAllObjects];
    //输出缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.cache removeAllObjects];
    
    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
        //        NSLog(@"添加 %@",[NSString stringWithFormat:@"hello %d",i]);
    }
    
    //输出缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
    
}

@end

