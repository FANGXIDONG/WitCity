
//
//  DDMessagesViewController.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMessagesViewController.h"
#import "YLScrollTabs.h"       //分段标签视图
#import "YLCategoryModel.h"    //分类model
#import "DDMyreplyViewController.h"
#import "DDSystemMessageVC.h"

@interface DDMessagesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLScrollTabs *scrollTabs;
@end

@implementation DDMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"我的消息"];
    [self addViews];
    [self loadCategory];
}
-(void)addViews
{
    [self.view addSubview:self.scrollTabs];
    [self.view addSubview:self.scrollView];
}
#pragma mark - getter
-(YLScrollTabs *)scrollTabs
{
    if(!_scrollTabs) {
        _scrollTabs = [[YLScrollTabs alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kYLScrollTabsHeight)];
        _scrollTabs.lineWidth = WINDOW_WIDTH/2;
        _scrollTabs.currLine.backgroundColor = kYLColorFontYellow;
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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollTabs.frame), WINDOW_WIDTH, WINDOW_HEIGHT - CGRectGetHeight(self.scrollTabs.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
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
//加载分类
- (void)loadCategory
{
    NSArray *titleArr = @[@"我的回复",@"系统消息"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<titleArr.count; i++) {
        
        YLCategoryModel *model = [[YLCategoryModel alloc] init];
        model.name = titleArr[i];
        [array addObject:model];
    }
    [self.scrollTabs updateWithArray:array];
    [self addTableVCWithArray:array];
}
#pragma mark - other
- (void)addTableVCWithArray:(NSArray *)array
{
    NSInteger length = array.count;
    for (NSInteger i=0; i<length; i++) {
        
        if (i == 0) {
            DDMyreplyViewController *vc = [[DDMyreplyViewController alloc] init];
            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
        }
        if (i == 1) {
            
            DDSystemMessageVC *vc = [[DDSystemMessageVC alloc] init];
            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
        }
  
    }
    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * length, CGRectGetHeight(self.scrollView.frame));
}

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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
