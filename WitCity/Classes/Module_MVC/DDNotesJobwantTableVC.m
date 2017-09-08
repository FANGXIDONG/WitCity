//
//  DDNotesJobwantTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNotesJobwantTableVC.h"
#import "YLLoginVC.h"            //登录vc
#import "YLLoginManager.h"       //登录管理对象
#import "DDJobSeekModel.h"
#import "DDMyNotesJobwantTableView.h"
#import "DDPublishJobwantVC.h"    //求职页面

@interface DDNotesJobwantTableVC ()

@property (nonatomic, strong) YLLoginManager    *loginManager;

@property (nonatomic, strong) DDMyNotesJobwantTableView *jbTableView;
@end

@implementation DDNotesJobwantTableVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews
{

    [self.view addSubview:self.jbTableView];

}

#pragma mark - getter
-(DDMyNotesJobwantTableView *)jbTableView
{
    if(!_jbTableView) {
        _jbTableView = [[DDMyNotesJobwantTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _jbTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
        //        _jbTableView.categroyId = self.categroyId;
    }
    return _jbTableView;
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
            [self pushJobwantVcWithModel:dict[kYLModel]];
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
-(void)pushJobwantVcWithModel:(DDJobSeekModel *)model{
    DDPublishJobwantVC *jobVC = [[DDPublishJobwantVC alloc] init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:jobVC];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)transferStatusWithId:(NSString *)qzhi_id status:(NSString *)status{
    
    [YLToast showToastWithView:self.view];
    [DDLifeHttpUtil transferJobwantShowWithId:qzhi_id status:status block:^(NSDictionary *dict) {
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
    //发帖求职数据
    [self getJobwantListDataWithPage:page append:append];

}

-(void)getJobwantListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfJobwantWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDJobSeekModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.jbTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

@end
