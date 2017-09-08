//
//  DDSegementVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/1/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDSegementVC.h"
#import "YLEnterpriseVC.h"
#import "DDEnterpriseContactsVC.h"
#import "YLLoginManager.h"
#import "YLSearchVC.h"
#import "YLUserCenterVC.h"
#import "DDPwdAlertView.h"
#import "DDContactTypeSearchVC.h"

@interface DDSegementVC ()
@property (nonatomic, strong) YLEnterpriseVC         *noticeVC;
@property (nonatomic, strong) DDEnterpriseContactsVC   *forumVC;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIBarButtonItem    *btnSearch;
@property (nonatomic, strong) UIBarButtonItem    *btnPost;
@property (nonatomic, strong) YLLoginManager     *loginManager;
@property (nonatomic, strong) DDPwdAlertView *passView;
@end

@implementation DDSegementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self initNavi];
}

-(void)initNavi{
    [ND addObserver:self selector:@selector(cancelPop) name:@"popToEnterprise" object:nil];
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
    self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(rightClick) imageNamed:@"c_search"];
}

-(void)addViews
{
//    //权限是否可看到通讯录按钮
//    if ([[YLUserSingleton shareInstance].outh intValue] == 1) {
//        self.navigationItem.titleView = self.segment;
//        [self addChildViewController:self.forumVC];
//        [self addChildViewController:self.noticeVC];
//        [self.view addSubview:self.forumVC.view];
//        [self.view addSubview:self.noticeVC.view];
//    }else{
        self.navigationItem.title = @"企业";
        [self addChildViewController:self.noticeVC];
        [self.view addSubview:self.noticeVC.view];
//    }
}

- (void)leftClick
{
    [self pushUserCenterVC];
}

- (void)rightClick
{
    [self pushSearchVC];
}


#pragma mark - getter
-(UISegmentedControl *)segment
{
    if(!_segment) {
        NSArray *items = @[@"企业", @"通讯录"];
        _segment = [[UISegmentedControl alloc]initWithItems:items];
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

-(YLEnterpriseVC *)noticeVC
{
    if(!_noticeVC) {
        _noticeVC = [[YLEnterpriseVC alloc]init];
    }
    return _noticeVC;
}

-(DDEnterpriseContactsVC *)forumVC
{
    if(!_forumVC) {
        _forumVC = [[DDEnterpriseContactsVC alloc]init];
    }
    return _forumVC;
}

-(UIBarButtonItem *)btnSearch
{
    if(!_btnSearch) {
        _btnSearch = [self buttonForNavigationBarWithAction:@selector(rightClick) imageNamed:@"c_search"];
    }
    return _btnSearch;
}

-(UIBarButtonItem *)btnPost
{
    if(!_btnPost) {
        _btnPost = [self buttonForNavigationBarWithAction:@selector(pushPostVC) imageNamed:@"c_search"];
    }
    return _btnPost;
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
}

#pragma mark - server

#pragma mark - push
- (void)pushSearchVC
{
    YLSearchVC *vc = [[YLSearchVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushModalWithController:vc];
}

- (void)pushUserCenterVC
{
    YLUserCenterVC *vc = [[YLUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//通讯录搜索
- (void)pushPostVC
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDContactTypeSearchVC *contactVC = [[DDContactTypeSearchVC alloc] init];
        contactVC.hidesBottomBarWhenPushed = YES;
        [self pushModalWithController:contactVC];
    }];
}

#pragma mark - other
- (void)segmentClick:(UISegmentedControl *)segment
{
    self.noticeVC.view.hidden = segment.selectedSegmentIndex == 1;
    self.forumVC.view.hidden = !self.noticeVC.view.hidden;
    self.navigationItem.rightBarButtonItem = segment.selectedSegmentIndex == 1 ? self.btnPost : self.btnSearch;
    if (segment.selectedSegmentIndex == 1) {
        [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
            //每次都需验证
            [self checkUserLoginPassword];
        }];
    }else{
    }
}
-(void)cancelPop{
    [_passView removeFromSuperview];
    self.segment.selectedSegmentIndex = 0;
    self.noticeVC.view.hidden = NO;
}

-(void)checkUserLoginPassword{
    //弹出式密码框
    _passView = [[DDPwdAlertView alloc]initSingleBtnView];
    
    _passView.passWordTextConfirm =^(NSString *text){//点击确定按钮输出密码
        
        [YLHomeHttpUtil enterpriserUserPasswordWithUid:[YLUserSingleton shareInstance].uid password:[text md5] block:^(NSDictionary *dict) {

            if ([dict[@"status"] intValue] == 1) {
//                passView.alertLabel.text = @"验证成功！";
                [_passView removeFromSuperview];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:NO completion:nil];
            }else{
                _passView.alertLabel.text = @"密码错误！";
            }
            
        } failure:^{
        }];
    };
    [_passView show];
}

- (void)pushWithVC:(UIViewController *)vc
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







