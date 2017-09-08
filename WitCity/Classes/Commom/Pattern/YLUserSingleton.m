//
//  FJZUserSingleton.m
//  FJZ
//
//  Created by duyulong on 11/27/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLUserSingleton.h"

static YLUserSingleton *_instance;

@implementation YLUserSingleton

+(instancetype)mj_objectWithKeyValues:(id)keyValues
{
    _instance = [super mj_objectWithKeyValues:keyValues];
    return _instance;
}

-(void)clearUserInfo
{
    _instance = nil;
}

+(YLUserSingleton *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

@end
