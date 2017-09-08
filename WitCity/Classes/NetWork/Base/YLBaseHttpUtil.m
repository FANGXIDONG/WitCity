//
//  YLBaseHttpUtil.m
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLBaseHttpUtil.h"
#import "YLResponseModel.h"
#import "YLToast.h"
#import "GTMBase64.h"


#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


#define Api_secret @"cc0aa948-6b7e-11e7-8e3a-408d5c21834b"

@implementation YLBaseHttpUtil
//时间转时间戳
+(NSString *)unixTime{
    //    //方法一
    //        NSDate *localDate = [NSDate date]; //获取当前时间
    //        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
    ////        NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    //方法二
    //    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    //    NSTimeInterval a=[dat timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
    //    NSString *timeSp = [NSString stringWithFormat:@"%f", a]; //转为字符型
    
    //    //简写之
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    //    //C语言的time(NULL)函数也可以
    //     NSLog(@"%ld", time(NULL));  // 这句也可以获得时间戳，跟上面一样，精确到秒
    
    return timeSp;
}

+ (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    
    //    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    //    const char *cData = [key cStringUsingEncoding:NSUTF8StringEncoding];
    //    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //
    //    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    //
    //    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    //
    //    NSString *hash =  [HMAC base64EncodedString];
    //
    //    return hash;
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    
    return HMAC;
}



+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params  type:(YLHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure
{
    
    
    NSString *string1 = @"GET/tongju/api/get_verify_code.php";
    NSString *string2 = [self unixTime];
    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
    NSString *paraStr = [NSString stringWithFormat:@"%@mobile=15205145990",string3];
    
    
    NSLog(@"时间戳：%@",string2);
    
    NSLog(@"需要加密的：%@",paraStr);
    
    //    NSString *paraStr = [NSString stringWithFormat:@"%@&%@",[YLUserSingleton shareInstance].uid,[self unixTime]];
    
    //    NSString *encryPara = [AESCrypt encrypt:paraStr password:kKey iv:kIV];
    
    NSString *encryPara = [self hmac:paraStr withKey:Api_secret];
    
    NSLog(@"加密后==%@",encryPara);
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置请求内容的类型
    [manager.requestSerializer setValue:string2 forHTTPHeaderField:@"api-expires"];
    //设置请求的编码类型
    [manager.requestSerializer setValue:encryPara forHTTPHeaderField:@"api-signature"];


    
//    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
//    NSDictionary *headerFieldValueDictionary = @{@"expires":@"1.0"};
//    if (headerFieldValueDictionary != nil) {
//        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//            NSString *value = headerFieldValueDictionary[httpHeaderField];
//            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//        }
//    }

    
    if (type == kYLHttpResponseTypeText) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}


+(void)postWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (type == kYLHttpResponseTypeText) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];

        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", url, action];
    
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -1009 || error.code != -1001) {
            NSLog(@"error.userInfo = %@", error.userInfo);
        }
        failure();
    }];
}


+(void)postWithUrlByself:(NSString *)url params:(NSDictionary *)params type:(YLHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (type == kYLHttpResponseTypeText) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@", url, action];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -1009 || error.code != -1001) {
            NSLog(@"error.userInfo = %@", error.userInfo);
        }
        failure();
    }];
}

+ (void)uploadImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", url, action];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"image/png", nil];
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (image!=nil) {
            NSData *data = UIImagePNGRepresentation(image);
            NSInputStream *stream = [NSInputStream inputStreamWithData:data];
            [formData appendPartWithInputStream:stream name:@"avatar" fileName:@"witcity.png" length:data.length mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"image error = %@", error);
        if (fail) {
            fail();
        }
    }];
}

//多图上传
+ (void)uploadMultiImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(NSArray *)imageDatas success:(void (^)(id responseObject))success fail:(void (^)())fail{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", url, action];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"image/png", nil];
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger imgCount = 1;
        for (NSData *imageData in imageDatas) {
            
//            NSData *data = UIImagePNGRepresentation(image);
            NSInputStream *stream = [NSInputStream inputStreamWithData:imageData];
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
            NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
            [formData appendPartWithInputStream:stream name:@"thumb" fileName:fileName length:imageData.length mimeType:@"image/png"];

            imgCount++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"image error = %@", error);
        if (fail) {
            fail();
        }
    }];
}


+ (void)setWithMutableDict:(NSMutableDictionary *)dict key:(NSString *)key value:(id)value
{
    NSString *v = value;
    if (value != nil) {
        [dict setObject:v forKey:key];
    }
}

/**
 *  关于构造令牌
 *  令牌的构造：encode(md5(账号+秘钥) + 请求时间(Unix时间) ，账号)
 *  说明：
 *  1.MD5是要生成32位
 *  2.这里的encode(md5(账号+秘钥) + 请求时间(Unix时间)，账号)；  账号+秘钥，是按照字符串拼接的
 *  3.这里讲账号和秘钥做md5之后与毫秒时间戳拼接成新的字符串，作为encode的第一个参数再把账号做第二个参数，传入encode方法，生成令牌。
 *  4.Unix时间戳是1970年1月1日起的绝对时间
 */

//构造令牌
+(NSString *)getToken{
    
    //----------------- encode加密的第一个参数 --------------------------
    NSString *accountSecretStr = [INNDER_ACCOUNT_ID stringByAppendingString:SECTRCT_KEY_TOKEN];
    NSString *md5String = [accountSecretStr md5];
    NSString *timeSp = [self unixTime];
    NSString *paramStr = [md5String stringByAppendingString:timeSp];
    //-------------------------------------------------------------------
    //对时间戳MD5、账号MD5
    NSString *dynKey  = [timeSp md5];
    NSString *fixedKey  = [INNDER_ACCOUNT_ID md5];
    //第一个md5加密后的字符串和第二个MD5加密后的字符串分别进行分割
    NSString *dynKeyPart1 = [dynKey  substringWithRange:NSMakeRange(0, 4)];
    NSString *dynKeyPart2 = [dynKey  substringFromIndex:28];
    NSString *fixedKeyPart1  = [fixedKey  substringWithRange:NSMakeRange(0, 4)];
    NSString *fixedKeyPart2  = [fixedKey  substringFromIndex:28];
    //分割后的字符串进行拼接、且MD5加密得到新的key
    NSString *pinjieStr = [NSString stringWithFormat:@"%@%@%@%@",dynKeyPart1,fixedKeyPart1,dynKeyPart2,fixedKeyPart2];
    NSString *newKey = [pinjieStr md5];
    //将得到fixedKeyPart1 与encode方法传入的第一个参数，加上dynKeyPart2 做字符串拼接得到一个新的字符串，取该字符串的长度len
    NSString *str  = [NSString stringWithFormat:@"%@%@%@",fixedKeyPart1,paramStr,dynKeyPart2];
    unsigned long int len = [str length];

    //NSString转字符char数组
    const char *strArr = [str cStringUsingEncoding:[NSString defaultCStringEncoding]];
    const char *keyArr = [newKey cStringUsingEncoding:[NSString defaultCStringEncoding]];

    NSString *code;
    //遍历数组，对数组元素进行异或运算(用1表示真，用0表示假)
    for ( int n = 0; n < len; n++) {
        
        char c = strArr[n];
        int  i = keyArr[n % 32];
        if ( n == 0 ) {
           code = [NSString stringWithFormat:@"%c%d",c,i];
        }else{
            code = [NSString stringWithFormat:@"%@%c%d",code,c,i];
        }
    }
    //.将code做base64加密，加密后与dynKeyPart1 + dynKeyPart2 拼接，去掉其中包含的=号，就得到了最后的code
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    NSString *codeBase = [GTMBase64 stringByEncodingData:codeData];
    NSString *codeJoin = [NSString stringWithFormat:@"%@%@%@",dynKeyPart1,dynKeyPart2,codeBase];
    NSString *tokenStr = [codeJoin stringByReplacingOccurrencesOfString:@"=" withString:@""];
    NSLog(@"令牌：%@",tokenStr);
    return tokenStr;
}

////时间转时间戳
//+(NSString *)unixTime{
//    //方法一
////    NSDate *localDate = [NSDate date]; //获取当前时间
////    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
////    NSLog(@"timeSp:%@",timeSp); //时间戳的值
//    
//        //方法二
//        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSTimeInterval a=[dat timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
//        NSString *timeSp = [NSString stringWithFormat:@"%f", a]; //转为字符型
//    
//    //    //简写之
//    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];
//    //
//    //    //C语言的time(NULL)函数也可以
//    //     NSLog(@"%ld", time(NULL));  // 这句也可以获得时间戳，跟上面一样，精确到秒
//    
//    return timeSp;
//}
//时间戳转时间
+(NSString *)getTimeFromSp{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1363948516];
    //    NSLog(@"1363948516  = %@",confromTimesp); //之后就可以对NSDate进行格式或处理
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSString *nowtimeStr = [formatter stringFromDate:confromTimesp];
    return nowtimeStr;
}


@end
