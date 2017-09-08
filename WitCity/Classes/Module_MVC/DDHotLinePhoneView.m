//
//  DDHotLinePhoneView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDHotLinePhoneView.h"

@interface DDHotLinePhoneView()

@property (nonatomic, strong) UIImageView *phoneView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *phoneBtn;
@end

@implementation DDHotLinePhoneView

-(void)addViews {

    [self addSubview:self.phoneView];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneBtn];
}

-(void)layout{
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(self.phoneView.mas_height);
        make.left.mas_equalTo(20);
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(self);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(self.phoneView);
        make.right.mas_equalTo(self.phoneBtn.mas_left).mas_offset(20);
    }];
    
}

-(void)useStyle{
    
    self.backgroundColor = [UIColor whiteColor];
    self.phoneView.image = [UIImage imageNamed:@"hotline_phone"];
    self.phoneLabel.textColor =[UIColor greenColor];
    self.phoneLabel.font = [UIFont systemFontOfSize:20];
    self.phoneBtn.backgroundColor = [UIColor redColor];
    [self.phoneBtn setTitle:@"拨号" forState:UIControlStateNormal];
    [self.phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.phoneBtn addTarget:self action:@selector(callPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setPhone:(NSString *)phone{
    
    self.phoneLabel.text = phone;
}

-(void)callPhoneAction:(UIButton *)sender{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeHotlineSend)
                             }];
}

@end












