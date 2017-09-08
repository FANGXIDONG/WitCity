//
//  DDMyNotesTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNotesTableVC.h"
#import "YLLoginVC.h"            //登录vc
#import "YLLoginManager.h"       //登录管理对象
#import "DDLWQModel.h"
#import "DDRecruitModel.h" 
#import "DDRentOutModel.h"
#import "DDRentWantModel.h"
#import "DDJobSeekModel.h"

#import "DDMyNotesLWQTableView.h"
#import "DDMyNotesJobwantTableView.h"
#import "DDMyNotesRentoutTableView.h"
#import "DDMyNotesRentwantTableView.h"
#import "DDMyNotesRecruitTableView.h"

@interface DDMyNotesTableVC ()

@property (nonatomic, strong) YLLoginManager    *loginManager;
@property (nonatomic, strong) DDMyNotesLWQTableView *lwqTableView;
@property (nonatomic, strong) DDMyNotesJobwantTableView *jbTableView;
@property (nonatomic, strong) DDMyNotesRentoutTableView *rtTableView;
@property (nonatomic, strong) DDMyNotesRentwantTableView *rwTableView;
@property (nonatomic, strong) DDMyNotesRecruitTableView *rTableView;
@end

@implementation DDMyNotesTableVC

#pragma mark - init

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self addViews];
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addViews];
//    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.rTableView];
    [self.view addSubview:self.jbTableView];
    [self.view addSubview:self.rtTableView];
    [self.view addSubview:self.rwTableView];
    [self.view addSubview:self.lwqTableView];
}

#pragma mark - getter

-(DDMyNotesRecruitTableView *)rTableView
{
    if(!_rTableView) {
        _rTableView = [[DDMyNotesRecruitTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _rTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rTableView;
}
-(DDMyNotesJobwantTableView *)jbTableView
{
    if(!_jbTableView) {
        _jbTableView = [[DDMyNotesJobwantTableView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _jbTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _jbTableView;
}
-(DDMyNotesRentoutTableView *)rtTableView
{
    if(!_rtTableView) {
        _rtTableView = [[DDMyNotesRentoutTableView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH*2, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _rtTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rtTableView;
}
-(DDMyNotesRentwantTableView *)rwTableView
{
    if(!_rwTableView) {
        _rwTableView = [[DDMyNotesRentwantTableView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH*3, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _rwTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rwTableView;
}
-(DDMyNotesLWQTableView *)lwqTableView
{
    if(!_lwqTableView) {
        _lwqTableView = [[DDMyNotesLWQTableView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH*4, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _lwqTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _lwqTableView;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    switch (self.categroyId) {
        case 0:
        {
            //发帖招聘数据
            [self getRecruitListDataWithPage:page append:append];
        }
            break;
        case 1:
        {
            //发帖求职数据
            [self getJobwantListDataWithPage:page append:append];
        }
            break;
        case 2:
        {
            //发帖出租数据
            [self getRentoutListDataWithPage:page append:append];
        }
            break;
        case 3:
        {
            //发帖求租数据
            [self getRentwantListDataWithPage:page append:append];
        }
            break;
        case 4:
        {
            //发帖柳梧圈数据
            [self getLWQListDataWithPage:page append:append];
        }
            break;
        default:
            break;
    }
}

-(void)getRecruitListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfRecruitWithpage:page block:^(NSDictionary *dict) {
    NSArray *array = [DDRecruitModel mj_objectArrayWithKeyValuesArray:dict];
    [self showDataWithTableView:self.rTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
    
}

-(void)getRentwantListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfRentwantWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDRentWantModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.rwTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

-(void)getRentoutListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfRentoutWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDRentOutModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.rtTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

-(void)getJobwantListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfJobwantWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDJobSeekModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.jbTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

-(void)getLWQListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfLWQWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDLWQModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.lwqTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

#pragma mark - other



@end
