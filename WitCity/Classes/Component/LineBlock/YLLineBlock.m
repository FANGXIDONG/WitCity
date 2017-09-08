//
//  YLLineBlock.m
//  HYB
//
//  Created by simpletour on 16/3/28.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLLineBlock.h"

@interface YLLineBlock ()

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation YLLineBlock

-(void)addViews
{
    [self addSubview:self.line1];
    [self addSubview:self.line2];
}

-(void)layout
{
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.backgroundColor = kYLColorBakcgorund;
    self.line1.backgroundColor = kYLColorLine;
    self.line2.backgroundColor = kYLColorLine;
}


@end
