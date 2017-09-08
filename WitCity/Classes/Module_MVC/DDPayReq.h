//
//  DDPayReq.h
//  WitCity
//
//  Created by 方冬冬 on 2016/11/22.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//拉起发起微信支付

#import "YLModel.h"

@interface DDPayReq : YLModel

@property (nonatomic, copy) NSString *appid;     //应用ID
@property (nonatomic, copy) NSString *partnerid; //商户号
@property (nonatomic, copy) NSString *prepayid;  //预支付交易回话id
@property (nonatomic, copy) NSString *package;   //扩展字段，Sign=WXPay
@property (nonatomic, copy) NSString *noncestr;  //随机字符串
@property (nonatomic, copy) NSString *timestamp; //时间戳
@property (nonatomic, copy) NSString *sign;      //签名
@property (nonatomic, copy) NSString *orderid;   //订单流水号
@end
