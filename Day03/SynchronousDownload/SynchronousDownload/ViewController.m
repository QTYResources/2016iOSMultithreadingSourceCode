//
//  ViewController.m
//  SynchronousDownload
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "HMAppInfo.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *appInfos;

@end

// 1. 创建模型类，获取数据，测试
// 2. 数据源方法
// 3. 同步下载图片

@implementation ViewController

// 懒加载
- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [HMAppInfo appInfos];
    }
    return _appInfos;
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
    // 1. 创建可重用的cell
    static NSString *reuseId = @"appInfo";
    // 如果未使用[tableView registerClass:<#(nullable Class)#> forCellReuseIdentifier:<#(nonnull NSString *)#>]方法注册Cell类，则不能在这里使用下面的方法：
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    // 2. 获取数据，给cell内部子控件赋值
    HMAppInfo *appInfo = self.appInfos[indexPath.row];
    
    cell.textLabel.text = appInfo.name;
    cell.detailTextLabel.text = appInfo.download;
    
    // 同步下载图片
    // 模拟网速比较慢
    [NSThread sleepForTimeInterval:0.5];
    NSURL *url = [NSURL URLWithString:appInfo.icon];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    cell.imageView.image = img;
    
    return cell;
}

@end
