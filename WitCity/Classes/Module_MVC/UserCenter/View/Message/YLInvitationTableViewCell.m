//
//  YLInvitationTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/6/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLInvitationTableViewCell.h"
#import "YLNewsModel.h"

@interface YLInvitationTableViewCell ()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UIButton *btnNumber;
@property (nonatomic, strong) UIButton *btnStatus;
@property (nonatomic, strong) YLNewsModel *model;

@end

@implementation YLInvitationTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.btnStatus];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.btnNumber];
}

-(void)layout
{
    [self.btnStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.btnStatus.mas_bottom);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(0);
    }];
    
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblDetail.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.btnNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblDate);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(self.lblDate);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.btnNumber.titleLabel.font = [UIFont systemFontOfSize:12];
    self.btnStatus.titleLabel.font = [UIFont systemFontOfSize:12];

    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblDate.textColor = kYLColorFontGray;
    [self.btnNumber setTitleColor:kYLColorFontGray forState:UIControlStateNormal];
    [self.btnStatus setTitleColor:kYLColorFontRed forState:UIControlStateNormal];
    [self.btnNumber setImage:[UIImage imageNamed:@"wdxx_wdfticon1"] forState:UIControlStateNormal];
    [self.btnStatus setImage:[UIImage imageNamed:@"wdxx_wdfticon"] forState:UIControlStateNormal];
    self.btnNumber.enabled = NO;
    self.btnStatus.enabled = NO;
    self.btnStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.btnNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

-(void)updateWithModel:(id)obj
{
    YLNewsModel *model = obj;
    self.model = model;
    self.lblTitle.text = model.name;
    self.lblDate.text = model.inserttime;
    self.lblDetail.text = model.content;
    [self.btnStatus setTitle:model.status forState:UIControlStateNormal];
    [self.btnNumber setTitle:[NSString stringWithFormat:@"共%@个回帖", model.reply] forState:UIControlStateNormal];
}

@end
