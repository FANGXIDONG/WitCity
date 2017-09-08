//
//  DDCustomActivity.h
//  AccurateHardship
//
//  Created by 方冬冬 on 2016/11/9.
//  Copyright © 2016年 BeiJingXingYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCustomActivity : UIActivity
@property (nonatomic) UIImage *shareImage;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *shareContentArray;
-(instancetype)initWithImage:(UIImage *)shareImage atURL:(NSURL *)URL atTitle:(NSString *)title atShareContentArray:(NSArray *)shareContentArray;

@end
