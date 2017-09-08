//
//  YLBaseHttpUtil.h
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>

typedef NS_ENUM(NSInteger, YLHttpResponseType) {
    kYLHttpResponseTypeJson,
    kYLHttpResponseTypeText
};

@interface YLBaseHttpUtil : NSObject

+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure;

+(void)postWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure;

+(void)postWithUrlByself:(NSString *)url params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure;

+ (void)uploadImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)())fail;

//多图上传
+ (void)uploadMultiImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(NSArray *)imageDatas success:(void (^)(id responseObject))success fail:(void (^)())fail;


+ (void)setWithMutableDict:(NSMutableDictionary *)dict key:(NSString *)key value:(id)value;

//构造令牌
+(NSString *)getToken;
@end








