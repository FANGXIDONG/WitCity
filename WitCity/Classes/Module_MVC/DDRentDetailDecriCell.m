//
//  DDRentDetailDecriCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentDetailDecriCell.h"
#import "YLLineBlock.h"
#import "DDRentoutDetailModel.h"
#import "DDPositionPersonPhone.h"  //咨询电话

@interface DDRentDetailDecriCell()
@property (nonatomic, strong) UILabel *descriTitleLabel;
@property (nonatomic, strong) UILabel *descrieLabel;
@property (nonatomic, strong) YLLineBlock *line;       //分割线
@property (nonatomic, strong) DDRentoutDetailModel *model;     //分割线
@property (nonatomic, strong) DDPositionPersonPhone *ppView;
@end

@implementation DDRentDetailDecriCell


-(void)addViews{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.descriTitleLabel];
    [self.contentView addSubview:self.descrieLabel];
    [self.contentView addSubview:self.ppView];
}
-(void)layout{
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.descriTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.descrieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descriTitleLabel.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(self.descriTitleLabel);
    }];
    [self.ppView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(self.descrieLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(0);
    }];
}
-(void)useStyle{
    
    self.descriTitleLabel.text = @"房源描述";
    self.descriTitleLabel.font = [UIFont systemFontOfSize:20];
    self.descriTitleLabel.textColor = kYLColorFontBlack;
    
    self.descrieLabel.textColor = kYLColorFontGray;
    self.descrieLabel.font = [UIFont systemFontOfSize:14];
    self.descrieLabel.numberOfLines = 0;
}
-(void)updateWithModel:(id)obj{
    
    DDRentoutDetailModel *model = obj;
    self.model = model;
    self.descrieLabel.text = model.summary;
    self.ppView.phone = model.phone;
    self.ppView.person = model.person;
}
@end















