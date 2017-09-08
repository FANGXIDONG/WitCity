//
//  YLValidateManager.m
//  HYB
//
//  Created by duyulong on 16/4/30.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLValidateManager.h"
#import "YLToast.h"


@interface YLValidateManager ()

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation YLValidateManager

-(instancetype)initWithController:(UIViewController *)vc
{
    self  = [super init];
    if(self) {
        self.vc = vc;
    }
    return self;
}


- (BOOL)validateLoginWithModel:(YLLoginModel *)model {
    UIView *view = self.vc.view;
    if (model.username.length <= 0) {
        [YLToast showToastWithView:view text:@"请输入手机号"];
        return NO;
    }
    
    if (model.password.length <= 0) {
        [YLToast showToastWithView:view text:@"请输入密码"];
        return NO;
    }
    
    if (![self validatePhoneWithPhone:model.username]) {
        [YLToast showToastWithView:view text:@"请输入正确的手机号"];
        return NO;
    }
    
    
    if (model.password.length <6 || model.password.length > 20) {
        [YLToast showToastWithView:view text:@"密码为6-20位字母加数字"];
        return NO;
    }
    
    return YES;
}


- (BOOL)validateForgetPasswordWithModel:(YLLoginModel *)model
{
    UIView *view = self.vc.view;
    if (model.username.length <= 0) {
        [YLToast showToastWithView:view text:@"请输入手机号"];
        return NO;
    }
    if (model.vercode.length <= 0) {
        [YLToast showToastWithView:view text:@"请输入验证码"];
        return NO;
    }
    if (model.password.length <= 0) {
        [YLToast showToastWithView:view text:@"请输入密码"];
        return NO;
    }

    if (![self validatePhoneWithPhone:model.username]) {
        [YLToast showToastWithView:view text:@"请输入正确的手机号"];
        return NO;
    }
    
    if (model.vercode.length != 6) {
        [YLToast showToastWithView:view text:@"验证码只能为6位"];
        return NO;
    }
    
    if (model.password.length <6 || model.password.length > 20) {
        [YLToast showToastWithView:view text:@"密码为6-20位字母加数字"];
        return NO;
    }
  
    
    return YES;
}


- (BOOL)validateVercodeWithPhone:(NSString *)phone
{
    UIView *view = self.vc.view;
    if (phone.length <= 0) {
        [YLToast showToastWithView:view text:@"请输入手机号"];
        return NO;
    }
    
    if (![self validatePhoneWithPhone:phone]) {
        [YLToast showToastWithView:view text:@"请输入正确的手机号"];
        return NO;
    }
    return YES;
}

- (BOOL)validateRegisterWithModel:(YLLoginModel *)model
{
    return [self validateForgetPasswordWithModel:model];
}

- (BOOL)validatePhoneWithPhone:(NSString *)phone
{
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [pred evaluateWithObject:phone];
}

@end
