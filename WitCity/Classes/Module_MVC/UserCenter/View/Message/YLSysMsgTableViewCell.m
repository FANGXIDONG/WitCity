//
//  YLSysMsgTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/6/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSysMsgTableViewCell.h"
#import "YLNewsModel.h"

@interface YLSysMsgTableViewCell ()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblDate;

@end

@implementation YLSysMsgTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblDate];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(5);
    }];
    
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblDetail.mas_bottom).offset(5);
        make.right.mas_equalTo(self.lblTitle);
        make.bottom.mas_equalTo(-10);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:16];
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblDate.textColor = kYLColorFontGray;
    self.lblTitle.numberOfLines = 0;
    self.lblDetail.numberOfLines = 0;
}

-(void)updateWithModel:(id)obj
{
    YLNewsModel *model = obj;
    self.lblTitle.text = model.title;
    self.lblDetail.text = model.content;
    self.lblDate.text = model.inserttime;
}

@end
