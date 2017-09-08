//
//  HomeHttpUtil.m
//  WitCity
//
//  Created by duyulong on 16/5/30.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLHomeHttpUtil.h"
#import "YLUserSingleton.h"

@implementation YLHomeHttpUtil

//获取banner
+ (void)bannerWithBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    [self postWithAction:HTTP_BANNER_LIST params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//获取分类
+ (void)categoryWithId:(NSNumber *)uid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"cat_id" value:uid];
    
    [self postWithAction:HTTP_CATEGORY params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//获取办事内容列表
+ (void)officeListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_OFFICE_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//获取政策列表
+ (void)policyListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_POLICY_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//获取企业列表
+ (void)enterpriseListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_ENTERPRISE_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//获取企业通讯录列表
+ (void)enterpriseContactsListBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    [self postWithAction:HTTP_ENTERPRISE_CONTACTSLIST params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//验证用户密码接口
+ (void)enterpriserUserPasswordWithUid:(NSString *)u_id password:(NSString *)password block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"uid" value:u_id];
    [self setWithMutableDict:md key:@"pwd" value:password];
    
    [self postWithAction:HTTP_CHECK_PWD params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//获取互动列表
+ (void)interactionListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"cat_id" value:categoryId];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_INTERACTION_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"hudpng:%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//获取互动详情
+ (void)interactionDetailWithId:(NSString *)Id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"c_id" value:Id];
    
    [self postWithAction:HTTP_INTERACTION_DETAIL params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"hudpng:%@",result.contentlist);

            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//获取搜索关键词
+ (void)searchKeysWithCid:(NSString *)cid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"cat_id" value:cid];
    
    [self postWithAction:HTTP_SEARCH_HOT_KEY params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

// 检索通讯录

+ (void)searchContactsWithKey:(NSString *)key type:(NSString *)type block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    int ty = [type intValue];
    NSLog(@"=================ty:%d",ty);
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"key" value:key];
    [self setWithMutableDict:md key:@"type" value:@(ty)];
    
    [self postWithAction:HTTP_CONTACTTYPE_SEARCH params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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


//获取搜索结果
+ (void)searchResultWithKey:(NSString *)key cid:(NSString *)cid page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"key" value:key];
    [self setWithMutableDict:md key:@"cat_id" value:cid];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    
    [self postWithAction:HTTP_SEARCH_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//===============================
//改版后：企业列表
+ (void)getEnterpriseListWithUser_id:(NSString *)user_id
                            reg_type:(NSString *)reg_type
                            industry:(NSString *)industry
                                 reg:(NSString *)reg
                                page:(NSInteger)page
                               block:(void(^)(NSDictionary *dict))dict
                             failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"user_id" value:@""];
    [self setWithMutableDict:md key:@"reg_type" value:reg_type];
    [self setWithMutableDict:md key:@"industry" value:industry];
    [self setWithMutableDict:md key:@"reg" value:reg];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self getWithAction:HTTP_ENTERPRISE_DATA_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//搜索企业列表
+ (void)searchEnterpriseListWithUser_id:(NSString *)user_id
                                    key:(NSString *)key
                                   page:(NSInteger)page
                                  block:(void(^)(NSDictionary *dict))dict
                                failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"key" value:key];
    [self setWithMutableDict:md key:@"user_id" value:user_id];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:HTTP_ENTERPRISE_SEARCH_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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






