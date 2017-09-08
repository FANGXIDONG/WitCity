//
//  DDTravelTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDTravelTableVC.h"
#import "DDTravelTableView.h"
#import "DDLifeHttpUtil.h"
#import "DDBusListModel.h"
#import "DDDefaultVC.h"
#import "DDBusHeaderView.h"
#import "DDBusSearchViewController.h"

@interface DDTravelTableVC ()

@property (nonatomic, strong) DDBusHeaderView *headerView;
@property (nonatomic, strong) DDTravelTableView *tableView;

@end

@implementation DDTravelTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - getter
-(DDTravelTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[DDTravelTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 ) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}
-(DDBusHeaderView *)headerView
{
    if(!_headerView) {
        _headerView = [[DDBusHeaderView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 50)];
        WS(wself);
        _headerView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _headerView;
}


#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
            //单元格公交车点击回调
        case kDDBlockTypeLifeBus:{
            DDBusListModel *model = dict[kYLModel];
            [self pushDefaultDetailVCWithModel:model];
        }break;
            //搜索按钮点击回调
        case kDDBlockTypeLifeBusSearch:
        {
            [self pushBusSearchVC];
        }
        default:
            break;
    }
}


#pragma mark - push
- (void)pushBusSearchVC
{
    DDBusSearchViewController *vc = [[DDBusSearchViewController alloc]init];
    [self pushModalWithController:vc];
}


#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [DDLifeHttpUtil getBusListWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDBusListModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
        //
    }];
}

#pragma mark - push
- (void)pushDefaultDetailVCWithModel:(DDBusListModel *)model
{
    DDDefaultVC *vc = [[DDDefaultVC alloc] init];
    vc.busModel = model;
    vc.flag = @"公交详情";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
