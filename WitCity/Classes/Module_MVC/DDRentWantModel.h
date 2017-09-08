//
//  DDRentWantModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//求租model

#import "YLModel.h"

@interface DDRentWantModel : YLModel
@property (nonatomic , copy) NSString *qzu_id;    //求租id
@property (nonatomic , copy) NSString *avatar;    //缩略图
@property (nonatomic , copy) NSString *title;     //标题   -
@property (nonatomic , copy) NSString *type;      //出租类型  -
@property (nonatomic , copy) NSString *price;     //期望租金  -
@property (nonatomic , copy) NSString *phone;     //联系电话  -
@property (nonatomic , copy) NSString *person;    //联系人   -
@property (nonatomic , copy) NSString *inserttime;//发布时间
@property (nonatomic , copy) NSString *url;       //内容详情数据接口
@property (nonatomic , copy) NSString *pages;     //总页数

@property (nonatomic , copy) NSString *area;      //区域  -
@property (nonatomic , copy) NSString *summary;   //期望房源描述 -

@property (nonatomic , copy) NSString *status;    //1审核通过 2审核中 3审核通过
@end
