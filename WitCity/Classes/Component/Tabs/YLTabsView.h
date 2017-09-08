//
//  XHTabsView.h
//  style_ios
//
//  Created by yulongdu on 10/17/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLView.h"

#define kYLTabsViewHeight (45)


@interface YLTabsView : YLView

@property(nonatomic, strong) UIView *currLine;

@property(nonatomic, assign) NSInteger itemCount;
@property(nonatomic, assign) NSInteger selectedIndex;

-(instancetype)initWithFrame:(CGRect)frame  items:(NSArray *)items;
- (void)updateLinePositionWithOffset:(CGFloat)offset;
- (void)selectedButtonWithIndex:(NSInteger)index;

@end
