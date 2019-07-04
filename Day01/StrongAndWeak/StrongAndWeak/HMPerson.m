//
//  HMPerson.m
//  StrongAndWeak
//
//  Created by QinTuanye on 2019/7/4.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "HMPerson.h"

@implementation HMPerson

+ (instancetype)personWithName:(NSString *)name {
    HMPerson *person = [[HMPerson new] autorelease];
    person.name = name;
    
    return person;
}

@end
