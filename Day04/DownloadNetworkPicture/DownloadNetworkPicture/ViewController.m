//
//  ViewController.m
//  DownloadNetworkPicture
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "HMDownloaderOperation.h"
#import "HMAppInfo.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (nonatomic, strong) NSOperationQueue *queue;
//下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *operationCache;

//记录当前点击的图片的地址
@property (nonatomic, copy) NSString *currentURLString;

@property (nonatomic, strong) NSArray *appInfos;

@end

@implementation ViewController
//懒加载
- (NSOperationQueue *)queue {
    if(_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
- (NSMutableDictionary *)operationCache {
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _operationCache;
}

- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [HMAppInfo appInfos];
    }
    return _appInfos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //随机取一个模型
    int index = arc4random_uniform((u_int32_t)self.appInfos.count);
    HMAppInfo *appInfo = self.appInfos[index];
    
    //判断当前点击的图片地址，和上一次图片的地址，是否一样，如果不一样，取消上一次操作
    if (![appInfo.icon isEqualToString:self.currentURLString]) {
        //取消上一次操作
        [self.operationCache[self.currentURLString] cancel];
    }
    
    
    //记录当前点击图片的地址
    self.currentURLString = appInfo.icon;
    
    //下载图片
    HMDownloaderOperation *op = [HMDownloaderOperation downloaderOperationWithURLString:appInfo.icon finishedBlock:^(UIImage *img) {
        self.imageview.image = img;
        //下载完成，移除缓存的操作
        [self.operationCache removeObjectForKey:appInfo.icon];
    }];
    
    [self.queue addOperation:op];
    //缓存下载操作
    self.operationCache[appInfo.icon] = op;
}



@end

