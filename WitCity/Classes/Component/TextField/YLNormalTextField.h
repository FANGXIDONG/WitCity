//
//  XHNormalTextField.h
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLTextField.h"
#import "YLMacro.h"
#import <UIKit/UIKit.h>

@interface YLNormalTextField : YLTextField

@property (nonatomic, strong) UIImageView *imageView;

//手机号验证
- (BOOL)validatePhone;
//密码验证
- (BOOL)validatePassword;

@end
