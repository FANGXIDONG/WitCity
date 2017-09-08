//
//  YLLoginView.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLLoginView.h"
#import "YLLoginTextField.h"
#import "YLNormalButton.h"
#import "YLLoginButton.h"
#import "YLUtil.h"

#define kImageViewSize (90)

@interface YLLoginView()

@property (nonatomic, strong) YLLoginTextField *txtUsername;
@property (nonatomic, strong) YLLoginTextField *txtPassword;
@property (nonatomic, strong) UIButton         *btnForgetPassword;
@property (nonatomic, strong) YLLoginButton    *btnSubmit;
@property (nonatomic, strong) UILabel          *lblRegister;

@end

@implementation YLLoginView

-(void)addViews
{
    self.btnSubmit = [[YLLoginButton alloc]initWithTitle:@"登录"];
    [self addSubview:self.txtUsername];
    [self addSubview:self.txtPassword];
    [self addSubview:self.btnSubmit];
    [self addSubview:self.btnForgetPassword];
    [self addSubview:self.lblRegister];
}

-(void)layout
{
    [self.txtUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    [self.txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.txtUsername);
        make.top.mas_equalTo(self.txtUsername.mas_bottom);
    }];
    
    [self.btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.txtPassword.mas_bottom).offset(30);
    }];
    
    [self.btnForgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnSubmit.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(100);
    }];
    
    [self.lblRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnSubmit);
        make.centerY.mas_equalTo(self.btnForgetPassword);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.txtUsername.placeholder = @"请输入手机号码";
    self.txtPassword.placeholder = @"请输入密码";
    self.txtUsername.keyboardType = UIKeyboardTypeNumberPad;
    self.txtPassword.secureTextEntry = YES;
    self.txtUsername.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.lblRegister.userInteractionEnabled = YES;
    self.lblRegister.textColor = kYLColorFontBlack;
    self.lblRegister.font = [UIFont systemFontOfSize:14];
    
    self.btnForgetPassword.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btnForgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.btnForgetPassword setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [self.btnForgetPassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.btnForgetPassword.titleLabel.font = [UIFont systemFontOfSize:14];
    self.lblRegister.attributedText = [YLUtil attributedString:@"没有账号? 注册" starPoint:6 endPoint:2 colorValue:kYLColorFontRed];
    
    self.txtUsername.validateType = kYLTextFieldTypeUsername;
    self.txtPassword.validateType = kYLTextFieldTypePassword;
    
    [self.btnForgetPassword addTarget:self action:@selector(btnForgetPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSubmit addTarget:self action:@selector(btnSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.lblRegister addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblRegisterClick:)]];
   


}

//忘记密码点击
- (void)btnForgetPasswordClick:(UIButton *)button
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeForgetPassword)
                             }];
}

//注册点击
- (void)lblRegisterClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeRegister)
                             }];
}

//登录点击
- (void)btnSubmitClick:(UIButton *)button
{
    YLLoginModel *model = [[YLLoginModel alloc]init];
    model.username = self.txtUsername.text;
    model.password = self.txtPassword.text;
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeLogin),
                             kYLModel : model
                             }];
}

@end
