//
//  NetworkTools.h
//  SingleCase
//
//  Created by QinTuanye on 2019/7/22.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTools : NSObject

// 单例的方法
+ (instancetype)sharedNetworkTools;
+ (instancetype)sharedNetworkToolsOnce;

@end

NS_ASSUME_NONNULL_END
