

//
//  DDConfirmRechargeView.m
//  WitCity
//
//  Created by 方冬冬 on 2016/12/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDConfirmRechargeView.h"

@interface DDConfirmRechargeView()
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UIView  *line;        //分割线
@property (nonatomic, strong) UILabel *orderIdLabel;//订单号
@property (nonatomic, strong) UILabel *phoneLabel;  //手机号
@property (nonatomic, strong) UILabel *moneyLabel;  //充值金额
@property (nonatomic, strong) UIButton *confirmBtn; //确认支付按钮
@end

@implementation DDConfirmRechargeView
-(void)addViews
{
    [self addSubview:self.bgView];
    [self addSubview:self.confirmBtn];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.orderIdLabel];
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.moneyLabel];
}
-(void)layout
{
   [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.and.right.and.top.mas_equalTo(self);
       make.height.mas_equalTo(200);
   }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.line.mas_bottom).offset(20);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.titleLabel);
        make.top.top.mas_equalTo(self.orderIdLabel.mas_bottom).offset(20);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.titleLabel);
        make.top.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(20);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
}
-(void)useStyle
{
    self.backgroundColor = kYLColorBakcgorund;
    self.bgView.backgroundColor =[UIColor whiteColor];
    
    self.titleLabel.text = @"请确认支付信息";
    self.titleLabel.textColor = kYLColorFontBlack;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.line.backgroundColor =  kYLColorBakcgorund;
    
//    self.orderIdLabel.text = @"订单号：1234567890";
    self.orderIdLabel.textColor = kYLColorFontBlack;
    self.orderIdLabel.font = [UIFont systemFontOfSize:15];
    self.orderIdLabel.adjustsFontSizeToFitWidth = YES;
    
//    self.phoneLabel.text = @"手机号：15205145990";
    self.phoneLabel.textColor = kYLColorFontBlack;
    self.phoneLabel.font = [UIFont systemFontOfSize:15];
    
//    self.moneyLabel.text = @"充值金额：1234567890";
    self.moneyLabel.textColor = kYLColorFontBlack;
    self.moneyLabel.font = [UIFont systemFontOfSize:15];
    
    [self.confirmBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirmBtn.backgroundColor = kYLColorFontOrange;
    
    [self.confirmBtn addTarget:self action:@selector(confirmPayAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)confirmPayAction:(UIButton *)sender{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeWechatPayConfirmPay),
                             }];
}

-(void)setValuesWith:(DDPayReq *)req request:(DDRequestModel *)request
{
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单号：%@",req.prepayid];
    self.phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",request.phone];
    self.moneyLabel.text = [NSString stringWithFormat:@"充值金额：%@",request.money];
}
@end














