//
//  DDUtils.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/31.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUtils : NSObject
//检测邮箱地址
+ (BOOL)checkEmailAddress:(NSString *)email;
//租金
+ (NSString *)priceStatusWithPrice:(NSString *)price;
//工资
+ (NSString *)salaryStatusWithSalary:(NSString *)salary;
//最高学历
+ (NSString *)eduStatusWithEdu:(NSString *)edu;
//工作经验
+ (NSString *)experienceStatusWithExp:(NSString *)exp;
//出租类型
+ (NSString *)rentTypeStatusWithRentType:(NSString *)type;
//类型
+ (NSString *)typeStatusWithType:(NSString *)type;
//房屋来源
+ (NSString *)sourceStatusWithSource:(NSString *)source;

+(NSString *)getSalaryFromStatusWithStatus:(NSString *)status;
+(NSString *)getExperienceFromStatusWithStatus:(NSString *)status;
+(NSString *)getEduFromStatusWithStatus:(NSString *)status;
@end













