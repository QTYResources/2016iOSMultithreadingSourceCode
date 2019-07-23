//
//  ViewController.m
//  UIImageViewCategary
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+WebCache.h"
#import "HMAppInfo.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //随机取一个模型
    int index = arc4random_uniform((u_int32_t)self.appInfos.count);
    HMAppInfo *appInfo = self.appInfos[index];
    
    //
    [self.imageview setImageUrlString:appInfo.icon];
    
}



@end

