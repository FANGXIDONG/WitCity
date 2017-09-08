//
//  YLUserCenterTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLUserCenterTableView.h"
#import "YLUserCenterTableViewCell.h"
#import "YLUserCenterSectionView.h"

@interface YLUserCenterTableView ()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation YLUserCenterTableView

static NSString *cellId = @"UserCenterCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kYLColorBakcgorund;
        [self registerClass:[YLUserCenterTableViewCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    if kAPPUserTypeEnterprise{
        return 6;
    }else{
        return 5;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if kAPPUserTypeEnterprise {
        switch (section) {
            case 1:{
                count = 4;
            }break;
            default:{
                count = 0;
            }break;
        }
    }else{
        switch (section) {
            case 0:{
                count = 4;
            }break;
            default:{
                count = 0;
            }break;
        }
    }

    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YLUserCenterSectionView *view = [[YLUserCenterSectionView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kYLUserCenterSectionHeight)];
    view.section = section;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)]];
    
    NSString *title;
    NSString *imageNamed = @"";
    
    //权限是否可看到通讯录按钮
    if kAPPUserTypeEnterprise {
        
        switch (section) {
            case 0:{
                title = @"企业通讯录";
                imageNamed = @"u_contact";
            }break;
            case 1:{
                title = @"我的收藏";
                imageNamed = @"u_collect";
            }break;
            case 2:{
                title = @"我的消息";
                imageNamed = @"u_message";
            }break;
            case 3:
            {
                title = @"企业资料";
                imageNamed = @"u_enterpriseData";
                view.value = [NSString stringWithFormat:@"完善度：%@",[YLUserSingleton shareInstance].percent];
            }break;
            case 4:
            {
                title = @"企业认证";
                imageNamed = @"u_enterpriseAuth";
                view.value = [[YLUserSingleton shareInstance].is_check intValue] ==0?@"未认证":@"已认证";
            }break;
            case 5:
            {
                title = @"设置";
                imageNamed = @"u_setting";
            }break;
            default:
                break;
        }
        
    }else{
       
        
        switch (section) {
            case 0:{
                title = @"我的收藏";
                imageNamed = @"u_collect";
            }break;
            case 1:{
                title = @"我的消息";
                imageNamed = @"u_message";
            }break;
            case 2:
            {
                title = @"企业资料";
                imageNamed = @"u_enterpriseData";
                view.value = [NSString stringWithFormat:@"完善度：%@",[YLUserSingleton shareInstance].percent];
            }break;
            case 3:
            {
                title = @"企业认证";
                imageNamed = @"u_enterpriseAuth";
                view.value = [[YLUserSingleton shareInstance].is_check intValue] ==0?@"未认证":@"已认证";
            }break;
            case 4:{
                title = @"设置";
                imageNamed = @"u_setting";
            }break;
            default:
                break;
        }
    }
    view.title = title;
    view.imageNamed = imageNamed;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kYLUserCenterSectionHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLUserCenterTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[YLUserCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    NSString *title;
    NSString *imageNamed;
    NSInteger sectionValue;
    
    if kAPPUserTypeEnterprise {
        sectionValue = 1;
    }else{
        sectionValue = 0;
    }
    
    if (indexPath.section == sectionValue) {
        
        switch (indexPath.row) {
//            case 0:{
//                title = @"企业";
//                imageNamed = @"u_enterprise";
//            }break;
            case 0:{
                title = @"政策";
                imageNamed = @"u_policy";
            }break;
            case 1:{
                title = @"办事";
                imageNamed = @"u_office";
            }break;
            case 2:{
                title = @"公告";
                imageNamed = @"u_notification";
            }break;
            case 3:{
                title = @"论坛";
                imageNamed = @"u_forum";
            }break;
            default:
                break;
        }
    }
    
    cell.isHideLine = [tableView numberOfRowsInSection:indexPath.section] == (indexPath.row + 1);
    cell.title = title;
    cell.imageNamed = imageNamed;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLBlockType blockType = 0;
    NSInteger sectionValue = 0;
    if kAPPUserTypeEnterprise {
        sectionValue = 1;
    }else{
        sectionValue = 0;
    }
    if (indexPath.section == sectionValue) {
        switch (indexPath.row) {
//            case 0:{
//                blockType = kYLBlockTypeUserCenterEnterprise;
//            }break;
            case 0:{
                blockType = kYLBlockTypeUserCenterPolicy;
            }break;
            case 1:{
                blockType = kYLBlockTypeUserCenterOffice;
            }break;
            case 2:{
                blockType = kYLBlockTypeUserCenterNotification;
            }break;
            case 3:{
                blockType = kYLBlockTypeUserCenterForum;
            }break;
            default:
                break;
        }
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(blockType)
                                 }];
    }
}


- (void)headerViewClick:(UITapGestureRecognizer *)gesture
{
    YLUserCenterSectionView *view = (YLUserCenterSectionView *)gesture.view;
    NSInteger section = view.section;
    YLBlockType blockType =0;
    
    if kAPPUserTypeEnterprise {
        switch (section) {
            case 0:{
                blockType = kYLBlockTypeUserCenterEnterpriseContact;
            }break;
            case 1:{
                blockType = kYLBlockTypeUserCenterCollect;
            }break;
            case 2:{
                blockType = kYLBlockTypeUserCenterMessage;
            }break;
            case 3:
            {
                blockType = kYLBlockTypeUserCenterEnterPriseData;
            }break;
            case 4:
            {
                blockType = kYLBlockTypeUserCenterEnterPriseAuth;
            }break;
            case 5:
            {
                blockType = kYLBlockTypeUserCenterSetting;
            }break;
            default:
                break;
        }
    }else{
        switch (section) {
            case 0:{
                blockType = kYLBlockTypeUserCenterCollect;
            }break;
            case 1:{
                blockType = kYLBlockTypeUserCenterMessage;
            }break;
            case 2:
            {
                blockType = kYLBlockTypeUserCenterEnterPriseData;
            }break;
            case 3:
            {
                blockType = kYLBlockTypeUserCenterEnterPriseAuth;
            }break;
            case 4:
            {
                blockType = kYLBlockTypeUserCenterSetting;
            }break;
            default:
                break;
        }
    }
    

    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType)
                             }];
}


@end
