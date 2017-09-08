//
//  XHNavigationController.h
//  xiaoher
//
//  Created by raoxb on 14-10-22.
//  Copyright (c) 2014年 wenjin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YLNavigationControllerStyle) {
    kYLNavigationControllerStyleBlue =  0,
    kYLNavigationControllerStyleYellow,
    kYLNavigationControllerStyleWhite,
    kYLNavigationControllerStyleClear,
};

@interface YLNavigationController : UINavigationController

@property (nonatomic, assign) YLNavigationControllerStyle style;

- (void)pushModalWithController:(UIViewController *)controller;
@end
