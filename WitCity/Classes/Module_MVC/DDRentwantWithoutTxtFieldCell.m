
//
//  DDRentwantWithoutTxtFieldCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentwantWithoutTxtFieldCell.h"

@interface DDRentwantWithoutTxtFieldCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation DDRentwantWithoutTxtFieldCell

-(void)addViews{
    [self addSubview:self.nameLabel];
    [self addSubview:self.rightLabel];
}

-(void)layout{
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-25);
    }];
}

-(void)useStyle{
    self.nameLabel.textColor = kYLColorFontBlack;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    
    self.rightLabel.textColor = kYLColorFontGray;
    self.rightLabel.font = [UIFont systemFontOfSize:14];
}

-(void)setString:(NSString *)string {
    self.nameLabel.text = string;
}

-(void)setRightStr:(NSString *)rightStr{
    
    self.rightLabel.text =rightStr;
}

@end














