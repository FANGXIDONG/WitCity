//
//  YLSettingTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSettingTableView.h"
#import "YLSettingTableViewCell.h"

@interface YLSettingTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation YLSettingTableView

static NSString *cellId = @"SettingCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[YLSettingTableViewCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLSettingTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[YLSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    NSString *title;
    NSString *detail;
    YLSettingTableViewCellStyle style = 0;
    switch (indexPath.row) {
        case 0:{
            title = @"推送消息";
            style = kYLSettingTableViewCellStylePush;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }break;
        case 1:{
            title = @"清除缓存";
            style = kYLSettingTableViewCellStyleCache;
            CGFloat size = [[SDImageCache sharedImageCache] getSize] / (1024 * 1024);
            detail = [NSString stringWithFormat:@"%.1fM", size];;
        }break;
        case 2:{
            title = _versionStr;
            style = kYLSettingTableViewCellStyleArrow;
        }break;
        case 3:{
            title = @"关于我们";
            style = kYLSettingTableViewCellStyleArrow;
        }break;
        default:
            break;
    }
    
    cell.style = style;
    cell.title = title;
    cell.detail = detail;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YLBlockType blockType;
    
    switch (indexPath.row) {
        case 0:{
            blockType = -999;
        }break;
        case 1:{
            blockType = kYLBlockTypeSettingClearCache;
        }break;
        case 2:{
            blockType = -999;
        }break;
        case 3:{
            blockType = kYLBlockTypeSettingAbout;
        }break;
        default: {
            blockType = -999;
        }break;
    }
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType)
                             }];
}


@end
