//
//  HMAppInfo.h
//  SolveMisplacement
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMAppInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *download;

// 缓存图片
@property (nonatomic, strong) UIImage *image;

+ (instancetype)appInfoWithDic:(NSDictionary *)dic;
// 获取所有的模型数据
+ (NSArray *)appInfos;

@end

NS_ASSUME_NONNULL_END
