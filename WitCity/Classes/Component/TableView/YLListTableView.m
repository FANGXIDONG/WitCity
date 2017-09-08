//
//  YLListTableView.m
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLListTableView.h"
#import "MJRefresh.h"

@implementation YLListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self) {
        [self setupRefresh];
    }
    return self;
}

- (void)setupRefresh
{
    [self addHeaderWithTarget:self action:@selector(headerRereshing)];
    __weak typeof(self) weakself = self;
    [self addInfiniteScrollingWithActionHandler:^{
        [weakself loadNextPage];
    }];
}

- (void)loadNextPage
{
    if(self.refreshBlock) {
        self.refreshBlock(YLListTableViewRefreshStateLoadNextPage);
    }
}

- (void)headerRereshing
{
    if(self.refreshBlock) {
        self.refreshBlock(YLListTableViewRefreshStateRefresh);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self headerEndRefreshing];
    });

}

- (void)updateWithArray:(NSArray *)array withFlag:(NSInteger )flag
{
    self.data = [array mutableCopy];
    self.flagId = flag;
    [self reloadData];
}

-(void)appendWithArray:(NSArray *)array withFlag:(NSInteger )flag
{
    [self.data addObjectsFromArray:array];
    self.flagId = flag;
    [self reloadData];
}

@end
