//
//  RYUserMainFooterView.m
//  TongHua
//
//  Created by simpletour on 16/2/23.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "YLPersonInfoFooterView.h"
#import "YLNormalButton.h"

@interface YLPersonInfoFooterView ()

@property (nonatomic, strong) UIButton *btnLogout;

@end

@implementation YLPersonInfoFooterView

-(void)addViews
{
    [self addSubview:self.btnLogout];
}

-(void)layout
{
    [self.btnLogout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.btnLogout.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.btnLogout setTitleColor:kYLColorFontRed forState:UIControlStateNormal];
    [self.btnLogout addTarget:self action:@selector(btnLoginoutClick:) forControlEvents:UIControlEventTouchUpInside];
}

//注销点击
- (void)btnLoginoutClick:(UIButton *)button
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeLoginout)
                             }];
}

@end
