//
//  DDDataModel.h
//  WitCity
//
//  Created by 方冬冬 on 2017/7/27.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDDataModel : YLModel
@property (nonatomic, copy) NSString * reg_type;//注册类型id
@property (nonatomic, copy) NSString *reg_type_name;
@property (nonatomic, copy) NSString *industry;//行业类型id
@property (nonatomic, copy) NSString *industry_name;
@property (nonatomic, copy) NSString *contn;//联系人姓名
@property (nonatomic, copy) NSString *contp;//联系人电话
@property (nonatomic, copy) NSString *address;//公司地址
@property (nonatomic, copy) NSString *des;//公司简介
@property (nonatomic, strong) NSArray *thumb;  //file图片
@property (nonatomic, copy) NSString *user_id;//用户id
@property  (nonatomic,copy) NSString *name;//公司名称
@property (nonatomic, copy) NSString *url;
@end
