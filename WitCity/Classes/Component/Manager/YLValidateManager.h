//
//  YLValidateManager.h
//  HYB
//
//  Created by duyulong on 16/4/30.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YLLoginModel.h"

@interface YLValidateManager : NSObject

-(instancetype)initWithController:(UIViewController *)vc;

- (BOOL)validateForgetPasswordWithModel:(YLLoginModel *)model;
- (BOOL)validateRegisterWithModel:(YLLoginModel *)model;
- (BOOL)validateVercodeWithPhone:(NSString *)phone;
- (BOOL)validateLoginWithModel:(YLLoginModel *)model;
- (BOOL)validatePhoneWithPhone:(NSString *)phone;

@end
