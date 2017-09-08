//
//  RYBaseHttpUtil.m
//  TongHua
//
//  Created by simpletour on 16/2/3.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "WCBaseHttpUtil.h"


@implementation WCBaseHttpUtil

+(void)postWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure
{
    [super postWithUrl:Http_test_hotst action:action params:params type:type block:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
    } failure:^{
        failure();
    }];
}

+(void)testpostWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure
{
    [super postWithUrl:Http_test_hotst action:action params:params type:type block:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
    } failure:^{
        failure();
    }];
}

+(void)getWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://103.37.160.99",action];
    [super getWithUrl:url params:params type:type block:^(id responseObject) {
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
        
    } failure:^{
        failure();
    }];
}

//+(void)postAnotherWayWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure
//{
//    [super postWithUrl:HTTP_HOST action:action params:params type:type block:^(id responseObject) {
//        
////        NSLog(@"%d",[responseObject[@"ret"] intValue]);
//        
//        if ([responseObject[@"ret"] intValue] == 200) {
//            
//            NSDictionary *dic = responseObject[@"data"];
//            DDResponseModel *result = [[DDResponseModel alloc] init];
//            result.code = dic[@"code"];
//            result.msg = dic[@"msg"];
//            result.status = dic[@"data"][@"status"];
//
//            block(result);
//        }else{
//            [YLToast showToastInKeyWindowWithText:responseObject[@"msg"]];
//            failure();
//        }
//
//    } failure:^{
//        failure();
//    }];
//}

+(void)postWithActionWithHostUrlByself:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure
{
    [super postWithUrlByself:action params:params type:type block:^(id responseObject) {
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
    } failure:^{
        failure();
    }];
}

//多图上传
+ (void)uploadMultiImageWithAction:(NSString *)action params:(NSDictionary *)params images:(NSArray *)images  success:(void (^)(YLResponseModel *result))success fail:(void (^)())fail
{
//    [super uploadMultiImageWithUrl:HTTP_HOST action:action params:params image:images success:success fail:fail];
    [super uploadMultiImageWithUrl:Http_test_hotst action:action params:params image:images success:^(id responseObject) {
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        success(result);
    } fail:^{
        fail();
    }];
}

+ (void)uploadImageWithAction:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image  success:(void (^)(YLResponseModel *result))success fail:(void (^)())fail
{
//    [super uploadImageWithUrl:HTTP_HOST action:action params:params image:image success:success fail:fail];
    [super uploadImageWithUrl:HTTP_HOST action:action params:params image:image success:^(id responseObject) {
        YLResponseModel *result = [YLResponseModel mj_objectWithKeyValues:responseObject];
        success(result);
    } fail:^{
        fail();
    }];
}

+(void)postTextWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(NSString *text))block failure:(void(^)())failure
{
    [super postWithUrl:HTTP_HOST action:action params:params type:type block:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        block(str);
    } failure:^{
        failure();
    }];
}

// --------------------------------- 调用组团钟接口 ----------------------------------------

+(void)postZuTuanWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure{
    
    [super postWithUrl:ZUTUAN_HTTP_HOST action:action params:params type:type block:^(id responseObject) {
        DDResponseModel *result = [DDResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
    } failure:^{
        failure();
    }];
    
}


@end
