
//
//  DDCommonView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDCommonView.h"

@interface DDCommonView()
@property (nonatomic, strong) UIImageView   *imgView;
@property (nonatomic, strong) UILabel       *titleLabel;
@end

@implementation DDCommonView

-(void)addViews{
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
}

-(void)layout{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(40);
        make.width.mas_equalTo(self.imgView.mas_height);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(5);
    }];
    
}

-(void)useStyle{
    
    self.backgroundColor = [UIColor  whiteColor];
    self.titleLabel.textColor = kYLColorFontGray;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

-(void)setTitle:(NSString *)title{
    
    self.titleLabel.text = title;
    
}
-(void)setImageNamed:(NSString *)imageNamed{
    
    self.imgView.image = [UIImage imageNamed:imageNamed];
}
@end






