//
//  ViewController.m
//  SolveMisplacement
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "HMAppInfo.h"
#import "HMAppInfoCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *appInfos;

// 全局队列
@property (nonatomic, strong) NSOperationQueue *queue;

@end

// 1. 创建模型类，获取数据，测试
// 2. 数据源方法
// 3. 同步下载图片——如果网络比较慢，界面会卡顿
// 4. 异步下载图片_图片显示不出来，点击cell或者上下拖动图片可以显示
// 解决，使用占位图片
// 5. 图片缓存——把网络上下载的图片，保存到内存
// 解决，图片重复下载，把图片缓存到内存中，节省用户的流量（拿空间换取执行时间)
// 6. 解决图片下载速度特别慢，出现的错行问题。
// 当图片下载完成之后，重新加载对应的cell

@implementation ViewController

// 懒加载
- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [HMAppInfo appInfos];
    }
    return _appInfos;
}

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1. 测试模型数据
//    NSLog(@"%@", self.appInfos);
}

// 2. 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1。 创建可重用的cell
    static NSString *reuseId = @"appInfo";
    HMAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[HMAppInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    // 2. 获取数据，给cell内部子控件赋值
    HMAppInfo *appInfo = self.appInfos[indexPath.row];
    
    // cell内部的子控件都是懒加载的
    // 当返回cell之前，会调用cell的layoutSubviews方法
    cell.textLabel.text = appInfo.name;
    cell.detailTextLabel.text = appInfo.download;
    
    // 判断有没有图片缓存
    if (appInfo.image) {
        NSLog(@"从缓存z加载图片...");
        cell.imageView.image = appInfo.image;
        return cell;
    }
    
    // 设置占位图片
    cell.imageView.image = [UIImage imageNamed:@"user_default"];
    
    // 异步下载图片
    // 模拟网速比较慢
    [self.queue addOperationWithBlock:^{
        //        [NSThread sleepForTimeInterval:0.5];
        // 模拟图片下载速度慢
        if (indexPath.row > 9) {
            [NSThread sleepForTimeInterval:5];
        }
        
        // 下载图片
        NSLog(@"下载网络图片...");
        
        NSURL *url = [NSURL URLWithString:appInfo.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        // 缓存图片
        appInfo.image = img;
        
        // 主线程上更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            cell.imageView.image = img;
            // 解决图片显示错行
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    
    // 3. 返回cell
    return cell;
}

@end
