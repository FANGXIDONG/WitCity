

//
//  DDMyreplyTableView.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyreplyTableView.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应
#import "DDMyreplyCell.h"

@interface DDMyreplyTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDMyreplyTableView
static NSString *recruitcellId = @"myreply";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DDMyreplyCell class] forCellReuseIdentifier:recruitcellId];
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
    return [self fd_heightForCellWithIdentifier:recruitcellId cacheByIndexPath:indexPath configuration:^(DDMyreplyCell *cell) {
        [cell updateWithModel:self.data[indexPath.row]];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DDMyreplyCell *cell =  [tableView dequeueReusableCellWithIdentifier:recruitcellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[DDMyreplyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recruitcellId];
    }
    
    WS(ws);
    cell.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:dict];
    };
    
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}
- (YLTableViewCell *)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath class:(Class)clazz cellId:(NSString *)cellId
{
    YLTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[clazz alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [self allBlockWithDict:@{
//                             kYLKeyForBlockType : @(kYLBlockTypeCommentDetail),
//                             kYLModel : self.data[indexPath.row]
//                             }];
}


@end
