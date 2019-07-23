//
//  HMAppInfoCell.m
//  05-异步下载网络图片
//
//  Created by Apple on 15/10/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMAppInfoCell.h"
#import "HMAppInfo.h"
#import "UIImageView+WebCache.h"
@interface HMAppInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *downloadView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation HMAppInfoCell

- (void)setAppInfo:(HMAppInfo *)appInfo {
    _appInfo = appInfo;
    self.nameView.text = appInfo.name;
    self.downloadView.text = appInfo.download;
    
    [self.iconView setImageUrlString:appInfo.icon];
    
}

@end
