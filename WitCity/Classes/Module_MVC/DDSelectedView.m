//
//  DDSelectedView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/16.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSelectedView.h"

@interface DDSelectedView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DDSelectedView

-(void)addViews{
    [self addSubview:self.label];
    [self addSubview:self.iv];
}
-(void)layout{
    
    [self.label  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(0);
        make.height.mas_equalTo(self);
    }];
    [self.iv  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.label.mas_right).offset(0);
        make.width.and.height.mas_equalTo(14);
        make.centerY.mas_equalTo(self);
    }];
}

-(void)useStyle{
    
    self.label.font = [UIFont systemFontOfSize:15];
    self.iv.image = [UIImage imageNamed:@"si_up"];

}

-(void)setStr:(NSString *)str   {
    self.label.text = str;
}
-(void)setImageStr:(NSString *)imageStr{
    self.iv.image = [UIImage imageNamed:imageStr];
}

@end










