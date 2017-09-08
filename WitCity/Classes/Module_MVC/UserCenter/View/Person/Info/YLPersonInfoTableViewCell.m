//
//  YLPersonInfoTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPersonInfoTableViewCell.h"

@interface YLPersonInfoTableViewCell ()

@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIView      *lineTop;
@property (nonatomic, strong) UIView      *lineBottom;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel     *lblTitle;


@end

@implementation YLPersonInfoTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.lineTop];
    [self.contentView addSubview:self.lineBottom];
    [self.contentView addSubview:self.arrow];
}

-(void)layout
{
    [self.lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(15);
    }];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.arrow.mas_left).offset(-21);
        make.width.and.height.mas_equalTo(65);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.lblTitle.mas_right).offset(10);
        make.right.mas_equalTo(self.arrow.mas_left).offset(-15);
    }];
}

-(void)useStyle
{
    self.avatar.image = HEADER_PLACEHOLDER;
    self.arrow.image = [UIImage imageNamed:@"u_arrow"];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 32.5;
    self.textField.placeholder = @"未填写";
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = kYLColorFontGray;
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.enabled = NO;
}

-(void)setStyle:(YLPersonInfoCellStyle)style
{
    switch (style) {
        case kYLPersonInfoCellStyleDefault:{
            self.avatar.hidden = YES;
            
        }break;
        case kYLPersonInfoCellStyleAvatar:{
            self.avatar.hidden = NO;
            self.textField.text = @"";
            self.textField.hidden = YES;
        }break;
        case kYLPersonInfoCellStyleNickname: {
            self.arrow.hidden = YES;
            [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.mas_equalTo(self);
                make.left.mas_equalTo(self.lblTitle.mas_right).offset(10);
                make.right.mas_equalTo(-15);
            }];
        }break;
        default:
            break;
    }
    _style = style;
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setDetail:(NSString *)detail
{
    self.textField.text = detail;
}

@end
