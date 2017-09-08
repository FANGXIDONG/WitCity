//
//  DDUtils.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/31.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDUtils.h"
//出租类型(1主卧-合租2次卧-合租3一室-整租4两室-整租5三室-整租6四室-整租7四室以上-整租。)
//工资标准：
//1.  2K以下    2  .2K-3K    3.  3K-5K    4.  5K-8K    5.  8K-10K
//6.  10K以上    7.  面议。
//最高学历：1高中2中专3大专4本科5硕士6博士7博士后8学历不限
//工作经验：1、无经验2、 1年以下3、1-3年4、3-5年5、5年以上;
//租金选项：1、1k元以下2、1k-1.5k元3、1.5k-2k元4、2k-3k元5、3k-5k元6、5k元-8k元7、8k以上
//付款方式：1月付2、季度付3、半年付4、年付。
@implementation DDUtils
//检测邮箱地址
+ (BOOL)checkEmailAddress:(NSString *)email
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:email];
}
//租金
+ (NSString *)priceStatusWithPrice:(NSString *)price{
    
    NSString *status;
    if ([price isEqualToString:@"1k以下"]) {
        status  =@"1";
    }else if ([price isEqualToString:@"1k-1.5k"]){
        status  =@"2";
    }else if ([price isEqualToString:@"1.5k-2k"]){
        status  =@"3";
    }else if ([price isEqualToString:@"2k-3k"]){
        status  =@"4";
    }else if ([price isEqualToString:@"3k-5k"]){
        status  =@"5";
    }else if ([price isEqualToString:@"5k-8k"]){
        status  =@"6";
    }else if ([price isEqualToString:@"8k以上"]){
        status  =@"7";
    }else{
        
    }
    return status;
}
//工资
//工资标准：
//1.  2K以下    2  .2K-3K    3.  3K-5K    4.  5K-8K    5.  8K-10K
//6.  10K以上    7.  面议。
+ (NSString *)salaryStatusWithSalary:(NSString *)salary{
    
    NSString *status;
    if ([salary isEqualToString:@"2k以下"]) {
        status  =@"1";
    }else if ([salary isEqualToString:@"2k-3k"]){
        status  =@"2";
    }else if ([salary isEqualToString:@"3k-5k"]){
        status  =@"3";
    }else if ([salary isEqualToString:@"5k-8k"]){
        status  =@"4";
    }else if ([salary isEqualToString:@"8k-10k"]){
        status  =@"5";
    }else if ([salary isEqualToString:@"10k以上"]){
        status  =@"6";
    }else if ([salary isEqualToString:@"面议"]){
        status  =@"7";
    }else{
        
    }
    return status;
}
+(NSString *)getSalaryFromStatusWithStatus:(NSString *)status{
    NSString *salary;
    if ([status isEqualToString:@"1"]) {
        salary  =@"2k以下";
    }else if ([status isEqualToString:@"2"]){
        salary  =@"2k-3k";
    }else if ([status isEqualToString:@"3"]){
        salary  =@"3k-5k";
    }else if ([status isEqualToString:@"4"]){
        salary  =@"5k-8k";
    }else if ([status isEqualToString:@"5"]){
        salary  =@"8k-10k";
    }else if ([status isEqualToString:@"6"]){
        salary  =@"10k以上";
    }else if ([status isEqualToString:@"7"]){
        salary  =@"面议";
    }else{
        
    }
    return salary;
}
//最高学历
//最高学历：1高中2中专3大专4本科5硕士6博士7博士后8学历不限
+ (NSString *)eduStatusWithEdu:(NSString *)edu{
    NSString *status;
    if ([edu isEqualToString:@"高中"]) {
        status  =@"1";
    }else if ([edu isEqualToString:@"中专"]){
        status  =@"2";
    }else if ([edu isEqualToString:@"大专"]){
        status  =@"3";
    }else if ([edu isEqualToString:@"本科"]){
        status  =@"4";
    }else if ([edu isEqualToString:@"硕士"]){
        status  =@"5";
    }else if ([edu isEqualToString:@"博士"]){
        status  =@"6";
    }else if ([edu isEqualToString:@"博士后"]){
        status  =@"7";
    }else if ([edu isEqualToString:@"学历不限"]){
        status  =@"8";
    }else{
        
    }
    return status;
}
+(NSString *)getEduFromStatusWithStatus:(NSString *)status{
    NSString *edu;
    if ([status isEqualToString:@"高中"]) {
        edu  =@"高中";
    }else if ([status isEqualToString:@"中专"]){
        edu  =@"中专";
    }else if ([status isEqualToString:@"大专"]){
        edu  =@"大专";
    }else if ([status isEqualToString:@"本科"]){
        edu  =@"本科";
    }else if ([status isEqualToString:@"硕士"]){
        edu  =@"硕士";
    }else if ([status isEqualToString:@"博士"]){
        edu  =@"博士";
    }else if ([status isEqualToString:@"博士后"]){
        edu  =@"博士后";
    }else if ([status isEqualToString:@"学历不限"]){
        edu  =@"学历不限";
    }else{
        
    }
    return edu;
}
//工作经验
//工作经验：1、无经验2、 1年以下3、1-3年4、3-5年5、5年以上;
+ (NSString *)experienceStatusWithExp:(NSString *)exp{
    NSString *status;
    if ([exp isEqualToString:@"无经验"]) {
        status  =@"1";
    }else if ([exp isEqualToString:@"1年以下"]){
        status  =@"2";
    }else if ([exp isEqualToString:@"1-3年"]){
        status  =@"3";
    }else if ([exp isEqualToString:@"3-5年"]){
        status  =@"4";
    }else if ([exp isEqualToString:@"5年以上"]){
        status  =@"5";
    }else{
        
    }
    return status;
}
+(NSString *)getExperienceFromStatusWithStatus:(NSString *)status{
    NSString *exp;
    if ([status isEqualToString:@"无经验"]) {
        exp  =@"无经验";
    }else if ([status isEqualToString:@"1年以下"]){
        exp  =@"年以下";
    }else if ([status isEqualToString:@"1-3年"]){
        exp  =@"1-3年";
    }else if ([status isEqualToString:@"3-5年"]){
        exp  =@"3-5年";
    }else if ([status isEqualToString:@"5年以上"]){
        exp  =@"5年以上";
    }else{
        
    }
    return exp;
}

//出租类型
//出租类型(1主卧-合租2次卧-合租3一室-整租4两室-整租5三室-整租6四室-整租7四室以上-整租。)
+ (NSString *)rentTypeStatusWithRentType:(NSString *)type{
    NSString *status;
    if ([type isEqualToString:@"主卧-合租"]) {
        status  =@"1";
    }else if ([type isEqualToString:@"次卧-合租"]){
        status  =@"2";
    }else if ([type isEqualToString:@"一室-整租"]){
        status  =@"3";
    }else if ([type isEqualToString:@"两室-整租"]){
        status  =@"4";
    }else if ([type isEqualToString:@"三室-整租"]){
        status  =@"5";
    }else if ([type isEqualToString:@"四室-整租"]){
        status  =@"6";
    }else if ([type isEqualToString:@"四室以上-整租"]){
        status  =@"7";
    }else{
        
    }
    return status;
}
//类型
+ (NSString *)typeStatusWithType:(NSString *)type{
    NSString *status;
    if ([type isEqualToString:@"全职"]) {
        status  =@"1";
    }else if ([type isEqualToString:@"兼职"]){
        status  =@"2";
    }else if ([type isEqualToString:@"实习"]){
        status  =@"3";
    }else{
        
    }
    return status;
}
//房屋来源
+ (NSString *)sourceStatusWithSource:(NSString *)source{
    NSString *status;
    if ([source isEqualToString:@"房东"]) {
        status  =@"1";
    }else if ([source isEqualToString:@"中介"]){
        status  =@"2";
    }else{
        
    }
    return status;
}
@end
