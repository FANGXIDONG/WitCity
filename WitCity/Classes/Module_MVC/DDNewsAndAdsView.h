//
//  DDNewsAndAdsView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//


#import "YLView.h"
#import "DDNewsModel.h"      //新闻广告model
#import "DDWeatherView.h"    //天气视图
#import "DDWeatherModel.h"

@interface DDNewsAndAdsView : YLView

//@property (nonatomic ,strong) DDWeatherModel *weatherModel; //天气Model
- (instancetype)initWithFrame:(CGRect)frame newsAndAdsmodel:(DDNewsModel *)naModel weatherModel:(DDWeatherModel *)wModel;

@end
