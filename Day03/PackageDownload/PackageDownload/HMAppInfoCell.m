//
//  HMAppInfoCell.m
//  05-异步下载网络图片
//
//  Created by Apple on 15/10/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMAppInfoCell.h"
#import "HMAppInfo.h"
@interface HMAppInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *downloadView;

@end

@implementation HMAppInfoCell

- (void)setAppInfo:(HMAppInfo *)appInfo {
    _appInfo = appInfo;
    self.nameView.text = appInfo.name;
    self.downloadView.text = appInfo.download;
    
}

@end
