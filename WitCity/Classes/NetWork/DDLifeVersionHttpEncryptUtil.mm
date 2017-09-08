//
//  DDLifeVersionHttpEncryptUtil.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/3.
//  Copyright © 2016年 bjxybs. All rights reserved.
//



//==============================================
//1. 加密方式
//1) api-expires: 自增的整数，不允许重复，建议使用unix时间戳（精确到秒级即可）
//2) api-secret:API秘钥，由服务端和客户端约定。
//3) api-signature:签名，主要生成算法：hex(HMAC_SHA256(apiSecret, verb + path + expires + data)), 如果服务端计算签名跟客户端不一致则拒绝返回数据。
//各验证字段含义：
//apiSecret:密钥，约定。
//verb: 主要是http请求方式，GET/POST/PUT
//path: 请求路径，不包含host， 比如：/path/api.php
//expires: 客户端传的参数api-expires, 放在header里
//data: 主要指query_string, 例如：a=123&b=456, 用&连接起来。POST body部分不参与计算.
//==============================================


#import "DDLifeVersionHttpEncryptUtil.h"
//#include <iostream>     //注意：导入iostream，使用c++时需要将文件的后缀改为mm,否则出现not found
//#import "AES.h"
//#import "DDAES128CBC.h"
//#import "AESCrypt.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


#define Api_secret @"cc0aa948-6b7e-11e7-8e3a-408d5c21834b"


#define kKey   @"xyBSnQE2FFDSEdsd"
#define kIV    @"5efd3f6060e20330"

@implementation DDLifeVersionHttpEncryptUtil

+ (void)testBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
//    http://p.zhcs.cmtibet.com/?c=sc_user&m=got_userinfo&encryptU_id=ff7797283c5eade0acb341a54029f995
    
//    NSString *passEncry = [AESCrypt encrypt:[YLUserSingleton shareInstance].uid password:kKey iv:kIV];
//    NSString *timeSpEncry = [AESCrypt encrypt:[self unixTime] password:kKey iv:kIV];
    
    
//    NSString *string1 = @"GET/tongju/api/get_verify_code.php";
//    NSString *string2 = [self unixTime];
//    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
//    NSString *paraStr = [NSString stringWithFormat:@"%@mobile=15205145990",string3];
//    
//    
//    NSLog(@"时间戳：%@",string2);
//    
//    NSLog(@"需要加密的：%@",paraStr);
//    
////    NSString *paraStr = [NSString stringWithFormat:@"%@&%@",[YLUserSingleton shareInstance].uid,[self unixTime]];
//    
////    NSString *encryPara = [AESCrypt encrypt:paraStr password:kKey iv:kIV];
//    
//    NSString *encryPara = [self hmac:paraStr withKey:Api_secret];
//    
//    NSLog(@"加密后==%@",encryPara);
//    
//    
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"mobile" value:@"15205145990"];
    [self getWithAction:@"/tongju/api/get_verify_code.php" params:md type:kYLHttpResponseTypeJson block:^(YLResponseModel *result) {
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

////时间转时间戳
//+(NSString *)unixTime{
////    //方法一
////        NSDate *localDate = [NSDate date]; //获取当前时间
////        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
//////        NSLog(@"timeSp:%@",timeSp); //时间戳的值
//    
//    //方法二
////    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
////    NSTimeInterval a=[dat timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
////    NSString *timeSp = [NSString stringWithFormat:@"%f", a]; //转为字符型
//    
//    //    //简写之
//        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];
//        NSLog(@"timeSp:%@",timeSp); //时间戳的值
//    //    //C语言的time(NULL)函数也可以
//    //     NSLog(@"%ld", time(NULL));  // 这句也可以获得时间戳，跟上面一样，精确到秒
//    
//    return timeSp;
//}
//
//+ (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
//{
//    
////    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
////    const char *cData = [key cStringUsingEncoding:NSUTF8StringEncoding];
////    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
////    
////    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
////    
////    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
////    
////    NSString *hash =  [HMAC base64EncodedString];
////    
////    return hash;
//    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
//    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
//    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
//    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
//    for (int i = 0; i < HMACData.length; ++i){
//        [HMAC appendFormat:@"%02x", buffer[i]];
//    }
//    
//    return HMAC;
//}


@end










