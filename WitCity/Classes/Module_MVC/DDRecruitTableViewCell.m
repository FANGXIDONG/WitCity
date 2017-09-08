//
//  DDRecruitTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRecruitTableViewCell.h"
#import "DDRecruitModel.h"       //招聘model

@interface DDRecruitTableViewCell ()

//招聘
@property (nonatomic , strong) UIImageView *logoView; //LOGO
@property (nonatomic , strong) UILabel *lblName;      //公司名称
@property (nonatomic , strong) UILabel *lblArea;      //公司范围及地址
@property (nonatomic , strong) UILabel *lblDate;      //招聘时间
@property (nonatomic , strong) UILabel *lblSalary;    //薪资范围
@property (nonatomic , strong) DDRecruitModel *model;

@end

@implementation DDRecruitTableViewCell


-(void)addViews
{
    /**
     *  使用UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h自适应时一定要加到self.contentView上不能是self上【方冬冬】
     */
    [self.contentView addSubview:self.logoView];
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.lblArea];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.lblSalary];

}

-(void)layout
{
//招聘
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(60);
//        make.height.and.width.mas_equalTo(60);
    }];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
        make.top.mas_equalTo(self.logoView);
        make.right.mas_equalTo(-100);
    }];
    
    [self.lblArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.mas_equalTo(self.lblName);
        make.top.mas_equalTo(self.lblName.mas_bottom).offset(5);
        
    }];
    
    [self.lblSalary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lblArea);
    }];
    
    /**
     *  使用自适应高度的时候一定要加上make.bottom距离视图下面的高度，不然高度测试不了，导致重叠【方冬冬】
     *
     */
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblSalary.mas_bottom).offset(5);
        make.left.mas_equalTo(self.lblArea);
        make.bottom.mas_equalTo(-10);            //attention
    }];
}

-(void)useStyle
{
    
    //招聘
    self.lblName.font = [UIFont boldSystemFontOfSize:16];
    self.lblName.numberOfLines = 0;
    self.lblName.textColor =kYLColorFontBlack;
    
    self.lblArea.font = [UIFont systemFontOfSize:12];
    self.lblArea.numberOfLines = 0;
    self.lblArea.textColor =kYLColorFontGray;

    self.lblDate.font = [UIFont systemFontOfSize:13];
    self.lblDate.textColor = kYLColorFontGray;
    
    self.lblSalary.font = [UIFont systemFontOfSize:17];
    self.lblSalary.textColor = kYLColorFontRed;
    
}

-(void)updateWithModel:(id)obj
{
    
    //招聘
    DDRecruitModel *model = obj;
    self.model = model;
    self.lblName.text = model.business;
    self.lblArea.text = [NSString stringWithFormat:@"%@ [%@]",model.position,model.address];
    self.lblDate.text = model.inserttime;
    [self.logoView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"ic_page"]];
//    (1.2K以下，2.2-3K,3.3-5K,4.5-8K,5.8-10K,6.10K以上，7.面议)
    if ([model.salary intValue] == 1) {
        self.lblSalary.text = @"小于2K";
    }
    if ([model.salary intValue] == 2) {
        self.lblSalary.text = @"2K - 3K";
    }
    if ([model.salary intValue] == 3) {
        self.lblSalary.text = @"3K - 5K";
    }
    if ([model.salary intValue] == 4) {
        self.lblSalary.text = @"5K - 8K";
    }
    if ([model.salary intValue] == 5) {
        self.lblSalary.text = @"8K -10K";
    }
    if ([model.salary intValue] == 6) {
        self.lblSalary.text = @"10k以上";
    }
    if ([model.salary intValue] == 7) {
        self.lblSalary.text = @"面议";
    }


}

@end




































