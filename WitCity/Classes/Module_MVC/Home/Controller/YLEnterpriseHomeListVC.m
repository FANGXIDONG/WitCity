//
//  YLEnterpriseHomeListVC.m
//  WitCity
//
//  Created by duyulong on 16/5/31.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLEnterpriseHomeListVC.h"
#import "YLEnterpriseListTableView.h"
#import "YLDefaultDetailVC.h"
#import "YLHomeHttpUtil.h"
#import "YLNewsModel.h"
#import "YLPolicyTableView.h"
#import "YLCollectManager.h"
#import "YLLoginVC.h"
#import "YLLoginManager.h"

@interface YLEnterpriseHomeListVC ()

@property (nonatomic, strong) YLPolicyTableView *tableView;
@property (nonatomic, strong) YLCollectManager  *manager;
@property (nonatomic, strong) YLLoginManager    *loginManager;

@end

@implementation YLEnterpriseHomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:self.naviTitle];
    [self addViews];
    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
}

-(YLPolicyTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLPolicyTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(YLCollectManager *)manager
{
    if(!_manager) {
        _manager = [[YLCollectManager alloc]initWithController:self];
    }
    return _manager;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeNewsDetail:{
            YLNewsModel *model = dict[kYLModel];
            [self pushDefaultDetailVCWithModel:model];
        }break;
        case kYLBlockTypeCollectAdd:{
            [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
                YLNewsModel *model = dict[kYLModel];
                [self.manager collectWithContentId:model.content_id categoryId:self.categoryId block:^(NSDictionary *dict) {
                    model.status = @"1";
                } failure:^{}];
            }];
        }break;
        case kYLBlockTypeCollectCancel:{
            [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
                YLNewsModel *model = dict[kYLModel];
                [self.manager collectCancelWithContentId:model.content_id categoryId:self.categoryId block:^(NSDictionary *dict) {
                    model.status = @"0";
                } failure:^{}];
            }];
        }break;
        default:
            break;
    }
}

-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [YLHomeHttpUtil officeListWithCategoryId:self.categoryId page:page block:^(NSDictionary *dict) {
        
        NSArray *array = [YLNewsModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

- (void)pushDefaultDetailVCWithModel:(YLNewsModel *)model
{
    YLDefaultDetailVC *vc = [[YLDefaultDetailVC alloc] init];
    vc.model = model;
    vc.categoryId = self.categoryId;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
