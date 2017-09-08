//
//  YLLoginVC.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLLoginVC.h"
#import "YLLoginView.h"
#import "YLRegisterVC.h"
#import "YLForgetPasswordVC.h"
#import "YLUserHttpUtil.h"
#import "YLLoginManager.h"
#import "YLValidateManager.h"
#import "DDEnterpriseEditVC.h"

@interface YLLoginVC ()

@property (nonatomic, strong) YLLoginView *mainView;
@property (nonatomic, strong) YLLoginManager *loginManager;
@property (nonatomic, strong) YLValidateManager *validateManager;

@end

@implementation YLLoginVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"登录"];
    [self addViews];
}

- (void)rightClick
{
    [self pushRegisterVC];
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

#pragma mark - getter
-(YLLoginView *)mainView
{
    if(!_mainView) {
        _mainView  = [[YLLoginView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

-(YLValidateManager *)validateManager
{
    if(!_validateManager) {
        _validateManager = [[YLValidateManager alloc]initWithController:self];
    }
    return _validateManager;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeForgetPassword: {//忘记密码
            [self pushForgetPasswordVC];
        } break;
        case kYLBlockTypeLogin: {//登录
            YLLoginModel *model = dict[kYLModel];
            [self loginWithLoginModel:model];
        } break;
        case kYLBlockTypeRegister: {//注册
            [self pushRegisterVC];
        } break;
        default:
            break;
    }
}

#pragma mark - server
- (void)loginWithLoginModel:(YLLoginModel *)model
{
    NSString *username = model.username;
    NSString *password = model.password;
    
    if ([self.validateManager validateLoginWithModel:model]) {
        [YLToast showToastWithView:self.view];
        [self.loginManager loginWithUsername:username password:password block:^(NSDictionary *dict) {
            [YLToast hiddenToastWithView:self.view];
           
            
            //用户类型为2企业，资料为空0
            if ([[YLUserSingleton shareInstance].percent isEqual: @"0%"] && [[YLUserSingleton shareInstance].usertype intValue] == 2) {
                [self pushEnterpriseEditVC];
            }else{
                [self popViewController];
            }
        } failure:^{
            [YLToast hiddenToastWithView:self.view];
        }];
    }
}


#pragma mark - push
//资料完善页面
-(void)pushEnterpriseEditVC{
    DDEnterpriseEditVC *editVC = [[DDEnterpriseEditVC alloc] init];
    editVC.titleString = @"完善资料";
    [self.navigationController pushViewController:editVC animated:YES];
}

//注册
-(void)pushRegisterVC
{
    YLRegisterVC *vc = [[YLRegisterVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//忘记密码
-(void)pushForgetPasswordVC
{
    YLForgetPasswordVC *vc = [[YLForgetPasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - other
-(void)popViewController
{
    if (self.isPopToRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
