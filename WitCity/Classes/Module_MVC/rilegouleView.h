//
//  rilegouleView.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentView;
@class ContentScrollView;
@class EveryDayTableViewCell;
@interface rilegouleView : UIView

@property (nonatomic, strong) ContentView *contentView;
@property (nonatomic, strong) ContentScrollView *scrollView;
@property (nonatomic, strong)  EveryDayTableViewCell *animationView;
@property (nonatomic ,strong) UIImageView *playView;
@property (nonatomic ,assign) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index;

@property (nonatomic ,assign) CGFloat offsetY;
@property (nonatomic ,assign) CGAffineTransform animationTrans;

- (void)aminmationShow;
- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete;

@end
