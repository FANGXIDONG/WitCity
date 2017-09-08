//
//  YLCommentFooterView.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentFooterView.h"

@interface YLCommentFooterView ()

@property (nonatomic, strong) UIView      *line;
@property (nonatomic, strong) UIButton    *btnSend;

@end

@implementation YLCommentFooterView

-(void)addViews
{
    [self addSubview:self.textField];
    [self addSubview:self.btnSend];
    [self addSubview:self.line];
}

-(void)layout
{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.btnSend.mas_left).offset(-10);
    }];
}

-(void)useStyle
{
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.borderColor = kYLColorLine.CGColor;
    self.textField.layer.borderWidth = 1.0f;
    self.textField.layer.cornerRadius = 15;
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.placeholder = @"发送评论";
    
    
    self.line.backgroundColor = kYLColorLine;
    self.btnSend.backgroundColor = kYLColorBakcgorund;
    self.btnSend.layer.masksToBounds = YES;
    self.btnSend.layer.cornerRadius = 15;
    [self.btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [self.btnSend setTitleColor:kYLColorFontGray forState:UIControlStateNormal];
    
    
    
    [self.btnSend addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnSendClick:(UIButton *)button
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeCommentSend),
                             kYLValue : self.textField.text
                             }];
    self.textField.text = @"";
    [self.textField resignFirstResponder];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    self.textField.placeholder = placeholder;
}

@end
