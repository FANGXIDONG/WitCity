//
//  DDWeatherView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDWeatherView.h"

@implementation DDWeatherView

-(void)addViews
{
    [self addSubview:self.dateLabel];
    [self addSubview:self.weekLabel];
    [self addSubview:self.horLabel];
    [self addSubview:self.weatherView];
    [self addSubview:self.tempLabel];
    [self addSubview:self.weatherLabel];
}

-(void)layout
{
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self).multipliedBy(0.7);
    }];
    
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel);
        make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(5);
    }];
    [self.horLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(40);
    }];
    [self.weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.horLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.horLabel);
        make.width.and.height.mas_equalTo(self.horLabel.mas_height);
    }];
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel);
        make.left.mas_equalTo(self.weatherView.mas_right).offset(5);
    }];
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weekLabel);
        make.centerX.mas_equalTo(self.tempLabel);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.alpha  = 0.8;
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = YES;
    
    self.dateLabel.textColor = kYLColorFontBlack;
    self.weekLabel.textColor = kYLColorFontBlack;
    self.tempLabel.textColor = kYLColorFontBlack;
    self.weatherLabel.textColor = kYLColorFontBlack;
    self.horLabel.backgroundColor = kYLColorFontGray;
    
    float fontSize = 0.0;
    if (IS_IPHONE_4_OR_LESS) {
        fontSize = 10;
    }if (IS_IPHONE_5) {
        fontSize = 12;
    }if (IS_IPHONE_6) {
        fontSize = 15;
    }if (IS_IPHONE_6P) {
        fontSize = 16;
    }
    self.dateLabel.font = [UIFont systemFontOfSize:fontSize];
    self.weekLabel.font = [UIFont systemFontOfSize:fontSize];
    self.tempLabel.font = [UIFont systemFontOfSize:fontSize];
    self.weatherLabel.font = [UIFont systemFontOfSize:fontSize];
}

-(instancetype)initWithFrame:(CGRect)frame model:(DDWeatherModel *)model{
    self = [super initWithFrame:frame];
    if (self) {

        self.dateLabel.text = model.date;
        self.weekLabel.text = model.week;
        [self.weatherView sd_setImageWithURL:[NSURL URLWithString:model.img1]];
        self.tempLabel.text = [NSString stringWithFormat:@"%@℃ ~ %@℃",model.temp1,model.temp2];
        self.weatherLabel.text = model.weather;
        
    }
    return self;
}


//-(instancetype)initWithFrame:(CGRect)frame model:(DDWeatherModel *)model{
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        self.backgroundColor = [UIColor whiteColor];
//        self.alpha = 0.6;
//        
//        self.dateLabel = [[UILabel alloc] init];
//        self.weekLabel = [[UILabel alloc] init];
//        self.weatherView = [[UIImageView alloc] init];
//        self.tempLabel = [[UILabel alloc] init];
//        self.weatherLabel = [[UILabel alloc] init];
//        
//        self.dateLabel.text = model.date;
//        self.weekLabel.text = model.week;
//        
//        
//        
//    }
//    return self;
//}
@end
