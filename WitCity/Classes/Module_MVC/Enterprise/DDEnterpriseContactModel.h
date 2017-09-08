//
//  DDEnterpriseContactModel.h
//  WitCity
//
//  Created by 方冬冬 on 2017/1/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDEnterpriseContactModel : YLModel
@property (nonatomic , copy) NSString *txl_id;//通讯录id
@property (nonatomic , copy) NSString *name;  //法人
@property (nonatomic , copy) NSString *company;//公司
@property (nonatomic , copy) NSString *phone;  //电话
@property (nonatomic , copy) NSString *url;    //详情页面
@end
