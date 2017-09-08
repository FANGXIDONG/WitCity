//
//  DDMyNoteViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNoteViewController.h"
#import "YLScrollTabs.h"       //分段标签视图
#import "DDMyNotesTableVC.h"   //我的发帖表格控制器
#import "YLCategoryModel.h"    //分类model

#import "DDNotesLwqTableVC.h" 
#import "DDNotesJobwantTableVC.h"
#import "DDNotesRecruitTableVC.h" 
#import "DDNotesRentoutTableVC.h" 
#import "DDNotesRentwantTableVC.h"

@interface DDMyNoteViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLScrollTabs *scrollTabs;
@end

@implementation DDMyNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"我的发帖"];
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
        _scrollTabs.lineWidth = 60;
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
    NSArray *titleArr = @[@"招聘",@"求职",@"出租",@"求租",@"柳梧圈"];
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
//    NSInteger length = array.count;
//    for (NSInteger i=0; i<length; i++) {
//
//        DDMyNotesTableVC *vc = [[DDMyNotesTableVC alloc] init];
//        vc.categroyId = i;
//        vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
//        [self addChildViewController:vc];
//        [self.scrollView addSubview:vc.view];
//    }
//    self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * length, CGRectGetHeight(self.scrollView.frame));
    
    NSInteger length = array.count;
    for (NSInteger i=0; i<length; i++) {

        if (i == 0) {
            DDNotesRecruitTableVC *vc = [[DDNotesRecruitTableVC alloc] init];
            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
        }
        if (i == 1) {
            
//            UIViewController *vc = [[UIViewController alloc] init];
//            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
//            vc.view.backgroundColor = kYLColorFontRed;
//            [self addChildViewController:vc];
//            [self.scrollView addSubview:vc.view];
            
            DDNotesJobwantTableVC *vc = [[DDNotesJobwantTableVC alloc] init];
            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
        }
        
        if (i == 2) {
            DDNotesRentoutTableVC *vc = [[DDNotesRentoutTableVC alloc] init];
            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
        }
        if (i ==3) {
            DDNotesRentwantTableVC *vc = [[DDNotesRentwantTableVC alloc] init];
            vc.view.frame = CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
        }
        if (i == 4) {
            DDNotesLwqTableVC *vc = [[DDNotesLwqTableVC alloc] init];
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
    // Dispose of any resources that can be recreated.
}



@end

















