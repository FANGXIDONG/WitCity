//
//  ContentView.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomView;
@class EveryDayModel;
@interface ContentView : UIView


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *littleLabel;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) CustomView *collectionCustom;
@property (nonatomic, strong) CustomView *shareCustom;
@property (nonatomic, strong) CustomView *cacheCustom;
@property (nonatomic, strong) CustomView *replyCustom;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width model:(EveryDayModel *)model collor:(UIColor *)collor;

- (void)setData:(EveryDayModel *)model;

@end
