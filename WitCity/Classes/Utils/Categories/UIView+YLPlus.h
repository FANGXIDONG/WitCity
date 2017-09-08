//
//  UIView+YLPlus.h
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLPlus)

@property (nonatomic) CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
/**
 *  1.添加边框
 *
 *  @param color <#color description#>
 */
- (void)addBorderColor:(UIColor *)color;

/**
 *  2.UIView 的点击事件
 *
 *  @param target   目标
 *  @param action   事件
 */

- (void)addTarget:(id)target
           action:(SEL)action;
@end
