//
//  YLPostView.m
//  WitCity
//
//  Created by simpletour on 16/6/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPostView.h"
#import "YLTextView.h"

@interface YLPostView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) YLTextView *textView;
@property (nonatomic, strong) UIView *line;

@end

@implementation YLPostView

-(void)addViews
{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.textFiled];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.line];
}

-(void)layout
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(13);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(50);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.textFiled.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.textFiled);
        make.top.mas_equalTo(self.line.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.textFiled.font = [UIFont systemFontOfSize:15];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.line.backgroundColor = kYLColorLine;
    
    self.textFiled.placeholder = @"标题(30字以内)";
    self.textView.placeholder = @"概述(400字以内)";
}

-(NSString *)title
{
    return self.textFiled.text;
}

-(NSString *)content
{
    return self.textView.text;
}

@end
