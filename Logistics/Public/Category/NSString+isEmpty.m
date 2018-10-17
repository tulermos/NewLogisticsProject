//
//  NSString+isEmpty.m
//  Logistics
//
//  Created by tulemos on 2018/10/17.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "NSString+isEmpty.h"

@implementation NSString (isEmpty)

+(BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end
