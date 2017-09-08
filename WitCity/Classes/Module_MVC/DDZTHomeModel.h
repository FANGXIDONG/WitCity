//
//  DDZTHomeModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDZTHomeModel : YLModel

@property (nonatomic, strong) NSString *icon;          //图片
@property (nonatomic, strong) NSString *begin_tm;      //开始时间
@property (nonatomic, strong) NSString *end_tm;        //结束时间
@property (nonatomic, strong) NSString *id;            //ID
@property (nonatomic, strong) NSString *current_price; //团购价
@property (nonatomic, strong) NSString *discount;      //折扣
@property (nonatomic, strong) NSString *origin_price;  //原价
@property (nonatomic, strong) NSString *name;          //名称
@property (nonatomic, strong) NSString *info;          //描述
@property (nonatomic, strong) NSString *url;           //详细接口

@end
