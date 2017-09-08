//
//  YLPersonEditTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPersonEditTableViewCell.h"

@interface YLPersonEditTableViewCell ()

@property (nonatomic, strong) UIView      *lineTop;
@property (nonatomic, strong) UIView      *lineBottom;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton    *btnClear;

@end

@implementation YLPersonEditTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.btnClear];
    [self.contentView addSubview:self.lineTop];
    [self.contentView addSubview:self.lineBottom];
}

-(void)layout
{
    [self.lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.btnClear.mas_left).offset(-10);
    }];
    
    [self.btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-16);
        make.width.and.height.mas_equalTo(30);
    }];
}

-(void)useStyle
{
    self.lineTop.backgroundColor = kYLColorLine;
    self.lineBottom.backgroundColor = kYLColorLine;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textColor = kYLColorFontBlack;

    [self.btnClear addTarget:self action:@selector(btnClearClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnClearClick:(UIButton *)button
{

}

-(NSString *)title
{
    return self.textField.text;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    self.textField.placeholder = placeholder;
}


-(void)setTitle:(NSString *)title
{
    self.textField.text = title;
}

-(void)setIsHideTopLine:(BOOL)isHideTopLine
{
    self.lineTop.hidden = isHideTopLine;
}

-(void)setIsHideBottomLine:(BOOL)isHideBottomLine
{
    self.lineBottom.hidden = isHideBottomLine;
}

-(void)setIsPassword:(BOOL)isPassword
{
    self.textField.secureTextEntry = YES;
}

@end
