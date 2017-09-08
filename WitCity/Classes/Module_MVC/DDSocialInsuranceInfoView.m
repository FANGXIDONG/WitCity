//
//  SocialInsuranceInfoView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSocialInsuranceInfoView.h"
#import "YLLineBlock.h"
#import "DDRecentTwoConsumeView.h"

#define kRencentTwoConsumeViewHeight   50

@interface DDSocialInsuranceInfoView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *restLabel;
@property (nonatomic, strong) YLLineBlock *lineGap;
@property (nonatomic, strong) YLLineBlock *lineBottom;
@property (nonatomic, strong) DDRecentTwoConsumeView *recentTwoView;
@end

@implementation DDSocialInsuranceInfoView

-(void)addViews{
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.restLabel];
    [self addSubview:self.lineGap];
    [self addSubview:self.lineBottom];
    [self addSubview:self.recentTwoView];
}

-(void)layout{
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(15);
        
    }];
    
    [self.restLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.nameLabel);
    }];
    
    [self.lineGap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.restLabel.mas_bottom).offset(15);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.recentTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineGap.mas_bottom);
        make.right.and.left.mas_equalTo(0);
        make.height.mas_equalTo(kRencentTwoConsumeViewHeight);
    }];
    [self.recentTwoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchRencentTwoConsumeAction:)]];
    
    
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recentTwoView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

-(void)useStyle{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.nameLabel.text = [NSString stringWithFormat:@"用户姓名："];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = kYLColorFontBlack;
    
    self.restLabel.text = [NSString stringWithFormat:@"用户当前余额："];
    self.restLabel.textColor = kYLColorFontBlack;
    self.restLabel.font = [UIFont systemFontOfSize:14];
    
}

-(void)watchRencentTwoConsumeAction:(UITapGestureRecognizer *)tap{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeWatchRencentTwoConsume),
                             }];
}

@end







