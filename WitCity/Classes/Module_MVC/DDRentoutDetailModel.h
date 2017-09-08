//
//  DDRentoutDetailModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//出租详情

#import "YLModel.h"

@interface DDRentoutDetailModel : YLModel

@property (nonatomic, copy) NSString *lease_id;   //出租id
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *price;      //租金
@property (nonatomic, copy) NSString *address;    //地址
@property (nonatomic, copy) NSString *type;       //类型
@property (nonatomic, copy) NSString *source;     //1个人房东 2中介
@property (nonatomic, copy) NSString *floor;      //楼层
@property (nonatomic, copy) NSString *config;     //房屋配置
@property (nonatomic, copy) NSString *summary;    //房源描述
@property (nonatomic, copy) NSString *person;     //联系人姓名
@property (nonatomic, copy) NSString *phone;      //联系电话
@property (nonatomic, copy) NSString *thumb;      //缩略图
@property (nonatomic, copy) NSString *inserttime; //发布时间
@end

