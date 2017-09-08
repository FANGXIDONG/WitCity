//
//  YLCommentSectionView.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentSectionView.h"

@interface YLCommentSectionView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation YLCommentSectionView

-(void)addViews
{
    [self addSubview:self.icon];
    [self addSubview:self.lblTitle];
}

-(void)layout
{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(10);
        make.top.and.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-16);
    }];
}

-(void)useStyle
{
    self.backgroundColor = kYLColorBakcgorund;
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.textColor = kYLColorFontBlack;
    
    self.lblTitle.text = @"评论";
    self.icon.image = [UIImage imageNamed:@"ltxqy2_titleicon"];
}

@end
