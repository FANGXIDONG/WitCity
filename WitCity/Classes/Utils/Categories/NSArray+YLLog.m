//
//  NSArray+YLLog.m
//  FJZ
//
//  Created by simpletour on 15/12/31.
//  Copyright © 2015年 FJZ. All rights reserved.
//

#import "NSArray+YLLog.h"
#import <objc/runtime.h>


@implementation NSArray (YLLog)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"\t%@,\n", obj];
    }];
    [str appendString:@")"];
    return str;
}



@end
