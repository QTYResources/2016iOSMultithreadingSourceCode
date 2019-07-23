//
//  UIImageView+WebCache.m
//  03-下载网络图片
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//
#define HMMYKEY "str"
#import "UIImageView+WebCache.h"
#import "HMDownloaderOperationManager.h"
#import <objc/runtime.h>
@interface UIImageView ()
//记录当前点击的图片的地址
@property (nonatomic, copy) NSString *currentURLString;
@end

@implementation UIImageView (WebCache)

//在分类中增加属性，必须自己写属性的getter和setter方法
- (NSString *)currentURLString {
    return objc_getAssociatedObject(self, HMMYKEY);
}

- (void)setCurrentURLString:(NSString *)currentURLString {
    objc_setAssociatedObject(self, HMMYKEY, currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setImageUrlString:(NSString *)urlString {
    //判断当前点击的图片地址，和上一次图片的地址，是否一样，如果不一样，取消上一次操作
    if (![urlString isEqualToString:self.currentURLString]) {
        //取消上一次操作
        //        [self.operationCache[self.currentURLString] cancel];
        
        [[HMDownloaderOperationManager sharedManager] cancelOperation:self.currentURLString];
    }
    
    
    //记录当前点击图片的地址
    self.currentURLString = urlString;
    
    //下载图片
    [[HMDownloaderOperationManager sharedManager] downloadWithURLString:urlString finishedBlock:^(UIImage *img) {
        self.image = img;
    }];

}
@end
