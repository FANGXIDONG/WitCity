//
//  YLSearchTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSearchResultTableViewCell.h"
#import "YLNewsModel.h"

@interface YLSearchResultTableViewCell ()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UIView *line;

@end

@implementation YLSearchResultTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.line];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-16);
    }];
    
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(5);
        make.right.mas_equalTo(self.lblTitle);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblDate.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)useStyle
{
    self.line.backgroundColor = kYLColorLine;
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblDate.font = [UIFont systemFontOfSize:10];
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblDate.textColor = kYLColorFontGray;
}

-(void)updateWithModel:(id)obj
{
    YLNewsModel *model = obj;
    self.lblTitle.text = model.title;
    self.lblDetail.text = model.content;
    self.lblDate.text = model.inserttime;
}

@end
