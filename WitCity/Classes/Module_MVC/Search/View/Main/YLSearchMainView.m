//
//  YLSearchMainView.m
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSearchMainView.h"
#import "YLScrollTabs.h"
#import "YLSearchContentView.h"
#import "YLSearchResultTableView.h"
#import "YLCategoryModel.h"
#import "YLHomeHttpUtil.h"

@interface YLSearchMainView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLScrollTabs *scrollTabs;
@property (nonatomic, strong) YLSearchResultTableView *resultTableView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSArray *items;

@end

@implementation YLSearchMainView

-(void)addViews
{
    [self addSubview:self.scrollTabs];
    [self addSubview:self.scrollView];
    [self addSubview:self.resultTableView];
}

-(void)layout
{
    [self.scrollTabs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(kYLScrollTabsHeight);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.scrollTabs.mas_bottom);
    }];
    
    [self.resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
    }];
}

-(void)useStyle
{
    self.resultTableView.hidden = YES;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollTabs.lineWidth = 60;
    
    YLCategoryModel *m1 = [self modelWithId:@"18" name:@"公告"];
    YLCategoryModel *m2 = [self modelWithId:@"19" name:@"论坛"];
    YLCategoryModel *m3 = [self modelWithId:@"3" name:@"政策"];
    YLCategoryModel *m4 = [self modelWithId:@"2" name:@"企业"];
    NSArray *items = @[m1, m2, m3, m4];
    self.items = items;
    [self.scrollTabs updateWithArray:items];
    [self addSearchContentViewsWithArray:items];
    
    WS(ws);
    self.scrollTabs.allBlock = ^(NSDictionary *dict) {
        CGFloat value = [dict[kYLValue] integerValue];
        [ws offsetScrollViewWithIndex:value];
        [ws allBlockWithDict:@{
                               kYLKeyForBlockType : @(kYLBlockTypeTabChange),
                               kYLValue : @(value)
                               }];
    };
    
    self.resultTableView.allBlock = ^(NSDictionary *dict){
        [ws allBlockWithDict:dict];
    };
}

- (YLCategoryModel *)modelWithId:(NSString *)Id name:(NSString *)name
{
    YLCategoryModel *model = [[YLCategoryModel alloc]init];
    model.category_id = Id;
    model.name = name;
    return model;
}

-(void)addSearchContentViewsWithArray:(NSArray *)array
{
    NSInteger i;
    for (i=0; i<array.count; i++) {
        YLSearchContentView *view = [YLSearchContentView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(WINDOW_WIDTH);
            make.left.mas_equalTo(i * WINDOW_WIDTH);
            make.height.mas_equalTo(CONTENT_HEIGHT);
        }];
        
        YLCategoryModel *model = array[i];
        view.model = model;
        
        WS(ws);
        view.allBlock = ^(NSDictionary *dict) {
            [ws allBlockWithDict:dict];
        };
        
        [self loadSearchKeysWithCategoryId:model.category_id view:view];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = CGSizeMake(i * WINDOW_WIDTH, CONTENT_HEIGHT2 - kYLScrollTabsHeight);
    });
}

- (void)loadSearchKeysWithCategoryId:(NSString *)categoryId view:(YLSearchContentView *)view
{
        [YLHomeHttpUtil searchKeysWithCid:categoryId block:^(NSDictionary *dict) {
            NSArray *array = dict[@"key_name"];
            [view updateWithArray:array];
        } failure:^{
        }];
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollTabs updateLinePositionWithOffset:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.index = index;
    [self.scrollTabs selectedButtonWithIndex:index];
}

- (void)offsetScrollViewWithIndex:(NSInteger)index
{
    self.index = index;
    [UIView animateWithDuration:0.3f animations:^{
        self.scrollView.contentOffset = CGPointMake(index * WINDOW_WIDTH, 0);
    }];
}

-(NSString *)categoryId
{
    YLCategoryModel *model = self.items[self.index];
    return model.category_id;
}

- (void)showResultViewWithArray:(NSArray *)array
{
    self.resultTableView.hidden = NO;
    [self bringSubviewToFront:self.resultTableView];
    self.scrollView.hidden = !self.resultTableView.hidden;
    [self.resultTableView updateWithArray:array];
}

- (void)hideResultView
{
    self.resultTableView.hidden = YES;
    [self bringSubviewToFront:self.scrollView];
    self.scrollView.hidden = !self.resultTableView.hidden;
}

@end
