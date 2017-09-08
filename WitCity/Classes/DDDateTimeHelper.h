//
//  DDDateTimeHelper.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDDateTimeHelper : NSObject

//转换成北京时间字符串
+ (NSString *)htcTimeToLocationStr:(NSDate*)curDate;
@end
