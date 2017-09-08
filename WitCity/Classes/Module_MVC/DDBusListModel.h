//
//  DDBusListModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDBusListModel : YLModel

@property (nonatomic, strong) NSNumber *n_id;   //线路id
@property (nonatomic, copy) NSString   *num;    //公交线路
@property (nonatomic, copy) NSString   *start;  //首发站
@property (nonatomic, copy) NSString   *end;    //终点站
@property (nonatomic, copy) NSString   *stime;  //首班时间
@property (nonatomic, copy) NSString   *etime;  //末班时间
@property (nonatomic, copy) NSString   *url;    //详情页Url
@end
