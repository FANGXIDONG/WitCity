
//
//  DDBusSectionView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDBusSectionView.h"

@interface DDBusSectionView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *lblTitle;

@end

@implementation DDBusSectionView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.lblTitle];
}

-(void)layout
{
 
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.and.with.mas_equalTo(25);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
    }];
}

-(void)useStyle
{
    self.backgroundColor = kYLColorBakcgorund;
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.textColor = kYLColorFontBlack;
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setImageNamed:(NSString *)imageNamed
{
    self.imageView.image = [UIImage imageNamed:imageNamed];
}

@end
