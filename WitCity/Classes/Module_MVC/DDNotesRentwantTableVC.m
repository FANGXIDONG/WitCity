//
//  DDNotesRentwantTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNotesRentwantTableVC.h"
#import "YLLoginVC.h"            //登录vc
#import "YLLoginManager.h"       //登录管理对象
#import "DDRentWantModel.h"
#import "DDMyNotesRentwantTableView.h"
#import "DDPublishRentwantVC.h"   //求租页面

@interface DDNotesRentwantTableVC ()

@property (nonatomic, strong) YLLoginManager    *loginManager;

@property (nonatomic, strong) DDMyNotesRentwantTableView *rwTableView;
@end

@implementation DDNotesRentwantTableVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.rwTableView];
}

#pragma mark - getter

-(DDMyNotesRentwantTableView *)rwTableView
{
    if(!_rwTableView) {
        _rwTableView = [[DDMyNotesRentwantTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _rwTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rwTableView;
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
        case kDDBlockTypeNotesEdit:
        {//编辑
            [self pushRentwantVcWithModel:dict[kYLModel]];
        }break;
        case kDDBlockTypeNotesDelete:
        {//删除
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该数据" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                
                if (clickIndex == 1) {
                    [self deleteRentwantWithQzu_id:dict[kYLValue]];
                }
            }];
            alert.animationStyle=LXASAnimationDefault;
            [alert showLXAlertView];
        }break;
        default:
            break;
    }
}
-(void)pushRentwantVcWithModel:(DDRentWantModel *)model{
    DDPublishRentwantVC *rentwantVC = [[DDPublishRentwantVC alloc] init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:rentwantVC];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}

//删除求租
-(void)deleteRentwantWithQzu_id:(NSString *)qzu_id{
    
    [YLToast showToastWithView:self.view];
    [DDLifeHttpUtil deleteNotesOfRentWantWithId:qzu_id block:^(NSDictionary *dict) {
        [YLToast hiddenToastWithView:self.view];
        if ([dict[@"status"] intValue] == 1) {
            [self refresh];
        }
    } failure:^{
        //
    }];
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [self getRentwantListDataWithPage:page append:append];
}


-(void)getRentwantListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfRentwantWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDRentWantModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.rwTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

@end
