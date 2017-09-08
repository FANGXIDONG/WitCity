//
//  NSDictionary+YLLog.m
//  FJZ
//
//  Created by simpletour on 15/12/31.
//  Copyright © 2015年 FJZ. All rights reserved.
//

#import "NSDictionary+YLLog.h"

@implementation NSDictionary (YLLog)

-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [str appendString:@"}\n"];
    return str;
}

@end
