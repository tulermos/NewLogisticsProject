//
//  UIAlertView+Block.h
//
//
//  Created by CHia on 15/10/27.
//  Copyright © 2015年 CHia. All rights reserved.
//

#import "UIAlertView+CHAlertAction.h"
#import <objc/runtime.h>

@implementation UIAlertView (CHAlertAction)


static char key;



- (void(^)(NSInteger buttonIndex))block
{
    return objc_getAssociatedObject(self, &key);;
}
- (void)setBlock:(void(^)(NSInteger buttonIndex))block
{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
    }
}


- (void)showWithBlock:(void(^)(NSInteger buttonIndex))block
{
    self.block = block;
    self.delegate = self;
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.block)
    {
        self.block(buttonIndex);
    }
    
    objc_removeAssociatedObjects(self);
}


@end
