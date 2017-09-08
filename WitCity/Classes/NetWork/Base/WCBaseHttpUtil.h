//
//  RYBaseHttpUtil.h
//  TongHua
//
//  Created by simpletour on 16/2/3.
//  Copyright © 2016年 RY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLBaseHttpUtil.h"
#import "YLHttpUrl.h"
#import "NSString+YLEncryption.h"
#import "YLToast.h"
#import "YLResponseModel.h"
#import "DDResponseModel.h"

#define kYLPageSize 10

@interface WCBaseHttpUtil : YLBaseHttpUtil

+(void)postWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure;
+(void)getWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure;
+(void)testpostWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure;
////这里调社保返回数据格式字段不太一样，故重新整一个
//+(void)postAnotherWayWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure;

+(void)postWithActionWithHostUrlByself:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(YLResponseModel *result))block failure:(void(^)())failure;

+ (void)uploadMultiImageWithAction:(NSString *)action params:(NSDictionary *)params images:(NSArray *)images  success:(void (^)(YLResponseModel *result))success fail:(void (^)())fail;

+ (void)uploadImageWithAction:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image  success:(void (^)(YLResponseModel *result))success fail:(void (^)())fail;

+(void)postTextWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(NSString *text))block failure:(void(^)())failure;

//调组团钟
+(void)postZuTuanWithAction:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure;

@end



