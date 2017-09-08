//
//  DDEnterpriseAuthView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/20.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseAuthView.h"
#import "DDEnterpriseItemView.h"

#define ITEMPADDING    25
#define ItemWidth  (WINDOW_WIDTH - ITEMPADDING*4)/3
#define ItemH   70

@interface DDEnterpriseAuthView()

@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *rightView;
@property (nonatomic, strong) UIImageView *eHomeView;
@property (nonatomic, strong) UIImageView *addView;
@property (nonatomic, strong) UIImageView *groupView;
@property (nonatomic, strong) UIImageView *chatView;
@property (nonatomic, strong) UIImageView *authView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DDEnterpriseItemView *attributeView;
@property (nonatomic, strong) DDEnterpriseItemView *saxnumberView;
@property (nonatomic, strong) DDEnterpriseItemView *artificialPersonView;
@property (nonatomic, strong) DDEnterpriseItemView *idnumberView;
@property (nonatomic, strong) DDEnterpriseItemView *phoneView;
@end

@implementation DDEnterpriseAuthView
-(void)addViews{
    [self addSubview:self.introduceLabel];
    [self addSubview:self.rightView];
    [self addSubview:self.eHomeView];
    [self addSubview:self.addView];
    [self addSubview:self.groupView];
    [self addSubview:self.chatView];
    [self addSubview:self.authView];
    [self addSubview:self.middleView];
    
    [self.middleView addSubview:self.flagLabel];
    [self.middleView addSubview:self.titleLabel];
    
    [self addSubview:self.attributeView];
    [self addSubview:self.saxnumberView];
    [self addSubview:self.artificialPersonView];
    [self addSubview:self.idnumberView];
    [self addSubview:self.phoneView];
}
-(void)layout{
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introduceLabel);
        make.left.mas_equalTo(self.introduceLabel.mas_right).offset(3);
        make.width.and.height.mas_equalTo(15);
    }];
    [self.eHomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introduceLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(ITEMPADDING);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.eHomeView);
        make.left.mas_equalTo(self.eHomeView.mas_right).offset(ITEMPADDING);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.eHomeView);
        make.left.mas_equalTo(self.addView.mas_right).offset(ITEMPADDING);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.eHomeView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.eHomeView);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chatView);
        make.left.mas_equalTo(self.chatView.mas_right).offset(ITEMPADDING);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chatView.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.middleView.centerY);
        make.width.mas_equalTo(4);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.flagLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.middleView.centerY);
    }];
    [self.attributeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.middleView.mas_bottom);
        make.width.mas_equalTo(WINDOW_WIDTH/2);
        make.height.mas_equalTo(ItemH);
    }];
    [self.saxnumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.attributeView.mas_right);
        make.top.mas_equalTo(self.middleView.mas_bottom);
        make.width.mas_equalTo(WINDOW_WIDTH/2);
        make.height.mas_equalTo(ItemH);
    }];
    [self.artificialPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.attributeView.mas_bottom);
        make.width.mas_equalTo(WINDOW_WIDTH/2);
        make.height.mas_equalTo(ItemH);
    }];
    [self.idnumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.artificialPersonView.mas_right);
        make.top.mas_equalTo(self.artificialPersonView);
        make.width.mas_equalTo(WINDOW_WIDTH/2);
        make.height.mas_equalTo(ItemH);
    }];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.artificialPersonView.mas_bottom);
        make.width.mas_equalTo(WINDOW_WIDTH/2);
        make.height.mas_equalTo(ItemH);
    }];
}
-(void)useStyle{
    
    self.introduceLabel.text = @"您的企业已通过企业认证，享受以下权益";
    self.introduceLabel.textAlignment  = NSTextAlignmentRight;
    self.introduceLabel.font = [UIFont systemFontOfSize:13];
    self.rightView.image = [UIImage imageNamed:@"enterprise_gg"];
    
    self.eHomeView.image = [UIImage imageNamed:@"enterprise_home_light"];
    self.addView.image = [UIImage imageNamed:@"enterprise_addfriend_light"];
    self.groupView.image = [UIImage imageNamed:@"enterprise_group_light"];
    self.chatView.image = [UIImage imageNamed:@"enterprise_chat_light"];
    self.authView.image = [UIImage imageNamed:@"enterprise_auth_light"];

    self.middleView.backgroundColor = YLCOLOR(YLCOLOR_BACKGROUND_GARY);
    self.flagLabel.backgroundColor = kYLColorFontOrange;
    self.titleLabel.text = @"资料";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.attributeView.title = @"企业归属：";
    self.saxnumberView.title = @"纳税识别号：";
    self.artificialPersonView.title = @"法人：";
    self.idnumberView.title = @"身份证号码：";
    self.phoneView.title = @"联系方式：";
    

    [self.phoneView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callClick:)]];
    
}
-(void)setAuthModel:(DDAuthModel *)authModel{
    self.attributeView.value = [authModel.is_new intValue] == 0?@"非高新区":@"高新区";
    self.saxnumberView.value = authModel.reg_num;
    self.artificialPersonView.value = authModel.owner_name;
    self.idnumberView.value = authModel.owner_idcard;
    self.phoneView.value = authModel.owner_phone;
    
    self.phoneView.color = kDDColorSkyBlue;
    
}
-(void)callClick:(UITapGestureRecognizer *)tap{
    

    //拨号
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"15205145990"]]];
    
}

@end










