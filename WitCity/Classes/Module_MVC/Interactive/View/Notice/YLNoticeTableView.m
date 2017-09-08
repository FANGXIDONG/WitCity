//
//  YLNoticeTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/23.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLNoticeTableView.h"
#import "YLNoticeTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应

@interface YLNoticeTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation YLNoticeTableView

static NSString *cellId = @"NoticeCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[YLNoticeTableViewCell class] forCellReuseIdentifier:cellId];
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
    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLNoticeTableViewCell *cell) {
        [cell updateWithModel:self.data[indexPath.row]];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLNoticeTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[YLNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    WS(ws);
    cell.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:dict];
    };
    
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeCommentDetail),
                             kYLModel : self.data[indexPath.row]
                             }];
}


@end
