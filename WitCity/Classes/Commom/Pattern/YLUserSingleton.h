//
//  FJZUserSingleton.h
//  FJZ
//
//  Created by duyulong on 11/27/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLModel.h"

@interface YLUserSingleton : YLModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *usertype;
@property (nonatomic, copy) NSString *outh; //权限1可以看到 ，2不可看到通讯录按钮
@property (nonatomic, copy) NSString *percent;//资料完善度
@property (nonatomic, copy) NSString *is_check;//0未认证1已认证

- (void)clearUserInfo;

+(YLUserSingleton *)shareInstance;

@end
