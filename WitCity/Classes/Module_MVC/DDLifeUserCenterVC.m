
//
//  DDLifeUserCenterVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeUserCenterVC.h"
#import "DDLifeUserCenterTableView.h"
#import "YLLoginManager.h"
#import "YLPersonInfoVC.h"
#import "YLSettingVC.h"
#import "DDMyNoteViewController.h"  //我的发帖VC
#import "DDLifeUserCenterHeaderView.h"
#import "DDDefaultVC.h"
#import "DDMessagesViewController.h"   //我的消息

@interface DDLifeUserCenterVC ()

@property (nonatomic,strong)DDLifeUserCenterTableView *tableView;
@property (nonatomic,strong)DDLifeUserCenterHeaderView *headerView;
@property (nonatomic,strong)YLLoginManager *loginManager;
@end

@implementation DDLifeUserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationWithTitle:@"个人中心"];
    [self addViews];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [ND addObserver:self selector:@selector(updateUserInfo) name:kUpdateUserInfoNotification object:nil];
    
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"更新资料",@"updateInfo", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:kUpdateUserInfoNotification object:nil userInfo:dict];
    [ND postNotification:notification];
}

//-(void)dealloc
//{
//    [ND removeObserver:self name:kUpdateUserInfoNotification object:nil];
//}
//- (void)updateUserInfo
//{
//    [self.headerView updateUserInfo];
//}
//

-(void)addViews{
    
    [self.view addSubview:self.tableView];
}


-(DDLifeUserCenterTableView *)tableView{
    if(!_tableView) {
        _tableView = [[DDLifeUserCenterTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
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
            //个人资料
        case kDDBlockTypePersonInfo:
        {
            [self pushPersonInfoVC];
        }
            break;
            //我的订单
        case kDDBlockTypeMyOrders:
        {
            [self pushToDefaultVC:@"全部订单"];
        }break;
            //我的发帖
            case kDDBlockTypeMySends:
        {
            [self pushToMySendNotes];
        }break;
            //外卖订单
            case kDDBlockTypeMyTakeOuts:
        {
           
        }break;
            //设置
            case kDDBlockTypeMySetting:
        {
            [self pushSettingVC];
        }break;
            //待付款
            case kDDBlockTypeReadyPayying:
        {
           [self pushToDefaultVC:@"待付款"];
        }break;
            //待发货
            case kDDBlockTypeReadyShipping:
        {
           [self pushToDefaultVC:@"待发货"];
        }break;
            //待确认
            case kDDBlockTypeReadyConfirm:
        {
            [self pushToDefaultVC:@"待确认"];
          
        }break;
            //待评价
            case kDDBlockTypeReadyComment:
        {
         [self pushToDefaultVC:@"待评价"];
        }break;
            //退货
            case kDDBlockTypeReadyReturn:
        {
        [self pushToDefaultVC:@"退货"];
        }break;
            //我的消息
            case kDDBlockTypeMyMessage:
        {
            [self pushMessagesVC];
        }break;
        default:
            break;
    }
}

-(void)pushToDefaultVC:(NSString *)flag
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDDefaultVC *defaultVc = [[DDDefaultVC alloc] init];
        defaultVc.flag = flag;
        defaultVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:defaultVc animated:YES];
    }];
}

//我的消息控制器
-(void)pushMessagesVC{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        
    DDMessagesViewController *mvc = [[DDMessagesViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
    }];
}

#pragma mark - push

-(void)pushToMySendNotes{
    
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDMyNoteViewController *myNotesVC = [[DDMyNoteViewController alloc] init];
        [self.navigationController pushViewController:myNotesVC animated:YES];
    }];
}


- (void)pushPersonInfoVC
{
    YLPersonInfoVC *vc = [[YLPersonInfoVC alloc]init];
    [self pushWithVC:vc];
}

- (void)pushWithVC:(UIViewController *)vc
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)pushSettingVC
{
    YLSettingVC *vc = [[YLSettingVC alloc]init];
    vc.version = @"切换企业版";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
