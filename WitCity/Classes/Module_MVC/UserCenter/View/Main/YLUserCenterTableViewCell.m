//
//  YLUserCenterTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLUserCenterTableViewCell.h"


@interface YLUserCenterTableViewCell ()

@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel     *lblTitle;
@property (nonatomic, strong) UILabel     *lblValue;
@property (nonatomic, strong) UIView      *line;


@end

@implementation YLUserCenterTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.arrow];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblValue];
    [self.contentView addSubview:self.line];
}

-(void)layout
{
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(40);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(20);
    }];
    [self.lblValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrow.mas_left).offset(-2);
        make.top.and.bottom.mas_equalTo(self);
        make.width.mas_equalTo(100);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photo.mas_right).offset(10);
        make.top.and.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self.lblValue.mas_left).offset(-10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.arrow.image = [UIImage imageNamed:@"u_arrow"];
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.line.backgroundColor = kYLColorLine;
    self.lblValue.font = FONT_H(13);
    self.lblValue.textColor = kDDColorGrayText;
    self.lblValue.textAlignment = NSTextAlignmentRight;
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setImageNamed:(NSString *)imageNamed
{
    self.photo.image = [UIImage imageNamed:imageNamed];
}
-(void)setValue:(NSString *)value{
    self.lblValue.text = value;
}
@end
