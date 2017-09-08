//
//  ScopeOfFundsView.m
//  WitCity
//
//  Created by 刘帅 on 17/1/4.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "ScopeOfFundsView.h"

@interface ScopeOfFundsView()

@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIButton *btn3;
@property (nonatomic, strong)UIButton *btn4;
@property (nonatomic, strong)UIButton *btn5;
@property (nonatomic, strong)UIButton *btn6;
@property (nonatomic, strong)UIImageView *backgroundImage;

@end

@implementation ScopeOfFundsView

-(void)addViews
{
    [self addSubview:self.backgroundImage];
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    [self addSubview:self.btn4];
    [self addSubview:self.btn5];
    [self addSubview:self.btn6];
}

-(void)layout
{
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_bottom).offset(10);
        make.left.equalTo(self.btn1.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn3.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn3.mas_bottom).offset(10);
        make.left.equalTo(self.btn3.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn5.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
}

-(void)useStyle
{
    self.backgroundImage.image = [UIImage imageNamed:@"ScopeOfFunds"];
    [self.btn1 setTitle:@"0~100万" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btn1.backgroundColor = [UIColor lightGrayColor];
    
    [self.btn2 setTitle:@"101~500万" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btn2.backgroundColor = [UIColor lightGrayColor];
    
    [self.btn3 setTitle:@"501~1000万" forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btn3.backgroundColor = [UIColor lightGrayColor];
    
    [self.btn4 setTitle:@"1001~5000万" forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn4.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btn4.backgroundColor = [UIColor lightGrayColor];
    
    [self.btn5 setTitle:@"5001~10000万" forState:UIControlStateNormal];
    [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn5.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btn5.backgroundColor = [UIColor lightGrayColor];
    
    [self.btn6 setTitle:@"10000万以上" forState:UIControlStateNormal];
    [self.btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn6.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btn6.backgroundColor = [UIColor lightGrayColor];
    
    [self.btn1 addTarget:self action:@selector(postActionNF1)];
    [self.btn2 addTarget:self action:@selector(postActionNF2)];
    [self.btn3 addTarget:self action:@selector(postActionNF3)];
    [self.btn4 addTarget:self action:@selector(postActionNF4)];
    [self.btn5 addTarget:self action:@selector(postActionNF5)];
    [self.btn6 addTarget:self action:@selector(postActionNF6)];
}

- (void)postActionNF1 {
    [ND postNotificationName:@"ScopeOfFundsPost" object:@"1"];
}

- (void)postActionNF2 {
    [ND postNotificationName:@"ScopeOfFundsPost" object:@"2"];
}

- (void)postActionNF3 {
    [ND postNotificationName:@"ScopeOfFundsPost" object:@"3"];
}

- (void)postActionNF4 {
    [ND postNotificationName:@"ScopeOfFundsPost" object:@"4"];
}

- (void)postActionNF5 {
    [ND postNotificationName:@"ScopeOfFundsPost" object:@"5"];
}

- (void)postActionNF6 {
    [ND postNotificationName:@"ScopeOfFundsPost" object:@"6"];
}


@end
