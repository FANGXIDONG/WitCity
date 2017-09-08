//
//  YLTabBarController.h
//  TongHua
//
//  Created by simpletour on 16/2/29.
//  Copyright © 2016年 RY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLView.h"

@interface YLTabBarController : UITabBarController

@property (nonatomic, strong) NSArray *defaultIcons;
@property (nonatomic, strong) NSArray *selectedIcons;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end


@interface YLTabBarView : YLView

@property (nonatomic, copy)   UIColor *defaultColor;
@property (nonatomic, copy)   UIColor *selectedColor;

- (void)updateWithTitles:(NSArray *)titles defaultIcons:(NSArray *)defaultIcons selectedIcons:(NSArray *)selectedIcons count:(NSInteger)count;

@end

@interface YLTabBarItemView : YLView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy)   UIColor *defaultColor;
@property (nonatomic, copy)   UIColor *selectedColor;

- (void)updateWithTitle:(NSString *)title defaultIcon:(UIImage *)defaultIcon selectedIcon:(UIImage *)selectedIcon;

@end