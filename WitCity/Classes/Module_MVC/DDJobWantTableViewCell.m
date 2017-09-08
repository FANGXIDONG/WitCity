//
//  DDJobWantTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/7.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDJobWantTableViewCell.h"
#import "DDJobSeekModel.h"       //求职model

@interface DDJobWantTableViewCell()
//求职
@property (nonatomic , strong) UIImageView *personThumb; //求职者头像
@property (nonatomic , strong) UILabel *personName;      //求职者名字
@property (nonatomic , strong) UILabel *personExperience;//求职经验
@property (nonatomic , strong) UILabel *personDate;      //求职时间
@property (nonatomic , strong) DDJobSeekModel *jobSeekmodel;
@end

@implementation DDJobWantTableViewCell

-(void)addViews{
    [self.contentView addSubview:self.personThumb];
    [self.contentView addSubview:self.personName];
    [self.contentView addSubview:self.personExperience];
    [self.contentView addSubview:self.personDate];
}

-(void)layout{
    //求职
    [self.personThumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
//        make.height.and.width.mas_equalTo(60);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(45);
    }];
    
    [self.personDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.personThumb);
        make.right.mas_equalTo(-10);
    }];
    
    [self.personName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.personThumb.mas_right).offset(10);
        make.top.mas_equalTo(self.personThumb);
    }];
    
    [self.personExperience mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.personName.mas_bottom).offset(10);
        make.left.mas_equalTo(self.personName);
        make.bottom.mas_equalTo(-10);            //attention
    }];
    
}
-(void)useStyle{
    
    self.personThumb.layer.cornerRadius = 30;
    self.personThumb.layer.masksToBounds = YES;
    //求职
    self.personName.font = [UIFont boldSystemFontOfSize:16];
    self.personName.numberOfLines = 0;
    self.personName.textColor =kYLColorFontBlack;
    
    self.personExperience.font = [UIFont systemFontOfSize:12];
    self.personExperience.numberOfLines = 0;
    self.personExperience.textColor =kYLColorFontGray;
    
    self.personDate.font = [UIFont systemFontOfSize:11];
    self.personDate.textColor = kYLColorFontGray;
}

-(void)updateWithModel:(id)obj{
    //求职
    DDJobSeekModel  *jobModel  = obj;
    self.jobSeekmodel   = jobModel;
    self.personName.text = jobModel.name;
    self.personDate.text = jobModel.inserttime;
    [self.personThumb sd_setImageWithURL:[NSURL URLWithString:jobModel.avatar] placeholderImage:[UIImage imageNamed:@""]];
//    工作经验：1、无经验2、 1年以下3、1-3年4、3-5年5、5年以上;
    
    NSString *experienceStr;
    if ([jobModel.experience intValue] == 1) {
        experienceStr = @"无经验";
    }
    if ([jobModel.experience intValue] == 2) {
        experienceStr = @"1年以下";
    }
    if ([jobModel.experience intValue] == 3) {
        experienceStr = @"1-3年";
    }
    if ([jobModel.experience intValue] == 4) {
        experienceStr = @"3-5年";
    }
    if ([jobModel.experience intValue] == 5) {
        experienceStr = @"5年以上";
    }
    self.personExperience.text = [NSString stringWithFormat:@"工作经验：%@",experienceStr];
    
}
@end





