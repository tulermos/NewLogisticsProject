//
//  JPushModel.m
//  Logistics
//
//  Created by meng wang on 2018/5/2.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "JPushModel.h"

@implementation JPushModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeBool:self.type forKey:@"type"];
    [aCoder encodeBool:self.isRead forKey:@"isRead"];
    [aCoder encodeObject:self.id forKey:@"id"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.type = [aDecoder decodeBoolForKey:@"type"];
        self.isRead = [aDecoder decodeBoolForKey:@"isRead"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
    }
    return self;
    
}




@end
