//
//  NSString+Sandbox.h
//  14-获取沙盒目录
//
//  Created by Apple on 15/10/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Sandbox)
- (instancetype)appendCache;
- (instancetype)appendTemp;
- (instancetype)appendDocument;

@end
