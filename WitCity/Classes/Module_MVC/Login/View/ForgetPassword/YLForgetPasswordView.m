//
//  YLForgetPasswordView.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLForgetPasswordView.h"
#import "YLLoginTextField.h"
#import "YLLoginVerifyTextField.h"
#import "YLLoginButton.h"

@interface YLForgetPasswordView ()

@property (nonatomic, strong) YLLoginTextField       *txtUsername;
@property (nonatomic, strong) YLLoginVerifyTextField *txtVerifyCode;
@property (nonatomic, strong) YLLoginTextField       *txtPassword;
@property (nonatomic, strong) YLLoginButton          *btnFinish;
@property (nonatomic, strong) UILabel *lblHint;

@end

@implementation YLForgetPasswordView

-(void)addViews
{
    self.btnFinish = [[YLLoginButton alloc]initWithTitle:@"完成"];
    [self addSubview:self.txtUsername];
    [self addSubview:self.txtVerifyCode];
    [self addSubview:self.txtPassword];
    [self addSubview:self.btnFinish];
    [self addSubview:self.lblHint];
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
    
    [self.btnFinish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.txtVerifyCode.mas_bottom).offset(33);
    }];
    
    [self.lblHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnFinish);
        make.top.mas_equalTo(self.btnFinish.mas_bottom).offset(15);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.txtUsername.placeholder = @"请输入手机号码";
    self.txtVerifyCode.placeholder = @"请输入验证码";
    self.txtPassword.placeholder = @"请输入新密码";
    self.txtPassword.secureTextEntry = YES;
    self.txtUsername.keyboardType = UIKeyboardTypeNumberPad;
    self.txtVerifyCode.keyboardType = UIKeyboardTypeNumberPad;
    self.txtPassword.secureTextEntry = YES;
    self.lblHint.userInteractionEnabled = YES;
    self.lblHint.textColor = kYLColorFontBlack;
    self.lblHint.font = [UIFont systemFontOfSize:14];
    
    self.txtUsername.validateType = kYLTextFieldTypeUsername;
    self.txtPassword.validateType = kYLTextFieldTypePassword;
    self.lblHint.attributedText = [YLUtil attributedString:@"记起密码? 登录" starPoint:6 endPoint:2 colorValue:kYLColorFontRed];
    
    [self.btnFinish addTarget:self action:@selector(btnFinishClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.lblHint addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblHintClick:)]];
    
    WS(ws);
    self.txtVerifyCode.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:@{
                               kYLKeyForBlockType : @(kYLBlockTypeMessageCode),
                               kYLValue : ws.txtUsername.text
                               }];
    };
    
}

//忘记密码点击
-(void)btnFinishClick:(UIButton *)button
{
    YLLoginModel *model = [[YLLoginModel alloc]init];
    model.username = self.txtUsername.text;
    model.password = self.txtPassword.text;
    model.vercode = self.txtVerifyCode.text;
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeForgetPassword),
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

- (void)distableStatus
{
    [self.txtVerifyCode disabledStatus];
}

@end
