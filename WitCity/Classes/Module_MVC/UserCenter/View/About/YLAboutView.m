//
//  YLAboutView.m
//  WitCity
//
//  Created by simpletour on 16/6/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLAboutView.h"

@interface YLAboutView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UILabel *lblEmail;
@property (nonatomic, strong) UILabel *lblVersion;
@property (nonatomic, strong) UIView *line;

@end

@implementation YLAboutView

-(void)addViews
{
    [self addSubview:self.icon];
    [self addSubview:self.lblTitle];
    [self addSubview:self.lblDetail];
    [self addSubview:self.lblPhone];
    [self addSubview:self.lblEmail];
    [self addSubview:self.lblVersion];
    [self addSubview:self.line];
}

-(void)layout
{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(self);
        make.width.and.height.mas_equalTo(70);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.icon.mas_bottom).offset(20);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(15);
    }];
    
    [self.lblVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.lblVersion.mas_top).offset(-5);
        make.height.mas_equalTo(1);
    }];
    
    [self.lblEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblDetail);
        make.bottom.mas_equalTo(self.line.mas_top).offset(-40);
    }];
    
    [self.lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblDetail);
        make.bottom.mas_equalTo(self.lblEmail.mas_top).offset(-20);
    }];
}

-(void)useStyle
{
    self.icon.image = [UIImage imageNamed:@"app_icon"];
    self.lblTitle.font = [UIFont systemFontOfSize:22];
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblPhone.font = [UIFont systemFontOfSize:14];
    self.lblEmail.font = [UIFont systemFontOfSize:14];
    self.lblVersion.font = [UIFont systemFontOfSize:14];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontBlack;
    self.lblPhone.textColor = kYLColorFontBlack;
    self.lblEmail.textColor = kYLColorFontBlack;
    self.lblVersion.textColor = kYLColorFontBlack;
    self.line.backgroundColor = kYLColorLine;
    self.lblDetail.numberOfLines = 0;
    
    self.lblTitle.text = @"智慧柳梧";
    self.lblVersion.text = @"v1.0";
    self.lblPhone.text = @"电话：0891-6855066";
    self.lblEmail.text = @"电子邮箱：lasaliuwu@163.com";
    self.lblDetail.text = @"智慧柳梧是一个集企业办事、政策法规、公告论坛、生活信息、吃喝玩乐、旅游出行、团购配送、便民查询、便民缴费、柳梧商家、柳梧企业为一体的大型综合APP， 是西藏柳梧地区内容最丰富、最具权威的移动手机应用。";
}

@end
