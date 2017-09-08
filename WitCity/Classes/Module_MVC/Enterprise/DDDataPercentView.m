//
//  DDDataPercentView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/8/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDDataPercentView.h"

@interface DDDataPercentView()
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *defaultPercent;
@property (nonatomic, strong) UILabel *percentLabel;
@end

@implementation DDDataPercentView

-(void)addViews{
    [self addSubview:self.desLabel];
    [self addSubview:self.defaultPercent];
}

-(void)layout{
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    [self.defaultPercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.desLabel.mas_bottom).offset(3);
        make.left.mas_equalTo(self.desLabel);
        make.right.mas_equalTo(self.desLabel);
        make.height.mas_equalTo(10);
    }];
}
-(void)useStyle{
    self.backgroundColor = [UIColor whiteColor];
    self.defaultPercent.layer.cornerRadius = 5;
    self.defaultPercent.layer.masksToBounds = YES;
    self.defaultPercent.backgroundColor = kDDColorGrayBg;
    
    self.desLabel.textColor = kDDColorGrayText;
    self.desLabel.font   =[UIFont systemFontOfSize:13];
}
-(void)setPercent:(NSString *)percent{
    self.desLabel.text = [NSString stringWithFormat:@"完善度：%@",percent];

    self.percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * [percent floatValue]/100, 10)];
    [self.defaultPercent addSubview:self.percentLabel];
    self.percentLabel.layer.cornerRadius = 5;
    self.percentLabel.layer.masksToBounds   =YES;
    self.percentLabel.backgroundColor = kYLColorFontOrange;
}
@end



