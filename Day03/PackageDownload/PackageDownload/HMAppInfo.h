//
//  HMAppInfo.h
//  05-异步下载网络图片
//
//  Created by Apple on 15/10/16.
//  Copyright © 2015年 heima. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HMAppInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *download;



+ (instancetype)appInfoWithDic:(NSDictionary *)dic;
//获取所有的模型数据
+ (NSArray *)appInfos;
@end
