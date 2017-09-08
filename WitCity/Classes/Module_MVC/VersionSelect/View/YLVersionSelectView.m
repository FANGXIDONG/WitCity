//
//  YLVersionSelectView.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLVersionSelectView.h"

@interface YLVersionSelectView ()

@property (nonatomic, strong) UIImageView *ivEnterprise;
@property (nonatomic, strong) UIImageView *ivLife;
@property (nonatomic, strong) UIButton *btnEnterprise;
@property (nonatomic, strong) UIButton *btnLife;

@end

@implementation YLVersionSelectView

-(void)addViews
{
    [self addSubview:self.ivEnterprise];
    [self addSubview:self.ivLife];
    [self.ivEnterprise addSubview:self.btnEnterprise];
    [self.ivLife addSubview:self.btnLife];
}

-(void)layout
{
    [self.ivEnterprise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    [self.ivLife mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.ivEnterprise);
        make.top.mas_equalTo(self.ivEnterprise.mas_bottom);
    }];
    
    [self.btnEnterprise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ivEnterprise);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.btnLife mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.with.and.height.mas_equalTo(self.btnEnterprise);
        make.centerY.mas_equalTo(self.ivLife);
    }];
}

-(void)useStyle
{
    [self.btnEnterprise setTitle:@"企业" forState:UIControlStateNormal];
    [self.btnLife setTitle:@"生活" forState:UIControlStateNormal];
}

@end
