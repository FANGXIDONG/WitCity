//
//  YLMessageVC.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLMessageVC.h"
#import "YLScrollTabs.h"
#import "YLMessageTableVC.h"
#import "YLCategoryModel.h"

@interface YLMessageVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLScrollTabs *scrollTabs;

@end

@implementation YLMessageVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"我的消息"];
    [self addViews];
    
}

-(void)addViews
{
    [self.view addSubview:self.scrollTabs];
    [self.view addSubview:self.scrollView];
    YLCategoryModel *c1 = [[YLCategoryModel alloc]init];
    YLCategoryModel *c2 = [[YLCategoryModel alloc]init];
    YLCategoryModel *c3 = [[YLCategoryModel alloc]init];
    c1.name = @"我的发帖";
    c2.name = @"我的回复";
    c3.name = @"系统消息";
    NSArray *array = @[c1, c2, c3];
    [self.scrollTabs updateWithArray:array];
    [self addTableVCWithArray:array];
}

#pragma mark - getter
-(YLScrollTabs *)scrollTabs
{
    if(!_scrollTabs) {
        _scrollTabs = [[YLScrollTabs alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kYLScrollTabsHeight)];
        _scrollTabs.lineWidth = 60;
        WS(wself);
        _scrollTabs.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _scrollTabs;
}

-(UIScrollView *)scrollView
{
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollTabs.frame), WINDOW_WIDTH, CONTENT_HEIGHT2 - CGRectGetHeight(self.scrollTabs.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeTabsView:{
            CGFloat value = [dict[kYLValue] integerValue];
            [self offsetScrollViewWithIndex:value];
        }break;
            
        default:
            break;
    }
}

#pragma mark - server

#pragma mark - push



#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollTabs updateLinePositionWithOffset:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    [self.scrollTabs selectedButtonWithIndex:index];
}

- (void)offsetScrollViewWithIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.3f animations:^{
        self.scrollView.contentOffset = CGPointMake(index * WINDOW_WIDTH, 0);
    }];
}

#pragma mark - other
- (void)addTableVCWithArray:(NSArray *)array
{
    NSInteger length = array.count;
    for (NSInteger i=0; i<length; i++) {
        YLMessageTableVC *vc = [[YLMessageTableVC alloc]init];
        vc.index = i;
        vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
    }
    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * length, CGRectGetHeight(self.scrollView.frame));
}



@end
