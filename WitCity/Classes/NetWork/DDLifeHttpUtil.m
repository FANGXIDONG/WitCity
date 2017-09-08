//
//  DDLifeHttpUtil.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/7.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//对生活版接口的封装

#import "DDLifeHttpUtil.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation DDLifeHttpUtil

+ (void)recruitListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:HTTP_RECRUIT_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)jobSeekListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:HTTP_JOBFINDING_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)rentOutListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:HTTP_RENTOUT_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)rentWantListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:HTTP_WANTRENT_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}


+ (void)LWQListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:HTTP_LIUWUQUAN_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"柳梧圈%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}


+ (void)getBusListWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:HTTP_BUS_LIST params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)getNewsAndAdsBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    [self postWithAction:HTTP_newsOrAds params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)getWeatherWithCityId:(NSInteger)cityId Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"city" value:@(cityId)];
    [self postWithAction:HTTP_WEATHER params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)getBusSearchResultWithKeyword:(NSString *)key page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"key" value:key];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self postWithAction:HTTP_BUS_SEARCH params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
                        NSLog(@"搜索结果%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)getHotlineDataBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{

    [self postWithAction:HTTP_HOTLINE params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            //            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

+ (void)getLwqCommentDetailDataWithUrl:(NSString *)url circle_id:(NSString *)circle_id Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    [self postWithActionWithHostUrlByself:url params:nil type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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


//获得医保通订购关系
+ (void)getSocialInsuranceRelationshipWithPhone:(NSString *)phone Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
//    [self setWithMutableDict:md key:@"phone" value:[YLUserSingleton shareInstance].phone];
    [self setWithMutableDict:md key:@"phone" value:@"13908910957"]; //已开通西藏的手机号
    
    [self postWithAction:HTTP_SI_RELATIONSHIP params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
             NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];

}

//订购医保通，开通
+ (void)orderSocialInsuranceWithSocialNumber:(NSString *)socialNum orSocialCardNumber:(NSString *)socialCardNum Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    if (socialNum == nil) {
        socialNum = @"";
    }
    if (socialCardNum == nil) {
        socialCardNum = @"";
    }
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    //    [self setWithMutableDict:md key:@"phone" value:[YLUserSingleton shareInstance].phone];
    [self setWithMutableDict:md key:@"phone" value:@"13908910957"]; //已开通西藏的手机号
    [self setWithMutableDict:md key:@"vbid" value:socialNum];
    [self setWithMutableDict:md key:@"vbno" value:socialCardNum];
    
    [self postWithAction:HTTP_SI_ORDER params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
    
}

//查询医保通消费详情
+ (void)inquireSocialInsuranceConsumeDetailBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    //    [self setWithMutableDict:md key:@"phone" value:[YLUserSingleton shareInstance].phone];
    [self setWithMutableDict:md key:@"phone" value:@"13908910957"]; //已开通西藏的手机号
    
    [self postWithAction:HTTP_SI_CONSUME params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];

}

//查询医保卡余额以及本月消费
+ (void)inquireSocialInsuranceCardMoneyDetailBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    //    [self setWithMutableDict:md key:@"phone" value:[YLUserSingleton shareInstance].phone];
    [self setWithMutableDict:md key:@"phone" value:@"13908910957"]; //已开通西藏的手机号
    
    [self postWithAction:HTTP_SI_LEFTMONEY params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];

}

//我的发帖
//我的发帖 - 求职
+ (void)getMySendNotesOfJobwantWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self postWithAction:HTTP_NOTES_JOBWANT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//我的发帖 - 求租
+ (void)getMySendNotesOfRentwantWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self postWithAction:HTTP_NOTES_RENTWANT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//我的发帖 - 招聘
+ (void)getMySendNotesOfRecruitWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self postWithAction:HTTP_NOTES_RECRUIT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//我的发帖 - 出租
+ (void)getMySendNotesOfRentoutWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self postWithAction:HTTP_NOTES_RENTOUT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//我的发帖 - 柳梧圈
+ (void)getMySendNotesOfLWQWithpage:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self postWithAction:HTTP_NOTES_LWQ params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//删除求租
+ (void)deleteNotesOfRentWantWithId:(NSString *)qzu_id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"qzu_id" value:qzu_id];
    [self postWithAction:HTTP_DELETE_RENTWANT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//删除出租
+ (void)deleteNotesOfRentOutWithId:(NSString *)lease_id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"lease_id" value:lease_id];
    [self postWithAction:HTTP_DELETE_RENTOUT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

//删除柳梧圈
+ (void)deleteNotesOfLWQWithId:(NSString *)circle_id block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"circle_id" value:circle_id];
    [self postWithAction:HTTP_DELETE_LWQ params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            dict(result.contentlist);
            NSLog(@"%@",result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//更改招聘显示状态(status 1显示  2隐藏)
+ (void)transferRecruitShowWithId:(NSString *)recruit_id status:(NSString *)status block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"recruit_id" value:recruit_id];
    [self setWithMutableDict:md key:@"status" value:status];
    [self postWithAction:HTTP_TRANSFER_RECRUIT_SHOW params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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
//更改求职显示状态
+ (void)transferJobwantShowWithId:(NSString *)qzhi_id status:(NSString *)status block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"qzhi_id" value:qzhi_id];
    [self setWithMutableDict:md key:@"status" value:status];
    [self postWithAction:HTTP_TRANSFER_JOBWANT_SHOW params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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


+(void)getRentoutDetailDataWithLease_id:(NSString *)lease_id Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"lease_id" value:lease_id];
    
    [self postWithAction:HTTP_RENTOUT_DETAIL params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            // NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];

}

//-------------------------------- 发布 --------------------------------------------------------
//发布柳梧圈
+ (void)publishLwqWithtitle:(NSString *)title
                    content:(NSString *)content
                  thumbFile:(NSArray *)images
                      Block:(void(^)(NSDictionary *dict))dict
                    failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"title" value:title];
    [self setWithMutableDict:md key:@"content" value:content];
    //    [self setWithMutableDict:md key:@"file" value:file];
    
    [self uploadMultiImageWithAction:HTTP_PUBLISH_LWQ params:md images:images success:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            //            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } fail:^{
        failure();
    }];
//    
//    [self uploadMultiImageWithAction:HTTP_PUBLISH_LWQ params:md images:images success:^(id responseObject) {
//        
//        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
//        NSLog(@"avatar responseObject = %@", responseObject);
//        //        access(result.contentlist);
//        //        YLUserSingleton *user = [YLUserSingleton shareInstance];
//        //        user.avatar = result.contentlist[@"url"];
//        //        [ND postNotificationName:kUpdateUserInfoNotification object:nil];
//        
//        
//        
//    } fail:^{
//        failure();
//    }];
}

//发布求租
+ (void)publishRentWantWithTitle:(NSString *)title
                            area:(NSString *)area
                            type:(NSString *)type
                           price:(NSString *)price
                         summary:(NSString *)summary
                          person:(NSString *)person
                           phone:(NSString *)phone
                           Block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{
    
    NSString *priceStatus = [DDUtils priceStatusWithPrice:price];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"title" value:title];
    [self setWithMutableDict:md key:@"area" value:area];
    [self setWithMutableDict:md key:@"price" value:priceStatus];
    [self setWithMutableDict:md key:@"summary" value:summary];
    [self setWithMutableDict:md key:@"person" value:person];
    [self setWithMutableDict:md key:@"phone" value:phone];
    [self setWithMutableDict:md key:@"type" value:type];
    [self postWithAction:HTTP_PUBLISH_RENTWANT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
         NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
    
}

//发布招聘
//Worktype	int	1全职 2兼职3实习   thumb公司logo
+ (void)publishRecruitWithThumb:(NSString *)thumb
                        business:(NSString *)business
                        position:(NSString *)position
                     workrequire:(NSString *)workrequire
                         address:(NSString *)address
                          salary:(NSString *)salary
                            exep:(NSString *)exep
                             edu:(NSString *)edu
                        worktype:(NSString *)worktype
                          attact:(NSString *)attact
                        industry:(NSString *)insustry
                         quality:(NSString *)quality
                            size:(NSString *)size
                         summary:(NSString *)summary
                          person:(NSString *)person
                           phone:(NSString *)phone
                           Block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{

    NSString *statusEdu = [DDUtils eduStatusWithEdu:edu];
    NSString *statusExep = [DDUtils experienceStatusWithExp:exep];
    NSString *statusSalary = [DDUtils salaryStatusWithSalary:salary];
    NSString *statusWType = [DDUtils typeStatusWithType:worktype];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"business" value:business];
    [self setWithMutableDict:md key:@"position" value:position];
    [self setWithMutableDict:md key:@"workrequire" value:workrequire];
    [self setWithMutableDict:md key:@"address" value:address];
    [self setWithMutableDict:md key:@"salary" value:statusSalary];
    [self setWithMutableDict:md key:@"exep" value:statusExep];
    [self setWithMutableDict:md key:@"edu" value:statusEdu];
    [self setWithMutableDict:md key:@"worktype" value:statusWType];
    [self setWithMutableDict:md key:@"attact" value:attact];
    [self setWithMutableDict:md key:@"industry" value:insustry];
    [self setWithMutableDict:md key:@"quality" value:quality];
    [self setWithMutableDict:md key:@"size" value:size];
    [self setWithMutableDict:md key:@"summary" value:summary];
    [self setWithMutableDict:md key:@"person" value:person];
    [self setWithMutableDict:md key:@"phone" value:phone];
    
    UIImage *image = [UIImage imageNamed:thumb];
    [self uploadImageWithAction:HTTP_PUBLISH_RECRUIT params:md image:image success:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } fail:^{
       failure();
    }];
}

//发布出租
//Thumb 	Array	图片(thumb1,thumb2…)
+ (void)publishRentOutWithTitle:(NSString *)title address:(NSString *)address price:(NSString *)price type:(NSString *)type source:(NSString *)source floor:(NSString *)floor config:(NSString *)config summary:(NSString *)summary thumb:(NSArray *)thumb person:(NSString *)person phone:(NSString *)phone Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    
//    NSString *statusEdu = [DDUtils eduStatusWithEdu:edu];
//    NSString *statusExep = [DDUtils experienceStatusWithExp:exep];
//    NSString *statusSalary = [DDUtils salaryStatusWithSalary:salary];
    NSString *statusSource = [DDUtils sourceStatusWithSource:source];
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"title" value:title];
    [self setWithMutableDict:md key:@"price" value:price];
    [self setWithMutableDict:md key:@"address" value:address];
    [self setWithMutableDict:md key:@"type" value:type];
    [self setWithMutableDict:md key:@"source" value:statusSource];
    [self setWithMutableDict:md key:@"floor" value:floor];
    [self setWithMutableDict:md key:@"config" value:config];
    [self setWithMutableDict:md key:@"summary" value:summary];
    [self setWithMutableDict:md key:@"person" value:person];
    [self setWithMutableDict:md key:@"phone" value:phone];
    
    [self uploadMultiImageWithAction:HTTP_PUBLISH_RENTOUT params:md images:thumb success:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            //            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } fail:^{
        failure();
    }];
}

//发布求职
+ (void)publishJobSeekWithName:(NSString *)name gender:(NSString *)gender college:(NSString *)college edu:(NSString *)edu birth:(NSString *)birth phone:(NSString *)phone email:(NSString *)email exep:(NSString *)exep history:(NSArray *)history job:(NSString *)job worktype:(NSString *)worktype salary:(NSString *)salary Block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"u_id" value:[YLUserSingleton shareInstance].uid];
    [self setWithMutableDict:md key:@"name" value:name];
    [self setWithMutableDict:md key:@"gender" value:gender];
    [self setWithMutableDict:md key:@"college" value:college];
    [self setWithMutableDict:md key:@"edu" value:edu];
    [self setWithMutableDict:md key:@"birth" value:birth];
    [self setWithMutableDict:md key:@"phone" value:phone];
    [self setWithMutableDict:md key:@"email" value:email];
    [self setWithMutableDict:md key:@"exep" value:exep];
    [self setWithMutableDict:md key:@"history" value:history];
    [self setWithMutableDict:md key:@"job" value:job];
    [self setWithMutableDict:md key:@"worktype" value:worktype];
    [self setWithMutableDict:md key:@"salary" value:salary];
    [self postWithAction:HTTP_PUBLISH_JOBWANT params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}
//----------------------------------------------------------------------------------------
//我的消息 - 我的回复
+ (void)myReplyMessagesWithUid:(NSString *)uid page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:uid];
    [self postWithAction:HTTP_MYREPLY_MESSAGES params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//我的消息 - 系统消息
+ (void)systemMessagesWithUid:(NSString *)uid page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self setWithMutableDict:md key:@"u_id" value:uid];
    [self postWithAction:HTTP_SYSTEM_MESSAGES params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**
 *  充值生成订单接口
 */
+(void)createRechargePrepayidWithUid:(NSString *)uid Body:(NSString *)body money:(NSString *)money phone:(NSString *)phone prodid:(NSString *)prodid filltype:(NSString *)filltype incretype:(NSString *)incretype block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSString  *ipAddress = [self getIPAddress:YES];
    NSLog(@"ip->>%@",ipAddress);
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"uid" value:uid];
    [self setWithMutableDict:md key:@"body" value:body];
    [self setWithMutableDict:md key:@"money" value:money];
    [self setWithMutableDict:md key:@"phone" value:phone];
    [self setWithMutableDict:md key:@"prodid" value:prodid];
    [self setWithMutableDict:md key:@"filltype" value:filltype];
    [self setWithMutableDict:md key:@"incretype" value:incretype];
//    [self setWithMutableDict:md key:@"ipAddress" value:ipAddress];
    
    [self postWithAction:HTTP_CREATE_PREPAYID params:md  type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
        if (result.errcode.integerValue == kYLResponseStateSuccess) {
            NSLog(@"充值输出:%@",result.contentlist);
            dict(result.contentlist);
        } else {
            [YLToast showToastInKeyWindowWithText:result.msg];
            failure();
        }
    } failure:^{
        failure();
    }];
}

//+(void)createOrderFortoDBWithUid:(NSString *)uid orderid:(NSString *)orderid phone:(NSString *)phone
//                           block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
//    
//    NSMutableDictionary *md = [NSMutableDictionary dictionary];
//    [self setWithMutableDict:md key:@"uid" value:uid];
//    [self setWithMutableDict:md key:@"orderid" value:orderid];
//    [self setWithMutableDict:md key:@"phone" value:phone];
//    
//    [self postWithAction:HTTP_CREATE_ORDER params:md  type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
//        if (result.errcode.integerValue == kYLResponseStateSuccess) {
//            NSLog(@"入库生成订单输出:%@- %@-%@",result.contentlist,result.msg,result.errcode);
//            dict(result.contentlist);
//        } else {
//            [YLToast showToastInKeyWindowWithText:result.msg];
//            failure();
//        }
//    } failure:^{
//        failure();
//    }];
//}
#pragma mark - 获取设备ip地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


@end












