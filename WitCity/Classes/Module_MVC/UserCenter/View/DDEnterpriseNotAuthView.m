//
//  DDEnterpriseNotAuthView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/28.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseNotAuthView.h"
#import "YLLoginTextField.h"
#import "YLLoginButton.h"
#import "YLRadioView.h"
#import "DDAuthModel.h"

#define ITEMPADDING    30
#define ItemWidth  (WINDOW_WIDTH - ITEMPADDING*4)/3
#define ItemH   70

@interface DDEnterpriseNotAuthView()
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *rightView;
@property (nonatomic, strong) UIImageView *eHomeView;
@property (nonatomic, strong) UIImageView *addView;
@property (nonatomic, strong) UIImageView *groupView;
@property (nonatomic, strong) UIImageView *chatView;
@property (nonatomic, strong) UIImageView *authView;
@property (nonatomic, strong) YLRadioView      *highTechArea;
@property (nonatomic, strong) YLRadioView      *notHighTechArea;
@property (nonatomic, strong) UIView *txtView;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) YLLoginTextField *saxTxt;
@property (nonatomic, strong) YLLoginTextField *nameTxt;
@property (nonatomic, strong) YLLoginTextField *idcardTxt;
@property (nonatomic, strong) YLLoginTextField *phoneTxt;
@property (nonatomic, strong) YLLoginButton    *btnReview;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) int radioValue;
@end

@implementation DDEnterpriseNotAuthView
-(void)addViews{
    self.btnReview = [[YLLoginButton alloc]initWithTitle:@"审核"];
    [self addSubview:self.introduceLabel];
    [self addSubview:self.rightView];
    [self addSubview:self.eHomeView];
    [self addSubview:self.addView];
    [self addSubview:self.groupView];
    [self addSubview:self.chatView];
    [self addSubview:self.authView];
    
    [self addSubview:self.highTechArea];
    [self addSubview:self.notHighTechArea];
    
    [self addSubview:self.txtView];
    
//    [self.txtView addSubview:self.desLabel];
    [self.txtView addSubview:self.saxTxt];
    [self.txtView addSubview:self.nameTxt];
    [self.txtView addSubview:self.idcardTxt];
    [self.txtView addSubview:self.phoneTxt];
    
    [self addSubview:self.btnReview];
    [self addSubview:self.middleView];
    
    [self.middleView addSubview:self.flagLabel];
    [self.middleView addSubview:self.titleLabel];
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
        make.top.mas_equalTo(self.introduceLabel.mas_bottom).offset(10);
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
        make.top.mas_equalTo(self.eHomeView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.eHomeView);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chatView);
        make.left.mas_equalTo(self.chatView.mas_right).offset(ITEMPADDING);
        make.width.and.height.mas_equalTo(ItemWidth);
    }];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chatView.mas_bottom).offset(10);
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
   [self.highTechArea mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.middleView.mas_bottom).offset(10);
       make.left.mas_equalTo(16);
       make.height.mas_equalTo(30);
       make.width.mas_equalTo(150);
   }];
    [self.notHighTechArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.mas_equalTo(self.highTechArea);
        make.left.mas_equalTo(self.highTechArea.mas_right).offset(10);
    }];
    [self.btnReview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
//        make.top.mas_equalTo(self.phoneTxt.mas_bottom).offset(20);
        make.bottom.mas_equalTo(-20);
    }];
    [self.txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(self.highTechArea.mas_bottom);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(self.btnReview.mas_top).mas_equalTo(-20);;
    }];
//    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(16);
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(44);
//    }];
    [self.saxTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.nameTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.saxTxt);
        make.top.mas_equalTo(self.saxTxt.mas_bottom).offset(5);
    }];
    [self.idcardTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.nameTxt);
        make.top.mas_equalTo(self.nameTxt.mas_bottom).offset(5);
    }];
    [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.mas_equalTo(self.idcardTxt);
        make.top.mas_equalTo(self.idcardTxt.mas_bottom).offset(5);
    }];
}

-(void)useStyle{
    
    self.desLabel.text = @"非高新区企业认证尚未开通，但您可以通过完善企业资料方式生成企业主业！";
    self.desLabel.textColor = kDDColorGrayText;
    self.desLabel.font = FONT_H(14);
    self.desLabel.numberOfLines = 2;
   
    self.introduceLabel.text = @"通过企业认证，享受以下权益";
    self.introduceLabel.textAlignment  = NSTextAlignmentRight;
    self.introduceLabel.font = [UIFont systemFontOfSize:13];
    self.rightView.image = [UIImage imageNamed:@"enterprise_gg"];
    
    self.eHomeView.image = [UIImage imageNamed:@"enterprise_home_unlight"];
    self.addView.image = [UIImage imageNamed:@"enterprise_addfriend_unlight"];
    self.groupView.image = [UIImage imageNamed:@"enterprise_group_unlight"];
    self.chatView.image = [UIImage imageNamed:@"enterprise_chat_unlight"];
    self.authView.image = [UIImage imageNamed:@"enterprise_auth_unlight"];
    
    self.middleView.backgroundColor = YLCOLOR(YLCOLOR_BACKGROUND_GARY);
    self.flagLabel.backgroundColor = kYLColorFontOrange;
    self.titleLabel.text = @"相关推荐";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.saxTxt.placeholder = @"纳税识别号";
    self.nameTxt.placeholder = @"法人姓名";
    self.idcardTxt.placeholder = @"法人身份证号码";
    self.phoneTxt.placeholder = @"法人联系方式";
    self.highTechArea.title = @"高新区企业";
    self.notHighTechArea.title = @"非高新区企业";
    
    WS(ws);
    self.highTechArea.allBlock = ^(NSDictionary *dict) {
        [ws radioClick:dict[kYLValue]];
    };
    
    self.notHighTechArea.allBlock = ^(NSDictionary *dict) {
        [ws radioClick:dict[kYLValue]];
    };
    
    self.highTechArea.selected = YES;
    
    self.saxTxt.keyboardType = UIKeyboardTypeNumberPad;
    self.idcardTxt.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
//    self.txtUsername.imageNamed = @"l_icon_username";
//    self.txtPassword.imageNamed = @"l_icon_password";

    self.phoneTxt.validateType = kYLTextFieldTypeUsername;
    self.idcardTxt.validateType = kDDTextFieldTypeIdCardNumber;
    
    _radioValue = 0;
    
    [self.btnReview addTarget:self action:@selector(authSubmit) forControlEvents:UIControlEventTouchUpInside];
}
//提交认证审核
-(void)authSubmit{
    DDAuthModel *mo = [[DDAuthModel alloc] init];
    mo.reg_num =self.saxTxt.text;
    mo.owner_name = self.nameTxt.text ;
    mo.owner_idcard =self.idcardTxt.text;
    mo.owner_phone =self.phoneTxt.text;
    
    YLBlockType blockType =0;
    if (_radioValue == 0) {
        //审核认证
        blockType = kDDBlockTypeAuthSubmit;
    }else if (_radioValue == 1)
    {
        //去完善资料
        blockType = kDDBlockTypeDataEdit;
    }else{
    }
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType),
                             kYLModel:mo
                             }];
}
//radio点击
- (void)radioClick:(YLRadioView *)radio
{
    if (radio == self.highTechArea) {
        self.notHighTechArea.selected = NO;
        
        self.btnReview.title = @"审核";

        _radioValue = 0;

        [self.desLabel removeFromSuperview];
        
        [self.txtView addSubview:self.saxTxt];
        [self.txtView addSubview:self.nameTxt];
        [self.txtView addSubview:self.idcardTxt];
        [self.txtView addSubview:self.phoneTxt];
        [self.saxTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [self.nameTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.height.mas_equalTo(self.saxTxt);
            make.top.mas_equalTo(self.saxTxt.mas_bottom).offset(5);
        }];
        [self.idcardTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.height.mas_equalTo(self.nameTxt);
            make.top.mas_equalTo(self.nameTxt.mas_bottom).offset(5);
        }];
        [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.height.mas_equalTo(self.idcardTxt);
            make.top.mas_equalTo(self.idcardTxt.mas_bottom).offset(5);
        }];
        
   
        
    } else {
        self.highTechArea.selected = NO;
        
         self.btnReview.title = @"去完善";
        
        _radioValue = 1;

        [self.saxTxt removeFromSuperview];
        [self.nameTxt removeFromSuperview];
        [self.idcardTxt removeFromSuperview];
        [self.phoneTxt removeFromSuperview];
        
        
        [self.txtView addSubview:self.desLabel];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(44);
        }];
        

        
        
  
    }
}

@end



















