//
//  YLScrollTabs.h
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

#define kYLScrollTabsHeight (40)

@interface YLScrollTabs : YLView

@property (nonatomic, assign) NSInteger lineWidth;

@property (nonatomic, strong) UIView *currLine;

- (void)updateLinePositionWithOffset:(CGFloat)offset;
- (void)selectedButtonWithIndex:(NSInteger)index;
- (void)updateWithArray:(NSArray *)array;

@end
