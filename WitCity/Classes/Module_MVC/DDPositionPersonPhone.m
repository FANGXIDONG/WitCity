//
//  DDPositionPersonPhone.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPositionPersonPhone.h"
#import "YLLineBlock.h"

@interface DDPositionPersonPhone()

@property (nonatomic, strong) UILabel *personLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) YLLineBlock *line;
@end

@implementation DDPositionPersonPhone

-(void)addViews {
    
    [self addSubview:self.personLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneBtn];
    [self addSubview:self.line];
}

-(void)layout{
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(self);
    }];
    
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self).multipliedBy(0.25);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(self.phoneBtn.mas_left).offset(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(25);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.personLabel);
//        make.centerY.mas_equalTo(self).multipliedBy(1.75);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(self.personLabel);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

-(void)useStyle{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.phoneLabel.textColor =kYLColorFontOrange;
    self.phoneLabel.font = [UIFont systemFontOfSize:18];
    self.phoneLabel.textAlignment = 1;
    self.personLabel.textColor =kYLColorFontBlack;
    self.personLabel.font = [UIFont systemFontOfSize:18];
    self.personLabel.textAlignment =1;
    
    self.phoneBtn.backgroundColor = kYLColorFontRed;
    [self.phoneBtn setTitle:@"咨询" forState:UIControlStateNormal];
    [self.phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.phoneBtn addTarget:self action:@selector(callPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setPhone:(NSString *)phone{
    
    self.phoneLabel.text = phone;
}

-(void)setPerson:(NSString *)person{
    self.personLabel.text = person;
}

-(void)callPhoneAction:(UIButton *)sender{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeHotlineInquire),
                             kYLValue:self.phoneLabel.text,
                             }];
}

@end
