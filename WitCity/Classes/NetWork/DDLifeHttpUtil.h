//
//  DDLifeHttpUtil.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/7.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "WCBaseHttpUtil.h"

@interface DDLifeHttpUtil : WCBaseHttpUtil

//=============================== 社区 ==============================

//获取招聘列表
+ (void)recruitListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取求职列表
+ (void)jobSeekListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取出租列表
+ (void)rentOutListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取求租列表
+ (void)rentWantListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取柳梧圈列表
+ (void)LWQListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


//获取职位详情

//获取简历详情

//获取出租详情

//获取求租详情

//柳梧圈详情


//获取公交车列表
+ (void)getBusListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取公交车搜索结果
+ (void)getBusSearchResultWithKeyword:(NSString *)key page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取天气
+ (void)getWeatherWithCityId:(NSInteger)cityId Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//获取新闻、广告

+ (void)getNewsAndAdsBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取市民热线数据
+ (void)getHotlineDataBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//获取柳梧圈详情
+ (void)getLwqCommentDetailDataWithUrl:(NSString *)url circle_id:(NSString *)circle_id Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//出租详情
+(void)getRentoutDetailDataWithLease_id:(NSString *)lease_id Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//---------------------------------- 发布 ---------------------------------------------------
/**
 * 发布柳梧圈
 *
 * @u_id      用户id
 * @title     标题
 * @content   内容
 * @thumbFile 图片
 * @author  fangdongdong
 *
 */
+ (void)publishLwqWithtitle:(NSString *)title content:(NSString *)content thumbFile:(NSArray *)images Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//发布出租
//Thumb 	Array	图片(thumb1,thumb2…)
+ (void)publishRentOutWithTitle:(NSString *)title address:(NSString *)address price:(NSString *)price type:(NSString *)type source:(NSString *)source floor:(NSString *)floor config:(NSString *)config summary:(NSString *)summary thumb:(NSArray *)thumb person:(NSString *)person phone:(NSString *)phone Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//发布求租
+ (void)publishRentWantWithTitle:(NSString *)title area:(NSString *)area type:(NSString *)type price:(NSString *)price summary:(NSString *)summary person:(NSString *)person phone:(NSString *)phone Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//发布招聘
//Worktype	int	1全职 2兼职3实习
+ (void)publishRecruitWithThumb:(NSString *)thumb business:(NSString *)business position:(NSString *)position workrequire:(NSString *)workrequire address:(NSString *)address salary:(NSString *)salary exep:(NSString *)exep edu:(NSString *)edu worktype:(NSString *)worktype attact:(NSString *)attact industry:(NSString *)insustry quality:(NSString *)quality size:(NSString *)size summary:(NSString *)summary person:(NSString *)person phone:(NSString *)phone Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//发布求职
//Gender	Int	1男 2女
//Birth	Time	出生日期Yyyy mm dd
//history	Array	工作经历
//history	company	Varchar	公司名称
//wtime	Varchar	工作时段
//work	Varchar	工作内容
//Job	Varchar	期望工作
//Worktype	Int	1全职2兼职

+ (void)publishJobSeekWithName:(NSString *)name gender:(NSString *)gender college:(NSString *)college edu:(NSString *)edu birth:(NSString *)birth phone:(NSString *)phone email:(NSString *)email exep:(NSString *)exep history:(NSArray *)history job:(NSString *)job worktype:(NSString *)worktype salary:(NSString *)salary Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


//--------------------------------------------------------------------------------------------

//-------------------- 医保社保 -----------------
//获取市民社保订购关系
+ (void)getSocialInsuranceRelationshipWithPhone:(NSString *)phone Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//医保通订购
+ (void)orderSocialInsuranceWithSocialNumber:(NSString *)socialNum orSocialCardNumber:(NSString *)socialCardNum Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//查询医保通消费详情
+ (void)inquireSocialInsuranceConsumeDetailBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//查询医保卡余额以及本月消费
+ (void)inquireSocialInsuranceCardMoneyDetailBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//-------------------- 我的发帖 -----------------
//我的发帖(求职)
+ (void)getMySendNotesOfJobwantWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//我的发帖（求租）
+ (void)getMySendNotesOfRentwantWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//我的发帖（招聘）
+ (void)getMySendNotesOfRecruitWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//我的发帖（出租）
+ (void)getMySendNotesOfRentoutWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//我的发帖（柳梧圈）
+ (void)getMySendNotesOfLWQWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//删除求租
+ (void)deleteNotesOfRentWantWithId:(NSString *)qzu_id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//删除出租
+ (void)deleteNotesOfRentOutWithId:(NSString *)lease_id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//删除柳梧圈
+ (void)deleteNotesOfLWQWithId:(NSString *)circle_id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//更改招聘显示状态
+ (void)transferRecruitShowWithId:(NSString *)recruit_id status:(NSString *)status block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
//更改求职显示状态
+ (void)transferJobwantShowWithId:(NSString *)qzhi_id status:(NSString *)status block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


//我的消息 - 我的回复
+ (void)myReplyMessagesWithUid:(NSString *)uid page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

//我的消息 - 系统消息
+ (void)systemMessagesWithUid:(NSString *)uid page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**
 *  充值生成订单接口
 *  body 商品描述
 *  money 充值金额
 *  price 充值金额（实际支付，分为单位）
 *  phone 充值电话
 *  prodid 产品id
 *  filltype 充值类型（默认KC）
 *  incretype 充值商品类型（默认 phoneincrement）
 */
+(void)createRechargePrepayidWithUid:(NSString *)uid Body:(NSString *)body money:(NSString *)money phone:(NSString *)phone prodid:(NSString *)prodid filltype:(NSString *)filltype incretype:(NSString *)incretype block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


////后台入库生成订单
//+(void)createOrderFortoDBWithUid:(NSString *)uid orderid:(NSString *)orderid phone:(NSString *)phone
//block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
@end








