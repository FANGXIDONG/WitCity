//
//  DDEnterpriseDataItemView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/20.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseDataItemView.h"

@interface DDEnterpriseDataItemView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation DDEnterpriseDataItemView
-(void)addViews{
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.valueLabel];
}
-(void)layout{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(80);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(0);
        make.right.mas_equalTo(-5);
    }];
}
-(void)useStyle{
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = kYLColorFontGray;
    self.valueLabel.font = [UIFont systemFontOfSize:15];
    self.valueLabel.textColor = kYLColorFontBlack;
    self.valueLabel.numberOfLines = 0;
}
-(void)setName:(NSString *)name{
    self.nameLabel.text = name;
}

-(void)setValue:(NSString *)value{
    self.valueLabel.text = value;
}
@end


