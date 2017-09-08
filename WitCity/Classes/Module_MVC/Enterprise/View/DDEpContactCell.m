
//
//  DDEpContactCell.m
//  WitCity
//
//  Created by 方冬冬 on 2017/1/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEpContactCell.h"
#import "DDEnterpriseContactModel.h"

@interface DDEpContactCell()
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UILabel *firstChacter;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) DDEnterpriseContactModel *model;
@end

@implementation DDEpContactCell

-(void)addViews{
    [self.contentView addSubview:self.firstView];
    [self.firstView addSubview:self.firstChacter];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.companyLabel];
}
-(void)layout{
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.and.height.mas_equalTo(40);
    }];
    [self.firstChacter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.firstView.centerY);
        make.centerX.mas_equalTo(self.firstView.centerX);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.firstView.mas_right).offset(6);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(25);
    }];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
//        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(25);
        make.bottom.mas_equalTo(-5);
    }];
}
-(void)useStyle{
    
    self.firstView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];;
    self.firstView.layer.cornerRadius = 20;
    self.firstView.layer.masksToBounds = YES;
    self.firstChacter.textColor = [UIColor whiteColor];
    self.firstChacter.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textColor = kYLColorFontBlack;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.companyLabel.textColor =kYLColorFontGray;
    self.companyLabel.font = [UIFont systemFontOfSize:14];
    self.companyLabel.numberOfLines = 2;
}

-(void)updateWithModel:(id)obj{
    
    DDEnterpriseContactModel *model = obj;
    self.model = model;
    self.nameLabel.text = model.name;
    self.companyLabel.text = model.company;
    NSString *character = [model.name substringToIndex:1];
    self.firstChacter.text = character;
    
}

@end









