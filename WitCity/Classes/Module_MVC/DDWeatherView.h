//
//  DDWeatherView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"
#import "DDWeatherModel.h"

@interface DDWeatherView : YLView

@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , strong) UILabel *weekLabel;
@property (nonatomic , strong) UIImageView *weatherView;
@property (nonatomic , strong) UILabel *tempLabel;
@property (nonatomic , strong) UILabel *weatherLabel;
@property (nonatomic , strong) UILabel *horLabel;

//@property (nonatomic , strong) DDWeatherModel *model;

- (instancetype)initWithFrame:(CGRect)frame model:(DDWeatherModel *)model;

//-(void)setDataWithModel:(DDWeatherModel *)model;

@end
