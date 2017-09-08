
//
//  DDEnterpriseItemView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/20.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseItemView.h"

@interface DDEnterpriseItemView()
@property (nonatomic, strong) UIView *flagView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation DDEnterpriseItemView

-(void)addViews{
    [self addSubview:self.flagView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
}

-(void)layout{
    
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(13);
        make.width.and.height.mas_equalTo(12);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.flagView.mas_right).offset(5);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(-5);
    }];

}

-(void)useStyle{
    
    self.flagView.layer.cornerRadius = 6;
    self.flagView.layer.masksToBounds = YES;
    self.flagView.backgroundColor = kYLColorFontYellow;
    
    self.titleLabel.textColor = kYLColorFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.valueLabel.textColor = kYLColorFontBlack;
    self.valueLabel.numberOfLines = 2;
    self.valueLabel.adjustsFontSizeToFitWidth = YES;
    self.valueLabel.font = [UIFont systemFontOfSize:15];
    
}
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}
-(void)setValue:(NSString *)value{
    self.valueLabel.text = value;
}
-(void)setColor:(UIColor *)color{
    self.valueLabel.textColor = color;
}


@end












