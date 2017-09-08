//
//  YLPersonEditVC.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPersonEditVC.h"
#import "YLUserHttpUtil.h"

@interface YLPersonEditVC ()

@property (nonatomic, strong) YLPersonEditTableView *tableView;

@end

@implementation YLPersonEditVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title;
    UIBarButtonItem *btnRight;
    if (self.type == kYLPersonEditTypeNickname) {
        title = @"修改昵称";
        btnRight = [self buttonForNavigationBarWithAction:@selector(saveNickname) title:@"保存"];
    } else if (self.type == kYLPersonEditTypePhone) {
        title = @"修改手机号码";
        btnRight = [self buttonForNavigationBarWithAction:@selector(savePhone) title:@"下一步"];
    } else {
        title = @"修改密码";
        btnRight = [self buttonForNavigationBarWithAction:@selector(savePasswordAndToNext) title:@"保存"];
    }
    [self navigationWithTitle:title];
    self.navigationItem.rightBarButtonItem = btnRight;
    [self addViews];
}

-(void)addViews
{
    self.tableView.type = self.type;
    [self.view addSubview:self.tableView];

}

#pragma mark - getter
-(YLPersonEditTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLPersonEditTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 20)];
        view.backgroundColor = kYLColorBakcgorund;
        _tableView.tableHeaderView = view;
    }
    return _tableView;
}

#pragma mark - callback

#pragma mark - server
- (void)saveNickname
{
    NSString *text = self.tableView.title;
    [YLUserHttpUtil editNicknameWithName:text block:^(NSDictionary *dict) {
        [YLToast showToastInKeyWindowWithText:@"昵称修改成功"];
        [YLUserSingleton shareInstance].name = text;
        if (self.allBlock) {self.allBlock(@{});}
        [ND postNotificationName:kUpdateUserInfoNotification object:nil];
        [self popViewController];
    } failure:^{
    }];
}

- (void)savePhone
{
    
}

- (void)savePasswordAndToNext
{
    NSString *opwd = self.tableView.title;
    NSString *npwd = self.tableView.pwd;
    NSString *pwd = self.tableView.pwdConfrim;
    
    if (![npwd isEqualToString:pwd]) {
        [YLToast showToastWithView:self.view text:@"两次密码输入不一致"];
        return;
    }
    
    [YLUserHttpUtil changePasswordWithOriginPassword:opwd newPassword:npwd block:^(NSDictionary *dict) {
        [YLToast showToastInKeyWindowWithText:@"密码修改成功"];
        [self popViewController];
    } failure:^{
    }];
}
#pragma mark - push

#pragma mark - other




@end
