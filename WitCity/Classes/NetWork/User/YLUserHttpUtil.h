//
//  RYUserHttpUtil.h
//  TongHua
//
//  Created by simpletour on 16/2/3.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "WCBaseHttpUtil.h"

@interface YLUserHttpUtil : WCBaseHttpUtil

//登录
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//注册
+ (void)registerWithUsername:(NSString *)username password:(NSString *)password msgCode:(NSString *)msgCode type:(NSNumber *)type nickname:(NSString *)nickname block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//忘记密码
+(void)forgetPasswordWithUsername:(NSString *)username password:(NSString *)password msgCode:(NSString *)msgCode block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//修改密码
+ (void)changePasswordWithOriginPassword:(NSString *)originPassword newPassword:(NSString *)newPassword block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取短信验证码
+ (void)msgCodeWithUsername:(NSString *)username block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取用户信息
+ (void)userInfoWithUsername:(NSString *)username block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//编辑昵称
+ (void)editNicknameWithName:(NSString *)name block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//上传头像
+ (void)uploadAvatarWithImage:(UIImage *)image block:(void(^)(NSString *avatar))block;

//收藏列表
+ (void)collectListWithCategoryId:(NSString *)categoryId page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//发帖列表
+ (void)invitationListWithPage:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//回复列表
+ (void)replyListWithPage:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//系统消息列表
+ (void)sysMsgListWithPage:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


//收藏
+ (void)collectWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//取消收藏
+ (void)collectCancelWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//意见反馈
+ (void)feedbackWithTelephone:(NSString *)telephone content:(NSString *)content block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//回复
+ (void)replyWithReplyId:(NSString *)replyId cid:(NSString *)cid content:(NSString *)content block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//发表帖子
+ (void)postWithTitle:(NSString *)title content:(NSString *)content block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取公司注册类型
+(void)getCompanyRegisterTypeblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取公司行业类型
+(void)getCompanyIndustryblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取个人中心企业资料
+ (void)getEnterpriseDatablock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取个人中心认证资料
+ (void)getEnterpriseAuthblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**
 *  企业资料完善接口
 *  user_id  用户id
 *  reg_type 注册类型id
 *  industry 行业类型id
 *  contn    联系人姓名
 *  contp    联系人电话
 *  address  公司地址
 *  des      公司简介
 *  thumb    图片  file
 */
+ (void)editEnterpriseDataWithUser_id :(NSString *)user_id reg_type:(NSString *)reg_type industry:(NSString *)industry contn:(NSString *)contn contp:(NSString *)contp address:(NSString *)address des:(NSString *)des thumb:(NSArray *)thumb block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//企业认证接口
+ (void)enterpriseAuthWithUser_id:(NSString *)user_id reg_num:(NSString *)reg_num owner_name:(NSString *)owner_name owner_idcard:(NSString *)owner_idcard owner_phone:(NSString *)owner_phone block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
@end








