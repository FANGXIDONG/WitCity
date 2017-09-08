//
//  YLHttpUrl.h
//  TongHua
//
//  Created by simpletour on 16/2/3.
//  Copyright © 2016年 RY. All rights reserved.
//

#ifndef YLHttpUrl_h
#define YLHttpUrl_h

#define kYLLoginTest 0

//主机
//company
//#define HTTP_HOST (@"http://111.11.196.68/xzzhcs/index.php")

//企业测试地址
#define Http_test_hotst  (@"http://t.zhcs.cmtibet.com/index.php")

#define HTTP_HOST  (@"http://p.zhcs.cmtibet.com/")

//------------------------------------------------------------------
//----------------------------- 组团钟（美团） ------------------------------

//组团钟正式服务器: http://www.zutuanzhong.com
#define ZUTUAN_HTTP_HOST  (@"http://www.zutuanzhong.com/")
//测试服务器:  http://test.zutuanzhong.com
#define ZUTUAN_HTTP_TESTHOST (@"http://test.zutuanzhong.com/")

/*
* 用于构造令牌的密钥
*/
#define SECTRCT_KEY_TOKEN  @"13b8fd568f7a7f3964de5cc1e38fd3e4"
/***
 * 合作帐号id
 */
#define INNDER_ACCOUNT_ID  @"10086"

#define ZUTUAN_TOKEN  @"a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ"

/**
 *  关于构造令牌
 *  令牌的构造：encode(md5(账号+秘钥) + 请求时间(Unix时间) ，账号)
 *  说明：
 *  1.MD5是要生成32位
 *  2.这里的encode(md5(账号+秘钥) + 请求时间(Unix时间)，账号)；  账号+秘钥，是按照字符串拼接的
 *  3.这里讲账号和秘钥做md5之后与毫秒时间戳拼接成新的字符串，作为encode的第一个参数再把账号做第二个参数，传入encode方法，生成令牌。
 *
 */

#define ZUTUAN_HTTP_INFO      (@"api/index.php?q=json/oauth/tg/search")

#define ZUTUAN_HTTP_HOMELIST  (@"api/index.php?q=json/oauth/seller/getList")



//美食
#define ZUTUAN_DELICIOUSFOODS   @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=tglist&opt={%22cate%22:3}"


//娱乐
#define ZUTAUN_ENTERPRISE  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=tglist&opt={%22cate%22:4}"

//酒店
#define ZUTUAN_HOTEL   @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=tglist&opt={%22cate%22:7}"

//景点
#define ZUTUAN_SENSES   @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=tglist&opt={%22cate%22:90}"

//全部订单
#define ZUTUAN_PREPARE_ALLORDERS  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A0%7D"

//待付款
#define ZUTUAN_PREPARE_PAY  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A1%7D"

//待发货
#define ZUTUAN_PREPARE_SEND  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A2%7D"

//待确认
#define ZUTUAN_PREPARE_CONFIRM  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A3%7D"

//待评价
#define ZUTUAN_PREPARE_COMMENT  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A4%7D"

//退款
#define ZUTUAN_PREPARE_RETURN   @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A5%7D"

//待付款:http://test.zutuanzhong.com/bin/index.html?account=10086&token=276b8d36BVIFBgEGVAEHBlBWBwdTUQFWVgBbXQMDWgkODVwEWlcDAAYNDwYBDg&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A1%7D
//待发货:http://test.zutuanzhong.com/bin/index.html?account=10086&token=276b8d36BVIFBgEGVAEHBlBWBwdTUQFWVgBbXQMDWgkODVwEWlcDAAYNDwYBDg&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A2%7D
//待确认:http://test.zutuanzhong.com/bin/index.html?account=10086&token=276b8d36BVIFBgEGVAEHBlBWBwdTUQFWVgBbXQMDWgkODVwEWlcDAAYNDwYBDg&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A3%7D
//待评价:http://test.zutuanzhong.com/bin/index.html?account=10086&token=276b8d36BVIFBgEGVAEHBlBWBwdTUQFWVgBbXQMDWgkODVwEWlcDAAYNDwYBDg&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A4%7D
//退款:http://test.zutuanzhong.com/bin/index.html?account=10086&token=276b8d36BVIFBgEGVAEHBlBWBwdTUQFWVgBbXQMDWgkODVwEWlcDAAYNDwYBDg&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A5%7D
//全部订单:http://test.zutuanzhong.com/bin/index.html?account=10086&token=276b8d36BVIFBgEGVAEHBlBWBwdTUQFWVgBbXQMDWgkODVwEWlcDAAYNDwYBDg&tz=order&opt=%7B%22type%22%3A1%2C%22status%22%3A0%7D

//预约点餐

//同城配送


//-----------------------------------------------------------------
//-----------------------------------------------------------------



//======================== 企业版 ==================================================

/********************** 登录 ***************************/

//获取用户信息
#define HHTP_USER_INFO           (@"index.php?c=sc_user&m=got_userinfo")

//登录
#define HTTP_LOGIN                   (@"?c=sc_user&m=login")
//注册
#define HTTP_REGISTER                (@"?c=sc_user&m=register")
//获取短信验证码
#define HTTP_SMS_CODE                (@"?c=sc_user&m=got_code")
//忘记密码
#define HTTP_FORGET_PASSWORD         (@"?c=sc_user&m=find_pwd")
//修改密码
#define HTTP_CHANGE_PASSWORD         (@"?c=sc_user&m=change_pwd")
//修改昵称
#define HTTP_CHANGE_NICKNAME         (@"?c=sc_user&m=change_name")
//修改手机号
#define HTTP_CHANGE_PHONE            (@"?c=sc_user&m=change_phone")
//获取个人信息
#define HTTP_PERSON_INFO             (@"?c=sc_user&m=get_userinfo")

//上传头像
#define HTTP_PERSON_AVATAR           (@"?c=sc_user&m=change_avatar")



//------------------------- 企业资料、企业认证--------
//获取公司注册类型
#define HTTP_ENTERPRISE_REG_TYPE  (@"?c=sc_company&m=reg_type")
//获取公司行业类型
#define HTTP_ENTERPRISE_INDUSTRY  (@"?c=sc_company&m=industry")
//获取个人中心企业资料
#define HTTP_ENTERPRISE_DATA   (@"?c=sc_company&m=detail_info")
//企业认证接口
#define HTTP_ENTERPRISE_AUTH  (@"?c=sc_company&m=company_check")
//企业资料完善接口
#define HTTP_ENTERPRISE_EDIT  (@"?c=sc_company&m=company_detail")
//获取个人中心认证资料
#define HTTP_ENTERPRISE_AUTH_DATA  (@"?c=sc_company&m=check_info")
//获取企业列表
#define HTTP_ENTERPRISE_DATA_LIST  (@"?c=sc_company&m=get_company_list")
//搜索企业列表
#define HTTP_ENTERPRISE_SEARCH_LIST  (@"?c=sc_company&m=search_company")



/********************** 首页 ***************************/
//获取分类
#define HTTP_CATEGORY                (@"?c=sc_category&m=get_category")
//获取栏目
#define HTTP_COLUMN                  (@"?c=sc_category&m=get_cate")

//通讯录列表接口
#define HTTP_ENTERPRISE_CONTACTSLIST  (@"?c=sc_txl&m=get_contact")
//验证用户密码接口
#define HTTP_CHECK_PWD                (@"?c=sc_txl&m=check_user")
//搜索接口
#define HTTP_CONTACTTYPE_SEARCH       (@"?c=sc_txl&m=search_contact")



/********************** 搜索 ***************************/
//热搜关键词
#define HTTP_SEARCH_HOT_KEY          (@"?c=sc_search&m=search_key")
//搜索列表
#define HTTP_SEARCH_LIST             (@"?c=sc_search&m=search_content_list")

/********************** 标签 ***************************/
//查询某个内容的标签
#define HTTP_FLAG_INFO               (@"?c=sc_public&m=get_tag")
//添加标签
#define HTTP_FLAG_ADD                (@"?c=sc_public&m=add_tag")
//根据分类id获取标签
#define HTTP_FLAG_FOR_CATEGORY_ID    (@"?c=sc_public&m=select_tag")
//根据内容id获取分类
#define HTTP_CATEGORY_FOR_CONTENT_ID (@"?c=sc_category&m=select_cate")



/********************** 收藏 ***************************/
//查询收藏的状态
#define HTTP_COLLECT_STATUS          (@"?c=sc_collection&m=collect_status")
//查询收藏的人数
#define HTTP_COLLECT_NUMBER          (@"?c=sc_collection&m=select_collect")
//获取收藏
#define HTTP_COLLECT_LIST            (@"?c=sc_collection&m=get_collect")
//添加收藏
#define HTTP_COLLECT_ADD             (@"?c=sc_collection&m=be_collect")
//取消收藏
#define HTTP_COLLECT_CANCEL          (@"?c=sc_collection&m=dis_collec")

/********************** 政策 ***************************/
//政策分类详情
#define HTTP_POLICY_DETAIL           (@"?c=sc_content&m=get_contentzc")
//政策内容列表
#define HTTP_POLICY_LIST             (@"?c=sc_content&m=get_content_zc")
//企业黄页内容列表
#define HTTP_ENTERPRISE_LIST         (@"?c=sc_content&m=get_content_hy")
//企业黄页分类内容详情
#define HTTP_ENTERPRISE_DETAIL       (@"?c=sc_content&m=get_contenthy")
//办事内容列表
#define HTTP_OFFICE_LIST             (@"?c=sc_content&m=get_content_bs")


/********************** 互动 ***************************/
//回复互动
#define HTTP_INTERACTION_REPLY       (@"?c=sc_interact&m=reply_interact")
//发表帖子
#define HTTP_INTERACTION_PUBLISH     (@"?c=sc_interact&m=insert_forum")
//互动详情
#define HTTP_INTERACTION_DETAIL      (@"?c=sc_interact&m=get_interact")
//互动列表
#define HTTP_INTERACTION_LIST        (@"?c=sc_interact&m=select_interact")
//推荐列表
#define HTTP_RECOMMEND_LIST          (@"?c=sc_content&m=get_intro")

/********************** 消息 ***************************/
//获取系统消息
#define HTTP_MESSAGE_SYSTEM          (@"?c=sc_interact&m=get_sysmsg")
//获取消息回复列表
#define HTTP_MESSAGE_REPLY_LIST      (@"?c=sc_interact&m=get_replyforum")
//获取消息发帖内容列表
#define HTTP_MESSAGE_PUBLISH_LIST    (@"?c=sc_interact&m=get_forumbyid")


/********************** 我的 ***************************/
//获取banner
#define HTTP_BANNER_LIST             (@"?c=sc_public&m=index_page")
//意见反馈
#define HTTP_FEED_BACK               (@"/feedback")


//======================== 生活版 ==================================================

//招聘列表
#define HTTP_RECRUIT_LIST      (@"?c=scp_recruit&m=recruitlist")
//求职列表
#define HTTP_JOBFINDING_LIST   (@"?c=scp_recruit&m=jobwantlist")
//求租列表
#define HTTP_WANTRENT_LIST     (@"?c=scp_lease&m=housewantlist")
//出租列表
#define HTTP_RENTOUT_LIST      (@"?c=scp_lease&m=leaselist")
//柳梧圈列表
#define HTTP_LIUWUQUAN_LIST    (@"?c=scp_interact&m=interactlist")


//出租详情
//index.php?c=scp_lease&m=lease
#define HTTP_RENTOUT_DETAIL  (@"?c=scp_lease&m=lease")


//公交车列表
#define HTTP_BUS_LIST   (@"?c=scp_indexpage&m=buslist")

//公交车查询
#define HTTP_BUS_SEARCH (@"?c=scp_indexpage&m=bussearch")

//公交车搜索历史
#define HTTP_BUS_HIS  (@"?c=scp_indexpage&m=bushistory")

//天气
#define HTTP_WEATHER  (@"?c=scp_indexpage&m=weather")

//新闻、广告
#define HTTP_newsOrAds (@"?c=scp_indexpage&m=newsadv")

//市民热线
#define HTTP_HOTLINE  (@"?c=scp_indexpage&m=hotline")


//==========================================================
//火车票
#define TRAIN_TICKET  @"http://111.11.196.68/xzzhcs/application/views/lifestyle/hcp.html"
//打车热线
#define PHONE_TAXI  @"http://111.11.196.68/xzzhcs/application/views/lifestyle/dcrx.html"
//充值
#define CHARGE_URL  @"http://wap.10086.cn/czjf/czjf.jsp"
//团购
#define GROUP_PURASE  @"http://www.zutuanzhong.com/bin/index.html?account=10086&token=a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ"

//电影票
#define MOVIES_TICKETS  @"http://www.zutuanzhong.com/bin/index.html?account=10086&a403a322Vw0JAQNdVwFVAVZQAgADVw8EAwVTCV8AAgpdAwpRWQJRXwoKBA0CCAVaDVZRBQdRBAQ&tz=tglist&opt={%22cate%22:5}"

//体育场预定静态页
#define stadium_order  @"http://111.11.196.68/xzzhcs/application/views/lifestyle/tycyd.html"

//违章查询
#define peccancy_search  @"http://light.weiche.me/#&index"


//----------------- 发布 ---------------------
//发布柳梧圈
#define HTTP_PUBLISH_LWQ  (@"?c=scp_interact&m=addinteract")

//发布求租
#define HTTP_PUBLISH_RENTWANT  (@"?c=scp_lease&m=addhousewant")

//发布出租
#define HTTP_PUBLISH_RENTOUT  (@"?c=scp_lease&m=addlease")

//发布求职
#define HTTP_PUBLISH_JOBWANT  (@"?c=scp_recruit&m=addjobwant")

//发布招聘
#define HTTP_PUBLISH_RECRUIT (@"?c=scp_recruit&m=addrecruit")

//回复柳梧圈
#define HTTP_PUBLISH_REPLY (@"?c=scp_interact&m=reply_interact")


//----------------- 我的发帖 -------------------------
//我的发帖(求职)
#define HTTP_NOTES_JOBWANT   (@"index.php?c=scp_recruit&m=jobwantbyid")

//我的发帖（求租）
#define HTTP_NOTES_RENTWANT   (@"index.php?c=scp_lease&m=housewantbyid")

//我的发帖（招聘）
#define HTTP_NOTES_RECRUIT   (@"index.php?c=scp_recruit&m=recruitbyid")

//我的发帖（出租）
#define HTTP_NOTES_RENTOUT   (@"index.php?c=scp_lease&m=leasebyid")

//我的发帖（柳梧圈）
#define HTTP_NOTES_LWQ   (@"index.php?c=scp_interact&m=interactbyid")

//编辑招聘
#define HTTP_UPDATE_RECRUIT    (@"index.php?c=scp_recruit&m=updaterecruit")
//编辑求职
#define HTTP_UPDATE_JOBWANT    (@"index.php?c=scp_recruit&m=updatejobwant")
//编辑求租
#define HTTP_UPDATE_RENTWANT    (@"index.php?c=scp_lease&m=updatehousewant")
//编辑出租
#define HTTP_UPDATE_RENTOUT     (@"index.php?c=scp_lease&m=updatelease")

//删除求租
#define HTTP_DELETE_RENTWANT   (@"index.php?c=scp_lease&m=delhousewant")
//删除出租
#define HTTP_DELETE_RENTOUT   (@"index.php?c=scp_lease&m=dellease")
//删除柳梧圈
#define HTTP_DELETE_LWQ     (@"index.php?c=scp_interact&m=delinteract")

//更改招聘显示状态
#define HTTP_TRANSFER_RECRUIT_SHOW  (@"index.php?c=scp_recruit&m=transferrecruit")
//更改求职显示状态
#define HTTP_TRANSFER_JOBWANT_SHOW   (@"index.php?c=scp_recruit&m=transferjobwant")



//我的消息 - 我的回复
#define HTTP_MYREPLY_MESSAGES  (@"index.php?c=scp_interact&m=replybyid")

//我的消息 - 系统消息
#define HTTP_SYSTEM_MESSAGES (@"index.php?c=scp_interact&m=sysmsg")



//------------------------ 社保 ---------------------------------//
//查询医保通订购关系接口(参数是手机号码：西藏移动)
#define HTTP_SI_RELATIONSHIP  (@"?c=scp_indexpage&m=queryorder_insurance")

//医保通订购
#define HTTP_SI_ORDER   (@"?c=scp_indexpage&m=order_insurance")

//查询医保通消费详情
#define HTTP_SI_CONSUME  (@"?c=scp_indexpage&m=getcostdetail")

//查询用户医保卡余额以及本月消费
#define HTTP_SI_LEFTMONEY  (@"?c=scp_indexpage&m=getusertotalmoney")




//微信充值
//充值产品的价格和id
#define HTTP_RECHARGE_PRODUCT  ("?c=sc_chongzhi&m=product")

//充值生成订单接口
#define HTTP_CREATE_PREPAYID  (@"?c=sc_chongzhi&m=increment")

//后台入库生成订单
#define HTTP_CREATE_ORDER   (@"?c=sc_chongzhi&m=corder")

//查询付款状态(入参orderid)
#define HTTP_QUIRE_PAYSTATUS  (@"?c=sc_chongzhi&m=orderQuery")


// ------------------- test ----------------
#define HTTP_AES_ENCRYPT_TEST  (@"?c=jiekoutest&m=aes128cbcEncrypt")
#define HTTP_AES_DECRYPT_TEST  @(@"?c=jiekoutest&m=aes128cbcHexDecrypt&str")

#endif /* YLHttpUrl_h */

























