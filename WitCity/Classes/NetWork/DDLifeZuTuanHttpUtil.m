//
//  DDLifeZuTuanHttpUtil.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeZuTuanHttpUtil.h"
#import "DDResponseModel.h"

@implementation DDLifeZuTuanHttpUtil


+ (void)getTestDataWithInfo:(NSString *)info page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{

    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [self setWithMutableDict:d key:@"key" value:@""];
    [self setWithMutableDict:d key:@"cid" value:@3];
    NSMutableDictionary *di = [NSMutableDictionary dictionary];
    [self setWithMutableDict:di key:@"type" value:@0];
    [self setWithMutableDict:di key:@"direction" value:@"desc"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self setWithMutableDict:dic key:@"page" value:@(page)];
    [self setWithMutableDict:dic key:@"pagesize" value:@100];
    [self setWithMutableDict:dic key:@"opt" value:d];
    [self setWithMutableDict:dic key:@"order" value:di];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [self setWithMutableDict:paramDic key:@"param" value:dic];
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"account" value:INNDER_ACCOUNT_ID];
    [self setWithMutableDict:md key:@"token" value:ZUTUAN_TOKEN];
    [self setWithMutableDict:md key:@"sysytem" value:@3];
    [self setWithMutableDict:md key:@"client" value:@1];
    [self setWithMutableDict:md key:@"info" value:paramDic];
    
    [self postZuTuanWithAction:ZUTUAN_HTTP_INFO params:md type:kYLHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            
            dict(result.data);
        } else {
            [YLToast showToastInKeyWindowWithText:result.message];
            failure();
        }
    } failure:^{
        failure();
    }];
}

@end














