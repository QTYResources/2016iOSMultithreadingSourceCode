//
//  ViewController.m
//  OperationManager
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

#import "HMDownloaderOperationManager.h"
#import "HMAppInfo.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;



//记录当前点击的图片的地址
@property (nonatomic, copy) NSString *currentURLString;

@property (nonatomic, strong) NSArray *appInfos;

@end

@implementation ViewController
//懒加载

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
        //        [self.operationCache[self.currentURLString] cancel];
        
        [[HMDownloaderOperationManager sharedManager] cancelOperation:self.currentURLString];
    }
    
    
    //记录当前点击图片的地址
    self.currentURLString = appInfo.icon;
    
    //下载图片
    [[HMDownloaderOperationManager sharedManager] downloadWithURLString:appInfo.icon finishedBlock:^(UIImage *img) {
        self.imageview.image = img;
    }];
}



@end

