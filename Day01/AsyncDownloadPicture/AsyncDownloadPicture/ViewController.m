//
//  ViewController.m
//  AsyncDownloadPicture
//
//  Created by QinTuanye on 2019/7/4.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)loadView {
    // 初始化scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.view = self.scrollView;
    
    // 初始化imageView
    self.imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [thread start];
}

// 下载网络图片
- (void)downloadImage {
    // 图片的地址
    NSURL *url = [NSURL URLWithString:@"http://pic1.win4000.com/wallpaper/4/59c9e6d957dc6.jpg"];
    // 下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 把NSData转换成UIImage
    UIImage *img = [UIImage imageWithData:data];
    
    // 在主线程上更新UI控件 线程间通信
    // waitUntiDone 值是YES 会等待方法执行完毕，才会执行后续代码
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:img waitUntilDone:YES];
}

- (void)updateUI:(UIImage *)img {
    self.imageView.image = img;
    // 让imageView的大小和图片的大小一致
    [self.imageView sizeToFit];
    
    // 设置scrollView滚动范围
    self.scrollView.contentSize = img.size;
}

@end
