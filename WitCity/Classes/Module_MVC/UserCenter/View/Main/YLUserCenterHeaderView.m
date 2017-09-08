//
//  YLUserCenterHeaderView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLUserCenterHeaderView.h"
#import "YLUserSingleton.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define kImageViewSize (40)

@interface YLUserCenterHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel     *lblName;


@end

@implementation YLUserCenterHeaderView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.arrow];
    [self addSubview:self.lblName];
}

-(void)layout
{
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(16);
        make.width.and.height.mas_equalTo(kImageViewSize);
    }];
    
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.arrow.mas_left).offset(-10);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView);
        make.right.mas_equalTo(-16);
        make.width.and.height.mas_equalTo(20);
        
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.arrow.image = [UIImage imageNamed:@"u_arrow"];
    self.imageView.image = [UIImage imageNamed:@"u_header"];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = kImageViewSize / 2.0f;
    self.lblName.textColor = kYLColorFontBlack;
    self.lblName.font = [UIFont systemFontOfSize:17];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)]];
    
    self.lblName.text = @"立即登录";
}

//headerView点击
-(void)headerViewClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypePersonInfo)
                             }];
}

//更新用户信息
-(void)updateUserInfo
{
    YLUserSingleton *user = [YLUserSingleton shareInstance];
    self.lblName.text = user.name ? user.name : @"立即登录";
    NSURL *url = [self imageUrlWithStr:user.avatar];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"u_header"] options:SDWebImageRefreshCached];
}

@end










