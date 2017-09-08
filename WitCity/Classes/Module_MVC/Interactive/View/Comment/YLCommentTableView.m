//
//  YLCommentTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentTableView.h"
#import "YLCommentTableViewCell.h"
#import "YLCommentSectionView.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "YLCommentModel.h"

@interface YLCommentTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;

@end

@implementation YLCommentTableView

static NSString *cellId = @"CommentCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[YLCommentTableViewCell class] forCellReuseIdentifier:cellId];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YLCommentSectionView *view = [[YLCommentSectionView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kYLCommentSectionHeight)];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kYLCommentSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLCommentTableViewCell *cell) {
        [cell updateWithModel:self.data[indexPath.row]];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLCommentTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[YLCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    [cell updateWithModel:self.data[indexPath.row]];
    cell.isHideLine = [self tableView:tableView numberOfRowsInSection:indexPath.section] == (indexPath.row + 1);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeCommentReply),
                             kYLModel : self.data[indexPath.row],
                             }];
    
}


- (void)updateWithArray:(NSArray *)array
{
    self.data = array;
    [self reloadData];
}

@end
