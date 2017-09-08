//
//  YLPushParseManager.m
//  HYB
//
//  Created by simpletour on 16/5/9.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLPushParseManager.h"

@interface YLPushParseManager ()

@end

static YLPushParseManager *_instance;

@implementation YLPushParseManager



#pragma mark - singleton
+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(YLPushParseManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

@end
