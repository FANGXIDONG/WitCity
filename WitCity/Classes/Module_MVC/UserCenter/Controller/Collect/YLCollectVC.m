//
//  YLCollectVC.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCollectVC.h"
#import "YLCollectTableVC.h"
#import "YLScrollTabs.h"
#import "YLCategoryModel.h"

@interface YLCollectVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLScrollTabs *scrollTabs;

@end

@implementation YLCollectVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"我的收藏"];
    [self addViews];
    [self.scrollTabs selectedButtonWithIndex:self.selectedIndex];
//     self.navigationController.navigationBar.translucent = YES;r
}

-(void)addViews
{
    [self.view addSubview:self.scrollTabs];
    [self.view addSubview:self.scrollView];
//    YLCategoryModel *m1 = [self modelWithId:@"2" name:@"企业"];
    YLCategoryModel *m2 = [self modelWithId:@"3" name:@"政策"];
    YLCategoryModel *m3 = [self modelWithId:@"1" name:@"办事"];
    YLCategoryModel *m4 = [self modelWithId:@"18" name:@"公告"];
    YLCategoryModel *m5 = [self modelWithId:@"19" name:@"论坛"];
    NSArray *array = @[ m2, m3, m4, m5];
    [self.scrollTabs updateWithArray:array];
    [self addTableVCWithArray:array];
}

- (YLCategoryModel *)modelWithId:(NSString *)Id name:(NSString *)name
{
    YLCategoryModel *model = [[YLCategoryModel alloc]init];
    model.category_id = Id;
    model.name = name;
    return model;
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
        YLCollectTableVC *vc = [[YLCollectTableVC alloc]init];
        vc.index = i;
        vc.model = array[i];
        vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
    }
    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * length, CGRectGetHeight(self.scrollView.frame));
}




@end
