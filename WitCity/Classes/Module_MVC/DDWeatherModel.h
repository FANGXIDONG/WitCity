//
//  DDWeatherModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/13.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDWeatherModel : YLModel

@property (nonatomic, copy) NSString   *date;    //日期
@property (nonatomic, copy) NSString   *week;    //周几
@property (nonatomic, copy) NSString   *temp1;   //最低温度
@property (nonatomic, copy) NSString   *temp2;   //最高温度
@property (nonatomic, copy) NSString   *img1;    //天气图标1
@property (nonatomic, copy) NSString   *img2;    //天气图标2
@property (nonatomic, copy) NSString   *weather; //天气
@end
