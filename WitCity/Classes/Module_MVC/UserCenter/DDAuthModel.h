//
//  DDAuthModel.h
//  WitCity
//
//  Created by 方冬冬 on 2017/8/1.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDAuthModel : YLModel
@property (nonatomic, copy) NSString *reg_num;//纳税识别号
@property (nonatomic, copy) NSString *owner_name;//法人姓名
@property (nonatomic, copy) NSString *owner_idcard;//法人身份证号
@property (nonatomic, copy) NSString *owner_phone;//法人电话
@property (nonatomic, copy) NSString *is_new;//0:非高新区1高新区
@property (nonatomic, copy) NSString *is_check;//0未认证1已认证
@property (nonatomic, copy) NSString *name;//公司名称
@end
