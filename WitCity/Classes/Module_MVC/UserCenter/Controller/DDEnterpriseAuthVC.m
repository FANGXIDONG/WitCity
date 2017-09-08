//
//  DDEnterpriseAuthVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/19.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseAuthVC.h"
#import "DDEnterpriseAuthView.h"
#import "DDEnterpriseNotAuthView.h"
#import "YLUserHttpUtil.h"
#import "DDAuthModel.h"
#import "DDEnterpriseEditVC.h"

@interface DDEnterpriseAuthVC ()
@property (nonatomic, strong) DDEnterpriseAuthView *authView;
@property (nonatomic, strong) DDEnterpriseNotAuthView *noauthView;
@end

@implementation DDEnterpriseAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"企业认证"];
    [self addViews];
    [self loadData];
}
-(void)skipClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//加载已认证后的数据
-(void)loadData{
    [YLUserHttpUtil getEnterpriseAuthblock:^(NSDictionary *dict) {
        self.authView.authModel = [DDAuthModel mj_objectWithKeyValues:dict];
    } failure:^{
        //
    }];
}
-(void)addViews{
    //已认证
    if ([[YLUserSingleton shareInstance].is_check intValue] == 1) {
        [self.view addSubview:self.authView];
        [self loadData];
    }else{
        [self.view addSubview:self.noauthView];
        self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(skipClick) title:@"跳过"];
    }
}
//未认证
-(DDEnterpriseNotAuthView *)noauthView{
    if (!_noauthView) {
        _noauthView = [[DDEnterpriseNotAuthView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    WS(wself);
    _noauthView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _noauthView;
}
//已认证
-(DDEnterpriseAuthView *)authView{
    if (!_authView) {
        _authView = [[DDEnterpriseAuthView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    return _authView;
}
#pragma mark  - callback
-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeAuthSubmit:{
            //查看生成的主页
            [self submitAuthData:dict[kYLModel]];
            
        }break;
        case kDDBlockTypeDataEdit:
        {
            //完善资料
            [self pushEditVC];
        }break;
        default:
            break;
    }
}
-(void)pushEditVC{
    DDEnterpriseEditVC *editVC = [[DDEnterpriseEditVC alloc] init];
    editVC.titleString = @"完善资料";
    [self.navigationController pushViewController:editVC animated:YES];
}
//提交认证审核
-(void)submitAuthData:(DDAuthModel *)model{
    
    [YLUserHttpUtil enterpriseAuthWithUser_id:[YLUserSingleton shareInstance].uid reg_num:model.reg_num owner_name:model.owner_name owner_idcard:model.owner_idcard owner_phone:model.owner_phone block:^(NSDictionary *dict) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功，等待后台审核" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popViewController];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    } failure:^{
        //
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end




