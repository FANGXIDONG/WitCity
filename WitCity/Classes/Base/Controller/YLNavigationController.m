//
//  XHNavigationController.m
//  xiaoher
//
//  Created by raoxb on 14-10-22.
//  Copyright (c) 2014年 wenjin. All rights reserved.
//

#import "YLNavigationController.h"
#import "YLMacro.h"
#import "UIImage+Category.h"
#import "UINavigationBar+Awesome.h"

@interface YLNavigationController ()<CAAnimationDelegate>

@end

@implementation YLNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.style = kYLNavigationControllerStyleBlue;
    
//    [self globalSetting];
}

- (void)globalSettingWithTitleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor
{

    UIFont *font = [UIFont systemFontOfSize:18];
    UIColor *color = titleColor;

    // 1、得到全局的navigationbar
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          color, NSForegroundColorAttributeName,font,
                                                          NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
    
    
    // 2、设置导航条背景
//    UINavigationBar *globalBar = [UINavigationBar appearance];
    UINavigationBar *globalBar = self.navigationBar;
    
//    globalBar.tintColor = [UIColor whiteColor];
    globalBar.shadowImage = [UIImage new];
//    globalBar.barTintColor = kYLColorFontOrange;
    globalBar.tintColor = titleColor;
//    globalBar.tintColor = [UIColor whiteColor];
    //[UIColor colorWithHex:0xfd6101]
    UIImage *bgImg = [UIImage imageWithColor:backgroundColor];
    [globalBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    
    UIFont *titleFont = [UIFont systemFontOfSize:20];

    // 3.设置导航栏的标题样式
    
    [globalBar setTitleTextAttributes:@{
                                        NSForegroundColorAttributeName : color,
                                        NSFontAttributeName:titleFont,
                                        }];
    
    //status bar 样式.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)pushModalWithController:(UIViewController *)controller
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:controller animated:NO];
}

-(void)setStyle:(YLNavigationControllerStyle)style
{
    UIColor *color = [UIColor colorWithHex:0xf7f8f9];
    switch (style) {
        case kYLNavigationControllerStyleBlue:{
            [self globalSettingWithTitleColor:[UIColor whiteColor] backgroundColor:kYLColorFontBlue];
        }break;
        case kYLNavigationControllerStyleYellow:{
            [self globalSettingWithTitleColor:[UIColor whiteColor] backgroundColor:kYLColorFontYellow];
        }break;
        case kYLNavigationControllerStyleWhite:{
            [self globalSettingWithTitleColor:[UIColor blackColor] backgroundColor:color];
        }break;
        case kYLNavigationControllerStyleClear:{
            [self globalSettingWithTitleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
        }break;
        default:
            break;
    }
    _style = style;
}

@end
