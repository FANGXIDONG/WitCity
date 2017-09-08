//
//  DDTravelTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDTravelTableViewCell.h"
#import "DDBusListModel.h"

@interface DDTravelTableViewCell ()

@property (nonatomic, strong) UILabel *lblBusNum;    //线路
@property (nonatomic, strong) UILabel *lblBusStart;  //首发站
@property (nonatomic ,strong) UILabel *lblBusEnd;    //终点站
@property (nonatomic ,strong) UIImageView *startImg; //首
@property (nonatomic ,strong) UIImageView *toImg;    //箭头
@property (nonatomic ,strong) UIImageView *endImg;   //末
@property (nonatomic ,strong) UILabel *lblStime;     //首发时间
@property (nonatomic ,strong) UILabel *lblEtime;     //末班时间
@property (nonatomic, strong) DDBusListModel *model;

@end

@implementation DDTravelTableViewCell


-(void)addViews
{
    [self.contentView addSubview:self.lblBusNum];
    [self.contentView addSubview:self.lblBusStart];
    [self.contentView addSubview:self.lblBusEnd];
    [self.contentView addSubview:self.startImg];
    [self.contentView addSubview:self.toImg];
    [self.contentView addSubview:self.endImg];
    [self.contentView addSubview:self.lblStime];
    [self.contentView addSubview:self.lblEtime];
}

-(void)layout
{
    [self.lblBusNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-50);
    }];
    
    [self.lblBusStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblBusNum);
        make.top.mas_equalTo(self.lblBusNum.mas_bottom).offset(10);
    }];
    
    [self.toImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblBusStart.mas_right).offset(5);
        make.top.mas_equalTo(self.lblBusNum.mas_bottom).offset(17);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(6);
    }];
    
    [self.lblBusEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.toImg.mas_right).offset(5);
        make.top.mas_equalTo(self.lblBusStart);
    }];
    
    [self.startImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblBusStart);
        make.top.mas_equalTo(self.lblBusStart.mas_bottom).offset(10);
        make.width.and.height.mas_equalTo(15);
    }];
    
    [self.lblStime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.startImg.mas_right).offset(8);
        make.top.mas_equalTo(self.lblBusStart.mas_bottom).offset(13);
    }];
    
    [self.endImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblStime.mas_right).offset(30);
        make.top.mas_equalTo(self.startImg);
        make.width.and.height.mas_equalTo(15);
    }];
    
    [self.lblEtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.endImg.mas_right).offset(8);
        make.top.mas_equalTo(self.lblStime);
    }];
}

-(void)useStyle
{
    self.lblBusNum.font = [UIFont systemFontOfSize:18];
    self.lblBusNum.textColor =kYLColorFontYellow;
    
    self.lblBusStart.font = [UIFont systemFontOfSize:14];
    self.lblBusStart.textColor =kYLColorFontBlack;
    
    self.toImg.image =[UIImage imageNamed:@"travel_to"];
    
    self.lblBusEnd.font = [UIFont systemFontOfSize:14];
    self.lblBusEnd.textColor = kYLColorFontBlack;
    
    self.startImg.image =[UIImage imageNamed:@"travel_shou"];
    
    self.endImg.image = [UIImage imageNamed:@"travel_mo"];
    
    self.lblStime.font = [UIFont systemFontOfSize:10];
    self.lblStime.textColor = kYLColorFontGray;
    
    self.lblEtime.font = [UIFont systemFontOfSize:10];
    self.lblEtime.textColor = kYLColorFontGray;
}

-(void)updateWithModel:(id)obj
{
    DDBusListModel *model = obj;
    self.model = model;
    self.lblBusNum.text = model.num;
    self.lblBusStart.text = model.start;
    self.lblBusEnd.text = model.end;
    self.lblStime.text = model.stime;
    self.lblEtime.text = model.etime;
}


@end


