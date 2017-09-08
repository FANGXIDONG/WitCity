//
//  YLUserCenterVC.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLUserCenterVC.h"
#import "YLUserCenterTableView.h"
#import "YLUserCenterHeaderView.h"
#import "YLPersonInfoVC.h"
#import "YLMessageVC.h"
#import "YLCollectVC.h"
#import "YLMessageVC.h"
#import "YLSettingVC.h"
#import "YLLoginVC.h"
#import "YLLoginManager.h"
#import "DDEnterpriseContactsVC.h"
#import "DDEnterpriseAuthVC.h"
#import "DDEnterpriseDataVC.h"
#import "DDEnterpriseEditVC.h"

@interface YLUserCenterVC ()

@property (nonatomic, strong) YLUserCenterHeaderView *headerView;
@property (nonatomic, strong) YLUserCenterTableView  *tableView;
@property (nonatomic, strong) YLLoginManager         *loginManager;

@end

@implementation YLUserCenterVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"个人中心"];
    [self addViews];
    [self.headerView updateUserInfo];
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ND addObserver:self selector:@selector(updateUserInfo) name:kUpdateUserInfoNotification object:nil];
}

-(void)dealloc
{
    [ND removeObserver:self name:kUpdateUserInfoNotification object:nil];
}

- (void)updateUserInfo
{
    [self.headerView updateUserInfo];
    [self.tableView reloadData];
}

#pragma mark - getter
-(YLUserCenterTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLUserCenterTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(YLUserCenterHeaderView *)headerView
{
    if(!_headerView) {
        _headerView = [[YLUserCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 100)];
        WS(wself);
        _headerView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _headerView;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypePersonInfo:{
            [self pushPersonInfoVC];
        }break;
        case kYLBlockTypeUserCenterEnterpriseContact:
        {
            //企业通讯录
            [self pushEnterpriseContactVC];
        }break;
        case kYLBlockTypeUserCenterCollect:{
            [self pushCollectVCWithSelectedIndex:0];
        }break;
        case kYLBlockTypeUserCenterEnterprise:{
            [self pushCollectVCWithSelectedIndex:0];
        }break;
        case kYLBlockTypeUserCenterPolicy:{
            [self pushCollectVCWithSelectedIndex:1];
        }break;
        case kYLBlockTypeUserCenterOffice:{
            [self pushCollectVCWithSelectedIndex:2];
        }break;
        case kYLBlockTypeUserCenterNotification:{
            [self pushCollectVCWithSelectedIndex:3];
        }break;
        case kYLBlockTypeUserCenterForum:{
            [self pushCollectVCWithSelectedIndex:4];
        }break;
        case kYLBlockTypeUserCenterMessage:{
            [self pushMessageVC];
        }break;
        case kYLBlockTypeUserCenterSetting:{
            [self pushSettingVC];
        }break;
        case kYLBlockTypeUserCenterEnterPriseData:
        {
            //企业资料
            [self pushEnterpriseDataVC];
        }break;
        case kYLBlockTypeUserCenterEnterPriseAuth:
        {
            //实名认证
            [self pushEnterpriseAuthVC];
        }break;
        default:
            break;
    }
}

#pragma mark - server

#pragma mark - push
- (void)pushPersonInfoVC
{
    YLPersonInfoVC *vc = [[YLPersonInfoVC alloc]init];
    [self pushWithVC:vc];
}
- (void)pushEnterpriseContactVC{
    DDEnterpriseContactsVC *contactVC = [[DDEnterpriseContactsVC alloc] init];
    contactVC.enterFlag = 1;
    [self pushWithVC:contactVC];
}
-(void)pushEnterpriseDataVC{
    
    if ([[YLUserSingleton shareInstance].percent  isEqual: @"0%"]) {
       DDEnterpriseEditVC *editVC = [[DDEnterpriseEditVC alloc] init];
        editVC.titleString = @"完善资料";
        [self pushWithVC:editVC];
    }else{
        DDEnterpriseDataVC *edataVC = [[DDEnterpriseDataVC alloc] init];
       [self pushWithVC:edataVC];
    }
}

-(void)pushEnterpriseAuthVC{
    DDEnterpriseAuthVC *adataVC = [[DDEnterpriseAuthVC alloc] init];
    [self pushWithVC:adataVC];
}

- (void)pushCollectVCWithSelectedIndex:(NSInteger)index
{
    YLCollectVC *vc = [[YLCollectVC alloc]init];
    vc.selectedIndex = index;
    [self pushWithVC:vc];
}

- (void)pushMessageVC
{
    YLMessageVC *vc = [[YLMessageVC alloc]init];
    [self pushWithVC:vc];
}

- (void)pushSettingVC
{
    YLSettingVC *vc = [[YLSettingVC alloc]init];
    vc.version = @"切换生活版";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - other


- (void)pushWithVC:(UIViewController *)vc
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

@end
