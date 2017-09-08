//
//  CustomView.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width LabelString:(id)labelString collor:(UIColor *)collor;

- (void)setTitle:(id)title;
- (void)setColor:(UIColor *)color;
@end
