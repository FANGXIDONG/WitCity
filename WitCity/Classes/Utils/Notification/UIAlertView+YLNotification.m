//
//  UIAlertView+YLNotification.m
//  HYB
//
//  Created by simpletour on 16/5/13.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "UIAlertView+YLNotification.h"
#import "YLHook.h"

@implementation UIAlertView (YLNotification)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(show);
        SEL swizzledSelector = @selector(yl_show);
        [YLHook hookWithClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

- (void)yl_show
{
    if ([self.title isEqualToString:@"Notification"]) {
        self.title = @"通知";
    }
    
    [self yl_show];
}

@end
