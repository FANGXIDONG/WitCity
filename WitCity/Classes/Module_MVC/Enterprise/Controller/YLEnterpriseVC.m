//
//  YLEnterpriseVC.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLEnterpriseVC.h"
#import "YLScrollTabs.h"
#import "YLEnterpriseTableVC.h"
#import "YLSearchVC.h"
#import "YLUserCenterVC.h"
#import "YLHomeHttpUtil.h"
#import "YLCategoryModel.h"

@interface YLEnterpriseVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLScrollTabs *scrollTabs;

@end

@implementation YLEnterpriseVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"企业";
//    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
//    self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(rightClick) imageNamed:@"c_search"];
    [self addViews];
    [self loadCategory];
}

-(void)addViews
{
    [self.view addSubview:self.scrollTabs];
    [self.view addSubview:self.scrollView];

}
- (void)leftClick
{
    [self pushUserCenterVC];
}

- (void)rightClick
{
    [self pushSearchVC];
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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollTabs.frame), WINDOW_WIDTH, CONTENT_HEIGHT - CGRectGetHeight(self.scrollTabs.frame))];
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
    [YLHomeHttpUtil categoryWithId:@2 block:^(NSDictionary *dict) {
        NSArray *array = [YLCategoryModel mj_objectArrayWithKeyValuesArray:dict];
        [self.scrollTabs updateWithArray:array];
        [self addTableVCWithArray:array];
    } failure:^{
    }];
}

#pragma mark - push
- (void)pushSearchVC
{
    YLSearchVC *vc = [[YLSearchVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushModalWithController:vc];
}

- (void)pushUserCenterVC
{
    YLUserCenterVC *vc = [[YLUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark - other
- (void)addTableVCWithArray:(NSArray *)array
{
    NSInteger length = array.count;
    for (NSInteger i=0; i<length; i++) {
        YLCategoryModel *model = array[i];
        YLEnterpriseTableVC *vc = [[YLEnterpriseTableVC alloc] init];
        vc.categoryId = model.category_id;
        vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
    }
    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * length, CGRectGetHeight(self.scrollView.frame));
}



@end



