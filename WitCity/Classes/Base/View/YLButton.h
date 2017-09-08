//
//  XHButton.h
//  xiaoher
//
//  Created by duyulong on 9/3/15.
//  Copyright (c) 2015 wenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+YL.h"
#import "YLColor.h"

@interface YLButton : UIButton


@property (nonatomic, assign) NSInteger normalColor;
@property (nonatomic, assign) NSInteger pressColor;
@property (nonatomic, assign) NSInteger selectedColor;
@property (nonatomic, assign) NSInteger disabledColor;
@property (nonatomic, copy)  NSString *title;

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
-(instancetype)initWithTitle:(NSString *)title;
- (void)initialization;
@end
