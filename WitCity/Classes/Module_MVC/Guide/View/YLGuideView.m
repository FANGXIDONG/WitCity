//
//  YLGuideView.m
//  
//
//  Created by simpletour on 16/5/5.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLGuideView.h"



@interface YLGuideView ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YLGuideView

-(void)addViews
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

-(void)layout
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(0);
        make.width.mas_equalTo(WINDOW_WIDTH);
        make.height.mas_equalTo(WINDOW_HEIGHT);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-60);
        make.height.mas_equalTo(20);
    }];
    
    [self layoutImageViews];
}

-(void)useStyle
{
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * kYLGuidePages, CONTENT_HEIGHT);
    self.pageControl.hidden = YES;
    self.pageControl.numberOfPages = kYLGuidePages;
    self.pageControl.currentPage = 0;
    
}

- (void)layoutImageViews
{
    for (int i=0; i<kYLGuidePages; i++) {
        UIImageView* imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.png", i]];
        [self.scrollView addSubview:imageView];
        
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i * WINDOW_WIDTH);
            make.width.mas_equalTo(WINDOW_WIDTH);
            make.height.mas_equalTo(WINDOW_HEIGHT);
        }];
        
        if (i == (kYLGuidePages - 1)) {
            imageView.userInteractionEnabled = YES;
            UIButton *button = [self guideButton];
            [button addTarget:self action:@selector(btnQuickStartClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(imageView);
                make.bottom.mas_equalTo(self.pageControl.mas_top).offset(-10);
                make.size.mas_equalTo(CGSizeMake(120, 36));
            }];
        }
    }
}

- (UIButton *)guideButton
{
    UIButton *button = [UIButton new];
    [button setTitle:@"立即进入" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:19];
    [button setTitleColor:[UIColor colorWithHex:0x7cb3ca] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.5f;
    button.layer.borderColor = [UIColor colorWithHex:0x7cb3ca].CGColor;
    button.backgroundColor = [UIColor clearColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 18;
    return button;
}

- (void)btnQuickStartClick:(UIButton *)button
{
    [self allBlockWithDict:@{}];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}


@end
