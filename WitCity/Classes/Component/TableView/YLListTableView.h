//
//  YLListTableView.h
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLTableView.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UITableView+FDTemplateLayoutCell.h"

typedef NS_ENUM(NSInteger, YLListTableViewRefreshState) {
    YLListTableViewRefreshStateRefresh,
    YLListTableViewRefreshStateLoadNextPage
};

@interface YLListTableView : YLTableView

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger flagId;
@property (nonatomic, copy) void(^refreshBlock)(YLListTableViewRefreshState state);

-(void)updateWithArray:(NSArray *)array withFlag:(NSInteger )flag;
-(void)appendWithArray:(NSArray *)array withFlag:(NSInteger )flag;

@end
