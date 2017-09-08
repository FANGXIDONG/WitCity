//
//  XHToast.h
//  style_ios
//
//  Created by duyulong on 9/24/15.
//  Copyright © 2015 nick. All rights reserved.
//


#import "MBProgressHUD.h"

@interface YLToast : NSObject<MBProgressHUDDelegate>

+ (void)showToastWithView:(UIView *)view;
+ (void)showToastWithView:(UIView *)view text:(NSString *)text delay:(CGFloat)delay;
+ (void)showToastWithView:(UIView *)view text:(NSString *)text;
+ (void)showToastWithView:(UIView *)view text:(NSString *)text detailsText:(NSString *)detailsText;
+ (void)showToastInKeyWindowWithText:(NSString *)text;
+ (void)hiddenToastWithView:(UIView *)view;
+ (void)showToastInKeyWindowWithText:(NSString *)text detailText:(NSString *)detailText;
@end
