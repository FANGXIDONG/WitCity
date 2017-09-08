//
//  DDNotesRecruitTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNotesRecruitTableVC.h"
#import "YLLoginVC.h"            //登录vc
#import "YLLoginManager.h"       //登录管理对象
#import "DDRecruitModel.h"
#import "DDMyNotesRecruitTableView.h"
#import "DDPublishRecruitVC.h"       //招聘页面

@interface DDNotesRecruitTableVC ()

@property (nonatomic, strong) YLLoginManager    *loginManager;
@property (nonatomic, strong) DDMyNotesRecruitTableView *rTableView;
@end

@implementation DDNotesRecruitTableVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.rTableView];

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
        {
            [self pushRecruitVcWithModel:dict[kYLModel]];
        }break;
        case kDDBlockTypeNotesShow:
        {
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"是否要显示该数据" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    [self transferStatusWithId:dict[kYLValue] status:@"1"];
                }
            }];
            alert.animationStyle=LXASAnimationDefault;
            [alert showLXAlertView];
        }break;
        case kDDBlockTypeNotesHide:
        {
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"是否要隐藏该数据" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    [self transferStatusWithId:dict[kYLValue] status:@"2"];
                }
            }];
            alert.animationStyle=LXASAnimationDefault;
            [alert showLXAlertView];
        }break;

        default:
            break;
    }
}

-(void)pushRecruitVcWithModel:(DDRecruitModel *)model{
    DDPublishRecruitVC *recVC = [[DDPublishRecruitVC alloc] init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:recVC];
    nav.style = 1;
    recVC.model = model;
    recVC.flag = @"招聘更新";
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)transferStatusWithId:(NSString *)recruit_id status:(NSString *)status{
    
    [YLToast showToastWithView:self.view];
    [DDLifeHttpUtil transferRecruitShowWithId:recruit_id status:status block:^(NSDictionary *dict) {
        [YLToast hiddenToastWithView:self.view];
        if ([dict[@"status"] intValue] == 1) {
            [YLToast showToastWithView:self.view text:@"操作成功"];
        }
    } failure:^{
        //
    }];
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [self getRecruitListDataWithPage:page append:append];
}

-(void)getRecruitListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfRecruitWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDRecruitModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.rTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
    
}

@end
