//
//  HomeHttpUtil.h
//  WitCity
//
//  Created by duyulong on 16/5/30.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "WCBaseHttpUtil.h"

@interface YLHomeHttpUtil : WCBaseHttpUtil

//获取banner
+ (void)bannerWithBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取分类
+ (void)categoryWithId:(NSNumber *)uid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取办事内容列表
+ (void)officeListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取企业列表
+ (void)enterpriseListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取企业通讯录列表
+ (void)enterpriseContactsListBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//验证用户密码接口
+ (void)enterpriserUserPasswordWithUid:(NSString *)u_id password:(NSString *)password block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
// 检索通讯录
+ (void)searchContactsWithKey:(NSString *)key type:(NSString *)type block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取政策列表
+ (void)policyListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取互动列表
+ (void)interactionListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取互动详情
+ (void)interactionDetailWithId:(NSString *)Id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取搜索关键词
+ (void)searchKeysWithCid:(NSString *)cid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取搜索结果
+ (void)searchResultWithKey:(NSString *)key cid:(NSString *)cid page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//===============================
//改版后：企业列表
+ (void)getEnterpriseListWithUser_id:(NSString *)user_id reg_type:(NSString *)reg_type industry:(NSString *)industry reg:(NSString *)reg page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//搜索企业列表
+ (void)searchEnterpriseListWithUser_id:(NSString *)user_id key:(NSString *)key page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
@end











