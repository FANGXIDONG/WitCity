//
//  YLCollectTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCollectTableView.h"
#import "YLCollectTableViewCell.h"
#import "YLPolicyTableViewCell.h"
#import "YLEnterpriseTableViewCell.h"
#import "YLPolicyTableViewCell.h"
#import "YLForumTableViewCell.h"
#import "YLNoticeTableViewCell.h"
#import "YLEnterpriseListTableViewCell.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface YLCollectTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation YLCollectTableView

static NSString *enterpriseCell = @"EnterpriseCell";
static NSString *policyCell = @"PolicyCell";
static NSString *officeCell = @"OfficeCell";
static NSString *noticeCell = @"NoticeCell";
static NSString *forumCell = @"ForumCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[YLEnterpriseTableViewCell class] forCellReuseIdentifier:enterpriseCell];
        [self registerClass:[YLPolicyTableViewCell class] forCellReuseIdentifier:policyCell];
        [self registerClass:[YLEnterpriseListTableViewCell class] forCellReuseIdentifier:officeCell];
        [self registerClass:[YLNoticeTableViewCell class] forCellReuseIdentifier:noticeCell];
        [self registerClass:[YLForumTableViewCell class] forCellReuseIdentifier:forumCell];
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
    CGFloat height = 0;
    if (self.index == 0) {
        height = 125;
    } else {
        NSString *cellId;
        if (self.index == 1) {
            cellId = policyCell;
        } else if (self.index == 2) {
            cellId = officeCell;
        } else if (self.index == 3) {
            cellId = noticeCell;
        } else {
            cellId = forumCell;
        }
        height = [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLTableViewCell *cell) {
            [cell updateWithModel:self.data[indexPath.row]];
        }];
    }
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId;
    Class clazz;
    if (self.index == 0) {
        cellId = enterpriseCell;
        clazz = [YLEnterpriseTableViewCell class];
    } else if (self.index == 1) {
        cellId = policyCell;
        clazz = [YLPolicyTableViewCell class];
    } else if (self.index == 2) {
        cellId = officeCell;
        clazz = [YLEnterpriseListTableViewCell class];
    } else if (self.index == 3) {
        cellId = noticeCell;
        clazz = [YLNoticeTableViewCell class];
    } else {
        cellId = forumCell;
        clazz = [YLForumTableViewCell class];
    }
    
    YLTableViewCell *cell =  [self createCellWithTableView:tableView indexPath:indexPath class:clazz cellId:cellId];
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}

- (YLTableViewCell *)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath class:(Class)clazz cellId:(NSString *)cellId
{
    YLTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[clazz alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.isCollectCell = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self  allBlockWithDict:@{
                              kYLKeyForBlockType : @(kYLBlockTypeNewsDetail),
                              kYLModel : self.data[indexPath.row]
                              }];
}


@end
