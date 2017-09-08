//
//  DDRequestModel.h
//  WitCity
//
//  Created by 方冬冬 on 2016/12/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDRequestModel : YLModel
@property (nonatomic, copy) NSString *body;     //商品描述
@property (nonatomic, copy) NSString *money;    //充值金额（实际支付，单位为分）
@property (nonatomic, copy) NSString *phone;    //充值电话
@property (nonatomic, copy) NSString *prodid;   //产品id
@property (nonatomic, copy) NSString *filltype; //充值类型（默认KC）
@property (nonatomic, copy) NSString *incretype;//充值商品类型（默认phoneincrement）
@end
