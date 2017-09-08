//
//  YLPersonEditTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPersonEditTableView.h"
#import "YLPersonEditTableViewCell.h"

@interface YLPersonEditTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YLUserSingleton *user;

@end

@implementation YLPersonEditTableView

static NSString *cellId = @"PersonEditCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = kYLColorBakcgorund;
        [self registerClass:[YLPersonEditTableViewCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

-(YLUserSingleton *)user
{
    if(!_user) {
        _user = [YLUserSingleton shareInstance];
    }
    return _user;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.type == kYLPersonEditTypePassword ? 3 : 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLPersonEditTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[YLPersonEditTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    NSString *placeholder;
    NSString *title;
    
    switch (indexPath.row) {
        case 0:{
            if (self.type == kYLPersonEditTypeNickname) {
                placeholder = @"请输入昵称";
                title = self.user.name;
            } else if (self.type == kYLPersonEditTypePhone) {
                placeholder = @"请输入手机号码";
                title = self.user.phone;
            } else {
                cell.isPassword = YES;
                placeholder = @"请输入原始密码";
            }
        }break;
        case 1:{
            cell.isPassword = YES;
            placeholder = @"请输入新密码";
        }break;
        case 2:{
            cell.isPassword = YES;
            placeholder = @"请确认新密码";
        }break;
        default:
            break;
    }
    
    cell.title = title;
    cell.placeholder = placeholder;
    cell.isHideTopLine = indexPath.row > 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSString *)title
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    YLPersonEditTableViewCell *cell = (YLPersonEditTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    return cell.title;
}

-(NSString *)pwd
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    YLPersonEditTableViewCell *cell = (YLPersonEditTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    return cell.title;
}

-(NSString *)pwdConfrim
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    YLPersonEditTableViewCell *cell = (YLPersonEditTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    return cell.title;
}


@end
