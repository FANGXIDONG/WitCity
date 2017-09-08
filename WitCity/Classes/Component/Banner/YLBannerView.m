//
//  FJZRecommendHeaderView.m
//  FJZ
//
//  Created by duyulong on 11/8/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLBannerView.h"
#import "YLBannerModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YLBannerView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIView        *view;
@property (nonatomic, strong) NSArray       *data;
@end

@implementation YLBannerView

-(void)addViews
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

-(void)layout
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.mas_equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
}

-(void)useStyle
{
    self.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

-(void)updateWithArray:(NSArray *)array
{
    self.data = array;
    [self removeImageViews];
    UIImageView *ivLast;
    NSInteger i=0;
    for (i=0; i<array.count; i++) {
        YLBannerModel *model = array[i];
        UIImageView *imageView = [UIImageView new];
        imageView.tag = 100 + i;

        [imageView sd_setImageWithURL:[self imageUrlWithStr:model.img]];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)]];
        [self.scrollView addSubview:imageView];
    
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!ivLast) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(ivLast.mas_right);
            }
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(WINDOW_WIDTH);
            make.height.mas_equalTo(self);
        }];
        
        imageView.backgroundColor = [UIColor colorWithRed:(0.2f * i) green:(0.2f * i) blue:(0.2f * i) alpha:1];
        ivLast = imageView;
    }
    
    self.pageControl.numberOfPages = i;
    self.pageControl.currentPage = 0;
    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * i, CGRectGetHeight(self.frame));
}

- (void)imageViewClick:(UITapGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    if (self.allBlock) {
        self.allBlock(@{
                        kYLKeyForBlockType : @(kYLBlockTypeBannerClick),
                        kYLModel : self.data[view.tag - 100],
                        });
    }
}

- (void)removeImageViews
{
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

@end
