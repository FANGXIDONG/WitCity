//
//  DDSearchSecTableView.m
//  WitCity
//
//  Created by 刘帅 on 17/1/4.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDSearchSecTableView.h"
#import "DDEpContactCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface DDSearchSecTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;

@end

static NSString *cellId = @"SearchSecResultCell";

@implementation DDSearchSecTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[DDEpContactCell class] forCellReuseIdentifier:cellId];
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
    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(DDEpContactCell *cell) {
        [cell updateWithModel:self.data[indexPath.row]];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDEpContactCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DDEpContactCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeEnterpriseContactDeatil),
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
