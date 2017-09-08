//
//  YLMessageTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLMessageTableView.h"
#import "YLInvitationTableViewCell.h"
#import "YLReplyTableViewCell.h"
#import "YLSysMsgTableViewCell.h"

@interface YLMessageTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation YLMessageTableView

static NSString *invitationCellId = @"InvitationCellId";
static NSString *replyCellId = @"ReplyCellId";
static NSString *sysMsgCellId = @"SysMsgCellId";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[YLInvitationTableViewCell class] forCellReuseIdentifier:invitationCellId];
        [self registerClass:[YLReplyTableViewCell class] forCellReuseIdentifier:replyCellId];
        [self registerClass:[YLSysMsgTableViewCell class] forCellReuseIdentifier:sysMsgCellId];
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
    NSString *cellId;
    if (self.index == 0) {
        cellId = invitationCellId;
    } else if (self.index == 1) {
        cellId = replyCellId;
    } else {
        cellId = sysMsgCellId;
    }
    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLTableViewCell *cell) {
        [cell updateWithModel:self.data[indexPath.row]];
    }];;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLTableViewCell *cell;
    if (self.index == 0) {
        YLInvitationTableViewCell *iCell =  [tableView dequeueReusableCellWithIdentifier:invitationCellId forIndexPath:indexPath];
        if (!iCell) {
            iCell = [[YLInvitationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:invitationCellId];
        }
        cell = iCell;
    } else if (self.index == 1) {
        YLReplyTableViewCell *rCell =  [tableView dequeueReusableCellWithIdentifier:replyCellId forIndexPath:indexPath];
        if (!rCell) {
            rCell = [[YLReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:replyCellId];
        }
        cell = rCell;
    } else {
        YLSysMsgTableViewCell *sCell =  [tableView dequeueReusableCellWithIdentifier:sysMsgCellId forIndexPath:indexPath];
        if (!sCell) {
            sCell = [[YLSysMsgTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sysMsgCellId];
        }
        cell = sCell;
    }
    
    [cell updateWithModel:self.data[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index < 2) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kYLBlockTypeNewsDetail),
                                 kYLModel : self.data[indexPath.row]
                                 }];
    }
}


@end
