//
//  DDDevelopingView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDDevelopingView.h"

@interface DDDevelopingView()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *messageLab;

@end

@implementation DDDevelopingView

-(void)addViews{
    [self addSubview:_imgView];
    [self addSubview:_messageLab];
}

-(void)layout{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(140);
        make.right.mas_equalTo(-140);
        make.top.mas_equalTo(50);
        make.height.mas_equalTo(self.imgView.mas_width);
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.imgView);
        make.left.mas_equalTo(80);
    }];
}

-(void)useStyle{
    
    self.imgView.image = [UIImage imageNamed:@"developing_bg"];
    self.messageLab.text = @"正在开发中，敬请期待";
    self.messageLab.textColor = kYLColorFontGray;
    self.messageLab.font = [ UIFont systemFontOfSize:16];
    self.messageLab.textAlignment = NSTextAlignmentCenter;
}

@end







