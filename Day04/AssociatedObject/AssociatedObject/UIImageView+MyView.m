//
//  UIImageView+MyView.m
//  06-关联对象
//
//  Created by Apple on 15/10/17.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "UIImageView+MyView.h"
#import <objc/runtime.h>


//1 可以在运行期间给某个对象增加属性
//2 可以在运行期间获取某个对象的所有属性名称
//3 交换方法

@implementation UIImageView (MyView)

- (NSString *)urlString {
    return objc_getAssociatedObject(self, "str");
}

- (void)setUrlString:(NSString *)urlString {
    //可以在运行期间给某个对象增加属性
    //关联对象
    
    objc_setAssociatedObject(self, "str", urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

@end
