//
//  YLReplyTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/6/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLReplyTableViewCell.h"
#import "YLNewsModel.h"

@interface YLReplyTableViewCell ()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UILabel *lblReply;

@end

@implementation YLReplyTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.lblReply];
}

-(void)layout
{
    [self.lblReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
    }];
    
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.lblReply);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblReply.mas_bottom).offset(5);
        make.left.mas_equalTo(self.lblReply);
        make.right.mas_equalTo(self.lblDate);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(5);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblReply.font = [UIFont systemFontOfSize:12];
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblDate.textColor = kYLColorFontGray;
    self.lblReply.textColor = kYLColorFontGray;
}

-(void)updateWithModel:(id)obj
{
    YLNewsModel *model = obj;
    self.lblReply.text = [NSString stringWithFormat:@"%@回复我:", model.rname];
    self.lblTitle.text = model.title;
    self.lblDetail.text = model.content;
    self.lblDate.text = model.rinserttime;
}


@end
