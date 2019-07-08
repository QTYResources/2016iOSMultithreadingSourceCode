//
//  Person.h
//  AttributeModifier
//
//  Created by QinTuanye on 2019/7/8.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
