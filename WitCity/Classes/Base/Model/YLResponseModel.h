//
//  RYResponseModel.h
//  TongHua
//
//  Created by simpletour on 16/2/5.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "YLModel.h"

typedef NS_ENUM(NSUInteger, YLResponseState) {
    kYLResponseStateSuccess = 0, //网络请求成功
    kYLResponseStateFailure,     //网络请求失败
};

@interface YLResponseModel : YLModel

@property (nonatomic, copy)   NSString *errcode;   //错误码
@property (nonatomic, strong) id    contentlist;   //数据
@property (nonatomic, copy)   NSString *msg;       //服务器返回消息

@end
