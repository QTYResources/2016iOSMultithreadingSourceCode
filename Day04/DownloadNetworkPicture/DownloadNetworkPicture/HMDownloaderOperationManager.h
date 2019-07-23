//
//  HMDownloaderOperationManager.h
//  03-下载网络图片
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDownloaderOperationManager : NSObject
//单例的方法
+ (instancetype)sharedManager;

- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void(^)(UIImage *img))finishedBlock;
@end
