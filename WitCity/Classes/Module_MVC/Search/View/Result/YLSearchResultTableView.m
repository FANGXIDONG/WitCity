//
//  YLSearchResultTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSearchResultTableView.h"
#import "YLSearchResultTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>


@interface YLSearchResultTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;

@end

@implementation YLSearchResultTableView

static NSString *cellId = @"SearchResultCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[YLSearchResultTableViewCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLSearchResultTableViewCell *cell) {
        [cell updateWithModel:self.data[indexPath.row]];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLSearchResultTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[YLSearchResultTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeNewsDetail),
                             kYLModel : self.data[indexPath.row]
                             }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

- (void)updateWithArray:(NSArray *)array
{
    self.data = array;
    [self reloadData];
}

@end
