//
//  DDRecentTwoConsumeView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/1.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRecentTwoConsumeView.h"

@interface DDRecentTwoConsumeView()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation DDRecentTwoConsumeView

-(void)addViews{
    
    [self addSubview:self.label];
    [self addSubview:self.imgView];
}

-(void)layout{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
        make.width.and.height.mas_equalTo(10);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
}

-(void)useStyle{
    
    self.label.text = @"近两笔消费";
    self.label.textColor = kYLColorFontOrange;
    self.label.font = [UIFont systemFontOfSize:14];
    
    self.imgView.image = [UIImage imageNamed:@""];
}

@end










