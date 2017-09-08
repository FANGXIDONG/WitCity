//
//  DDNotesRentoutTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNotesRentoutTableVC.h"
#import "YLLoginVC.h"            //登录vc
#import "YLLoginManager.h"       //登录管理对象
#import "DDRentOutModel.h"
#import "DDMyNotesRentoutTableView.h"
#import "DDPublishRentoutVC.h"    //出租页面

@interface DDNotesRentoutTableVC ()

@property (nonatomic, strong) YLLoginManager    *loginManager;
@property (nonatomic, strong) DDMyNotesRentoutTableView *rtTableView;
@end

@implementation DDNotesRentoutTableVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.rtTableView];
}

#pragma mark - getter


-(DDMyNotesRentoutTableView *)rtTableView
{
    if(!_rtTableView) {
        _rtTableView = [[DDMyNotesRentoutTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _rtTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rtTableView;
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
            [self pushRentoutVcWithModel:dict[kYLModel]];
        }break;
        case kDDBlockTypeNotesDelete:
        {//删除
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该数据" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    [self deleteRentwantWithLease_id:dict[kYLValue]];
                }
            }];
            alert.animationStyle=LXASAnimationDefault;
            [alert showLXAlertView];
        }break;
        default:
            break;
    }
}
-(void)pushRentoutVcWithModel:(DDRentOutModel *)model{
    DDPublishRentoutVC *rentoutVC = [[DDPublishRentoutVC alloc] init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:rentoutVC];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}

//删除出租
-(void)deleteRentwantWithLease_id:(NSString *)lease_id{
    
    [YLToast showToastWithView:self.view];
    [DDLifeHttpUtil deleteNotesOfRentOutWithId:lease_id block:^(NSDictionary *dict) {
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
    //发帖出租数据
    [self getRentoutListDataWithPage:page append:append];
}


-(void)getRentoutListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfRentoutWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDRentOutModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.rtTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}



@end
