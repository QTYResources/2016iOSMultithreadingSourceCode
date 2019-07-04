//
//  HMPerson.h
//  StrongAndWeak
//
//  Created by QinTuanye on 2019/7/4.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMPerson : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype)personWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
