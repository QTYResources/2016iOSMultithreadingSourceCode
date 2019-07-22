//
//  ViewController.m
//  CircularReference
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "HMAppInfo.h"
#import "HMAppInfoCell.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *appInfos;

//全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
//图片的缓存池
@property (nonatomic, strong) NSMutableDictionary *imageCache;
//下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *downloadCache;
@end
//1 创建模型类，获取数据，测试
//2 数据源方法
//3 同步下载图片--如果网速比较慢，界面会卡顿
//4 异步下载图片--图片显示不出来，点击cell或者上下拖动图片可以显示
    //解决，使用占位图片
//5 图片缓存--把网络上下载的图片，保存到内存--图片存储在模型对象中
    //解决，图片重复下载，把图片缓存到内存中，节省用户的流量 （拿空间换取执行时间）
//6 解决图片下载速度特别慢，出现的错行问题。
    //当图片下载完成之后，重新加载对应的cell
//7 当收到内存警告，要清理内存，如果图片存储在模型对象中，不好清理内存
    //图片的缓存池

//8 当有些图片下载速度比较慢，上下不停滚动的时候，会重复下载图片，会浪费流量
    //判断当前是否有对应图片的下载操作，如果没有添加下载操作，如果有不要重复创建操作
    //下载操作的缓存池

//9 分析是否有循环引用的问题
    //vc -> queue 和 downloadCache ->  op  -> block  -> self(vc)

@implementation ViewController
//懒加载
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

- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCache;
}

- (NSMutableDictionary *)downloadCache {
    if (_downloadCache == nil) {
        _downloadCache = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _downloadCache;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1 测试模型数据
//    NSLog(@"%@",self.appInfos);
}
//2 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1 创建可重用的cell
    static NSString *reuseId = @"appInfo";
    HMAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[HMAppInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    //2 获取数据，给cell内部子控件赋值
    HMAppInfo *appInfo = self.appInfos[indexPath.row];
    
    //cell内部的子控件都是懒加载的
    //当返回cell之前，会调用cell的layoutSubviews方法
    cell.textLabel.text = appInfo.name;
    cell.detailTextLabel.text = appInfo.download;
    
    //判断有没有图片缓存
    if (self.imageCache[appInfo.icon]) {
        NSLog(@"从缓存加载图片...");
        cell.imageView.image = self.imageCache[appInfo.icon];
        return cell;
    }
    
    //设置占位图片
    cell.imageView.image = [UIImage imageNamed:@"user_default"];
    
    //判断下载操作缓存池 中是否有对应的操作
    if (self.downloadCache[appInfo.icon]) {
        NSLog(@"正在拼命下载图片...");
        return cell;
    }

   
    
    
    //异步下载图片
    //模拟网速比较慢
//    __weak typeof(self) weakSelf = self;
    //下载操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        //        [NSThread sleepForTimeInterval:0.5];
        //模拟图片下载速度慢
        if (indexPath.row > 9) {
            [NSThread sleepForTimeInterval:5];
        }
        
        //下载图片
        NSLog(@"下载网络图片...");
        
        NSURL *url = [NSURL URLWithString:appInfo.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        
        //主线程上更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //线程不安全的
            //缓存图片
            self.imageCache[appInfo.icon] = img;
            //移除下载操作缓存池
            [self.downloadCache removeObjectForKey:appInfo.icon];
            
            
            //            cell.imageView.image = img;
            //解决图片显示错行
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    
    //把操作添加到队列中
    [self.queue addOperation:op];
    //把操作添加到下载操作缓存池中
    self.downloadCache[appInfo.icon] = op;
    
    
    
    //3 返回cell
    return cell;
}


//接收到内存警告
- (void)didReceiveMemoryWarning {
    //清理内存
    [self.imageCache removeAllObjects];
    //
    [self.downloadCache removeAllObjects];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击cell的时候，输出当前队列的操作数
    NSLog(@"队列的操作数：%zd",self.queue.operationCount);
    
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end

