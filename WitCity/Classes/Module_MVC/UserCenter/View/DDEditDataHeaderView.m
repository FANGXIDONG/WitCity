
//
//  DDEditDataHeaderView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/27.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEditDataHeaderView.h"

@interface DDEditDataHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation DDEditDataHeaderView

-(void)addViews{
    [self addSubview:self.titleLabel];
}
-(void)layout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
    }];
}
-(void)useStyle{
    self.backgroundColor = kDDColorGrayBg;
    self.titleLabel.text = @"完善资料通过审核后将自动生成企业列表，为了保持列表的美观度，建议至少填写三项";
    self.titleLabel.textColor = kDDColorGrayText;
    self.titleLabel.font = FONT_H(13);
    self.titleLabel.numberOfLines = 2;
}

@end
