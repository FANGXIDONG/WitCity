//
//  YLRegisterView.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLRegisterView.h"
#import "YLLoginTextField.h"
#import "YLLoginVerifyTextField.h"
#import "YLLoginButton.h"
#import "YLRadioView.h"

@interface YLRegisterView ()

@property (nonatomic, strong) YLLoginTextField       *txtUsername;
@property (nonatomic, strong) YLLoginVerifyTextField *txtVerifyCode;
@property (nonatomic, strong) YLLoginTextField       *txtPassword;
@property (nonatomic, strong) YLLoginTextField       *txtName;
@property (nonatomic, strong) YLLoginButton          *btnRegister;
@property (nonatomic, strong) YLRadioView            *rdoPersonal;
@property (nonatomic, strong) YLRadioView            *rdoEnterprise;
@property (nonatomic, strong) UILabel                *lblHint;

@end

@implementation YLRegisterView

-(void)addViews
{
    self.btnRegister = [[YLLoginButton alloc]initWithTitle:@"注册"];
    [self addSubview:self.txtUsername];
    [self addSubview:self.txtVerifyCode];
    [self addSubview:self.txtPassword];
    [self addSubview:self.txtName];
    [self addSubview:self.lblHint];
    [self addSubview:self.rdoPersonal];
    [self addSubview:self.rdoEnterprise];
    [self addSubview:self.btnRegister];
}

-(void)layout
{
    [self.txtUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(44);
    }];
    
    [self.txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.txtUsername);
        make.top.mas_equalTo(self.txtUsername.mas_bottom);
    }];
    
    [self.txtVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.txtUsername);
        make.top.mas_equalTo(self.txtPassword.mas_bottom);
    }];
    
    [self.rdoPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.txtVerifyCode);
        make.top.mas_equalTo(self.txtVerifyCode.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.rdoEnterprise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.mas_equalTo(self.rdoPersonal);
        make.left.mas_equalTo(self.rdoPersonal.mas_right).offset(30);
    }];
    
    [self.txtName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.txtUsername);
        make.top.mas_equalTo(self.rdoEnterprise.mas_bottom).offset(10);
    }];
    
    [self.btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.txtName.mas_bottom).offset(20);
    }];
    
    [self.lblHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnRegister.mas_bottom).offset(15);
        make.left.mas_equalTo(self.btnRegister);
    }];
    
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.txtUsername.placeholder = @"请输入手机号码";
    self.txtVerifyCode.placeholder = @"请输入验证码";
    self.txtPassword.placeholder = @"请输入密码";
    self.rdoPersonal.title = @"个人";
    self.rdoEnterprise.title = @"企业";
    
    self.txtUsername.keyboardType = UIKeyboardTypeNumberPad;
    self.txtVerifyCode.keyboardType = UIKeyboardTypeNumberPad;
    self.txtPassword.secureTextEntry = YES;
    self.txtUsername.imageNamed = @"l_icon_username";
    self.txtPassword.imageNamed = @"l_icon_password";
    
    self.lblHint.userInteractionEnabled = YES;
    self.lblHint.textColor = kYLColorFontBlack;
    self.lblHint.font = [UIFont systemFontOfSize:14];
    
    self.txtUsername.validateType = kYLTextFieldTypeUsername;
    self.txtPassword.validateType = kYLTextFieldTypePassword;


    self.lblHint.attributedText = [YLUtil attributedString:@"已有账号? 登录" starPoint:6 endPoint:2 colorValue:kYLColorFontRed];
    
    [self.btnRegister addTarget:self action:@selector(btnRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.lblHint addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblHintClick:)]];
    
    WS(ws);
    self.txtVerifyCode.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:@{
                               kYLKeyForBlockType : @(kYLBlockTypeMessageCode),
                               kYLValue : ws.txtUsername.text
                               }];
    };
    
    self.rdoPersonal.allBlock = ^(NSDictionary *dict) {
        [ws radioClick:dict[kYLValue]];
    };
    
    self.rdoEnterprise.allBlock = ^(NSDictionary *dict) {
        [ws radioClick:dict[kYLValue]];
    };
    
    self.rdoPersonal.selected = YES;
    self.txtName.placeholder = @"请输入用户昵称";
}

//注册点击
-(void)btnRegisterClick:(UIButton *)button
{
    YLLoginModel *model = [[YLLoginModel alloc]init];
    model.username = self.txtUsername.text;
    model.password = self.txtPassword.text;
    model.vercode = self.txtVerifyCode.text;
    model.nickname = self.txtName.text;
    model.userType = @(self.rdoEnterprise.selected + 1);
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeRegister),
                             kYLModel : model
                             }];
}

//登陆点击
- (void)lblHintClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeLogin),
                             }];
}

//radio点击
- (void)radioClick:(YLRadioView *)radio
{
    if (radio == self.rdoPersonal) {
        self.rdoEnterprise.selected = NO;
        self.txtName.placeholder = @"请输入用户昵称";
    } else {
        self.rdoPersonal.selected = NO;
        self.txtName.placeholder = @"请输入企业名称";
    }
}

- (void)distableStatus
{
    [self.txtVerifyCode disabledStatus];
}

@end
