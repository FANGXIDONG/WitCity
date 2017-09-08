
//
//  DDEnterpriseDataView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/20.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseDataView.h"
#import "DDEnterpriseDataItemView.h"


#define ItemH  40

@interface DDEnterpriseDataView()

@property (nonatomic, strong) UIImageView *defaultAvatorView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) DDEnterpriseDataItemView *industyView;
@property (nonatomic, strong) DDEnterpriseDataItemView *typeView;
@property (nonatomic, strong) DDEnterpriseDataItemView *personView;
@property (nonatomic, strong) DDEnterpriseDataItemView *phoneView;
@property (nonatomic, strong) DDEnterpriseDataItemView *addrView;
@property (nonatomic, strong) DDEnterpriseDataItemView *descriView;
@property (nonatomic, strong) UIButton *homeBtn;
@end

@implementation DDEnterpriseDataView

-(void)addViews{
    [self addSubview:self.defaultAvatorView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.industyView];
    [self addSubview:self.typeView];
    [self addSubview:self.personView];
    [self addSubview:self.phoneView];
    [self addSubview:self.addrView];
    [self addSubview:self.descriView];
    [self addSubview:self.homeBtn];
}
-(void)layout{
    [self.defaultAvatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.and.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.defaultAvatorView.mas_bottom).offset(10);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    [self.industyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(ItemH);
    }];
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.industyView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(ItemH);
    }];
    [self.personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(ItemH);
    }];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.personView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(ItemH);
    }];
    [self.addrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(ItemH);
    }];
    [self.descriView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addrView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(ItemH);
    }];
    [self.homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.and.right.mas_equalTo(0);
    }];
}
-(void)useStyle{
    
    self.defaultAvatorView.image = [UIImage imageNamed:@"enterprise_bg"];
    
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    self.nameLabel.textColor = kYLColorFontBlack;
    
    self.industyView.name = @"行业内别：";
    self.typeView.name = @"注册类型：";
    self.personView.name = @"联系人：";
    self.phoneView.name = @"联系方式：";
    self.addrView.name = @"公司地址：";
    self.descriView.name = @"公司简介：";
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查看生成的企业主页"];
    NSRange strRange = {0,[str length]};
    
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    
    [str addAttribute:NSForegroundColorAttributeName
                          value:kYLColorFontOrange
                          range:strRange];
    
    [_homeBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    [_homeBtn addTarget:self action:@selector(enterpriseHomePage) forControlEvents:UIControlEventTouchUpInside];
    
}

//生成企业主业
-(void)enterpriseHomePage{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeEnterpriseHomePage),
                             }];
}

-(void)setModel:(DDDataModel *)model{
    
    self.nameLabel.text = model.name;
    self.industyView.value = model.industry_name;
    self.typeView.value = model.reg_type_name;
    self.personView.value = model.contn;
    self.phoneView.value = model.contp;
    self.addrView.value = model.address;
    self.descriView.value = model.des;
}
@end







