//
//  DDDateTimeHelper.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDDateTimeHelper.h"

@implementation DDDateTimeHelper

+ (NSString *)htcTimeToLocationStr:(NSDate*)curDate
{
    if (curDate==nil) {
        return @"";
    }
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fixString = [dateFormatter stringFromDate:curDate];
    return fixString;
}


@end
