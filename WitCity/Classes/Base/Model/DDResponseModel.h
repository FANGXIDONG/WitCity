//
//  DDResponseModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/5.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//调用组团钟接口返回的model

#import "YLModel.h"
typedef NS_ENUM(NSUInteger, DDResponseState) {
    
    kDDResponseStateFailure = 0,     //没有data数据
    kDDResponseStateSuccess , //操作成功
};

@interface DDResponseModel : YLModel

@property (nonatomic, copy) NSString *status;  //状态 0 错误 1成功
@property (nonatomic, copy) NSString *code;    //编码
@property (nonatomic, copy) NSString *message; //描述,
@property (nonatomic, copy) id data; //数据,
@end








