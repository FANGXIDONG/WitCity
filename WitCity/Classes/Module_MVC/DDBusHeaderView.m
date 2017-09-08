//
//  DDBusHeaderView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDBusHeaderView.h"

@interface DDBusHeaderView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchTxt;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation DDBusHeaderView

-(void)addViews
{
    [self addSubview:self.searchTxt];
    [self.searchTxt addSubview:self.searchBtn];
}

-(void)layout
{
   [self.searchTxt mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(15);
       make.right.mas_equalTo(-15);
       make.top.mas_equalTo(5);
       make.centerY.mas_equalTo(self);
   }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.searchTxt.mas_right);
        make.top.mas_equalTo(self.searchTxt.mas_top);
        make.centerY.mas_equalTo(self.searchTxt);
        make.width.mas_equalTo(50);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.searchTxt.backgroundColor = kYLColorBakcgorund;
    self.searchTxt.borderStyle=UITextBorderStyleRoundedRect;
     self.searchTxt.keyboardType=UIKeyboardTypeWebSearch;
//    self.searchTxt.clearButtonMode = UITextFieldViewModeAlways;
    self.searchTxt.delegate =self;
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cx_sousuo"]];
    self.searchTxt.leftView = img;
    
    self.searchTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.searchTxt.placeholder  = @"输入火车站点或公交车名称";
    self.searchTxt.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBtn.layer.cornerRadius = 5;
    self.searchBtn.layer.masksToBounds = YES;
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = kYLColorFontYellow;
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self searchAction];
}

-(void)searchAction{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeBusSearch)
                             }];
}

@end









