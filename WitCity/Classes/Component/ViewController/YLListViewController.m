//
//  YLListViewController.m
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLListViewController.h"

@interface YLListViewController ()

@end

@implementation YLListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
}

- (BOOL)chechDataWithArray:(NSArray *)array append:(BOOL)append
{
    if (append) {
        return  YES;
    }
    if (!array || array.count <= 0) {
        [self showNoneDataView];
        return NO;
    } else {
        [self hiddenNoneDataView];
    }
    
    return YES;
}


- (void)showDataWithTableView:(YLListTableView *)tableView dataList:(NSArray *)dataList withFlag:(NSInteger )flag append:(BOOL)append
{
    __weak typeof(self) weakSelf = self;
    tableView.refreshBlock = ^(YLListTableViewRefreshState state) {
        if (state == YLListTableViewRefreshStateRefresh) {
            [weakSelf refresh];
        } else {
            [weakSelf load];
        }
    };
    
    if ([self chechDataWithArray:dataList append:append]) {
        if (append) {
            if (dataList.count > 0) {
                [tableView appendWithArray:dataList withFlag:flag];
            }
        } else {
            [tableView updateWithArray:dataList withFlag:flag];
        }
        [tableView.infiniteScrollingView stopAnimating];
        tableView.infiniteScrollingView.enabled = (dataList.count > 0);
    }
}


-(void)refresh
{
    self.page = 1;
    [self loadWithPage:self.page append:NO];
}

-(void)load
{
    self.page++;
    NSLog(@"%ld",(long)self.page);
    [self loadWithPage:self.page append:YES];
}

-(void)loadWithPage:(NSInteger)page append:(BOOL)append{}


@end







