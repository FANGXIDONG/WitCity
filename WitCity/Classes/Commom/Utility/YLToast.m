//
//  XHToast.m
//  style_ios
//
//  Created by duyulong on 9/24/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLToast.h"


@implementation YLToast

+ (void)showToastWithView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

//显示文字
+ (void)showToastWithView:(UIView *)view text:(NSString *)text detailsText:(NSString *)detailsText
{
    MBProgressHUD *hud = [self getHudWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    hud.labelText = text;
    hud.detailsLabelText = detailsText;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1.5f);
    }];
}

//隐藏toast
+ (void)hiddenToastWithView:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

//显示文字
+ (void)showToastWithView:(UIView *)view text:(NSString *)text
{
    MBProgressHUD *hud = [self getHudWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    hud.labelText = text;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2.0f);
    }];
}

//在keyWindow显示文字，带detail
+ (void)showToastInKeyWindowWithText:(NSString *)text detailText:(NSString *)detailText{
    
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [self getHudWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    hud.labelText = text;
    hud.detailsLabelText = text;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2.5f);
    }];
}

//在keyWindow显示文字
+ (void)showToastInKeyWindowWithText:(NSString *)text
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [self getHudWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    hud.labelText = text;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2.0f);
    }];
}

//显示文字和延迟秒数
+ (void)showToastWithView:(UIView *)view text:(NSString *)text delay:(CGFloat)delay
{
    MBProgressHUD *hud = [self getHudWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    hud.labelText = text;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    }];
}

+ (MBProgressHUD *)getHudWithView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    return hud;
}
@end
