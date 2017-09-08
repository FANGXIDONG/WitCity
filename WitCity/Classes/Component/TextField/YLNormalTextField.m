//
//  XHNormalTextField.m
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLNormalTextField.h"

@interface YLNormalTextField()

@property (nonatomic, strong) UIView *leftCustomView;

@end

@implementation YLNormalTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addViews];
        [self useStyle];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addViews
{
    self.leftCustomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    [self.leftCustomView addSubview:self.imageView];
}

- (void)useStyle
{
    self.leftView = self.leftCustomView;
    self.leftViewMode = UITextFieldViewModeAlways;
    [self setValue:[UIColor colorWithHex:0x999999] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - 手机号验证
- (BOOL)validatePhone
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self.text];
}
//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
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
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
#pragma mark - 密码验证
- (BOOL)validatePassword
{
    if(self.text.length < 6 || self.text.length > 16) {
        return NO;
    }
    return YES;
}

@end
