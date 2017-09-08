//
//  DDAddressView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDAddressView.h"

@interface DDAddressView()

@property (nonatomic, strong) UIImageView *addrImg;
@property (nonatomic, strong) UILabel *addrLabel;
@end

@implementation DDAddressView

-(void)addViews {
    [self addSubview:self.addrImg];
    [self addSubview:self.addrLabel];
}

-(void)layout{
    
    [self.addrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];
    
    [self.addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addrImg.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
    }];
}

-(void)useStyle{
    
    self.addrImg.image = [UIImage imageNamed:@"cz_dizhi"];
    
    self.addrLabel.textColor = kYLColorFontGray;
    self.addrLabel.font = [UIFont systemFontOfSize:15];
}

-(void)setAddrstr:(NSString *)addrstr{
    
    self.addrLabel.text = addrstr;
}

@end





