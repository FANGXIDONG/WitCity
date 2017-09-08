//
//  YLHook.h
//  HYB
//
//  Created by simpletour on 16/5/13.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLHook : NSObject

+ (void)hookWithClass:(Class)clazz originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
