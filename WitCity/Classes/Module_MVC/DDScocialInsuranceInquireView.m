//
//  DDScocialInsuranceInquireView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/1.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDScocialInsuranceInquireView.h"
#import "YLLoginTextField.h"
#import "DDRadioButton.h"

@interface DDScocialInsuranceInquireView()<DDRadioButtonDelegate>

@property (nonatomic, strong) YLLoginTextField *phoneTxt;
@property (nonatomic, strong) UIButton *inquireBtn;
@property (nonatomic, strong) DDRadioButton *restBtn;        //余额
@property (nonatomic, strong) DDRadioButton *recentSpendBtn; //近两笔消费
@property (nonatomic, copy) NSString *inquireType;  //0查余额  1查近两笔消费
@end

@implementation DDScocialInsuranceInquireView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self  = [super initWithFrame:frame];
    if (self) {
    
        self.restBtn = [[DDRadioButton alloc]initWithDelegate:self groupId:@"remaind"];
        self.restBtn.frame= CGRectMake(15, 80, 100, 30);
        [self.restBtn setTitle:@"余额" forState:UIControlStateNormal];
        [self.restBtn setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
        [self.restBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.restBtn setChecked:YES];
        [self addSubview:self.restBtn];
        
        self.recentSpendBtn = [[DDRadioButton alloc]initWithDelegate:self groupId:@"remaind"];
        self.recentSpendBtn.frame= CGRectMake(135, 80, 100, 30);
        [self.recentSpendBtn setTitle:@"近两笔消费" forState:UIControlStateNormal];
        [self.recentSpendBtn setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
        [self.recentSpendBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:self.recentSpendBtn];
        
        self.inquireType  = @"0";
    }
    
    return self;
}

-(void)addViews{
    
    [self addSubview:self.inquireBtn];
    [self addSubview:self.phoneTxt];
//    [self addSubview:self.restBtn];
//    [self addSubview:self.recentSpendBtn];
}

-(void)layout{
    
    [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    
//    [self.restBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(self.phoneTxt.mas_bottom).offset(15);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(100);
//    }];
//    
//    [self.recentSpendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.restBtn.mas_right).offset(20);
//        make.top.mas_equalTo(self.restBtn);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(180);
//    }];
    
    
    [self.inquireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.phoneTxt.mas_bottom).offset(100);
        make.height.mas_equalTo(50);
    }];
    
}

-(void)useStyle{
    
    self.backgroundColor =kYLColorBakcgorund;
    
    self.phoneTxt.placeholder  =[NSString stringWithFormat:@"当前绑定手机号：%@",[YLUserSingleton shareInstance].phone];
    self.phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTxt.validateType = kYLTextFieldTypeUsername;
    self.phoneTxt.enabled = NO;
    [self.phoneTxt setValue:kYLColorFontGray forKeyPath:@"_placeholderLabel.textColor"];
    
////    self.restBtn = [[DDRadioButton alloc]initWithDelegate:self groupId:@"remaind"];
////    self.restBtn.frame= CGRectMake(15, 80, 100, 30);
//    [self.restBtn setTitle:@"余额" forState:UIControlStateNormal];
//    [self.restBtn setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
//    [self.restBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
//    [self.restBtn setChecked:YES];
//    
//    self.restBtn.backgroundColor = kYLColorFontRed;
//    self.recentSpendBtn.backgroundColor = kYLColorFontRed;
//    
////    self.recentSpendBtn = [[DDRadioButton alloc]initWithDelegate:self groupId:@"remaind"];
////    self.recentSpendBtn.frame= CGRectMake(135, 80, 100, 30);
//    [self.recentSpendBtn setTitle:@"近两笔消费" forState:UIControlStateNormal];
//    [self.recentSpendBtn setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
//    [self.recentSpendBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    self.inquireBtn.backgroundColor = kDDColorSkyBlue;
    [self.inquireBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.inquireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.inquireBtn addTarget:self action:@selector(inquireSIAction:) forControlEvents:UIControlEventTouchUpInside  ];
    self.inquireBtn.layer.cornerRadius = 5;
    self.inquireBtn.layer.masksToBounds = YES;
}

-(void)inquireSIAction:(UIButton *)sender{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeSocialInsurnceInquire),
                             kYLValue:self.inquireType,
                             }];
}

-(void)didSelectedRadioButton:(DDRadioButton *)radio groupId:(NSString *)groupId
{
    if ([radio.titleLabel.text isEqualToString:@"余额"]) {
//        NSLog(@"余额");
        self.inquireType = @"0";
    }
    if ([radio.titleLabel.text isEqualToString:@"近两笔消费"]) {
//        NSLog(@"近两笔消费");
        self.inquireType = @"1";
    }

}


@end













