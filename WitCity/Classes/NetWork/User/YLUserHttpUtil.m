//
//  RYUserHttpUtil.m
//  TongHua
//
//  Created by simpletour on 16/2/3.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "YLUserHttpUtil.h"
#import "YLUserSingleton.h"
#import "YLMacro.h"
#import "UMessage.h"

@implementation YLUserHttpUtil

//登录
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"phone" value:username];
    [self setWithMutableDict:md key:@"pwd" value:[password md5]];
    
    [self postWithAction:HTTP_LOGIN params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSDictionary *d = result.contentlist;
            NSLog(@"%@",d);
            YLUserSingleton *user = [YLUserSingleton shareInstance];
            user = [YLUserSingleton mj_objectWithKeyValues:d];
            [ND postNotificationName:kUpdateUserInfoNotification object:nil];
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}



//注册
+ (void)registerWithUsername:(NSString *)username password:(NSString *)password msgCode:(NSString *)msgCode type:(NSNumber *)type nickname:(NSString *)nickname block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSDictionary *d = @{
                        @"phone":username,
                        @"pwd":[password md5],
                        @"code":msgCode,
                        @"usertype" : type,
                        @"name" : nickname,
                        };
    
    [self postWithAction:HTTP_REGISTER params:d type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}


//忘记密码
+(void)forgetPasswordWithUsername:(NSString *)username password:(NSString *)password msgCode:(NSString *)msgCode block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSDictionary *d = @{
                        @"phone":username,
                        @"npwd":[password md5],
                        @"code":msgCode,
                        };
    [self postWithAction:HTTP_FORGET_PASSWORD params:d type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//修改密码
+ (void)changePasswordWithOriginPassword:(NSString *)originPassword newPassword:(NSString *)newPassword block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"opwd" value:[originPassword md5]];
    [self setWithMutableDict:md key:@"npwd" value:[newPassword md5]];
    
    [self postWithAction:HTTP_CHANGE_PASSWORD params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}


//获取短信验证码
+ (void)msgCodeWithUsername:(NSString *)username block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"phone" value:username];
    
    [self postWithAction:HTTP_SMS_CODE params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//获取用户信息
+ (void)userInfoWithUsername:(NSString *)username block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"id" value:username];
    [self postWithAction:HTTP_PERSON_INFO params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSDictionary *d = result.contentlist;
            YLUserSingleton *user = [YLUserSingleton shareInstance];
            user = [YLUserSingleton mj_objectWithKeyValues:d];
            [ND postNotificationName:kUpdateUserInfoNotification object:nil];
            dict(d);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//编辑昵称
+ (void)editNicknameWithName:(NSString *)name block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"name" value:name];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    
    [self postWithAction:HTTP_CHANGE_NICKNAME params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//编辑手机号

//上传头像
+ (void)uploadAvatarWithImage:(UIImage *)image block:(void(^)(NSString *avatar))block
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"mime" value:@"png"];
    
    [self uploadImageWithAction:HTTP_PERSON_AVATAR params:md image:image success:^(id responseObject) {
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        NSLog(@"avatar responseObject = %@", responseObject);
        block(result.contentlist);
        YLUserSingleton *user = [YLUserSingleton shareInstance];
        user.avatar = result.contentlist[@"url"];
        [ND postNotificationName:kUpdateUserInfoNotification object:nil];
        
    } fail:^{
    }];
}

//收藏列表
+ (void)collectListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_COLLECT_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//发帖列表
+ (void)invitationListWithPage:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_MESSAGE_PUBLISH_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}
//回复列表
+ (void)replyListWithPage:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_MESSAGE_REPLY_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//系统消息列表
+ (void)sysMsgListWithPage:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_MESSAGE_SYSTEM params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}



//意见反馈
+ (void)feedbackWithTelephone:(NSString *)telephone content:(NSString *)content block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"telephone" value:telephone];
    [self setWithMutableDict:md key:@"content" value:content];
    
    [self postWithAction:HTTP_FEED_BACK params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//收藏
+ (void)collectWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"c_id" value:contentId];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    
    [self postWithAction:HTTP_COLLECT_ADD params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//取消收藏
+ (void)collectCancelWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"c_id" value:contentId];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    
    [self postWithAction:HTTP_COLLECT_CANCEL params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//回复
+ (void)replyWithReplyId:(NSString *)replyId cid:(NSString *)cid content:(NSString *)content block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"c_id" value:cid];
    [self setWithMutableDict:md key:@"reply_id" value:replyId];
    [self setWithMutableDict:md key:@"content" value:content];
    
    [self postWithAction:HTTP_INTERACTION_REPLY params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}


//发表帖子
+ (void)postWithTitle:(NSString *)title content:(NSString *)content block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"title" value:title];
    [self setWithMutableDict:md key:@"content" value:content];
    
    [self postWithAction:HTTP_INTERACTION_PUBLISH params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}
//获取个人中心企业资料
+ (void)getEnterpriseDatablock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"user_id" value:[YLUserSingleton shareInstance].uid];
    
    [self postWithAction:HTTP_ENTERPRISE_DATA params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}
//获取个人中心认证资料
+ (void)getEnterpriseAuthblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"user_id" value:[YLUserSingleton shareInstance].uid];
    
    [self postWithAction:HTTP_ENTERPRISE_AUTH_DATA params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//企业资料完善接口
+ (void)editEnterpriseDataWithUser_id :(NSString *)user_id
                              reg_type:(NSString *)reg_type
                              industry:(NSString *)industry
                                 contn:(NSString *)contn
                                 contp:(NSString *)contp
                               address:(NSString *)address
                                   des:(NSString *)des
                                 thumb:(NSArray *)thumb
                                 block:(void(^)(NSDictionary *dict))dict
                               failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"user_id" value:user_id];
    [self setWithMutableDict:md key:@"reg_type" value:reg_type];
    [self setWithMutableDict:md key:@"industry" value:industry];
    [self setWithMutableDict:md key:@"contn" value:contn];
    [self setWithMutableDict:md key:@"contp" value:contp];
    [self setWithMutableDict:md key:@"address" value:address];
    [self setWithMutableDict:md key:@"des" value:des];
    
    [self uploadMultiImageWithAction:HTTP_ENTERPRISE_EDIT params:md images:thumb success:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } fail:^{
        failure();
    }];
}

//企业认证接口
+ (void)enterpriseAuthWithUser_id:(NSString *)user_id
                          reg_num:(NSString *)reg_num
                       owner_name:(NSString *)owner_name
                     owner_idcard:(NSString *)owner_idcard
                      owner_phone:(NSString *)owner_phone
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"user_id" value:user_id];
    [self setWithMutableDict:md key:@"reg_num" value:reg_num];
    [self setWithMutableDict:md key:@"owner_name" value:owner_name];
    [self setWithMutableDict:md key:@"owner_idcard" value:owner_idcard];
    [self setWithMutableDict:md key:@"owner_phone" value:owner_phone];
    
    [self postWithAction:HTTP_ENTERPRISE_AUTH params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}
//获取公司注册类型
+(void)getCompanyRegisterTypeblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    [self postWithAction:HTTP_ENTERPRISE_REG_TYPE params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//获取公司行业类型
+(void)getCompanyIndustryblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    [self postWithAction:HTTP_ENTERPRISE_INDUSTRY params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

@end






