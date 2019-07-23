//
//  HMDownloaderOperation.h
//  02-自定义Operation
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
//自定义操作
//1 创建一个类继承自NSOperation
//2 重写main方法，自动释放池
//3 定义属性接收参数 ， 类方法快速初始化自定义操作
//4 取消操作（取消正在执行的操作）
//5 断言NSAssert


@interface HMDownloaderOperation : NSOperation
//要下载图片的地址
@property (nonatomic, copy) NSString *urlString;
//执行完成后，回调的block
@property (nonatomic, copy) void (^finishedBlock)(UIImage *img);

+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlock:(void(^)(UIImage *img))finishedBlock;
@end
