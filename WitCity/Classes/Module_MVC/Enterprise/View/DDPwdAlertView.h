//
//  DDPwdAlertView.h
//  WitCity
//
//  Created by 方冬冬 on 2017/1/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPwdAlertView : UIView

@property(nonatomic,copy)void (^passWordText)(NSString *text);
@property(nonatomic,copy)void (^passWordTextConfirm)(NSString *text);
@property (nonatomic,strong) UITextField *inputTextField;//密码输入框
@property (nonatomic,strong) UILabel     *alertLabel;//提示语
-(instancetype)initSingleBtnView;//单选按钮密码框
-(void)show;
@end
