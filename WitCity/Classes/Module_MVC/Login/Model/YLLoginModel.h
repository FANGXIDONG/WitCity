//
//  YLLoginModel.h
//  HYB
//
//  Created by duyulong on 16/4/23.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLModel.h"

@interface YLLoginModel : YLModel

@property (nonatomic, copy) NSString *username;       //用户名
@property (nonatomic, copy) NSString *vercode;        //验证码
@property (nonatomic, copy) NSString *nickname;       //用户昵称 公司名称
@property (nonatomic, copy) NSString *password;       //密码
@property (nonatomic, copy) NSString *passwordConfirm;//确认密码

@property (nonatomic, strong) NSNumber *userType;    //用户类型 个人 公司

@end
